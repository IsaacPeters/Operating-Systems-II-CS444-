
_kdebug:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
    int val = 0;
   1:	31 c0                	xor    %eax,%eax
{
   3:	89 e5                	mov    %esp,%ebp
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 10             	sub    $0x10,%esp

    if (argc > 1) {
   b:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   f:	7e 0e                	jle    1f <main+0x1f>
        val = atoi(argv[1]);
  11:	8b 45 0c             	mov    0xc(%ebp),%eax
  14:	8b 40 04             	mov    0x4(%eax),%eax
  17:	89 04 24             	mov    %eax,(%esp)
  1a:	e8 d1 01 00 00       	call   1f0 <atoi>
    }

    kdebug(val);
  1f:	89 04 24             	mov    %eax,(%esp)
  22:	e8 db 02 00 00       	call   302 <kdebug>

    exit();
  27:	e8 26 02 00 00       	call   252 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  39:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 55 08             	mov    0x8(%ebp),%edx
  66:	53                   	push   %ebx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	74 2d                	je     9e <strcmp+0x3e>
  71:	0f b6 19             	movzbl (%ecx),%ebx
  74:	38 d8                	cmp    %bl,%al
  76:	74 0e                	je     86 <strcmp+0x26>
  78:	eb 2b                	jmp    a5 <strcmp+0x45>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	38 c8                	cmp    %cl,%al
  82:	75 15                	jne    99 <strcmp+0x39>
    p++, q++;
  84:	89 d9                	mov    %ebx,%ecx
  86:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  89:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  8c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  8f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  93:	84 c0                	test   %al,%al
  95:	75 e9                	jne    80 <strcmp+0x20>
  97:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  99:	29 c8                	sub    %ecx,%eax
}
  9b:	5b                   	pop    %ebx
  9c:	5d                   	pop    %ebp
  9d:	c3                   	ret    
  9e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  a1:	31 c0                	xor    %eax,%eax
  a3:	eb f4                	jmp    99 <strcmp+0x39>
  a5:	0f b6 cb             	movzbl %bl,%ecx
  a8:	eb ef                	jmp    99 <strcmp+0x39>
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 12                	je     cd <strlen+0x1d>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  for(n = 0; s[n]; n++)
  cd:	31 c0                	xor    %eax,%eax
}
  cf:	5d                   	pop    %ebp
  d0:	c3                   	ret    
  d1:	eb 0d                	jmp    e0 <memset>
  d3:	90                   	nop
  d4:	90                   	nop
  d5:	90                   	nop
  d6:	90                   	nop
  d7:	90                   	nop
  d8:	90                   	nop
  d9:	90                   	nop
  da:	90                   	nop
  db:	90                   	nop
  dc:	90                   	nop
  dd:	90                   	nop
  de:	90                   	nop
  df:	90                   	nop

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	53                   	push   %ebx
 107:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 10a:	0f b6 18             	movzbl (%eax),%ebx
 10d:	84 db                	test   %bl,%bl
 10f:	74 1d                	je     12e <strchr+0x2e>
    if(*s == c)
 111:	38 d3                	cmp    %dl,%bl
 113:	89 d1                	mov    %edx,%ecx
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
  for(; *s; s++)
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
      return (char*)s;
  return 0;
 12e:	31 c0                	xor    %eax,%eax
}
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 145:	31 f6                	xor    %esi,%esi
{
 147:	53                   	push   %ebx
 148:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 14b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 14e:	eb 31                	jmp    181 <gets+0x41>
    cc = read(0, &c, 1);
 150:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 157:	00 
 158:	89 7c 24 04          	mov    %edi,0x4(%esp)
 15c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 163:	e8 02 01 00 00       	call   26a <read>
    if(cc < 1)
 168:	85 c0                	test   %eax,%eax
 16a:	7e 1d                	jle    189 <gets+0x49>
      break;
    buf[i++] = c;
 16c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 170:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 172:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 175:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 177:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 17b:	74 0c                	je     189 <gets+0x49>
 17d:	3c 0a                	cmp    $0xa,%al
 17f:	74 08                	je     189 <gets+0x49>
  for(i=0; i+1 < max; ){
 181:	8d 5e 01             	lea    0x1(%esi),%ebx
 184:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 187:	7c c7                	jl     150 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 190:	83 c4 2c             	add    $0x2c,%esp
 193:	5b                   	pop    %ebx
 194:	5e                   	pop    %esi
 195:	5f                   	pop    %edi
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    
 198:	90                   	nop
 199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
 1a5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a8:	8b 45 08             	mov    0x8(%ebp),%eax
 1ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b2:	00 
 1b3:	89 04 24             	mov    %eax,(%esp)
 1b6:	e8 d7 00 00 00       	call   292 <open>
  if(fd < 0)
 1bb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 1bd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1bf:	78 27                	js     1e8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c4:	89 1c 24             	mov    %ebx,(%esp)
 1c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cb:	e8 da 00 00 00       	call   2aa <fstat>
  close(fd);
 1d0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1d3:	89 c6                	mov    %eax,%esi
  close(fd);
 1d5:	e8 a0 00 00 00       	call   27a <close>
  return r;
 1da:	89 f0                	mov    %esi,%eax
}
 1dc:	83 c4 10             	add    $0x10,%esp
 1df:	5b                   	pop    %ebx
 1e0:	5e                   	pop    %esi
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    
 1e3:	90                   	nop
 1e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 1e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1ed:	eb ed                	jmp    1dc <stat+0x3c>
 1ef:	90                   	nop

000001f0 <atoi>:

int
atoi(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f7:	0f be 11             	movsbl (%ecx),%edx
 1fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 1fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 1ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 204:	77 17                	ja     21d <atoi+0x2d>
 206:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 208:	83 c1 01             	add    $0x1,%ecx
 20b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 20e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 212:	0f be 11             	movsbl (%ecx),%edx
 215:	8d 5a d0             	lea    -0x30(%edx),%ebx
 218:	80 fb 09             	cmp    $0x9,%bl
 21b:	76 eb                	jbe    208 <atoi+0x18>
  return n;
}
 21d:	5b                   	pop    %ebx
 21e:	5d                   	pop    %ebp
 21f:	c3                   	ret    

00000220 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 220:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 221:	31 d2                	xor    %edx,%edx
{
 223:	89 e5                	mov    %esp,%ebp
 225:	56                   	push   %esi
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	53                   	push   %ebx
 22a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 22d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 230:	85 db                	test   %ebx,%ebx
 232:	7e 12                	jle    246 <memmove+0x26>
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 238:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 23c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 23f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 242:	39 da                	cmp    %ebx,%edx
 244:	75 f2                	jne    238 <memmove+0x18>
  return vdst;
}
 246:	5b                   	pop    %ebx
 247:	5e                   	pop    %esi
 248:	5d                   	pop    %ebp
 249:	c3                   	ret    

0000024a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 24a:	b8 01 00 00 00       	mov    $0x1,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <exit>:
SYSCALL(exit)
 252:	b8 02 00 00 00       	mov    $0x2,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <wait>:
SYSCALL(wait)
 25a:	b8 03 00 00 00       	mov    $0x3,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <pipe>:
SYSCALL(pipe)
 262:	b8 04 00 00 00       	mov    $0x4,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <read>:
SYSCALL(read)
 26a:	b8 05 00 00 00       	mov    $0x5,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <write>:
SYSCALL(write)
 272:	b8 10 00 00 00       	mov    $0x10,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <close>:
SYSCALL(close)
 27a:	b8 15 00 00 00       	mov    $0x15,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <kill>:
SYSCALL(kill)
 282:	b8 06 00 00 00       	mov    $0x6,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <exec>:
SYSCALL(exec)
 28a:	b8 07 00 00 00       	mov    $0x7,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <open>:
SYSCALL(open)
 292:	b8 0f 00 00 00       	mov    $0xf,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <mknod>:
SYSCALL(mknod)
 29a:	b8 11 00 00 00       	mov    $0x11,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <unlink>:
SYSCALL(unlink)
 2a2:	b8 12 00 00 00       	mov    $0x12,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <fstat>:
SYSCALL(fstat)
 2aa:	b8 08 00 00 00       	mov    $0x8,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <link>:
SYSCALL(link)
 2b2:	b8 13 00 00 00       	mov    $0x13,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <mkdir>:
SYSCALL(mkdir)
 2ba:	b8 14 00 00 00       	mov    $0x14,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <chdir>:
SYSCALL(chdir)
 2c2:	b8 09 00 00 00       	mov    $0x9,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <dup>:
SYSCALL(dup)
 2ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <getpid>:
SYSCALL(getpid)
 2d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <sbrk>:
SYSCALL(sbrk)
 2da:	b8 0c 00 00 00       	mov    $0xc,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <sleep>:
SYSCALL(sleep)
 2e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <uptime>:
SYSCALL(uptime)
 2ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 2f2:	b8 16 00 00 00       	mov    $0x16,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 2fa:	b8 17 00 00 00       	mov    $0x17,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 302:	b8 18 00 00 00       	mov    $0x18,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <halt>:
 30a:	b8 19 00 00 00       	mov    $0x19,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    
 312:	66 90                	xchg   %ax,%ax
 314:	66 90                	xchg   %ax,%ax
 316:	66 90                	xchg   %ax,%ax
 318:	66 90                	xchg   %ax,%ax
 31a:	66 90                	xchg   %ax,%ax
 31c:	66 90                	xchg   %ax,%ax
 31e:	66 90                	xchg   %ax,%ax

00000320 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	89 c6                	mov    %eax,%esi
 327:	53                   	push   %ebx
 328:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 32b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 32e:	85 db                	test   %ebx,%ebx
 330:	74 09                	je     33b <printint+0x1b>
 332:	89 d0                	mov    %edx,%eax
 334:	c1 e8 1f             	shr    $0x1f,%eax
 337:	84 c0                	test   %al,%al
 339:	75 75                	jne    3b0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 33b:	89 d0                	mov    %edx,%eax
  neg = 0;
 33d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 344:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 347:	31 ff                	xor    %edi,%edi
 349:	89 ce                	mov    %ecx,%esi
 34b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 34e:	eb 02                	jmp    352 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 350:	89 cf                	mov    %ecx,%edi
 352:	31 d2                	xor    %edx,%edx
 354:	f7 f6                	div    %esi
 356:	8d 4f 01             	lea    0x1(%edi),%ecx
 359:	0f b6 92 5d 07 00 00 	movzbl 0x75d(%edx),%edx
  }while((x /= base) != 0);
 360:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 362:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 365:	75 e9                	jne    350 <printint+0x30>
  if(neg)
 367:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 36a:	89 c8                	mov    %ecx,%eax
 36c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 36f:	85 d2                	test   %edx,%edx
 371:	74 08                	je     37b <printint+0x5b>
    buf[i++] = '-';
 373:	8d 4f 02             	lea    0x2(%edi),%ecx
 376:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 37b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 37e:	66 90                	xchg   %ax,%ax
 380:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 385:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 388:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 38f:	00 
 390:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 394:	89 34 24             	mov    %esi,(%esp)
 397:	88 45 d7             	mov    %al,-0x29(%ebp)
 39a:	e8 d3 fe ff ff       	call   272 <write>
  while(--i >= 0)
 39f:	83 ff ff             	cmp    $0xffffffff,%edi
 3a2:	75 dc                	jne    380 <printint+0x60>
    putc(fd, buf[i]);
}
 3a4:	83 c4 4c             	add    $0x4c,%esp
 3a7:	5b                   	pop    %ebx
 3a8:	5e                   	pop    %esi
 3a9:	5f                   	pop    %edi
 3aa:	5d                   	pop    %ebp
 3ab:	c3                   	ret    
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 3b0:	89 d0                	mov    %edx,%eax
 3b2:	f7 d8                	neg    %eax
    neg = 1;
 3b4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3bb:	eb 87                	jmp    344 <printint+0x24>
 3bd:	8d 76 00             	lea    0x0(%esi),%esi

