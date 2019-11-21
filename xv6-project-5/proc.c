#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

#ifdef KDEBUG
uint debugState = FALSE;
#endif // KDEBUG

#ifndef PGSIZE
  #define PGSIZE 4096
#endif // PGSIZE

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);
extern int sys_cps(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

#ifdef KTHREADS
  p->oncpu = -1;
  p->isThread = FALSE;
  p->isParent = FALSE;
  p->threadCount = 0;
  p->tid = 0;
  p->nextTid = 1;
  p->threadExitValue = 1;
  
#endif // KTHREADS

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

#ifdef KTHREADS
  
int
kthread_create(void (*func)(void*), void *arg_ptr, void *tstack)
{
  int i, tid;
  struct proc *np;
  struct proc *curproc = myproc();

  if (debugState) {
      cprintf("%s %s %d: kthread_create() called from process:  %s   tid: %d\n"
              , __FILE__, __FUNCTION__, __LINE__
              , curproc->name, curproc->tid);
  }

  // Ensure we're page aligned
  if (((ulong) tstack) % PGSIZE != 0) {
    if (debugState) {
      cprintf("%s %s %d: ptr %d not page aligned\n"
              , __FILE__, __FUNCTION__, __LINE__
              , tstack);
    }
    return -1;
  }

  // Allocate process.
  if((np = allocproc()) == 0){
    if (debugState) {
      cprintf("%s %s %d: could not allocate new process\n"
              , __FILE__, __FUNCTION__, __LINE__);
    }
    return -1;
  }


  if (debugState) {
    cprintf("%s %s %d: copying process state\n"
            , __FILE__, __FUNCTION__, __LINE__);
  }
  // Copy process state from proc.
  np->pgdir = curproc->pgdir;
  np->isThread = TRUE;  
  np->sz = curproc->sz;
  if (curproc->isThread) {
    np->parent = curproc->parent;
  } else {
    np->parent = curproc;
  }
  np->parent->isParent = TRUE;
  np->parent->threadCount++;
  *np->tf = *curproc->tf;
  if (debugState) {
    cprintf("%s %s %d: copying process state complete\n"
            , __FILE__, __FUNCTION__, __LINE__);
  }

  // TODO is this right? not sure if we need to use tid or nextTid
  // Assign the new process it's tid based on the parent
  tid = np->parent->nextTid++;
  np->tid = tid;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  // Give the new process an instruction pointer
  np->tf->eip = (uint)func;

  // Set the extended stack pointer to the end of the page
  np->tf->esp = ((int) tstack) + PGSIZE;

  // Push the arg_ptr value onto the stack for the thread function to pick up
  np->tf->esp -= sizeof(int);
  *((int *) (np->tf->esp)) = (int) arg_ptr;

  // Push the value of the new threads tid onto the stack
  np->tf->esp -= sizeof(int);
  *((int *) (np->tf->esp)) = tid;

  if (debugState) {
    cprintf("%s %s %d: stack pointers initialized\n"
            , __FILE__, __FUNCTION__, __LINE__);
  }

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  if (debugState) {
    cprintf("%s %s %d: i am duped\n"
            , __FILE__, __FUNCTION__, __LINE__);
  }

  if (debugState) {
    cprintf("%s %s %d: copying process name\n"
            , __FILE__, __FUNCTION__, __LINE__);
  }

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  if (debugState) {
    cprintf("%s %s %d: locking process and making runnable\n"
            , __FILE__, __FUNCTION__, __LINE__);
  }

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  if (debugState) {
      cprintf("%s %s %d: new kthread created, tid: %d\n"
              , __FILE__, __FUNCTION__, __LINE__
              , np->tid);
  }

  return tid;
}

int
kthread_join(int tid)
{
  struct proc *p;
  int foundThread = 0;
  struct proc *curproc = myproc();

  if (debugState) {
      cprintf("%s %s %d: kthread_join() called from process:  %s   tid: %d\n"
              , __FILE__, __FUNCTION__, __LINE__
              , curproc->name, curproc->tid);
      sys_cps();
  }

  if (curproc->isParent && !curproc->threadCount) {
    // TODO release
    if (debugState) {
      cprintf("%s %s %d: This is a parent process with no threadcount, join failed\n"
              , __FILE__, __FUNCTION__, __LINE__);
    }
    return -1;
  } else if (!tid) {
    // TODO release
    if (debugState) {
      cprintf("%s %s %d: No tid entered for kthread_join(), join failed\n"
              , __FILE__, __FUNCTION__, __LINE__);
    }
    return -1;
  }

  if (curproc->isThread) {
    curproc = curproc->parent;
  }

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if (p->parent != curproc || p->tid != tid)
      continue;
  
    // Found the right parent / tid pair
    while (p->state != ZOMBIE) {
      release(&ptable.lock);
      yield();
      acquire(&ptable.lock);
    }

    if (debugState) {
      cprintf("%s %s %d: Found matching thread, joining\n"
              , __FILE__, __FUNCTION__, __LINE__);
    }

    curproc->threadCount--;
    if(p->state == ZOMBIE){
      // Found one.
      kfree(p->kstack);
      p->kstack = 0;
      p->pid = 0;
      p->parent = 0;
      p->name[0] = 0;
      p->killed = 0;
      p->state = UNUSED;
      // release(&ptable.lock);
    }
    foundThread = 1;

    if (debugState) {
      cprintf("%s %s %d: Thread is joined, setting as runnable\n"
              , __FILE__, __FUNCTION__, __LINE__);
    }

    break;
  }

  if (debugState) {
    cprintf("%s %s %d: Finishing join, found thread: %d\n"
            , __FILE__, __FUNCTION__, __LINE__
            , foundThread);
  }

  // p->state = RUNNABLE;

  release(&ptable.lock);
  if (debugState) {
    cprintf("%s %s %d: Returning found thread %d\n"
            , __FILE__, __FUNCTION__, __LINE__);
  }
  return foundThread;
}

