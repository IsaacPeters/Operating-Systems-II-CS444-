
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
  int i;

  if(argc < 2){
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
{
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 23                	jle    3f <main+0x3f>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  for(i=1; i<argc; i++)
  23:	83 c3 01             	add    $0x1,%ebx
    kill(atoi(argv[i]));
  26:	89 04 24             	mov    %eax,(%esp)
  29:	e8 f2 01 00 00       	call   220 <atoi>
  2e:	89 04 24             	mov    %eax,(%esp)
  31:	e8 7c 02 00 00       	call   2b2 <kill>
  for(i=1; i<argc; i++)
  36:	39 f3                	cmp    %esi,%ebx
  38:	75 e6                	jne    20 <main+0x20>
  exit();
  3a:	e8 43 02 00 00       	call   282 <exit>
    printf(2, "usage: kill pid...\n");
  3f:	c7 44 24 04 76 07 00 	movl   $0x776,0x4(%esp)
  46:	00 
  47:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4e:	e8 8d 03 00 00       	call   3e0 <printf>
    exit();
  53:	e8 2a 02 00 00       	call   282 <exit>
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 45 08             	mov    0x8(%ebp),%eax
  66:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  69:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	83 c1 01             	add    $0x1,%ecx
  73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 db                	test   %bl,%bl
  7c:	88 5a ff             	mov    %bl,-0x1(%edx)
  7f:	75 ef                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  81:	5b                   	pop    %ebx
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    
  84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 55 08             	mov    0x8(%ebp),%edx
  96:	53                   	push   %ebx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	74 2d                	je     ce <strcmp+0x3e>
  a1:	0f b6 19             	movzbl (%ecx),%ebx
  a4:	38 d8                	cmp    %bl,%al
  a6:	74 0e                	je     b6 <strcmp+0x26>
  a8:	eb 2b                	jmp    d5 <strcmp+0x45>
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  b0:	38 c8                	cmp    %cl,%al
  b2:	75 15                	jne    c9 <strcmp+0x39>
    p++, q++;
  b4:	89 d9                	mov    %ebx,%ecx
  b6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  bc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  bf:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  c3:	84 c0                	test   %al,%al
  c5:	75 e9                	jne    b0 <strcmp+0x20>
  c7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  c9:	29 c8                	sub    %ecx,%eax
}
  cb:	5b                   	pop    %ebx
  cc:	5d                   	pop    %ebp
  cd:	c3                   	ret    
  ce:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  d1:	31 c0                	xor    %eax,%eax
  d3:	eb f4                	jmp    c9 <strcmp+0x39>
  d5:	0f b6 cb             	movzbl %bl,%ecx
  d8:	eb ef                	jmp    c9 <strcmp+0x39>
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 12                	je     fd <strlen+0x1d>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  for(n = 0; s[n]; n++)
  fd:	31 c0                	xor    %eax,%eax
}
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    
 101:	eb 0d                	jmp    110 <memset>
 103:	90                   	nop
 104:	90                   	nop
 105:	90                   	nop
 106:	90                   	nop
 107:	90                   	nop
 108:	90                   	nop
 109:	90                   	nop
 10a:	90                   	nop
 10b:	90                   	nop
 10c:	90                   	nop
 10d:	90                   	nop
 10e:	90                   	nop
 10f:	90                   	nop

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	53                   	push   %ebx
 137:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 13a:	0f b6 18             	movzbl (%eax),%ebx
 13d:	84 db                	test   %bl,%bl
 13f:	74 1d                	je     15e <strchr+0x2e>
    if(*s == c)
 141:	38 d3                	cmp    %dl,%bl
 143:	89 d1                	mov    %edx,%ecx
 145:	75 0d                	jne    154 <strchr+0x24>
 147:	eb 17                	jmp    160 <strchr+0x30>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
  for(; *s; s++)
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
 15e:	31 c0                	xor    %eax,%eax
}
 160:	5b                   	pop    %ebx
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 175:	31 f6                	xor    %esi,%esi
{
 177:	53                   	push   %ebx
 178:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 17b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 17e:	eb 31                	jmp    1b1 <gets+0x41>
    cc = read(0, &c, 1);
 180:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 187:	00 
 188:	89 7c 24 04          	mov    %edi,0x4(%esp)
 18c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 193:	e8 02 01 00 00       	call   29a <read>
    if(cc < 1)
 198:	85 c0                	test   %eax,%eax
 19a:	7e 1d                	jle    1b9 <gets+0x49>
      break;
    buf[i++] = c;
 19c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 1a0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 1a2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 1a5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 1a7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1ab:	74 0c                	je     1b9 <gets+0x49>
 1ad:	3c 0a                	cmp    $0xa,%al
 1af:	74 08                	je     1b9 <gets+0x49>
  for(i=0; i+1 < max; ){
 1b1:	8d 5e 01             	lea    0x1(%esi),%ebx
 1b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b7:	7c c7                	jl     180 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1c0:	83 c4 2c             	add    $0x2c,%esp
 1c3:	5b                   	pop    %ebx
 1c4:	5e                   	pop    %esi
 1c5:	5f                   	pop    %edi
 1c6:	5d                   	pop    %ebp
 1c7:	c3                   	ret    
 1c8:	90                   	nop
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d8:	8b 45 08             	mov    0x8(%ebp),%eax
 1db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1e2:	00 
 1e3:	89 04 24             	mov    %eax,(%esp)
 1e6:	e8 d7 00 00 00       	call   2c2 <open>
  if(fd < 0)
 1eb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 1ed:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1ef:	78 27                	js     218 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1f1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f4:	89 1c 24             	mov    %ebx,(%esp)
 1f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fb:	e8 da 00 00 00       	call   2da <fstat>
  close(fd);
 200:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 203:	89 c6                	mov    %eax,%esi
  close(fd);
 205:	e8 a0 00 00 00       	call   2aa <close>
  return r;
 20a:	89 f0                	mov    %esi,%eax
}
 20c:	83 c4 10             	add    $0x10,%esp
 20f:	5b                   	pop    %ebx
 210:	5e                   	pop    %esi
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	90                   	nop
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 218:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 21d:	eb ed                	jmp    20c <stat+0x3c>
 21f:	90                   	nop

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 4d 08             	mov    0x8(%ebp),%ecx
 226:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	0f be 11             	movsbl (%ecx),%edx
 22a:	8d 42 d0             	lea    -0x30(%edx),%eax
 22d:	3c 09                	cmp    $0x9,%al
  n = 0;
 22f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 234:	77 17                	ja     24d <atoi+0x2d>
 236:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 238:	83 c1 01             	add    $0x1,%ecx
 23b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 23e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 242:	0f be 11             	movsbl (%ecx),%edx
 245:	8d 5a d0             	lea    -0x30(%edx),%ebx
 248:	80 fb 09             	cmp    $0x9,%bl
 24b:	76 eb                	jbe    238 <atoi+0x18>
  return n;
}
 24d:	5b                   	pop    %ebx
 24e:	5d                   	pop    %ebp
 24f:	c3                   	ret    