000003c0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3c4:	31 ff                	xor    %edi,%edi
{
 3c6:	56                   	push   %esi
 3c7:	53                   	push   %ebx
 3c8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3cb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 3ce:	8d 45 10             	lea    0x10(%ebp),%eax
{
 3d1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 3d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 3d7:	0f b6 13             	movzbl (%ebx),%edx
 3da:	83 c3 01             	add    $0x1,%ebx
 3dd:	84 d2                	test   %dl,%dl
 3df:	75 39                	jne    41a <printf+0x5a>
 3e1:	e9 ca 00 00 00       	jmp    4b0 <printf+0xf0>
 3e6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3e8:	83 fa 25             	cmp    $0x25,%edx
 3eb:	0f 84 c7 00 00 00    	je     4b8 <printf+0xf8>
  write(fd, &c, 1);
 3f1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 3f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3fb:	00 
 3fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 400:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 403:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 406:	e8 67 fe ff ff       	call   272 <write>
 40b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 40e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 412:	84 d2                	test   %dl,%dl
 414:	0f 84 96 00 00 00    	je     4b0 <printf+0xf0>
    if(state == 0){
 41a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 41c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 41f:	74 c7                	je     3e8 <printf+0x28>
      }
    } else if(state == '%'){
 421:	83 ff 25             	cmp    $0x25,%edi
 424:	75 e5                	jne    40b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 426:	83 fa 75             	cmp    $0x75,%edx
 429:	0f 84 99 00 00 00    	je     4c8 <printf+0x108>
 42f:	83 fa 64             	cmp    $0x64,%edx
 432:	0f 84 90 00 00 00    	je     4c8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 438:	25 f7 00 00 00       	and    $0xf7,%eax
 43d:	83 f8 70             	cmp    $0x70,%eax
 440:	0f 84 aa 00 00 00    	je     4f0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 446:	83 fa 73             	cmp    $0x73,%edx
 449:	0f 84 e9 00 00 00    	je     538 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 44f:	83 fa 63             	cmp    $0x63,%edx
 452:	0f 84 2b 01 00 00    	je     583 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 458:	83 fa 25             	cmp    $0x25,%edx
 45b:	0f 84 4f 01 00 00    	je     5b0 <printf+0x1f0>
  write(fd, &c, 1);
 461:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 464:	83 c3 01             	add    $0x1,%ebx
 467:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 46e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 46f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 471:	89 44 24 04          	mov    %eax,0x4(%esp)
 475:	89 34 24             	mov    %esi,(%esp)
 478:	89 55 d0             	mov    %edx,-0x30(%ebp)
 47b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 47f:	e8 ee fd ff ff       	call   272 <write>
        putc(fd, c);
 484:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 487:	8d 45 e7             	lea    -0x19(%ebp),%eax
 48a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 491:	00 
 492:	89 44 24 04          	mov    %eax,0x4(%esp)
 496:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 499:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 49c:	e8 d1 fd ff ff       	call   272 <write>
  for(i = 0; fmt[i]; i++){
 4a1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4a5:	84 d2                	test   %dl,%dl
 4a7:	0f 85 6d ff ff ff    	jne    41a <printf+0x5a>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 4b0:	83 c4 3c             	add    $0x3c,%esp
 4b3:	5b                   	pop    %ebx
 4b4:	5e                   	pop    %esi
 4b5:	5f                   	pop    %edi
 4b6:	5d                   	pop    %ebp
 4b7:	c3                   	ret    
        state = '%';
 4b8:	bf 25 00 00 00       	mov    $0x25,%edi
 4bd:	e9 49 ff ff ff       	jmp    40b <printf+0x4b>
 4c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 4c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 4d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 4d7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 4d9:	8b 10                	mov    (%eax),%edx
 4db:	89 f0                	mov    %esi,%eax
 4dd:	e8 3e fe ff ff       	call   320 <printint>
        ap++;
 4e2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 4e6:	e9 20 ff ff ff       	jmp    40b <printf+0x4b>
 4eb:	90                   	nop
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 4f0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 4f3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4fa:	00 
 4fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ff:	89 34 24             	mov    %esi,(%esp)
 502:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 506:	e8 67 fd ff ff       	call   272 <write>
 50b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 50e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 515:	00 
 516:	89 44 24 04          	mov    %eax,0x4(%esp)
 51a:	89 34 24             	mov    %esi,(%esp)
 51d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 521:	e8 4c fd ff ff       	call   272 <write>
        printint(fd, *ap, 16, 0);
 526:	b9 10 00 00 00       	mov    $0x10,%ecx
 52b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 532:	eb a0                	jmp    4d4 <printf+0x114>
 534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 538:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 53b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 53f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 541:	b8 56 07 00 00       	mov    $0x756,%eax
 546:	85 ff                	test   %edi,%edi
 548:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 54b:	0f b6 07             	movzbl (%edi),%eax
 54e:	84 c0                	test   %al,%al
 550:	74 2a                	je     57c <printf+0x1bc>
 552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 558:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 55b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 55e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 561:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 568:	00 
 569:	89 44 24 04          	mov    %eax,0x4(%esp)
 56d:	89 34 24             	mov    %esi,(%esp)
 570:	e8 fd fc ff ff       	call   272 <write>
        while(*s != 0){
 575:	0f b6 07             	movzbl (%edi),%eax
 578:	84 c0                	test   %al,%al
 57a:	75 dc                	jne    558 <printf+0x198>
      state = 0;
 57c:	31 ff                	xor    %edi,%edi
 57e:	e9 88 fe ff ff       	jmp    40b <printf+0x4b>
        putc(fd, *ap);
 583:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 586:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 588:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 58a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 591:	00 
 592:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 595:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 598:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 59b:	89 44 24 04          	mov    %eax,0x4(%esp)
 59f:	e8 ce fc ff ff       	call   272 <write>
        ap++;
 5a4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5a8:	e9 5e fe ff ff       	jmp    40b <printf+0x4b>
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5b0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 5b3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5b5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5bc:	00 
 5bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c1:	89 34 24             	mov    %esi,(%esp)
 5c4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 5c8:	e8 a5 fc ff ff       	call   272 <write>
 5cd:	e9 39 fe ff ff       	jmp    40b <printf+0x4b>
 5d2:	66 90                	xchg   %ax,%ax
 5d4:	66 90                	xchg   %ax,%ax
 5d6:	66 90                	xchg   %ax,%ax
 5d8:	66 90                	xchg   %ax,%ax
 5da:	66 90                	xchg   %ax,%ax
 5dc:	66 90                	xchg   %ax,%ax
 5de:	66 90                	xchg   %ax,%ax

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 d4 09 00 00       	mov    0x9d4,%eax
{
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ee:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 5f0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f3:	39 d0                	cmp    %edx,%eax
 5f5:	72 11                	jb     608 <free+0x28>
 5f7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f8:	39 c8                	cmp    %ecx,%eax
 5fa:	72 04                	jb     600 <free+0x20>
 5fc:	39 ca                	cmp    %ecx,%edx
 5fe:	72 10                	jb     610 <free+0x30>
 600:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 602:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 604:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 606:	73 f0                	jae    5f8 <free+0x18>
 608:	39 ca                	cmp    %ecx,%edx
 60a:	72 04                	jb     610 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60c:	39 c8                	cmp    %ecx,%eax
 60e:	72 f0                	jb     600 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 610:	8b 73 fc             	mov    -0x4(%ebx),%esi
 613:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 616:	39 cf                	cmp    %ecx,%edi
 618:	74 1e                	je     638 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 61a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 61d:	8b 48 04             	mov    0x4(%eax),%ecx
 620:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 623:	39 f2                	cmp    %esi,%edx
 625:	74 28                	je     64f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 627:	89 10                	mov    %edx,(%eax)
  freep = p;
 629:	a3 d4 09 00 00       	mov    %eax,0x9d4
}
 62e:	5b                   	pop    %ebx
 62f:	5e                   	pop    %esi
 630:	5f                   	pop    %edi
 631:	5d                   	pop    %ebp
 632:	c3                   	ret    
 633:	90                   	nop
 634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 638:	03 71 04             	add    0x4(%ecx),%esi
 63b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 63e:	8b 08                	mov    (%eax),%ecx
 640:	8b 09                	mov    (%ecx),%ecx
 642:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 645:	8b 48 04             	mov    0x4(%eax),%ecx
 648:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 64b:	39 f2                	cmp    %esi,%edx
 64d:	75 d8                	jne    627 <free+0x47>
    p->s.size += bp->s.size;
 64f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 652:	a3 d4 09 00 00       	mov    %eax,0x9d4
    p->s.size += bp->s.size;
 657:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 65a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 65d:	89 10                	mov    %edx,(%eax)
}
 65f:	5b                   	pop    %ebx
 660:	5e                   	pop    %esi
 661:	5f                   	pop    %edi
 662:	5d                   	pop    %ebp
 663:	c3                   	ret    
 664:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 66a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 679:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 67c:	8b 1d d4 09 00 00    	mov    0x9d4,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 682:	8d 48 07             	lea    0x7(%eax),%ecx
 685:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 688:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 68a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 68d:	0f 84 9b 00 00 00    	je     72e <malloc+0xbe>
 693:	8b 13                	mov    (%ebx),%edx
 695:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 698:	39 fe                	cmp    %edi,%esi
 69a:	76 64                	jbe    700 <malloc+0x90>
 69c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 6a3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 6a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6ab:	eb 0e                	jmp    6bb <malloc+0x4b>
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6b2:	8b 78 04             	mov    0x4(%eax),%edi
 6b5:	39 fe                	cmp    %edi,%esi
 6b7:	76 4f                	jbe    708 <malloc+0x98>
 6b9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6bb:	3b 15 d4 09 00 00    	cmp    0x9d4,%edx
 6c1:	75 ed                	jne    6b0 <malloc+0x40>
  if(nu < 4096)
 6c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6c6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6cc:	bf 00 10 00 00       	mov    $0x1000,%edi
 6d1:	0f 43 fe             	cmovae %esi,%edi
 6d4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 6d7:	89 04 24             	mov    %eax,(%esp)
 6da:	e8 fb fb ff ff       	call   2da <sbrk>
  if(p == (char*)-1)
 6df:	83 f8 ff             	cmp    $0xffffffff,%eax
 6e2:	74 18                	je     6fc <malloc+0x8c>
  hp->s.size = nu;
 6e4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6e7:	83 c0 08             	add    $0x8,%eax
 6ea:	89 04 24             	mov    %eax,(%esp)
 6ed:	e8 ee fe ff ff       	call   5e0 <free>
  return freep;
 6f2:	8b 15 d4 09 00 00    	mov    0x9d4,%edx
      if((p = morecore(nunits)) == 0)
 6f8:	85 d2                	test   %edx,%edx
 6fa:	75 b4                	jne    6b0 <malloc+0x40>
        return 0;
 6fc:	31 c0                	xor    %eax,%eax
 6fe:	eb 20                	jmp    720 <malloc+0xb0>
    if(p->s.size >= nunits){
 700:	89 d0                	mov    %edx,%eax
 702:	89 da                	mov    %ebx,%edx
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 708:	39 fe                	cmp    %edi,%esi
 70a:	74 1c                	je     728 <malloc+0xb8>
        p->s.size -= nunits;
 70c:	29 f7                	sub    %esi,%edi
 70e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 711:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 714:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 717:	89 15 d4 09 00 00    	mov    %edx,0x9d4
      return (void*)(p + 1);
 71d:	83 c0 08             	add    $0x8,%eax
  }
}
 720:	83 c4 1c             	add    $0x1c,%esp
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
 725:	5f                   	pop    %edi
 726:	5d                   	pop    %ebp
 727:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 728:	8b 08                	mov    (%eax),%ecx
 72a:	89 0a                	mov    %ecx,(%edx)
 72c:	eb e9                	jmp    717 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 72e:	c7 05 d4 09 00 00 d8 	movl   $0x9d8,0x9d4
 735:	09 00 00 
    base.s.size = 0;
 738:	ba d8 09 00 00       	mov    $0x9d8,%edx
    base.s.ptr = freep = prevp = &base;
 73d:	c7 05 d8 09 00 00 d8 	movl   $0x9d8,0x9d8
 744:	09 00 00 
    base.s.size = 0;
 747:	c7 05 dc 09 00 00 00 	movl   $0x0,0x9dc
 74e:	00 00 00 
 751:	e9 46 ff ff ff       	jmp    69c <malloc+0x2c>