void
kthread_exit(int exitValue)
{
  struct proc *curproc = myproc();
  // struct proc *p;
  int fd;

  if (debugState) {
      cprintf("%s %s %d: kthread_join() called from process:  %s   tid: %d\n"
              , __FILE__, __FUNCTION__, __LINE__
              , curproc->name, curproc->tid);
  }

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;
  curproc->killed = FALSE;
  curproc->oncpu = 0;
  curproc->state = ZOMBIE;

  acquire(&ptable.lock);

  // Jump into the scheduler, never to return.
  sched();
  panic("zombie exit");
}

#endif // KTHREADS

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  if (debugState) {
      cprintf("%s %s %d: fork() called from process:  %s   pid: %d\n"
              , __FILE__, __FUNCTION__, __LINE__
              , curproc->name, curproc->pid);
  }

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
#ifdef KTHREADS
      if(p->parent != curproc || p->isThread == TRUE)
#else // KTHREADS
      if(p->parent != curproc)
#endif // KTHREADS
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
#ifdef KTHREADS
    int current_cpu = cpuid();
#endif // KTHREADS

  c->proc = 0;
  
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

#ifdef KTHREADS
      // TODO ? You need to have this data member in the proc struct
      p->oncpu = current_cpu;
#endif // KTHREADS

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

#ifdef KTHREADS
      p->oncpu = -1;
#endif // KTHREADS

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = NULL;
    }
    release(&ptable.lock);

  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

static char *states[] = {
    [UNUSED]    "unused",
    [EMBRYO]    "embryo",
    [SLEEPING]  "sleep ",
    [RUNNABLE]  "runble",
    [RUNNING]   "run   ",
    [ZOMBIE]    "zombie"
};

#ifdef CPS
int
sys_cps(void)
{
    int i;
    const char *state = NULL;

    acquire(&ptable.lock);
    cprintf(
        "pid\tppid\tname\tstate\tsize"
        );
#ifdef KTHREADS
    cprintf(
        "\tcpu\tis par\tis thrd\tthrd #"
        );
#endif // KTHREADS
    cprintf("\n");
    for (i = 0; i < NPROC; i++) {
        if (ptable.proc[i].state != UNUSED) {
            if (ptable.proc[i].state >= 0 && ptable.proc[i].state < NELEM(states)
                && states[ptable.proc[i].state]) {
                state = states[ptable.proc[i].state];
            }
            else {
                state = "unknown";
            }
            cprintf("%d\t%d\t%s\t%s\t%u"
                    , ptable.proc[i].pid
                    , ptable.proc[i].parent ? ptable.proc[i].parent->pid : 1
                    , ptable.proc[i].name, state
                    , ptable.proc[i].sz
                );
#ifdef KTHREADS
            cprintf("\t%d\t%d\t%d\t%d"
                    , ptable.proc[i].oncpu
                    , ptable.proc[i].isParent
                    , ptable.proc[i].isThread
                    , ptable.proc[i].tid
                );
#endif // KTHREADS
            cprintf("\n");
        }
        else {
            // UNUSED process table entry is ignored
        }
    }
    release(&ptable.lock);

    return 0;
}
#endif // CPS

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