00000250 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 250:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 251:	31 d2                	xor    %edx,%edx
{
 253:	89 e5                	mov    %esp,%ebp
 255:	56                   	push   %esi
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	53                   	push   %ebx
 25a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 25d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 260:	85 db                	test   %ebx,%ebx
 262:	7e 12                	jle    276 <memmove+0x26>
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 272:	39 da                	cmp    %ebx,%edx
 274:	75 f2                	jne    268 <memmove+0x18>
  return vdst;
}
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5d                   	pop    %ebp
 279:	c3                   	ret    

0000027a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27a:	b8 01 00 00 00       	mov    $0x1,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <exit>:
SYSCALL(exit)
 282:	b8 02 00 00 00       	mov    $0x2,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <wait>:
SYSCALL(wait)
 28a:	b8 03 00 00 00       	mov    $0x3,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <pipe>:
SYSCALL(pipe)
 292:	b8 04 00 00 00       	mov    $0x4,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <read>:
SYSCALL(read)
 29a:	b8 05 00 00 00       	mov    $0x5,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <write>:
SYSCALL(write)
 2a2:	b8 10 00 00 00       	mov    $0x10,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <close>:
SYSCALL(close)
 2aa:	b8 15 00 00 00       	mov    $0x15,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <kill>:
SYSCALL(kill)
 2b2:	b8 06 00 00 00       	mov    $0x6,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <exec>:
