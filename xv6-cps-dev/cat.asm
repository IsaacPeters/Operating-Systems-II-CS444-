
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
  int fd, i;

  if(argc <= 1){
   5:	be 01 00 00 00       	mov    $0x1,%esi
{
   a:	53                   	push   %ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(argc <= 1){
  14:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  18:	8d 58 04             	lea    0x4(%eax),%ebx
  1b:	7e 5a                	jle    77 <main+0x77>
  1d:	8d 76 00             	lea    0x0(%esi),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 50 03 00 00       	call   382 <open>
  32:	85 c0                	test   %eax,%eax
  34:	89 c7                	mov    %eax,%edi
  36:	78 20                	js     58 <main+0x58>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  38:	89 04 24             	mov    %eax,(%esp)
  for(i = 1; i < argc; i++){
  3b:	83 c6 01             	add    $0x1,%esi
  3e:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  41:	e8 4a 00 00 00       	call   90 <cat>
    close(fd);
  46:	89 3c 24             	mov    %edi,(%esp)
  49:	e8 1c 03 00 00       	call   36a <close>
  for(i = 1; i < argc; i++){
  4e:	3b 75 08             	cmp    0x8(%ebp),%esi
  51:	75 cd                	jne    20 <main+0x20>
  }
  exit();
  53:	e8 ea 02 00 00       	call   342 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  58:	8b 03                	mov    (%ebx),%eax
  5a:	c7 44 24 04 69 08 00 	movl   $0x869,0x4(%esp)
  61:	00 
  62:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  69:	89 44 24 08          	mov    %eax,0x8(%esp)
  6d:	e8 3e 04 00 00       	call   4b0 <printf>
      exit();
  72:	e8 cb 02 00 00       	call   342 <exit>
    cat(0);
  77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  7e:	e8 0d 00 00 00       	call   90 <cat>
    exit();
  83:	e8 ba 02 00 00       	call   342 <exit>
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	83 ec 10             	sub    $0x10,%esp
  98:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  9b:	eb 1f                	jmp    bc <cat+0x2c>
  9d:	8d 76 00             	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  a4:	c7 44 24 04 60 0b 00 	movl   $0xb60,0x4(%esp)
  ab:	00 
  ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b3:	e8 aa 02 00 00       	call   362 <write>
  b8:	39 d8                	cmp    %ebx,%eax
  ba:	75 28                	jne    e4 <cat+0x54>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  bc:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  c3:	00 
  c4:	c7 44 24 04 60 0b 00 	movl   $0xb60,0x4(%esp)
  cb:	00 
  cc:	89 34 24             	mov    %esi,(%esp)
  cf:	e8 86 02 00 00       	call   35a <read>
  d4:	83 f8 00             	cmp    $0x0,%eax
  d7:	89 c3                	mov    %eax,%ebx
  d9:	7f c5                	jg     a0 <cat+0x10>
  if(n < 0){
  db:	75 20                	jne    fd <cat+0x6d>
}
  dd:	83 c4 10             	add    $0x10,%esp
  e0:	5b                   	pop    %ebx
  e1:	5e                   	pop    %esi
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    
      printf(1, "cat: write error\n");
  e4:	c7 44 24 04 46 08 00 	movl   $0x846,0x4(%esp)
  eb:	00 
  ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f3:	e8 b8 03 00 00       	call   4b0 <printf>
      exit();
  f8:	e8 45 02 00 00       	call   342 <exit>
    printf(1, "cat: read error\n");
  fd:	c7 44 24 04 58 08 00 	movl   $0x858,0x4(%esp)
 104:	00 
 105:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 10c:	e8 9f 03 00 00       	call   4b0 <printf>
    exit();
 111:	e8 2c 02 00 00       	call   342 <exit>
 116:	66 90                	xchg   %ax,%ax
 118:	66 90                	xchg   %ax,%ax
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 129:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12a:	89 c2                	mov    %eax,%edx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	83 c1 01             	add    $0x1,%ecx
 133:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 137:	83 c2 01             	add    $0x1,%edx
 13a:	84 db                	test   %bl,%bl
 13c:	88 5a ff             	mov    %bl,-0x1(%edx)
 13f:	75 ef                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 141:	5b                   	pop    %ebx
 142:	5d                   	pop    %ebp
 143:	c3                   	ret    
 144:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 14a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 55 08             	mov    0x8(%ebp),%edx
 156:	53                   	push   %ebx
 157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	74 2d                	je     18e <strcmp+0x3e>
 161:	0f b6 19             	movzbl (%ecx),%ebx
 164:	38 d8                	cmp    %bl,%al
 166:	74 0e                	je     176 <strcmp+0x26>
 168:	eb 2b                	jmp    195 <strcmp+0x45>
 16a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 170:	38 c8                	cmp    %cl,%al
 172:	75 15                	jne    189 <strcmp+0x39>
    p++, q++;
 174:	89 d9                	mov    %ebx,%ecx
 176:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 179:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 17c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 17f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 183:	84 c0                	test   %al,%al
 185:	75 e9                	jne    170 <strcmp+0x20>
 187:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 189:	29 c8                	sub    %ecx,%eax
}
 18b:	5b                   	pop    %ebx
 18c:	5d                   	pop    %ebp
 18d:	c3                   	ret    
 18e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 191:	31 c0                	xor    %eax,%eax
 193:	eb f4                	jmp    189 <strcmp+0x39>
 195:	0f b6 cb             	movzbl %bl,%ecx
 198:	eb ef                	jmp    189 <strcmp+0x39>
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 39 00             	cmpb   $0x0,(%ecx)
 1a9:	74 12                	je     1bd <strlen+0x1d>
 1ab:	31 d2                	xor    %edx,%edx
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	83 c2 01             	add    $0x1,%edx
 1b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1b7:	89 d0                	mov    %edx,%eax
 1b9:	75 f5                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 1bd:	31 c0                	xor    %eax,%eax
}
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
 1c1:	eb 0d                	jmp    1d0 <memset>
 1c3:	90                   	nop
 1c4:	90                   	nop
 1c5:	90                   	nop
 1c6:	90                   	nop
 1c7:	90                   	nop
 1c8:	90                   	nop
 1c9:	90                   	nop
 1ca:	90                   	nop
 1cb:	90                   	nop
 1cc:	90                   	nop
 1cd:	90                   	nop
 1ce:	90                   	nop
 1cf:	90                   	nop

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
 1d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld    
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	89 d0                	mov    %edx,%eax
 1e4:	5f                   	pop    %edi
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	53                   	push   %ebx
 1f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1fa:	0f b6 18             	movzbl (%eax),%ebx
 1fd:	84 db                	test   %bl,%bl
 1ff:	74 1d                	je     21e <strchr+0x2e>
    if(*s == c)
 201:	38 d3                	cmp    %dl,%bl
 203:	89 d1                	mov    %edx,%ecx
 205:	75 0d                	jne    214 <strchr+0x24>
 207:	eb 17                	jmp    220 <strchr+0x30>
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 210:	38 ca                	cmp    %cl,%dl
 212:	74 0c                	je     220 <strchr+0x30>
  for(; *s; s++)
 214:	83 c0 01             	add    $0x1,%eax
 217:	0f b6 10             	movzbl (%eax),%edx
 21a:	84 d2                	test   %dl,%dl
 21c:	75 f2                	jne    210 <strchr+0x20>
      return (char*)s;
  return 0;
 21e:	31 c0                	xor    %eax,%eax
}
 220:	5b                   	pop    %ebx
 221:	5d                   	pop    %ebp
 222:	c3                   	ret    
 223:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 235:	31 f6                	xor    %esi,%esi
{
 237:	53                   	push   %ebx
 238:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 23b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 23e:	eb 31                	jmp    271 <gets+0x41>
    cc = read(0, &c, 1);
 240:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 247:	00 
 248:	89 7c 24 04          	mov    %edi,0x4(%esp)
 24c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 253:	e8 02 01 00 00       	call   35a <read>
    if(cc < 1)
 258:	85 c0                	test   %eax,%eax
 25a:	7e 1d                	jle    279 <gets+0x49>
      break;
    buf[i++] = c;
 25c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 260:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 262:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 265:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 267:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 26b:	74 0c                	je     279 <gets+0x49>
 26d:	3c 0a                	cmp    $0xa,%al
 26f:	74 08                	je     279 <gets+0x49>
  for(i=0; i+1 < max; ){
 271:	8d 5e 01             	lea    0x1(%esi),%ebx
 274:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 277:	7c c7                	jl     240 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 279:	8b 45 08             	mov    0x8(%ebp),%eax
 27c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 280:	83 c4 2c             	add    $0x2c,%esp
 283:	5b                   	pop    %ebx
 284:	5e                   	pop    %esi
 285:	5f                   	pop    %edi
 286:	5d                   	pop    %ebp
 287:	c3                   	ret    
 288:	90                   	nop
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a2:	00 
 2a3:	89 04 24             	mov    %eax,(%esp)
 2a6:	e8 d7 00 00 00       	call   382 <open>
  if(fd < 0)
 2ab:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 2ad:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2af:	78 27                	js     2d8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b4:	89 1c 24             	mov    %ebx,(%esp)
 2b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2bb:	e8 da 00 00 00       	call   39a <fstat>
  close(fd);
 2c0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2c3:	89 c6                	mov    %eax,%esi
  close(fd);
 2c5:	e8 a0 00 00 00       	call   36a <close>
  return r;
 2ca:	89 f0                	mov    %esi,%eax
}
 2cc:	83 c4 10             	add    $0x10,%esp
 2cf:	5b                   	pop    %ebx
 2d0:	5e                   	pop    %esi
 2d1:	5d                   	pop    %ebp
 2d2:	c3                   	ret    
 2d3:	90                   	nop
 2d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2dd:	eb ed                	jmp    2cc <stat+0x3c>
 2df:	90                   	nop

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2e6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 11             	movsbl (%ecx),%edx
 2ea:	8d 42 d0             	lea    -0x30(%edx),%eax
 2ed:	3c 09                	cmp    $0x9,%al
  n = 0;
 2ef:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2f4:	77 17                	ja     30d <atoi+0x2d>
 2f6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2f8:	83 c1 01             	add    $0x1,%ecx
 2fb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2fe:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 302:	0f be 11             	movsbl (%ecx),%edx
 305:	8d 5a d0             	lea    -0x30(%edx),%ebx
 308:	80 fb 09             	cmp    $0x9,%bl
 30b:	76 eb                	jbe    2f8 <atoi+0x18>
  return n;
}
 30d:	5b                   	pop    %ebx
 30e:	5d                   	pop    %ebp
 30f:	c3                   	ret    

00000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 311:	31 d2                	xor    %edx,%edx
{
 313:	89 e5                	mov    %esp,%ebp
 315:	56                   	push   %esi
 316:	8b 45 08             	mov    0x8(%ebp),%eax
 319:	53                   	push   %ebx
 31a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 31d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 320:	85 db                	test   %ebx,%ebx
 322:	7e 12                	jle    336 <memmove+0x26>
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 328:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 32c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 32f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 332:	39 da                	cmp    %ebx,%edx
 334:	75 f2                	jne    328 <memmove+0x18>
  return vdst;
}
 336:	5b                   	pop    %ebx
 337:	5e                   	pop    %esi
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    

0000033a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33a:	b8 01 00 00 00       	mov    $0x1,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <exit>:
SYSCALL(exit)
 342:	b8 02 00 00 00       	mov    $0x2,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <wait>:
SYSCALL(wait)
 34a:	b8 03 00 00 00       	mov    $0x3,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <pipe>:
SYSCALL(pipe)
 352:	b8 04 00 00 00       	mov    $0x4,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <read>:
SYSCALL(read)
 35a:	b8 05 00 00 00       	mov    $0x5,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <write>:
SYSCALL(write)
 362:	b8 10 00 00 00       	mov    $0x10,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <close>:
SYSCALL(close)
 36a:	b8 15 00 00 00       	mov    $0x15,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kill>:
SYSCALL(kill)
 372:	b8 06 00 00 00       	mov    $0x6,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <exec>:
SYSCALL(exec)
 37a:	b8 07 00 00 00       	mov    $0x7,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <open>:
SYSCALL(open)
 382:	b8 0f 00 00 00       	mov    $0xf,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <mknod>:
SYSCALL(mknod)
 38a:	b8 11 00 00 00       	mov    $0x11,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <unlink>:
SYSCALL(unlink)
 392:	b8 12 00 00 00       	mov    $0x12,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <fstat>:
SYSCALL(fstat)
 39a:	b8 08 00 00 00       	mov    $0x8,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <link>:
SYSCALL(link)
 3a2:	b8 13 00 00 00       	mov    $0x13,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mkdir>:
SYSCALL(mkdir)
 3aa:	b8 14 00 00 00       	mov    $0x14,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <chdir>:
SYSCALL(chdir)
 3b2:	b8 09 00 00 00       	mov    $0x9,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <dup>:
SYSCALL(dup)
 3ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <getpid>:
SYSCALL(getpid)
 3c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <sbrk>:
SYSCALL(sbrk)
 3ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <sleep>:
SYSCALL(sleep)
 3d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <uptime>:
SYSCALL(uptime)
 3da:	b8 0e 00 00 00       	mov    $0xe,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 3e2:	b8 16 00 00 00       	mov    $0x16,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 3ea:	b8 17 00 00 00       	mov    $0x17,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 3f2:	b8 18 00 00 00       	mov    $0x18,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <halt>:
 3fa:	b8 19 00 00 00       	mov    $0x19,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    
 402:	66 90                	xchg   %ax,%ax
 404:	66 90                	xchg   %ax,%ax
 406:	66 90                	xchg   %ax,%ax
 408:	66 90                	xchg   %ax,%ax
 40a:	66 90                	xchg   %ax,%ax
 40c:	66 90                	xchg   %ax,%ax
 40e:	66 90                	xchg   %ax,%ax

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	89 c6                	mov    %eax,%esi
 417:	53                   	push   %ebx
 418:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 41b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 41e:	85 db                	test   %ebx,%ebx
 420:	74 09                	je     42b <printint+0x1b>
 422:	89 d0                	mov    %edx,%eax
 424:	c1 e8 1f             	shr    $0x1f,%eax
 427:	84 c0                	test   %al,%al
 429:	75 75                	jne    4a0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 42b:	89 d0                	mov    %edx,%eax
  neg = 0;
 42d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 434:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 437:	31 ff                	xor    %edi,%edi
 439:	89 ce                	mov    %ecx,%esi
 43b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 43e:	eb 02                	jmp    442 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 440:	89 cf                	mov    %ecx,%edi
 442:	31 d2                	xor    %edx,%edx
 444:	f7 f6                	div    %esi
 446:	8d 4f 01             	lea    0x1(%edi),%ecx
 449:	0f b6 92 85 08 00 00 	movzbl 0x885(%edx),%edx
  }while((x /= base) != 0);
 450:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 452:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 455:	75 e9                	jne    440 <printint+0x30>
  if(neg)
 457:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 45a:	89 c8                	mov    %ecx,%eax
 45c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 45f:	85 d2                	test   %edx,%edx
 461:	74 08                	je     46b <printint+0x5b>
    buf[i++] = '-';
 463:	8d 4f 02             	lea    0x2(%edi),%ecx
 466:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 46b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 46e:	66 90                	xchg   %ax,%ax
 470:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 475:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 478:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47f:	00 
 480:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 484:	89 34 24             	mov    %esi,(%esp)
 487:	88 45 d7             	mov    %al,-0x29(%ebp)
 48a:	e8 d3 fe ff ff       	call   362 <write>
  while(--i >= 0)
 48f:	83 ff ff             	cmp    $0xffffffff,%edi
 492:	75 dc                	jne    470 <printint+0x60>
    putc(fd, buf[i]);
}
 494:	83 c4 4c             	add    $0x4c,%esp
 497:	5b                   	pop    %ebx
 498:	5e                   	pop    %esi
 499:	5f                   	pop    %edi
 49a:	5d                   	pop    %ebp
 49b:	c3                   	ret    
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 4a0:	89 d0                	mov    %edx,%eax
 4a2:	f7 d8                	neg    %eax
    neg = 1;
 4a4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4ab:	eb 87                	jmp    434 <printint+0x24>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi

000004b0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b4:	31 ff                	xor    %edi,%edi
{
 4b6:	56                   	push   %esi
 4b7:	53                   	push   %ebx
 4b8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4bb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 4be:	8d 45 10             	lea    0x10(%ebp),%eax
{
 4c1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 4c4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 4c7:	0f b6 13             	movzbl (%ebx),%edx
 4ca:	83 c3 01             	add    $0x1,%ebx
 4cd:	84 d2                	test   %dl,%dl
 4cf:	75 39                	jne    50a <printf+0x5a>
 4d1:	e9 ca 00 00 00       	jmp    5a0 <printf+0xf0>
 4d6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4d8:	83 fa 25             	cmp    $0x25,%edx
 4db:	0f 84 c7 00 00 00    	je     5a8 <printf+0xf8>
  write(fd, &c, 1);
 4e1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4eb:	00 
 4ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 4f3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 4f6:	e8 67 fe ff ff       	call   362 <write>
 4fb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 4fe:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 502:	84 d2                	test   %dl,%dl
 504:	0f 84 96 00 00 00    	je     5a0 <printf+0xf0>
    if(state == 0){
 50a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 50c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 50f:	74 c7                	je     4d8 <printf+0x28>
      }
    } else if(state == '%'){
 511:	83 ff 25             	cmp    $0x25,%edi
 514:	75 e5                	jne    4fb <printf+0x4b>
      if(c == 'd' || c == 'u'){
 516:	83 fa 75             	cmp    $0x75,%edx
 519:	0f 84 99 00 00 00    	je     5b8 <printf+0x108>
 51f:	83 fa 64             	cmp    $0x64,%edx
 522:	0f 84 90 00 00 00    	je     5b8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 528:	25 f7 00 00 00       	and    $0xf7,%eax
 52d:	83 f8 70             	cmp    $0x70,%eax
 530:	0f 84 aa 00 00 00    	je     5e0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 536:	83 fa 73             	cmp    $0x73,%edx
 539:	0f 84 e9 00 00 00    	je     628 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 53f:	83 fa 63             	cmp    $0x63,%edx
 542:	0f 84 2b 01 00 00    	je     673 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 548:	83 fa 25             	cmp    $0x25,%edx
 54b:	0f 84 4f 01 00 00    	je     6a0 <printf+0x1f0>
  write(fd, &c, 1);
 551:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 554:	83 c3 01             	add    $0x1,%ebx
 557:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 55e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 561:	89 44 24 04          	mov    %eax,0x4(%esp)
 565:	89 34 24             	mov    %esi,(%esp)
 568:	89 55 d0             	mov    %edx,-0x30(%ebp)
 56b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 56f:	e8 ee fd ff ff       	call   362 <write>
        putc(fd, c);
 574:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 577:	8d 45 e7             	lea    -0x19(%ebp),%eax
 57a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 581:	00 
 582:	89 44 24 04          	mov    %eax,0x4(%esp)
 586:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 589:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 58c:	e8 d1 fd ff ff       	call   362 <write>
  for(i = 0; fmt[i]; i++){
 591:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 595:	84 d2                	test   %dl,%dl
 597:	0f 85 6d ff ff ff    	jne    50a <printf+0x5a>
 59d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 5a0:	83 c4 3c             	add    $0x3c,%esp
 5a3:	5b                   	pop    %ebx
 5a4:	5e                   	pop    %esi
 5a5:	5f                   	pop    %edi
 5a6:	5d                   	pop    %ebp
 5a7:	c3                   	ret    
        state = '%';
 5a8:	bf 25 00 00 00       	mov    $0x25,%edi
 5ad:	e9 49 ff ff ff       	jmp    4fb <printf+0x4b>
 5b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5bf:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 5c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5c7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 5c9:	8b 10                	mov    (%eax),%edx
 5cb:	89 f0                	mov    %esi,%eax
 5cd:	e8 3e fe ff ff       	call   410 <printint>
        ap++;
 5d2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5d6:	e9 20 ff ff ff       	jmp    4fb <printf+0x4b>
 5db:	90                   	nop
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5e0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 5e3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ea:	00 
 5eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ef:	89 34 24             	mov    %esi,(%esp)
 5f2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 5f6:	e8 67 fd ff ff       	call   362 <write>
 5fb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5fe:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 605:	00 
 606:	89 44 24 04          	mov    %eax,0x4(%esp)
 60a:	89 34 24             	mov    %esi,(%esp)
 60d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 611:	e8 4c fd ff ff       	call   362 <write>
        printint(fd, *ap, 16, 0);
 616:	b9 10 00 00 00       	mov    $0x10,%ecx
 61b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 622:	eb a0                	jmp    5c4 <printf+0x114>
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 628:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 62b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 62f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 631:	b8 7e 08 00 00       	mov    $0x87e,%eax
 636:	85 ff                	test   %edi,%edi
 638:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 63b:	0f b6 07             	movzbl (%edi),%eax
 63e:	84 c0                	test   %al,%al
 640:	74 2a                	je     66c <printf+0x1bc>
 642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 648:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 64b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 64e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 651:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 658:	00 
 659:	89 44 24 04          	mov    %eax,0x4(%esp)
 65d:	89 34 24             	mov    %esi,(%esp)
 660:	e8 fd fc ff ff       	call   362 <write>
        while(*s != 0){
 665:	0f b6 07             	movzbl (%edi),%eax
 668:	84 c0                	test   %al,%al
 66a:	75 dc                	jne    648 <printf+0x198>
      state = 0;
 66c:	31 ff                	xor    %edi,%edi
 66e:	e9 88 fe ff ff       	jmp    4fb <printf+0x4b>
        putc(fd, *ap);
 673:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 676:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 678:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 67a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 681:	00 
 682:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 685:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 688:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 68b:	89 44 24 04          	mov    %eax,0x4(%esp)
 68f:	e8 ce fc ff ff       	call   362 <write>
        ap++;
 694:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 698:	e9 5e fe ff ff       	jmp    4fb <printf+0x4b>
 69d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6a0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 6a3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 6a5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6ac:	00 
 6ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b1:	89 34 24             	mov    %esi,(%esp)
 6b4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 6b8:	e8 a5 fc ff ff       	call   362 <write>
 6bd:	e9 39 fe ff ff       	jmp    4fb <printf+0x4b>
 6c2:	66 90                	xchg   %ax,%ax
 6c4:	66 90                	xchg   %ax,%ax
 6c6:	66 90                	xchg   %ax,%ax
 6c8:	66 90                	xchg   %ax,%ax
 6ca:	66 90                	xchg   %ax,%ax
 6cc:	66 90                	xchg   %ax,%ax
 6ce:	66 90                	xchg   %ax,%ax

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 40 0b 00 00       	mov    0xb40,%eax
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6de:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 6e0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e3:	39 d0                	cmp    %edx,%eax
 6e5:	72 11                	jb     6f8 <free+0x28>
 6e7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e8:	39 c8                	cmp    %ecx,%eax
 6ea:	72 04                	jb     6f0 <free+0x20>
 6ec:	39 ca                	cmp    %ecx,%edx
 6ee:	72 10                	jb     700 <free+0x30>
 6f0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f6:	73 f0                	jae    6e8 <free+0x18>
 6f8:	39 ca                	cmp    %ecx,%edx
 6fa:	72 04                	jb     700 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fc:	39 c8                	cmp    %ecx,%eax
 6fe:	72 f0                	jb     6f0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 700:	8b 73 fc             	mov    -0x4(%ebx),%esi
 703:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 706:	39 cf                	cmp    %ecx,%edi
 708:	74 1e                	je     728 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 70a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 70d:	8b 48 04             	mov    0x4(%eax),%ecx
 710:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 713:	39 f2                	cmp    %esi,%edx
 715:	74 28                	je     73f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 717:	89 10                	mov    %edx,(%eax)
  freep = p;
 719:	a3 40 0b 00 00       	mov    %eax,0xb40
}
 71e:	5b                   	pop    %ebx
 71f:	5e                   	pop    %esi
 720:	5f                   	pop    %edi
 721:	5d                   	pop    %ebp
 722:	c3                   	ret    
 723:	90                   	nop
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 728:	03 71 04             	add    0x4(%ecx),%esi
 72b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 72e:	8b 08                	mov    (%eax),%ecx
 730:	8b 09                	mov    (%ecx),%ecx
 732:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 735:	8b 48 04             	mov    0x4(%eax),%ecx
 738:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 73b:	39 f2                	cmp    %esi,%edx
 73d:	75 d8                	jne    717 <free+0x47>
    p->s.size += bp->s.size;
 73f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 742:	a3 40 0b 00 00       	mov    %eax,0xb40
    p->s.size += bp->s.size;
 747:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 74a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 74d:	89 10                	mov    %edx,(%eax)
}
 74f:	5b                   	pop    %ebx
 750:	5e                   	pop    %esi
 751:	5f                   	pop    %edi
 752:	5d                   	pop    %ebp
 753:	c3                   	ret    
 754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 75a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 1d 40 0b 00 00    	mov    0xb40,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 48 07             	lea    0x7(%eax),%ecx
 775:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 778:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 77a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 77d:	0f 84 9b 00 00 00    	je     81e <malloc+0xbe>
 783:	8b 13                	mov    (%ebx),%edx
 785:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 788:	39 fe                	cmp    %edi,%esi
 78a:	76 64                	jbe    7f0 <malloc+0x90>
 78c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 793:	bb 00 80 00 00       	mov    $0x8000,%ebx
 798:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 79b:	eb 0e                	jmp    7ab <malloc+0x4b>
 79d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a2:	8b 78 04             	mov    0x4(%eax),%edi
 7a5:	39 fe                	cmp    %edi,%esi
 7a7:	76 4f                	jbe    7f8 <malloc+0x98>
 7a9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7ab:	3b 15 40 0b 00 00    	cmp    0xb40,%edx
 7b1:	75 ed                	jne    7a0 <malloc+0x40>
  if(nu < 4096)
 7b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7b6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7bc:	bf 00 10 00 00       	mov    $0x1000,%edi
 7c1:	0f 43 fe             	cmovae %esi,%edi
 7c4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 7c7:	89 04 24             	mov    %eax,(%esp)
 7ca:	e8 fb fb ff ff       	call   3ca <sbrk>
  if(p == (char*)-1)
 7cf:	83 f8 ff             	cmp    $0xffffffff,%eax
 7d2:	74 18                	je     7ec <malloc+0x8c>
  hp->s.size = nu;
 7d4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7d7:	83 c0 08             	add    $0x8,%eax
 7da:	89 04 24             	mov    %eax,(%esp)
 7dd:	e8 ee fe ff ff       	call   6d0 <free>
  return freep;
 7e2:	8b 15 40 0b 00 00    	mov    0xb40,%edx
      if((p = morecore(nunits)) == 0)
 7e8:	85 d2                	test   %edx,%edx
 7ea:	75 b4                	jne    7a0 <malloc+0x40>
        return 0;
 7ec:	31 c0                	xor    %eax,%eax
 7ee:	eb 20                	jmp    810 <malloc+0xb0>
    if(p->s.size >= nunits){
 7f0:	89 d0                	mov    %edx,%eax
 7f2:	89 da                	mov    %ebx,%edx
 7f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7f8:	39 fe                	cmp    %edi,%esi
 7fa:	74 1c                	je     818 <malloc+0xb8>
        p->s.size -= nunits;
 7fc:	29 f7                	sub    %esi,%edi
 7fe:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 801:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 804:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 807:	89 15 40 0b 00 00    	mov    %edx,0xb40
      return (void*)(p + 1);
 80d:	83 c0 08             	add    $0x8,%eax
  }
}
 810:	83 c4 1c             	add    $0x1c,%esp
 813:	5b                   	pop    %ebx
 814:	5e                   	pop    %esi
 815:	5f                   	pop    %edi
 816:	5d                   	pop    %ebp
 817:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 818:	8b 08                	mov    (%eax),%ecx
 81a:	89 0a                	mov    %ecx,(%edx)
 81c:	eb e9                	jmp    807 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 81e:	c7 05 40 0b 00 00 44 	movl   $0xb44,0xb40
 825:	0b 00 00 
    base.s.size = 0;
 828:	ba 44 0b 00 00       	mov    $0xb44,%edx
    base.s.ptr = freep = prevp = &base;
 82d:	c7 05 44 0b 00 00 44 	movl   $0xb44,0xb44
 834:	0b 00 00 
    base.s.size = 0;
 837:	c7 05 48 0b 00 00 00 	movl   $0x0,0xb48
 83e:	00 00 00 
 841:	e9 46 ff ff ff       	jmp    78c <malloc+0x2c>
