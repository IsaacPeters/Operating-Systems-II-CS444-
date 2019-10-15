
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  11:	00 
  12:	c7 04 24 26 08 00 00 	movl   $0x826,(%esp)
  19:	e8 54 03 00 00       	call   372 <open>
  1e:	85 c0                	test   %eax,%eax
  20:	0f 88 ac 00 00 00    	js     d2 <main+0xd2>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  26:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2d:	e8 78 03 00 00       	call   3aa <dup>
  dup(0);  // stderr
  32:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  39:	e8 6c 03 00 00       	call   3aa <dup>
  3e:	66 90                	xchg   %ax,%ax

  for(;;){
    printf(1, "init: starting sh\n");
  40:	c7 44 24 04 2e 08 00 	movl   $0x82e,0x4(%esp)
  47:	00 
  48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4f:	e8 3c 04 00 00       	call   490 <printf>
    pid = fork();
  54:	e8 d1 02 00 00       	call   32a <fork>
    if(pid < 0){
  59:	85 c0                	test   %eax,%eax
    pid = fork();
  5b:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  5d:	78 2d                	js     8c <main+0x8c>
  5f:	90                   	nop
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  60:	74 43                	je     a5 <main+0xa5>
  62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  68:	e8 cd 02 00 00       	call   33a <wait>
  6d:	85 c0                	test   %eax,%eax
  6f:	90                   	nop
  70:	78 ce                	js     40 <main+0x40>
  72:	39 d8                	cmp    %ebx,%eax
  74:	74 ca                	je     40 <main+0x40>
      printf(1, "zombie!\n");
  76:	c7 44 24 04 6d 08 00 	movl   $0x86d,0x4(%esp)
  7d:	00 
  7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  85:	e8 06 04 00 00       	call   490 <printf>
  8a:	eb dc                	jmp    68 <main+0x68>
      printf(1, "init: fork failed\n");
  8c:	c7 44 24 04 41 08 00 	movl   $0x841,0x4(%esp)
  93:	00 
  94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9b:	e8 f0 03 00 00       	call   490 <printf>
      exit();
  a0:	e8 8d 02 00 00       	call   332 <exit>
      exec("sh", argv);
  a5:	c7 44 24 04 f4 0a 00 	movl   $0xaf4,0x4(%esp)
  ac:	00 
  ad:	c7 04 24 54 08 00 00 	movl   $0x854,(%esp)
  b4:	e8 b1 02 00 00       	call   36a <exec>
      printf(1, "init: exec sh failed\n");
  b9:	c7 44 24 04 57 08 00 	movl   $0x857,0x4(%esp)
  c0:	00 
  c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c8:	e8 c3 03 00 00       	call   490 <printf>
      exit();
  cd:	e8 60 02 00 00       	call   332 <exit>
    mknod("console", 1, 1);
  d2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  d9:	00 
  da:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  e1:	00 
  e2:	c7 04 24 26 08 00 00 	movl   $0x826,(%esp)
  e9:	e8 8c 02 00 00       	call   37a <mknod>
    open("console", O_RDWR);
  ee:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  f5:	00 
  f6:	c7 04 24 26 08 00 00 	movl   $0x826,(%esp)
  fd:	e8 70 02 00 00       	call   372 <open>
 102:	e9 1f ff ff ff       	jmp    26 <main+0x26>
 107:	66 90                	xchg   %ax,%ax
 109:	66 90                	xchg   %ax,%ax
 10b:	66 90                	xchg   %ax,%ax
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 45 08             	mov    0x8(%ebp),%eax
 116:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 119:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	89 c2                	mov    %eax,%edx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 120:	83 c1 01             	add    $0x1,%ecx
 123:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 db                	test   %bl,%bl
 12c:	88 5a ff             	mov    %bl,-0x1(%edx)
 12f:	75 ef                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 131:	5b                   	pop    %ebx
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
 134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 13a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 55 08             	mov    0x8(%ebp),%edx
 146:	53                   	push   %ebx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	74 2d                	je     17e <strcmp+0x3e>
 151:	0f b6 19             	movzbl (%ecx),%ebx
 154:	38 d8                	cmp    %bl,%al
 156:	74 0e                	je     166 <strcmp+0x26>
 158:	eb 2b                	jmp    185 <strcmp+0x45>
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 160:	38 c8                	cmp    %cl,%al
 162:	75 15                	jne    179 <strcmp+0x39>
    p++, q++;
 164:	89 d9                	mov    %ebx,%ecx
 166:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 169:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 16c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 16f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 173:	84 c0                	test   %al,%al
 175:	75 e9                	jne    160 <strcmp+0x20>
 177:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 179:	29 c8                	sub    %ecx,%eax
}
 17b:	5b                   	pop    %ebx
 17c:	5d                   	pop    %ebp
 17d:	c3                   	ret    
 17e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 181:	31 c0                	xor    %eax,%eax
 183:	eb f4                	jmp    179 <strcmp+0x39>
 185:	0f b6 cb             	movzbl %bl,%ecx
 188:	eb ef                	jmp    179 <strcmp+0x39>
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <strlen>:

uint
strlen(const char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 196:	80 39 00             	cmpb   $0x0,(%ecx)
 199:	74 12                	je     1ad <strlen+0x1d>
 19b:	31 d2                	xor    %edx,%edx
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
  for(n = 0; s[n]; n++)
 1ad:	31 c0                	xor    %eax,%eax
}
 1af:	5d                   	pop    %ebp
 1b0:	c3                   	ret    
 1b1:	eb 0d                	jmp    1c0 <memset>
 1b3:	90                   	nop
 1b4:	90                   	nop
 1b5:	90                   	nop
 1b6:	90                   	nop
 1b7:	90                   	nop
 1b8:	90                   	nop
 1b9:	90                   	nop
 1ba:	90                   	nop
 1bb:	90                   	nop
 1bc:	90                   	nop
 1bd:	90                   	nop
 1be:	90                   	nop
 1bf:	90                   	nop

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
 1c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	89 d0                	mov    %edx,%eax
 1d4:	5f                   	pop    %edi
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	53                   	push   %ebx
 1e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1ea:	0f b6 18             	movzbl (%eax),%ebx
 1ed:	84 db                	test   %bl,%bl
 1ef:	74 1d                	je     20e <strchr+0x2e>
    if(*s == c)
 1f1:	38 d3                	cmp    %dl,%bl
 1f3:	89 d1                	mov    %edx,%ecx
 1f5:	75 0d                	jne    204 <strchr+0x24>
 1f7:	eb 17                	jmp    210 <strchr+0x30>
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 200:	38 ca                	cmp    %cl,%dl
 202:	74 0c                	je     210 <strchr+0x30>
  for(; *s; s++)
 204:	83 c0 01             	add    $0x1,%eax
 207:	0f b6 10             	movzbl (%eax),%edx
 20a:	84 d2                	test   %dl,%dl
 20c:	75 f2                	jne    200 <strchr+0x20>
      return (char*)s;
  return 0;
 20e:	31 c0                	xor    %eax,%eax
}
 210:	5b                   	pop    %ebx
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 225:	31 f6                	xor    %esi,%esi
{
 227:	53                   	push   %ebx
 228:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 22b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 22e:	eb 31                	jmp    261 <gets+0x41>
    cc = read(0, &c, 1);
 230:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 237:	00 
 238:	89 7c 24 04          	mov    %edi,0x4(%esp)
 23c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 243:	e8 02 01 00 00       	call   34a <read>
    if(cc < 1)
 248:	85 c0                	test   %eax,%eax
 24a:	7e 1d                	jle    269 <gets+0x49>
      break;
    buf[i++] = c;
 24c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 250:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 252:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 255:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 257:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 25b:	74 0c                	je     269 <gets+0x49>
 25d:	3c 0a                	cmp    $0xa,%al
 25f:	74 08                	je     269 <gets+0x49>
  for(i=0; i+1 < max; ){
 261:	8d 5e 01             	lea    0x1(%esi),%ebx
 264:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 267:	7c c7                	jl     230 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 270:	83 c4 2c             	add    $0x2c,%esp
 273:	5b                   	pop    %ebx
 274:	5e                   	pop    %esi
 275:	5f                   	pop    %edi
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 292:	00 
 293:	89 04 24             	mov    %eax,(%esp)
 296:	e8 d7 00 00 00       	call   372 <open>
  if(fd < 0)
 29b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 29d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 29f:	78 27                	js     2c8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a4:	89 1c 24             	mov    %ebx,(%esp)
 2a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ab:	e8 da 00 00 00       	call   38a <fstat>
  close(fd);
 2b0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2b3:	89 c6                	mov    %eax,%esi
  close(fd);
 2b5:	e8 a0 00 00 00       	call   35a <close>
  return r;
 2ba:	89 f0                	mov    %esi,%eax
}
 2bc:	83 c4 10             	add    $0x10,%esp
 2bf:	5b                   	pop    %ebx
 2c0:	5e                   	pop    %esi
 2c1:	5d                   	pop    %ebp
 2c2:	c3                   	ret    
 2c3:	90                   	nop
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2cd:	eb ed                	jmp    2bc <stat+0x3c>
 2cf:	90                   	nop

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2d6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 11             	movsbl (%ecx),%edx
 2da:	8d 42 d0             	lea    -0x30(%edx),%eax
 2dd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2e4:	77 17                	ja     2fd <atoi+0x2d>
 2e6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2e8:	83 c1 01             	add    $0x1,%ecx
 2eb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2ee:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2f2:	0f be 11             	movsbl (%ecx),%edx
 2f5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2f8:	80 fb 09             	cmp    $0x9,%bl
 2fb:	76 eb                	jbe    2e8 <atoi+0x18>
  return n;
}
 2fd:	5b                   	pop    %ebx
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret    