SYSCALL(exec)
 2ba:	b8 07 00 00 00       	mov    $0x7,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <open>:
SYSCALL(open)
 2c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <mknod>:
SYSCALL(mknod)
 2ca:	b8 11 00 00 00       	mov    $0x11,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <unlink>:
SYSCALL(unlink)
 2d2:	b8 12 00 00 00       	mov    $0x12,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <fstat>:
SYSCALL(fstat)
 2da:	b8 08 00 00 00       	mov    $0x8,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <link>:
SYSCALL(link)
 2e2:	b8 13 00 00 00       	mov    $0x13,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mkdir>:
SYSCALL(mkdir)
 2ea:	b8 14 00 00 00       	mov    $0x14,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <chdir>:
SYSCALL(chdir)
 2f2:	b8 09 00 00 00       	mov    $0x9,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <dup>:
SYSCALL(dup)
 2fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <getpid>:
SYSCALL(getpid)
 302:	b8 0b 00 00 00       	mov    $0xb,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <sbrk>:
SYSCALL(sbrk)
 30a:	b8 0c 00 00 00       	mov    $0xc,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <sleep>:
SYSCALL(sleep)
 312:	b8 0d 00 00 00       	mov    $0xd,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <uptime>:
SYSCALL(uptime)
 31a:	b8 0e 00 00 00       	mov    $0xe,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 322:	b8 16 00 00 00       	mov    $0x16,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 32a:	b8 17 00 00 00       	mov    $0x17,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 332:	b8 18 00 00 00       	mov    $0x18,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	89 c6                	mov    %eax,%esi
 347:	53                   	push   %ebx
 348:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 34e:	85 db                	test   %ebx,%ebx
 350:	74 09                	je     35b <printint+0x1b>
 352:	89 d0                	mov    %edx,%eax
 354:	c1 e8 1f             	shr    $0x1f,%eax
 357:	84 c0                	test   %al,%al
 359:	75 75                	jne    3d0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 35b:	89 d0                	mov    %edx,%eax
  neg = 0;
 35d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 364:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 367:	31 ff                	xor    %edi,%edi
 369:	89 ce                	mov    %ecx,%esi
 36b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 36e:	eb 02                	jmp    372 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 370:	89 cf                	mov    %ecx,%edi
 372:	31 d2                	xor    %edx,%edx
 374:	f7 f6                	div    %esi
 376:	8d 4f 01             	lea    0x1(%edi),%ecx
 379:	0f b6 92 91 07 00 00 	movzbl 0x791(%edx),%edx
  }while((x /= base) != 0);
 380:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 382:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 385:	75 e9                	jne    370 <printint+0x30>
  if(neg)
 387:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 38a:	89 c8                	mov    %ecx,%eax
 38c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 38f:	85 d2                	test   %edx,%edx
 391:	74 08                	je     39b <printint+0x5b>
    buf[i++] = '-';
 393:	8d 4f 02             	lea    0x2(%edi),%ecx
 396:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 39b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 39e:	66 90                	xchg   %ax,%ax
 3a0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 3a5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 3a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3af:	00 
 3b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3b4:	89 34 24             	mov    %esi,(%esp)
 3b7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3ba:	e8 e3 fe ff ff       	call   2a2 <write>
  while(--i >= 0)
 3bf:	83 ff ff             	cmp    $0xffffffff,%edi
 3c2:	75 dc                	jne    3a0 <printint+0x60>
    putc(fd, buf[i]);
}
 3c4:	83 c4 4c             	add    $0x4c,%esp
 3c7:	5b                   	pop    %ebx
 3c8:	5e                   	pop    %esi
 3c9:	5f                   	pop    %edi
 3ca:	5d                   	pop    %ebp
 3cb:	c3                   	ret    
 3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 3d0:	89 d0                	mov    %edx,%eax
 3d2:	f7 d8                	neg    %eax
    neg = 1;
 3d4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3db:	eb 87                	jmp    364 <printint+0x24>
 3dd:	8d 76 00             	lea    0x0(%esi),%esi

