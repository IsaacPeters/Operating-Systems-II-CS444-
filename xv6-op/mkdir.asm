
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
  int i;

  if(argc < 2){
   5:	be 01 00 00 00       	mov    $0x1,%esi
{
   a:	53                   	push   %ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 7d 08             	mov    0x8(%ebp),%edi
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(argc < 2){
  17:	83 ff 01             	cmp    $0x1,%edi
  1a:	8d 58 04             	lea    0x4(%eax),%ebx
  1d:	7e 3a                	jle    59 <main+0x59>
  1f:	90                   	nop
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  20:	8b 03                	mov    (%ebx),%eax
  22:	89 04 24             	mov    %eax,(%esp)
  25:	e8 e0 02 00 00       	call   30a <mkdir>
  2a:	85 c0                	test   %eax,%eax
  2c:	78 0f                	js     3d <main+0x3d>
  for(i = 1; i < argc; i++){
  2e:	83 c6 01             	add    $0x1,%esi
  31:	83 c3 04             	add    $0x4,%ebx
  34:	39 fe                	cmp    %edi,%esi
  36:	75 e8                	jne    20 <main+0x20>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  38:	e8 65 02 00 00       	call   2a2 <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  3d:	8b 03                	mov    (%ebx),%eax
  3f:	c7 44 24 04 ad 07 00 	movl   $0x7ad,0x4(%esp)
  46:	00 
  47:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4e:	89 44 24 08          	mov    %eax,0x8(%esp)
  52:	e8 a9 03 00 00       	call   400 <printf>
      break;
  57:	eb df                	jmp    38 <main+0x38>
    printf(2, "Usage: mkdir files...\n");
  59:	c7 44 24 04 96 07 00 	movl   $0x796,0x4(%esp)
  60:	00 
  61:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  68:	e8 93 03 00 00       	call   400 <printf>
    exit();
  6d:	e8 30 02 00 00       	call   2a2 <exit>
  72:	66 90                	xchg   %ax,%ax
  74:	66 90                	xchg   %ax,%ax
  76:	66 90                	xchg   %ax,%ax
  78:	66 90                	xchg   %ax,%ax
  7a:	66 90                	xchg   %ax,%ax
  7c:	66 90                	xchg   %ax,%ax
  7e:	66 90                	xchg   %ax,%ax

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 45 08             	mov    0x8(%ebp),%eax
  86:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  89:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 55 08             	mov    0x8(%ebp),%edx
  b6:	53                   	push   %ebx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	74 2d                	je     ee <strcmp+0x3e>
  c1:	0f b6 19             	movzbl (%ecx),%ebx
  c4:	38 d8                	cmp    %bl,%al
  c6:	74 0e                	je     d6 <strcmp+0x26>
  c8:	eb 2b                	jmp    f5 <strcmp+0x45>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d0:	38 c8                	cmp    %cl,%al
  d2:	75 15                	jne    e9 <strcmp+0x39>
    p++, q++;
  d4:	89 d9                	mov    %ebx,%ecx
  d6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  d9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  dc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  df:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  e3:	84 c0                	test   %al,%al
  e5:	75 e9                	jne    d0 <strcmp+0x20>
  e7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  e9:	29 c8                	sub    %ecx,%eax
}
  eb:	5b                   	pop    %ebx
  ec:	5d                   	pop    %ebp
  ed:	c3                   	ret    
  ee:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  f1:	31 c0                	xor    %eax,%eax
  f3:	eb f4                	jmp    e9 <strcmp+0x39>
  f5:	0f b6 cb             	movzbl %bl,%ecx
  f8:	eb ef                	jmp    e9 <strcmp+0x39>
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 12                	je     11d <strlen+0x1d>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 11d:	31 c0                	xor    %eax,%eax
}
 11f:	5d                   	pop    %ebp
 120:	c3                   	ret    
 121:	eb 0d                	jmp    130 <memset>
 123:	90                   	nop
 124:	90                   	nop
 125:	90                   	nop
 126:	90                   	nop
 127:	90                   	nop
 128:	90                   	nop
 129:	90                   	nop
 12a:	90                   	nop
 12b:	90                   	nop
 12c:	90                   	nop
 12d:	90                   	nop
 12e:	90                   	nop
 12f:	90                   	nop

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 55 08             	mov    0x8(%ebp),%edx
 136:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	53                   	push   %ebx
 157:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 15a:	0f b6 18             	movzbl (%eax),%ebx
 15d:	84 db                	test   %bl,%bl
 15f:	74 1d                	je     17e <strchr+0x2e>
    if(*s == c)
 161:	38 d3                	cmp    %dl,%bl
 163:	89 d1                	mov    %edx,%ecx
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	31 f6                	xor    %esi,%esi
{
 197:	53                   	push   %ebx
 198:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 19b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 19e:	eb 31                	jmp    1d1 <gets+0x41>
    cc = read(0, &c, 1);
 1a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1a7:	00 
 1a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b3:	e8 02 01 00 00       	call   2ba <read>
    if(cc < 1)
 1b8:	85 c0                	test   %eax,%eax
 1ba:	7e 1d                	jle    1d9 <gets+0x49>
      break;
    buf[i++] = c;
 1bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 1c0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 1c2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 1c5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 1c7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1cb:	74 0c                	je     1d9 <gets+0x49>
 1cd:	3c 0a                	cmp    $0xa,%al
 1cf:	74 08                	je     1d9 <gets+0x49>
  for(i=0; i+1 < max; ){
 1d1:	8d 5e 01             	lea    0x1(%esi),%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	7c c7                	jl     1a0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1d9:	8b 45 08             	mov    0x8(%ebp),%eax
 1dc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1e0:	83 c4 2c             	add    $0x2c,%esp
 1e3:	5b                   	pop    %ebx
 1e4:	5e                   	pop    %esi
 1e5:	5f                   	pop    %edi
 1e6:	5d                   	pop    %ebp
 1e7:	c3                   	ret    
 1e8:	90                   	nop
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 202:	00 
 203:	89 04 24             	mov    %eax,(%esp)
 206:	e8 d7 00 00 00       	call   2e2 <open>
  if(fd < 0)
 20b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 20d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 20f:	78 27                	js     238 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 211:	8b 45 0c             	mov    0xc(%ebp),%eax
 214:	89 1c 24             	mov    %ebx,(%esp)
 217:	89 44 24 04          	mov    %eax,0x4(%esp)
 21b:	e8 da 00 00 00       	call   2fa <fstat>
  close(fd);
 220:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 223:	89 c6                	mov    %eax,%esi
  close(fd);
 225:	e8 a0 00 00 00       	call   2ca <close>
  return r;
 22a:	89 f0                	mov    %esi,%eax
}
 22c:	83 c4 10             	add    $0x10,%esp
 22f:	5b                   	pop    %ebx
 230:	5e                   	pop    %esi
 231:	5d                   	pop    %ebp
 232:	c3                   	ret    
 233:	90                   	nop
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 23d:	eb ed                	jmp    22c <stat+0x3c>
 23f:	90                   	nop

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 08             	mov    0x8(%ebp),%ecx
 246:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
  n = 0;
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 254:	77 17                	ja     26d <atoi+0x2d>
 256:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 258:	83 c1 01             	add    $0x1,%ecx
 25b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 25e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 262:	0f be 11             	movsbl (%ecx),%edx
 265:	8d 5a d0             	lea    -0x30(%edx),%ebx
 268:	80 fb 09             	cmp    $0x9,%bl
 26b:	76 eb                	jbe    258 <atoi+0x18>
  return n;
}
 26d:	5b                   	pop    %ebx
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret    

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 271:	31 d2                	xor    %edx,%edx
{
 273:	89 e5                	mov    %esp,%ebp
 275:	56                   	push   %esi
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	53                   	push   %ebx
 27a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 27d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 280:	85 db                	test   %ebx,%ebx
 282:	7e 12                	jle    296 <memmove+0x26>
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 288:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 28c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 292:	39 da                	cmp    %ebx,%edx
 294:	75 f2                	jne    288 <memmove+0x18>
  return vdst;
}
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    

0000029a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29a:	b8 01 00 00 00       	mov    $0x1,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <exit>:
SYSCALL(exit)
 2a2:	b8 02 00 00 00       	mov    $0x2,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <wait>:
SYSCALL(wait)
 2aa:	b8 03 00 00 00       	mov    $0x3,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <pipe>:
SYSCALL(pipe)
 2b2:	b8 04 00 00 00       	mov    $0x4,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <read>:
SYSCALL(read)
 2ba:	b8 05 00 00 00       	mov    $0x5,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <write>:
SYSCALL(write)
 2c2:	b8 10 00 00 00       	mov    $0x10,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <close>:
SYSCALL(close)
 2ca:	b8 15 00 00 00       	mov    $0x15,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <kill>:
SYSCALL(kill)
 2d2:	b8 06 00 00 00       	mov    $0x6,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <exec>:
SYSCALL(exec)
 2da:	b8 07 00 00 00       	mov    $0x7,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <open>:
SYSCALL(open)
 2e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mknod>:
SYSCALL(mknod)
 2ea:	b8 11 00 00 00       	mov    $0x11,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <unlink>:
SYSCALL(unlink)
 2f2:	b8 12 00 00 00       	mov    $0x12,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <fstat>:
SYSCALL(fstat)
 2fa:	b8 08 00 00 00       	mov    $0x8,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <link>:
SYSCALL(link)
 302:	b8 13 00 00 00       	mov    $0x13,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mkdir>:
SYSCALL(mkdir)
 30a:	b8 14 00 00 00       	mov    $0x14,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <chdir>:
SYSCALL(chdir)
 312:	b8 09 00 00 00       	mov    $0x9,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <dup>:
SYSCALL(dup)
 31a:	b8 0a 00 00 00       	mov    $0xa,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <getpid>:
SYSCALL(getpid)
 322:	b8 0b 00 00 00       	mov    $0xb,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <sbrk>:
SYSCALL(sbrk)
 32a:	b8 0c 00 00 00       	mov    $0xc,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <sleep>:
SYSCALL(sleep)
 332:	b8 0d 00 00 00       	mov    $0xd,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <uptime>:
SYSCALL(uptime)
 33a:	b8 0e 00 00 00       	mov    $0xe,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 342:	b8 16 00 00 00       	mov    $0x16,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 34a:	b8 17 00 00 00       	mov    $0x17,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 352:	b8 18 00 00 00       	mov    $0x18,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    
 35a:	66 90                	xchg   %ax,%ax
 35c:	66 90                	xchg   %ax,%ax
 35e:	66 90                	xchg   %ax,%ax

00000360 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	89 c6                	mov    %eax,%esi
 367:	53                   	push   %ebx
 368:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 36b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 36e:	85 db                	test   %ebx,%ebx
 370:	74 09                	je     37b <printint+0x1b>
 372:	89 d0                	mov    %edx,%eax
 374:	c1 e8 1f             	shr    $0x1f,%eax
 377:	84 c0                	test   %al,%al
 379:	75 75                	jne    3f0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 37b:	89 d0                	mov    %edx,%eax
  neg = 0;
 37d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 384:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 387:	31 ff                	xor    %edi,%edi
 389:	89 ce                	mov    %ecx,%esi
 38b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 38e:	eb 02                	jmp    392 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 390:	89 cf                	mov    %ecx,%edi
 392:	31 d2                	xor    %edx,%edx
 394:	f7 f6                	div    %esi
 396:	8d 4f 01             	lea    0x1(%edi),%ecx
 399:	0f b6 92 d0 07 00 00 	movzbl 0x7d0(%edx),%edx
  }while((x /= base) != 0);
 3a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3a2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3a5:	75 e9                	jne    390 <printint+0x30>
  if(neg)
 3a7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 3aa:	89 c8                	mov    %ecx,%eax
 3ac:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 3af:	85 d2                	test   %edx,%edx
 3b1:	74 08                	je     3bb <printint+0x5b>
    buf[i++] = '-';
 3b3:	8d 4f 02             	lea    0x2(%edi),%ecx
 3b6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 3bb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3be:	66 90                	xchg   %ax,%ax
 3c0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 3c5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 3c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3cf:	00 
 3d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3d4:	89 34 24             	mov    %esi,(%esp)
 3d7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3da:	e8 e3 fe ff ff       	call   2c2 <write>
  while(--i >= 0)
 3df:	83 ff ff             	cmp    $0xffffffff,%edi
 3e2:	75 dc                	jne    3c0 <printint+0x60>
    putc(fd, buf[i]);
}
 3e4:	83 c4 4c             	add    $0x4c,%esp
 3e7:	5b                   	pop    %ebx
 3e8:	5e                   	pop    %esi
 3e9:	5f                   	pop    %edi
 3ea:	5d                   	pop    %ebp
 3eb:	c3                   	ret    
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 3f0:	89 d0                	mov    %edx,%eax
 3f2:	f7 d8                	neg    %eax
    neg = 1;
 3f4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3fb:	eb 87                	jmp    384 <printint+0x24>
 3fd:	8d 76 00             	lea    0x0(%esi),%esi