00000300 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 300:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 301:	31 d2                	xor    %edx,%edx
{
 303:	89 e5                	mov    %esp,%ebp
 305:	56                   	push   %esi
 306:	8b 45 08             	mov    0x8(%ebp),%eax
 309:	53                   	push   %ebx
 30a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 30d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 310:	85 db                	test   %ebx,%ebx
 312:	7e 12                	jle    326 <memmove+0x26>
 314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 318:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 31c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 31f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 322:	39 da                	cmp    %ebx,%edx
 324:	75 f2                	jne    318 <memmove+0x18>
  return vdst;
}
 326:	5b                   	pop    %ebx
 327:	5e                   	pop    %esi
 328:	5d                   	pop    %ebp
 329:	c3                   	ret    

0000032a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32a:	b8 01 00 00 00       	mov    $0x1,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <exit>:
SYSCALL(exit)
 332:	b8 02 00 00 00       	mov    $0x2,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <wait>:
SYSCALL(wait)
 33a:	b8 03 00 00 00       	mov    $0x3,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <pipe>:
SYSCALL(pipe)
 342:	b8 04 00 00 00       	mov    $0x4,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <read>:
SYSCALL(read)
 34a:	b8 05 00 00 00       	mov    $0x5,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <write>:
SYSCALL(write)
 352:	b8 10 00 00 00       	mov    $0x10,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <close>:
SYSCALL(close)
 35a:	b8 15 00 00 00       	mov    $0x15,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kill>:
SYSCALL(kill)
 362:	b8 06 00 00 00       	mov    $0x6,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <exec>:
SYSCALL(exec)
 36a:	b8 07 00 00 00       	mov    $0x7,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <open>:
SYSCALL(open)
 372:	b8 0f 00 00 00       	mov    $0xf,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <mknod>:
SYSCALL(mknod)
 37a:	b8 11 00 00 00       	mov    $0x11,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <unlink>:
SYSCALL(unlink)
 382:	b8 12 00 00 00       	mov    $0x12,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <fstat>:
SYSCALL(fstat)
 38a:	b8 08 00 00 00       	mov    $0x8,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <link>:
SYSCALL(link)
 392:	b8 13 00 00 00       	mov    $0x13,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <mkdir>:
SYSCALL(mkdir)
 39a:	b8 14 00 00 00       	mov    $0x14,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <chdir>:
SYSCALL(chdir)
 3a2:	b8 09 00 00 00       	mov    $0x9,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <dup>:
SYSCALL(dup)
 3aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <getpid>:
SYSCALL(getpid)
 3b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <sbrk>:
SYSCALL(sbrk)
 3ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <sleep>:
SYSCALL(sleep)
 3c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <uptime>:
SYSCALL(uptime)
 3ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 3d2:	b8 16 00 00 00       	mov    $0x16,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 3da:	b8 17 00 00 00       	mov    $0x17,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 3e2:	b8 18 00 00 00       	mov    $0x18,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    
 3ea:	66 90                	xchg   %ax,%ax
 3ec:	66 90                	xchg   %ax,%ax
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	89 c6                	mov    %eax,%esi
 3f7:	53                   	push   %ebx
 3f8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3fe:	85 db                	test   %ebx,%ebx
 400:	74 09                	je     40b <printint+0x1b>
 402:	89 d0                	mov    %edx,%eax
 404:	c1 e8 1f             	shr    $0x1f,%eax
 407:	84 c0                	test   %al,%al
 409:	75 75                	jne    480 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 40b:	89 d0                	mov    %edx,%eax
  neg = 0;
 40d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 414:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 417:	31 ff                	xor    %edi,%edi
 419:	89 ce                	mov    %ecx,%esi
 41b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 41e:	eb 02                	jmp    422 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 420:	89 cf                	mov    %ecx,%edi
 422:	31 d2                	xor    %edx,%edx
 424:	f7 f6                	div    %esi
 426:	8d 4f 01             	lea    0x1(%edi),%ecx
 429:	0f b6 92 7d 08 00 00 	movzbl 0x87d(%edx),%edx
  }while((x /= base) != 0);
 430:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 432:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 435:	75 e9                	jne    420 <printint+0x30>
  if(neg)
 437:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 43a:	89 c8                	mov    %ecx,%eax
 43c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 43f:	85 d2                	test   %edx,%edx
 441:	74 08                	je     44b <printint+0x5b>
    buf[i++] = '-';
 443:	8d 4f 02             	lea    0x2(%edi),%ecx
 446:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 44b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 44e:	66 90                	xchg   %ax,%ax
 450:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 455:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 458:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 45f:	00 
 460:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 464:	89 34 24             	mov    %esi,(%esp)
 467:	88 45 d7             	mov    %al,-0x29(%ebp)
 46a:	e8 e3 fe ff ff       	call   352 <write>
  while(--i >= 0)
 46f:	83 ff ff             	cmp    $0xffffffff,%edi
 472:	75 dc                	jne    450 <printint+0x60>
    putc(fd, buf[i]);
}
 474:	83 c4 4c             	add    $0x4c,%esp
 477:	5b                   	pop    %ebx
 478:	5e                   	pop    %esi
 479:	5f                   	pop    %edi
 47a:	5d                   	pop    %ebp
 47b:	c3                   	ret    
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 480:	89 d0                	mov    %edx,%eax
 482:	f7 d8                	neg    %eax
    neg = 1;
 484:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 48b:	eb 87                	jmp    414 <printint+0x24>
 48d:	8d 76 00             	lea    0x0(%esi),%esi