000003e0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3e4:	31 ff                	xor    %edi,%edi
{
 3e6:	56                   	push   %esi
 3e7:	53                   	push   %ebx
 3e8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 3ee:	8d 45 10             	lea    0x10(%ebp),%eax
{
 3f1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 3f4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 3f7:	0f b6 13             	movzbl (%ebx),%edx
 3fa:	83 c3 01             	add    $0x1,%ebx
 3fd:	84 d2                	test   %dl,%dl
 3ff:	75 39                	jne    43a <printf+0x5a>
 401:	e9 ca 00 00 00       	jmp    4d0 <printf+0xf0>
 406:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 408:	83 fa 25             	cmp    $0x25,%edx
 40b:	0f 84 c7 00 00 00    	je     4d8 <printf+0xf8>
  write(fd, &c, 1);
 411:	8d 45 e0             	lea    -0x20(%ebp),%eax
 414:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 41b:	00 
 41c:	89 44 24 04          	mov    %eax,0x4(%esp)
 420:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 423:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 426:	e8 77 fe ff ff       	call   2a2 <write>
 42b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 42e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 432:	84 d2                	test   %dl,%dl
 434:	0f 84 96 00 00 00    	je     4d0 <printf+0xf0>
    if(state == 0){
 43a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 43c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 43f:	74 c7                	je     408 <printf+0x28>
      }
    } else if(state == '%'){
 441:	83 ff 25             	cmp    $0x25,%edi
 444:	75 e5                	jne    42b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 446:	83 fa 75             	cmp    $0x75,%edx
 449:	0f 84 99 00 00 00    	je     4e8 <printf+0x108>
 44f:	83 fa 64             	cmp    $0x64,%edx
 452:	0f 84 90 00 00 00    	je     4e8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 458:	25 f7 00 00 00       	and    $0xf7,%eax
 45d:	83 f8 70             	cmp    $0x70,%eax
 460:	0f 84 aa 00 00 00    	je     510 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 466:	83 fa 73             	cmp    $0x73,%edx
 469:	0f 84 e9 00 00 00    	je     558 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 46f:	83 fa 63             	cmp    $0x63,%edx
 472:	0f 84 2b 01 00 00    	je     5a3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 478:	83 fa 25             	cmp    $0x25,%edx
 47b:	0f 84 4f 01 00 00    	je     5d0 <printf+0x1f0>
  write(fd, &c, 1);
 481:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 484:	83 c3 01             	add    $0x1,%ebx
 487:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 48e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 48f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 491:	89 44 24 04          	mov    %eax,0x4(%esp)
 495:	89 34 24             	mov    %esi,(%esp)
 498:	89 55 d0             	mov    %edx,-0x30(%ebp)
 49b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 49f:	e8 fe fd ff ff       	call   2a2 <write>
        putc(fd, c);
 4a4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 4a7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4b1:	00 
 4b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 4b9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4bc:	e8 e1 fd ff ff       	call   2a2 <write>
  for(i = 0; fmt[i]; i++){
 4c1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4c5:	84 d2                	test   %dl,%dl
 4c7:	0f 85 6d ff ff ff    	jne    43a <printf+0x5a>
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 4d0:	83 c4 3c             	add    $0x3c,%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5f                   	pop    %edi
 4d6:	5d                   	pop    %ebp
 4d7:	c3                   	ret    
        state = '%';
 4d8:	bf 25 00 00 00       	mov    $0x25,%edi
 4dd:	e9 49 ff ff ff       	jmp    42b <printf+0x4b>
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 4e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4ef:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 4f4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 4f7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 4f9:	8b 10                	mov    (%eax),%edx
 4fb:	89 f0                	mov    %esi,%eax
 4fd:	e8 3e fe ff ff       	call   340 <printint>
        ap++;
 502:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 506:	e9 20 ff ff ff       	jmp    42b <printf+0x4b>
 50b:	90                   	nop
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 510:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 513:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 51a:	00 
 51b:	89 44 24 04          	mov    %eax,0x4(%esp)
 51f:	89 34 24             	mov    %esi,(%esp)
 522:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 526:	e8 77 fd ff ff       	call   2a2 <write>
 52b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 52e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 535:	00 
 536:	89 44 24 04          	mov    %eax,0x4(%esp)
 53a:	89 34 24             	mov    %esi,(%esp)
 53d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 541:	e8 5c fd ff ff       	call   2a2 <write>
        printint(fd, *ap, 16, 0);
 546:	b9 10 00 00 00       	mov    $0x10,%ecx
 54b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 552:	eb a0                	jmp    4f4 <printf+0x114>
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 558:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 55b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 55f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 561:	b8 8a 07 00 00       	mov    $0x78a,%eax
 566:	85 ff                	test   %edi,%edi
 568:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 56b:	0f b6 07             	movzbl (%edi),%eax
 56e:	84 c0                	test   %al,%al
 570:	74 2a                	je     59c <printf+0x1bc>
 572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 578:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 57b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 57e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 581:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 588:	00 
 589:	89 44 24 04          	mov    %eax,0x4(%esp)
 58d:	89 34 24             	mov    %esi,(%esp)
 590:	e8 0d fd ff ff       	call   2a2 <write>
        while(*s != 0){
 595:	0f b6 07             	movzbl (%edi),%eax
 598:	84 c0                	test   %al,%al
 59a:	75 dc                	jne    578 <printf+0x198>
      state = 0;
 59c:	31 ff                	xor    %edi,%edi
 59e:	e9 88 fe ff ff       	jmp    42b <printf+0x4b>
        putc(fd, *ap);
 5a3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5a6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 5a8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 5aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5b1:	00 
 5b2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 5b5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5b8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bf:	e8 de fc ff ff       	call   2a2 <write>
        ap++;
 5c4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5c8:	e9 5e fe ff ff       	jmp    42b <printf+0x4b>
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5d0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 5d3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5d5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5dc:	00 
 5dd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e1:	89 34 24             	mov    %esi,(%esp)
 5e4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 5e8:	e8 b5 fc ff ff       	call   2a2 <write>
 5ed:	e9 39 fe ff ff       	jmp    42b <printf+0x4b>
 5f2:	66 90                	xchg   %ax,%ax
 5f4:	66 90                	xchg   %ax,%ax
 5f6:	66 90                	xchg   %ax,%ax
 5f8:	66 90                	xchg   %ax,%ax
 5fa:	66 90                	xchg   %ax,%ax
 5fc:	66 90                	xchg   %ax,%ax
 5fe:	66 90                	xchg   %ax,%ax

00000600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 0c 0a 00 00       	mov    0xa0c,%eax
{
 606:	89 e5                	mov    %esp,%ebp
 608:	57                   	push   %edi
 609:	56                   	push   %esi
 60a:	53                   	push   %ebx
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 610:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 613:	39 d0                	cmp    %edx,%eax
 615:	72 11                	jb     628 <free+0x28>
 617:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 618:	39 c8                	cmp    %ecx,%eax
 61a:	72 04                	jb     620 <free+0x20>
 61c:	39 ca                	cmp    %ecx,%edx
 61e:	72 10                	jb     630 <free+0x30>
 620:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 622:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 624:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 626:	73 f0                	jae    618 <free+0x18>
 628:	39 ca                	cmp    %ecx,%edx
 62a:	72 04                	jb     630 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62c:	39 c8                	cmp    %ecx,%eax
 62e:	72 f0                	jb     620 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 630:	8b 73 fc             	mov    -0x4(%ebx),%esi
 633:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 636:	39 cf                	cmp    %ecx,%edi
 638:	74 1e                	je     658 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 63a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 63d:	8b 48 04             	mov    0x4(%eax),%ecx
 640:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 643:	39 f2                	cmp    %esi,%edx
 645:	74 28                	je     66f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 647:	89 10                	mov    %edx,(%eax)
  freep = p;
 649:	a3 0c 0a 00 00       	mov    %eax,0xa0c
}
 64e:	5b                   	pop    %ebx
 64f:	5e                   	pop    %esi
 650:	5f                   	pop    %edi
 651:	5d                   	pop    %ebp
 652:	c3                   	ret    
 653:	90                   	nop
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 658:	03 71 04             	add    0x4(%ecx),%esi
 65b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 65e:	8b 08                	mov    (%eax),%ecx
 660:	8b 09                	mov    (%ecx),%ecx
 662:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 665:	8b 48 04             	mov    0x4(%eax),%ecx
 668:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 66b:	39 f2                	cmp    %esi,%edx
 66d:	75 d8                	jne    647 <free+0x47>
    p->s.size += bp->s.size;
 66f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 672:	a3 0c 0a 00 00       	mov    %eax,0xa0c
    p->s.size += bp->s.size;
 677:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 67a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 67d:	89 10                	mov    %edx,(%eax)
}
 67f:	5b                   	pop    %ebx
 680:	5e                   	pop    %esi
 681:	5f                   	pop    %edi
 682:	5d                   	pop    %ebp
 683:	c3                   	ret    
 684:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 68a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 699:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 69c:	8b 1d 0c 0a 00 00    	mov    0xa0c,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a2:	8d 48 07             	lea    0x7(%eax),%ecx
 6a5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 6a8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6aa:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 6ad:	0f 84 9b 00 00 00    	je     74e <malloc+0xbe>
 6b3:	8b 13                	mov    (%ebx),%edx
 6b5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6b8:	39 fe                	cmp    %edi,%esi
 6ba:	76 64                	jbe    720 <malloc+0x90>
 6bc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 6c3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 6c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6cb:	eb 0e                	jmp    6db <malloc+0x4b>
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6d2:	8b 78 04             	mov    0x4(%eax),%edi
 6d5:	39 fe                	cmp    %edi,%esi
 6d7:	76 4f                	jbe    728 <malloc+0x98>
 6d9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6db:	3b 15 0c 0a 00 00    	cmp    0xa0c,%edx
 6e1:	75 ed                	jne    6d0 <malloc+0x40>
  if(nu < 4096)
 6e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6ec:	bf 00 10 00 00       	mov    $0x1000,%edi
 6f1:	0f 43 fe             	cmovae %esi,%edi
 6f4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 6f7:	89 04 24             	mov    %eax,(%esp)
 6fa:	e8 0b fc ff ff       	call   30a <sbrk>
  if(p == (char*)-1)
 6ff:	83 f8 ff             	cmp    $0xffffffff,%eax
 702:	74 18                	je     71c <malloc+0x8c>
  hp->s.size = nu;
 704:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 707:	83 c0 08             	add    $0x8,%eax
 70a:	89 04 24             	mov    %eax,(%esp)
 70d:	e8 ee fe ff ff       	call   600 <free>
  return freep;
 712:	8b 15 0c 0a 00 00    	mov    0xa0c,%edx
      if((p = morecore(nunits)) == 0)
 718:	85 d2                	test   %edx,%edx
 71a:	75 b4                	jne    6d0 <malloc+0x40>
        return 0;
 71c:	31 c0                	xor    %eax,%eax
 71e:	eb 20                	jmp    740 <malloc+0xb0>
    if(p->s.size >= nunits){
 720:	89 d0                	mov    %edx,%eax
 722:	89 da                	mov    %ebx,%edx
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 728:	39 fe                	cmp    %edi,%esi
 72a:	74 1c                	je     748 <malloc+0xb8>
        p->s.size -= nunits;
 72c:	29 f7                	sub    %esi,%edi
 72e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 731:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 734:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 737:	89 15 0c 0a 00 00    	mov    %edx,0xa0c
      return (void*)(p + 1);
 73d:	83 c0 08             	add    $0x8,%eax
  }
}
 740:	83 c4 1c             	add    $0x1c,%esp
 743:	5b                   	pop    %ebx
 744:	5e                   	pop    %esi
 745:	5f                   	pop    %edi
 746:	5d                   	pop    %ebp
 747:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 748:	8b 08                	mov    (%eax),%ecx
 74a:	89 0a                	mov    %ecx,(%edx)
 74c:	eb e9                	jmp    737 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 74e:	c7 05 0c 0a 00 00 10 	movl   $0xa10,0xa0c
 755:	0a 00 00 
    base.s.size = 0;
 758:	ba 10 0a 00 00       	mov    $0xa10,%edx
    base.s.ptr = freep = prevp = &base;
 75d:	c7 05 10 0a 00 00 10 	movl   $0xa10,0xa10
 764:	0a 00 00 
    base.s.size = 0;
 767:	c7 05 14 0a 00 00 00 	movl   $0x0,0xa14
 76e:	00 00 00 
 771:	e9 46 ff ff ff       	jmp    6bc <malloc+0x2c>