00000400 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 404:	31 ff                	xor    %edi,%edi
{
 406:	56                   	push   %esi
 407:	53                   	push   %ebx
 408:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 40b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 40e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 411:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 414:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 417:	0f b6 13             	movzbl (%ebx),%edx
 41a:	83 c3 01             	add    $0x1,%ebx
 41d:	84 d2                	test   %dl,%dl
 41f:	75 39                	jne    45a <printf+0x5a>
 421:	e9 ca 00 00 00       	jmp    4f0 <printf+0xf0>
 426:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 428:	83 fa 25             	cmp    $0x25,%edx
 42b:	0f 84 c7 00 00 00    	je     4f8 <printf+0xf8>
  write(fd, &c, 1);
 431:	8d 45 e0             	lea    -0x20(%ebp),%eax
 434:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 43b:	00 
 43c:	89 44 24 04          	mov    %eax,0x4(%esp)
 440:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 443:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 446:	e8 77 fe ff ff       	call   2c2 <write>
 44b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 44e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 452:	84 d2                	test   %dl,%dl
 454:	0f 84 96 00 00 00    	je     4f0 <printf+0xf0>
    if(state == 0){
 45a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 45c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 45f:	74 c7                	je     428 <printf+0x28>
      }
    } else if(state == '%'){
 461:	83 ff 25             	cmp    $0x25,%edi
 464:	75 e5                	jne    44b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 466:	83 fa 75             	cmp    $0x75,%edx
 469:	0f 84 99 00 00 00    	je     508 <printf+0x108>
 46f:	83 fa 64             	cmp    $0x64,%edx
 472:	0f 84 90 00 00 00    	je     508 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 478:	25 f7 00 00 00       	and    $0xf7,%eax
 47d:	83 f8 70             	cmp    $0x70,%eax
 480:	0f 84 aa 00 00 00    	je     530 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 486:	83 fa 73             	cmp    $0x73,%edx
 489:	0f 84 e9 00 00 00    	je     578 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48f:	83 fa 63             	cmp    $0x63,%edx
 492:	0f 84 2b 01 00 00    	je     5c3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 498:	83 fa 25             	cmp    $0x25,%edx
 49b:	0f 84 4f 01 00 00    	je     5f0 <printf+0x1f0>
  write(fd, &c, 1);
 4a1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4a4:	83 c3 01             	add    $0x1,%ebx
 4a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ae:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4af:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b5:	89 34 24             	mov    %esi,(%esp)
 4b8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 4bb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 4bf:	e8 fe fd ff ff       	call   2c2 <write>
        putc(fd, c);
 4c4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 4c7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d1:	00 
 4d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 4d9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4dc:	e8 e1 fd ff ff       	call   2c2 <write>
  for(i = 0; fmt[i]; i++){
 4e1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4e5:	84 d2                	test   %dl,%dl
 4e7:	0f 85 6d ff ff ff    	jne    45a <printf+0x5a>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 4f0:	83 c4 3c             	add    $0x3c,%esp
 4f3:	5b                   	pop    %ebx
 4f4:	5e                   	pop    %esi
 4f5:	5f                   	pop    %edi
 4f6:	5d                   	pop    %ebp
 4f7:	c3                   	ret    
        state = '%';
 4f8:	bf 25 00 00 00       	mov    $0x25,%edi
 4fd:	e9 49 ff ff ff       	jmp    44b <printf+0x4b>
 502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 508:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 50f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 514:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 517:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 519:	8b 10                	mov    (%eax),%edx
 51b:	89 f0                	mov    %esi,%eax
 51d:	e8 3e fe ff ff       	call   360 <printint>
        ap++;
 522:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 526:	e9 20 ff ff ff       	jmp    44b <printf+0x4b>
 52b:	90                   	nop
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 530:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 533:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 53a:	00 
 53b:	89 44 24 04          	mov    %eax,0x4(%esp)
 53f:	89 34 24             	mov    %esi,(%esp)
 542:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 546:	e8 77 fd ff ff       	call   2c2 <write>
 54b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 54e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 555:	00 
 556:	89 44 24 04          	mov    %eax,0x4(%esp)
 55a:	89 34 24             	mov    %esi,(%esp)
 55d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 561:	e8 5c fd ff ff       	call   2c2 <write>
        printint(fd, *ap, 16, 0);
 566:	b9 10 00 00 00       	mov    $0x10,%ecx
 56b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 572:	eb a0                	jmp    514 <printf+0x114>
 574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 578:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 57b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 57f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 581:	b8 c9 07 00 00       	mov    $0x7c9,%eax
 586:	85 ff                	test   %edi,%edi
 588:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 58b:	0f b6 07             	movzbl (%edi),%eax
 58e:	84 c0                	test   %al,%al
 590:	74 2a                	je     5bc <printf+0x1bc>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 598:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 59b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 59e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 5a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a8:	00 
 5a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ad:	89 34 24             	mov    %esi,(%esp)
 5b0:	e8 0d fd ff ff       	call   2c2 <write>
        while(*s != 0){
 5b5:	0f b6 07             	movzbl (%edi),%eax
 5b8:	84 c0                	test   %al,%al
 5ba:	75 dc                	jne    598 <printf+0x198>
      state = 0;
 5bc:	31 ff                	xor    %edi,%edi
 5be:	e9 88 fe ff ff       	jmp    44b <printf+0x4b>
        putc(fd, *ap);
 5c3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5c6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 5c8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 5ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5d1:	00 
 5d2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 5d5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5d8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5db:	89 44 24 04          	mov    %eax,0x4(%esp)
 5df:	e8 de fc ff ff       	call   2c2 <write>
        ap++;
 5e4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5e8:	e9 5e fe ff ff       	jmp    44b <printf+0x4b>
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5f0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 5f3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5f5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5fc:	00 
 5fd:	89 44 24 04          	mov    %eax,0x4(%esp)
 601:	89 34 24             	mov    %esi,(%esp)
 604:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 608:	e8 b5 fc ff ff       	call   2c2 <write>
 60d:	e9 39 fe ff ff       	jmp    44b <printf+0x4b>
 612:	66 90                	xchg   %ax,%ax
 614:	66 90                	xchg   %ax,%ax
 616:	66 90                	xchg   %ax,%ax
 618:	66 90                	xchg   %ax,%ax
 61a:	66 90                	xchg   %ax,%ax
 61c:	66 90                	xchg   %ax,%ax
 61e:	66 90                	xchg   %ax,%ax

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 50 0a 00 00       	mov    0xa50,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 630:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 633:	39 d0                	cmp    %edx,%eax
 635:	72 11                	jb     648 <free+0x28>
 637:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 638:	39 c8                	cmp    %ecx,%eax
 63a:	72 04                	jb     640 <free+0x20>
 63c:	39 ca                	cmp    %ecx,%edx
 63e:	72 10                	jb     650 <free+0x30>
 640:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 642:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 644:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 646:	73 f0                	jae    638 <free+0x18>
 648:	39 ca                	cmp    %ecx,%edx
 64a:	72 04                	jb     650 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64c:	39 c8                	cmp    %ecx,%eax
 64e:	72 f0                	jb     640 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 650:	8b 73 fc             	mov    -0x4(%ebx),%esi
 653:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 656:	39 cf                	cmp    %ecx,%edi
 658:	74 1e                	je     678 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 65a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 65d:	8b 48 04             	mov    0x4(%eax),%ecx
 660:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 663:	39 f2                	cmp    %esi,%edx
 665:	74 28                	je     68f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 667:	89 10                	mov    %edx,(%eax)
  freep = p;
 669:	a3 50 0a 00 00       	mov    %eax,0xa50
}
 66e:	5b                   	pop    %ebx
 66f:	5e                   	pop    %esi
 670:	5f                   	pop    %edi
 671:	5d                   	pop    %ebp
 672:	c3                   	ret    
 673:	90                   	nop
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 678:	03 71 04             	add    0x4(%ecx),%esi
 67b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 67e:	8b 08                	mov    (%eax),%ecx
 680:	8b 09                	mov    (%ecx),%ecx
 682:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 685:	8b 48 04             	mov    0x4(%eax),%ecx
 688:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 68b:	39 f2                	cmp    %esi,%edx
 68d:	75 d8                	jne    667 <free+0x47>
    p->s.size += bp->s.size;
 68f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 692:	a3 50 0a 00 00       	mov    %eax,0xa50
    p->s.size += bp->s.size;
 697:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 69a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 69d:	89 10                	mov    %edx,(%eax)
}
 69f:	5b                   	pop    %ebx
 6a0:	5e                   	pop    %esi
 6a1:	5f                   	pop    %edi
 6a2:	5d                   	pop    %ebp
 6a3:	c3                   	ret    
 6a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6bc:	8b 1d 50 0a 00 00    	mov    0xa50,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c2:	8d 48 07             	lea    0x7(%eax),%ecx
 6c5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 6c8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ca:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 6cd:	0f 84 9b 00 00 00    	je     76e <malloc+0xbe>
 6d3:	8b 13                	mov    (%ebx),%edx
 6d5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6d8:	39 fe                	cmp    %edi,%esi
 6da:	76 64                	jbe    740 <malloc+0x90>
 6dc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 6e3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 6e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6eb:	eb 0e                	jmp    6fb <malloc+0x4b>
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f2:	8b 78 04             	mov    0x4(%eax),%edi
 6f5:	39 fe                	cmp    %edi,%esi
 6f7:	76 4f                	jbe    748 <malloc+0x98>
 6f9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6fb:	3b 15 50 0a 00 00    	cmp    0xa50,%edx
 701:	75 ed                	jne    6f0 <malloc+0x40>
  if(nu < 4096)
 703:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 706:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 70c:	bf 00 10 00 00       	mov    $0x1000,%edi
 711:	0f 43 fe             	cmovae %esi,%edi
 714:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 717:	89 04 24             	mov    %eax,(%esp)
 71a:	e8 0b fc ff ff       	call   32a <sbrk>
  if(p == (char*)-1)
 71f:	83 f8 ff             	cmp    $0xffffffff,%eax
 722:	74 18                	je     73c <malloc+0x8c>
  hp->s.size = nu;
 724:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 727:	83 c0 08             	add    $0x8,%eax
 72a:	89 04 24             	mov    %eax,(%esp)
 72d:	e8 ee fe ff ff       	call   620 <free>
  return freep;
 732:	8b 15 50 0a 00 00    	mov    0xa50,%edx
      if((p = morecore(nunits)) == 0)
 738:	85 d2                	test   %edx,%edx
 73a:	75 b4                	jne    6f0 <malloc+0x40>
        return 0;
 73c:	31 c0                	xor    %eax,%eax
 73e:	eb 20                	jmp    760 <malloc+0xb0>
    if(p->s.size >= nunits){
 740:	89 d0                	mov    %edx,%eax
 742:	89 da                	mov    %ebx,%edx
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 748:	39 fe                	cmp    %edi,%esi
 74a:	74 1c                	je     768 <malloc+0xb8>
        p->s.size -= nunits;
 74c:	29 f7                	sub    %esi,%edi
 74e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 751:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 754:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 757:	89 15 50 0a 00 00    	mov    %edx,0xa50
      return (void*)(p + 1);
 75d:	83 c0 08             	add    $0x8,%eax
  }
}
 760:	83 c4 1c             	add    $0x1c,%esp
 763:	5b                   	pop    %ebx
 764:	5e                   	pop    %esi
 765:	5f                   	pop    %edi
 766:	5d                   	pop    %ebp
 767:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 768:	8b 08                	mov    (%eax),%ecx
 76a:	89 0a                	mov    %ecx,(%edx)
 76c:	eb e9                	jmp    757 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 76e:	c7 05 50 0a 00 00 54 	movl   $0xa54,0xa50
 775:	0a 00 00 
    base.s.size = 0;
 778:	ba 54 0a 00 00       	mov    $0xa54,%edx
    base.s.ptr = freep = prevp = &base;
 77d:	c7 05 54 0a 00 00 54 	movl   $0xa54,0xa54
 784:	0a 00 00 
    base.s.size = 0;
 787:	c7 05 58 0a 00 00 00 	movl   $0x0,0xa58
 78e:	00 00 00 
 791:	e9 46 ff ff ff       	jmp    6dc <malloc+0x2c>