00000490 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 494:	31 ff                	xor    %edi,%edi
{
 496:	56                   	push   %esi
 497:	53                   	push   %ebx
 498:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 49b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 49e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 4a1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 4a4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 4a7:	0f b6 13             	movzbl (%ebx),%edx
 4aa:	83 c3 01             	add    $0x1,%ebx
 4ad:	84 d2                	test   %dl,%dl
 4af:	75 39                	jne    4ea <printf+0x5a>
 4b1:	e9 ca 00 00 00       	jmp    580 <printf+0xf0>
 4b6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4b8:	83 fa 25             	cmp    $0x25,%edx
 4bb:	0f 84 c7 00 00 00    	je     588 <printf+0xf8>
  write(fd, &c, 1);
 4c1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4cb:	00 
 4cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 4d3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 4d6:	e8 77 fe ff ff       	call   352 <write>
 4db:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 4de:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4e2:	84 d2                	test   %dl,%dl
 4e4:	0f 84 96 00 00 00    	je     580 <printf+0xf0>
    if(state == 0){
 4ea:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 4ec:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 4ef:	74 c7                	je     4b8 <printf+0x28>
      }
    } else if(state == '%'){
 4f1:	83 ff 25             	cmp    $0x25,%edi
 4f4:	75 e5                	jne    4db <printf+0x4b>
      if(c == 'd' || c == 'u'){
 4f6:	83 fa 75             	cmp    $0x75,%edx
 4f9:	0f 84 99 00 00 00    	je     598 <printf+0x108>
 4ff:	83 fa 64             	cmp    $0x64,%edx
 502:	0f 84 90 00 00 00    	je     598 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 508:	25 f7 00 00 00       	and    $0xf7,%eax
 50d:	83 f8 70             	cmp    $0x70,%eax
 510:	0f 84 aa 00 00 00    	je     5c0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 516:	83 fa 73             	cmp    $0x73,%edx
 519:	0f 84 e9 00 00 00    	je     608 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 51f:	83 fa 63             	cmp    $0x63,%edx
 522:	0f 84 2b 01 00 00    	je     653 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 528:	83 fa 25             	cmp    $0x25,%edx
 52b:	0f 84 4f 01 00 00    	je     680 <printf+0x1f0>
  write(fd, &c, 1);
 531:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 534:	83 c3 01             	add    $0x1,%ebx
 537:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 53e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 53f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 541:	89 44 24 04          	mov    %eax,0x4(%esp)
 545:	89 34 24             	mov    %esi,(%esp)
 548:	89 55 d0             	mov    %edx,-0x30(%ebp)
 54b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 54f:	e8 fe fd ff ff       	call   352 <write>
        putc(fd, c);
 554:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 557:	8d 45 e7             	lea    -0x19(%ebp),%eax
 55a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 561:	00 
 562:	89 44 24 04          	mov    %eax,0x4(%esp)
 566:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 569:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 56c:	e8 e1 fd ff ff       	call   352 <write>
  for(i = 0; fmt[i]; i++){
 571:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 575:	84 d2                	test   %dl,%dl
 577:	0f 85 6d ff ff ff    	jne    4ea <printf+0x5a>
 57d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 580:	83 c4 3c             	add    $0x3c,%esp
 583:	5b                   	pop    %ebx
 584:	5e                   	pop    %esi
 585:	5f                   	pop    %edi
 586:	5d                   	pop    %ebp
 587:	c3                   	ret    
        state = '%';
 588:	bf 25 00 00 00       	mov    $0x25,%edi
 58d:	e9 49 ff ff ff       	jmp    4db <printf+0x4b>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 598:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 59f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 5a4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5a7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 5a9:	8b 10                	mov    (%eax),%edx
 5ab:	89 f0                	mov    %esi,%eax
 5ad:	e8 3e fe ff ff       	call   3f0 <printint>
        ap++;
 5b2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5b6:	e9 20 ff ff ff       	jmp    4db <printf+0x4b>
 5bb:	90                   	nop
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5c0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 5c3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ca:	00 
 5cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cf:	89 34 24             	mov    %esi,(%esp)
 5d2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 5d6:	e8 77 fd ff ff       	call   352 <write>
 5db:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5de:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5e5:	00 
 5e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ea:	89 34 24             	mov    %esi,(%esp)
 5ed:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 5f1:	e8 5c fd ff ff       	call   352 <write>
        printint(fd, *ap, 16, 0);
 5f6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 602:	eb a0                	jmp    5a4 <printf+0x114>
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 608:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 60b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 60f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 611:	b8 76 08 00 00       	mov    $0x876,%eax
 616:	85 ff                	test   %edi,%edi
 618:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 61b:	0f b6 07             	movzbl (%edi),%eax
 61e:	84 c0                	test   %al,%al
 620:	74 2a                	je     64c <printf+0x1bc>
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 628:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 62b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 62e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 631:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 638:	00 
 639:	89 44 24 04          	mov    %eax,0x4(%esp)
 63d:	89 34 24             	mov    %esi,(%esp)
 640:	e8 0d fd ff ff       	call   352 <write>
        while(*s != 0){
 645:	0f b6 07             	movzbl (%edi),%eax
 648:	84 c0                	test   %al,%al
 64a:	75 dc                	jne    628 <printf+0x198>
      state = 0;
 64c:	31 ff                	xor    %edi,%edi
 64e:	e9 88 fe ff ff       	jmp    4db <printf+0x4b>
        putc(fd, *ap);
 653:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 656:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 658:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 65a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 661:	00 
 662:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 665:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 668:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 66b:	89 44 24 04          	mov    %eax,0x4(%esp)
 66f:	e8 de fc ff ff       	call   352 <write>
        ap++;
 674:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 678:	e9 5e fe ff ff       	jmp    4db <printf+0x4b>
 67d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 680:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 683:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 685:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 68c:	00 
 68d:	89 44 24 04          	mov    %eax,0x4(%esp)
 691:	89 34 24             	mov    %esi,(%esp)
 694:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 698:	e8 b5 fc ff ff       	call   352 <write>
 69d:	e9 39 fe ff ff       	jmp    4db <printf+0x4b>
 6a2:	66 90                	xchg   %ax,%ax
 6a4:	66 90                	xchg   %ax,%ax
 6a6:	66 90                	xchg   %ax,%ax
 6a8:	66 90                	xchg   %ax,%ax
 6aa:	66 90                	xchg   %ax,%ax
 6ac:	66 90                	xchg   %ax,%ax
 6ae:	66 90                	xchg   %ax,%ax

000006b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	a1 fc 0a 00 00       	mov    0xafc,%eax
{
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	57                   	push   %edi
 6b9:	56                   	push   %esi
 6ba:	53                   	push   %ebx
 6bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6be:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 6c0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c3:	39 d0                	cmp    %edx,%eax
 6c5:	72 11                	jb     6d8 <free+0x28>
 6c7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c8:	39 c8                	cmp    %ecx,%eax
 6ca:	72 04                	jb     6d0 <free+0x20>
 6cc:	39 ca                	cmp    %ecx,%edx
 6ce:	72 10                	jb     6e0 <free+0x30>
 6d0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d6:	73 f0                	jae    6c8 <free+0x18>
 6d8:	39 ca                	cmp    %ecx,%edx
 6da:	72 04                	jb     6e0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6dc:	39 c8                	cmp    %ecx,%eax
 6de:	72 f0                	jb     6d0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6e3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 6e6:	39 cf                	cmp    %ecx,%edi
 6e8:	74 1e                	je     708 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6ea:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ed:	8b 48 04             	mov    0x4(%eax),%ecx
 6f0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6f3:	39 f2                	cmp    %esi,%edx
 6f5:	74 28                	je     71f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6f7:	89 10                	mov    %edx,(%eax)
  freep = p;
 6f9:	a3 fc 0a 00 00       	mov    %eax,0xafc
}
 6fe:	5b                   	pop    %ebx
 6ff:	5e                   	pop    %esi
 700:	5f                   	pop    %edi
 701:	5d                   	pop    %ebp
 702:	c3                   	ret    
 703:	90                   	nop
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 708:	03 71 04             	add    0x4(%ecx),%esi
 70b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 70e:	8b 08                	mov    (%eax),%ecx
 710:	8b 09                	mov    (%ecx),%ecx
 712:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 715:	8b 48 04             	mov    0x4(%eax),%ecx
 718:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 71b:	39 f2                	cmp    %esi,%edx
 71d:	75 d8                	jne    6f7 <free+0x47>
    p->s.size += bp->s.size;
 71f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 722:	a3 fc 0a 00 00       	mov    %eax,0xafc
    p->s.size += bp->s.size;
 727:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 72a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 72d:	89 10                	mov    %edx,(%eax)
}
 72f:	5b                   	pop    %ebx
 730:	5e                   	pop    %esi
 731:	5f                   	pop    %edi
 732:	5d                   	pop    %ebp
 733:	c3                   	ret    
 734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 73a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 749:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 74c:	8b 1d fc 0a 00 00    	mov    0xafc,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 752:	8d 48 07             	lea    0x7(%eax),%ecx
 755:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 758:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 75d:	0f 84 9b 00 00 00    	je     7fe <malloc+0xbe>
 763:	8b 13                	mov    (%ebx),%edx
 765:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 768:	39 fe                	cmp    %edi,%esi
 76a:	76 64                	jbe    7d0 <malloc+0x90>
 76c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 773:	bb 00 80 00 00       	mov    $0x8000,%ebx
 778:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 77b:	eb 0e                	jmp    78b <malloc+0x4b>
 77d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 780:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 782:	8b 78 04             	mov    0x4(%eax),%edi
 785:	39 fe                	cmp    %edi,%esi
 787:	76 4f                	jbe    7d8 <malloc+0x98>
 789:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 78b:	3b 15 fc 0a 00 00    	cmp    0xafc,%edx
 791:	75 ed                	jne    780 <malloc+0x40>
  if(nu < 4096)
 793:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 796:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 79c:	bf 00 10 00 00       	mov    $0x1000,%edi
 7a1:	0f 43 fe             	cmovae %esi,%edi
 7a4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 7a7:	89 04 24             	mov    %eax,(%esp)
 7aa:	e8 0b fc ff ff       	call   3ba <sbrk>
  if(p == (char*)-1)
 7af:	83 f8 ff             	cmp    $0xffffffff,%eax
 7b2:	74 18                	je     7cc <malloc+0x8c>
  hp->s.size = nu;
 7b4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7b7:	83 c0 08             	add    $0x8,%eax
 7ba:	89 04 24             	mov    %eax,(%esp)
 7bd:	e8 ee fe ff ff       	call   6b0 <free>
  return freep;
 7c2:	8b 15 fc 0a 00 00    	mov    0xafc,%edx
      if((p = morecore(nunits)) == 0)
 7c8:	85 d2                	test   %edx,%edx
 7ca:	75 b4                	jne    780 <malloc+0x40>
        return 0;
 7cc:	31 c0                	xor    %eax,%eax
 7ce:	eb 20                	jmp    7f0 <malloc+0xb0>
    if(p->s.size >= nunits){
 7d0:	89 d0                	mov    %edx,%eax
 7d2:	89 da                	mov    %ebx,%edx
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7d8:	39 fe                	cmp    %edi,%esi
 7da:	74 1c                	je     7f8 <malloc+0xb8>
        p->s.size -= nunits;
 7dc:	29 f7                	sub    %esi,%edi
 7de:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 7e1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 7e4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 7e7:	89 15 fc 0a 00 00    	mov    %edx,0xafc
      return (void*)(p + 1);
 7ed:	83 c0 08             	add    $0x8,%eax
  }
}
 7f0:	83 c4 1c             	add    $0x1c,%esp
 7f3:	5b                   	pop    %ebx
 7f4:	5e                   	pop    %esi
 7f5:	5f                   	pop    %edi
 7f6:	5d                   	pop    %ebp
 7f7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 7f8:	8b 08                	mov    (%eax),%ecx
 7fa:	89 0a                	mov    %ecx,(%edx)
 7fc:	eb e9                	jmp    7e7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 7fe:	c7 05 fc 0a 00 00 00 	movl   $0xb00,0xafc
 805:	0b 00 00 
    base.s.size = 0;
 808:	ba 00 0b 00 00       	mov    $0xb00,%edx
    base.s.ptr = freep = prevp = &base;
 80d:	c7 05 00 0b 00 00 00 	movl   $0xb00,0xb00
 814:	0b 00 00 
    base.s.size = 0;
 817:	c7 05 04 0b 00 00 00 	movl   $0x0,0xb04
 81e:	00 00 00 
 821:	e9 46 ff ff ff       	jmp    76c <malloc+0x2c>
