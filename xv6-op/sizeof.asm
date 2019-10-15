
_sizeof:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
    printf(1, "This appears to be a %d bit system.\n", __WORDSIZE);
   9:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
  10:	00 
  11:	c7 44 24 04 98 08 00 	movl   $0x898,0x4(%esp)
  18:	00 
  19:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  20:	e8 db 04 00 00       	call   500 <printf>
    {
        unsigned int i = 1;

        char *c = (char *) &i;
        if (0 != (*c)) {
            printf(1, "    This system is little endian.\n");
  25:	c7 44 24 04 c0 08 00 	movl   $0x8c0,0x4(%esp)
  2c:	00 
  2d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  34:	e8 c7 04 00 00       	call   500 <printf>
        }
        else {
            printf(1, "    This system is big endian.\n");
        }
    }
    printf(1, "\n");
  39:	c7 44 24 04 32 0a 00 	movl   $0xa32,0x4(%esp)
  40:	00 
  41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  48:	e8 b3 04 00 00       	call   500 <printf>

    printf(1, "Size of basic C data types\n");
  4d:	c7 44 24 04 18 0a 00 	movl   $0xa18,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 9f 04 00 00       	call   500 <printf>
    printf(1, "                        bytes  bits\n");
  61:	c7 44 24 04 e4 08 00 	movl   $0x8e4,0x4(%esp)
  68:	00 
  69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  70:	e8 8b 04 00 00       	call   500 <printf>
    printf(1, "    sizeof(char)        %d      %d\n"
  75:	c7 44 24 0c 08 00 00 	movl   $0x8,0xc(%esp)
  7c:	00 
  7d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  84:	00 
  85:	c7 44 24 04 0c 09 00 	movl   $0x90c,0x4(%esp)
  8c:	00 
  8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  94:	e8 67 04 00 00       	call   500 <printf>
           , (int) sizeof(char)
           , (int) CHARBITS);
    printf(1, "    sizeof(short)       %d      %d\n"
  99:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  a0:	00 
  a1:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
  a8:	00 
  a9:	c7 44 24 04 30 09 00 	movl   $0x930,0x4(%esp)
  b0:	00 
  b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b8:	e8 43 04 00 00       	call   500 <printf>
           , (int) sizeof(short)
           , (int) SHORTBITS);
    printf(1, "    sizeof(int)         %d      %d\n"
  bd:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  c4:	00 
  c5:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  cc:	00 
  cd:	c7 44 24 04 54 09 00 	movl   $0x954,0x4(%esp)
  d4:	00 
  d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  dc:	e8 1f 04 00 00       	call   500 <printf>
           , (int) sizeof(int)
           , (int) INTBITS);
    printf(1, "    sizeof(unsigned)    %d      %d\n"
  e1:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  e8:	00 
  e9:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  f0:	00 
  f1:	c7 44 24 04 78 09 00 	movl   $0x978,0x4(%esp)
  f8:	00 
  f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 100:	e8 fb 03 00 00       	call   500 <printf>
           , (int) sizeof(unsigned)
           // This is not directly supported by a nice macro, so I'm
           //   calculating it.
           , (int) (sizeof(unsigned) * CHARBITS));
    printf(1, "    sizeof(long)        %d      %d\n"
 105:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
 10c:	00 
 10d:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
 114:	00 
 115:	c7 44 24 04 9c 09 00 	movl   $0x99c,0x4(%esp)
 11c:	00 
 11d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 124:	e8 d7 03 00 00       	call   500 <printf>
           , (int) sizeof(long)
           , (int) LONGBITS);
    printf(1, "    sizeof(long long)   %d      %d\n"
 129:	c7 44 24 0c 40 00 00 	movl   $0x40,0xc(%esp)
 130:	00 
 131:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
 138:	00 
 139:	c7 44 24 04 c0 09 00 	movl   $0x9c0,0x4(%esp)
 140:	00 
 141:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 148:	e8 b3 03 00 00       	call   500 <printf>
           , (int) sizeof(long long)
           // This is not directly supported by a nice macro, sir I'm
           //   calculating it.
           , (int) (sizeof(long long) * CHARBITS));

    printf(1, "    sizeof(void *)      %d      %d (aka a pointer)\n"
 14d:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
 154:	00 
 155:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
 15c:	00 
 15d:	c7 44 24 04 e4 09 00 	movl   $0x9e4,0x4(%esp)
 164:	00 
 165:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 16c:	e8 8f 03 00 00       	call   500 <printf>
           , (int) sizeof(void *), (int) PTRBITS);

    // You MUST call exit() as the last thing your code does in xv6.
    exit();
 171:	e8 2c 02 00 00       	call   3a2 <exit>
 176:	66 90                	xchg   %ax,%ax
 178:	66 90                	xchg   %ax,%ax
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 189:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 c2                	mov    %eax,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	53                   	push   %ebx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	74 2d                	je     1ee <strcmp+0x3e>
 1c1:	0f b6 19             	movzbl (%ecx),%ebx
 1c4:	38 d8                	cmp    %bl,%al
 1c6:	74 0e                	je     1d6 <strcmp+0x26>
 1c8:	eb 2b                	jmp    1f5 <strcmp+0x45>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d0:	38 c8                	cmp    %cl,%al
 1d2:	75 15                	jne    1e9 <strcmp+0x39>
    p++, q++;
 1d4:	89 d9                	mov    %ebx,%ecx
 1d6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1d9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1dc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1df:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1e3:	84 c0                	test   %al,%al
 1e5:	75 e9                	jne    1d0 <strcmp+0x20>
 1e7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1e9:	29 c8                	sub    %ecx,%eax
}
 1eb:	5b                   	pop    %ebx
 1ec:	5d                   	pop    %ebp
 1ed:	c3                   	ret    
 1ee:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 1f1:	31 c0                	xor    %eax,%eax
 1f3:	eb f4                	jmp    1e9 <strcmp+0x39>
 1f5:	0f b6 cb             	movzbl %bl,%ecx
 1f8:	eb ef                	jmp    1e9 <strcmp+0x39>
 1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000200 <strlen>:

uint
strlen(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 12                	je     21d <strlen+0x1d>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 21d:	31 c0                	xor    %eax,%eax
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
 221:	eb 0d                	jmp    230 <memset>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 55 08             	mov    0x8(%ebp),%edx
 236:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	53                   	push   %ebx
 257:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 25a:	0f b6 18             	movzbl (%eax),%ebx
 25d:	84 db                	test   %bl,%bl
 25f:	74 1d                	je     27e <strchr+0x2e>
    if(*s == c)
 261:	38 d3                	cmp    %dl,%bl
 263:	89 d1                	mov    %edx,%ecx
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
  for(; *s; s++)
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
 27e:	31 c0                	xor    %eax,%eax
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 295:	31 f6                	xor    %esi,%esi
{
 297:	53                   	push   %ebx
 298:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 29b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 29e:	eb 31                	jmp    2d1 <gets+0x41>
    cc = read(0, &c, 1);
 2a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2a7:	00 
 2a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2b3:	e8 02 01 00 00       	call   3ba <read>
    if(cc < 1)
 2b8:	85 c0                	test   %eax,%eax
 2ba:	7e 1d                	jle    2d9 <gets+0x49>
      break;
    buf[i++] = c;
 2bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 2c0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 2c2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2c5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 2c7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2cb:	74 0c                	je     2d9 <gets+0x49>
 2cd:	3c 0a                	cmp    $0xa,%al
 2cf:	74 08                	je     2d9 <gets+0x49>
  for(i=0; i+1 < max; ){
 2d1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2d7:	7c c7                	jl     2a0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2d9:	8b 45 08             	mov    0x8(%ebp),%eax
 2dc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2e0:	83 c4 2c             	add    $0x2c,%esp
 2e3:	5b                   	pop    %ebx
 2e4:	5e                   	pop    %esi
 2e5:	5f                   	pop    %edi
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	90                   	nop
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	53                   	push   %ebx
 2f5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f8:	8b 45 08             	mov    0x8(%ebp),%eax
 2fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 302:	00 
 303:	89 04 24             	mov    %eax,(%esp)
 306:	e8 d7 00 00 00       	call   3e2 <open>
  if(fd < 0)
 30b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 30d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 30f:	78 27                	js     338 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 311:	8b 45 0c             	mov    0xc(%ebp),%eax
 314:	89 1c 24             	mov    %ebx,(%esp)
 317:	89 44 24 04          	mov    %eax,0x4(%esp)
 31b:	e8 da 00 00 00       	call   3fa <fstat>
  close(fd);
 320:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 323:	89 c6                	mov    %eax,%esi
  close(fd);
 325:	e8 a0 00 00 00       	call   3ca <close>
  return r;
 32a:	89 f0                	mov    %esi,%eax
}
 32c:	83 c4 10             	add    $0x10,%esp
 32f:	5b                   	pop    %ebx
 330:	5e                   	pop    %esi
 331:	5d                   	pop    %ebp
 332:	c3                   	ret    
 333:	90                   	nop
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 338:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 33d:	eb ed                	jmp    32c <stat+0x3c>
 33f:	90                   	nop

00000340 <atoi>:

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 4d 08             	mov    0x8(%ebp),%ecx
 346:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	0f be 11             	movsbl (%ecx),%edx
 34a:	8d 42 d0             	lea    -0x30(%edx),%eax
 34d:	3c 09                	cmp    $0x9,%al
  n = 0;
 34f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 354:	77 17                	ja     36d <atoi+0x2d>
 356:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 358:	83 c1 01             	add    $0x1,%ecx
 35b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 35e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 362:	0f be 11             	movsbl (%ecx),%edx
 365:	8d 5a d0             	lea    -0x30(%edx),%ebx
 368:	80 fb 09             	cmp    $0x9,%bl
 36b:	76 eb                	jbe    358 <atoi+0x18>
  return n;
}
 36d:	5b                   	pop    %ebx
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    

00000370 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 370:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 371:	31 d2                	xor    %edx,%edx
{
 373:	89 e5                	mov    %esp,%ebp
 375:	56                   	push   %esi
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	53                   	push   %ebx
 37a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 37d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 380:	85 db                	test   %ebx,%ebx
 382:	7e 12                	jle    396 <memmove+0x26>
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 388:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 38c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 38f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 392:	39 da                	cmp    %ebx,%edx
 394:	75 f2                	jne    388 <memmove+0x18>
  return vdst;
}
 396:	5b                   	pop    %ebx
 397:	5e                   	pop    %esi
 398:	5d                   	pop    %ebp
 399:	c3                   	ret    

0000039a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 39a:	b8 01 00 00 00       	mov    $0x1,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <exit>:
SYSCALL(exit)
 3a2:	b8 02 00 00 00       	mov    $0x2,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <wait>:
SYSCALL(wait)
 3aa:	b8 03 00 00 00       	mov    $0x3,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <pipe>:
SYSCALL(pipe)
 3b2:	b8 04 00 00 00       	mov    $0x4,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <read>:
SYSCALL(read)
 3ba:	b8 05 00 00 00       	mov    $0x5,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <write>:
SYSCALL(write)
 3c2:	b8 10 00 00 00       	mov    $0x10,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <close>:
SYSCALL(close)
 3ca:	b8 15 00 00 00       	mov    $0x15,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <kill>:
SYSCALL(kill)
 3d2:	b8 06 00 00 00       	mov    $0x6,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <exec>:
SYSCALL(exec)
 3da:	b8 07 00 00 00       	mov    $0x7,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <open>:
SYSCALL(open)
 3e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <mknod>:
SYSCALL(mknod)
 3ea:	b8 11 00 00 00       	mov    $0x11,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <unlink>:
SYSCALL(unlink)
 3f2:	b8 12 00 00 00       	mov    $0x12,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <fstat>:
SYSCALL(fstat)
 3fa:	b8 08 00 00 00       	mov    $0x8,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <link>:
SYSCALL(link)
 402:	b8 13 00 00 00       	mov    $0x13,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <mkdir>:
SYSCALL(mkdir)
 40a:	b8 14 00 00 00       	mov    $0x14,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <chdir>:
SYSCALL(chdir)
 412:	b8 09 00 00 00       	mov    $0x9,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <dup>:
SYSCALL(dup)
 41a:	b8 0a 00 00 00       	mov    $0xa,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <getpid>:
SYSCALL(getpid)
 422:	b8 0b 00 00 00       	mov    $0xb,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <sbrk>:
SYSCALL(sbrk)
 42a:	b8 0c 00 00 00       	mov    $0xc,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <sleep>:
SYSCALL(sleep)
 432:	b8 0d 00 00 00       	mov    $0xd,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <uptime>:
SYSCALL(uptime)
 43a:	b8 0e 00 00 00       	mov    $0xe,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 442:	b8 16 00 00 00       	mov    $0x16,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 44a:	b8 17 00 00 00       	mov    $0x17,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 452:	b8 18 00 00 00       	mov    $0x18,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    
 45a:	66 90                	xchg   %ax,%ax
 45c:	66 90                	xchg   %ax,%ax
 45e:	66 90                	xchg   %ax,%ax

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	89 c6                	mov    %eax,%esi
 467:	53                   	push   %ebx
 468:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 46b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 46e:	85 db                	test   %ebx,%ebx
 470:	74 09                	je     47b <printint+0x1b>
 472:	89 d0                	mov    %edx,%eax
 474:	c1 e8 1f             	shr    $0x1f,%eax
 477:	84 c0                	test   %al,%al
 479:	75 75                	jne    4f0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 47b:	89 d0                	mov    %edx,%eax
  neg = 0;
 47d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 484:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 487:	31 ff                	xor    %edi,%edi
 489:	89 ce                	mov    %ecx,%esi
 48b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 48e:	eb 02                	jmp    492 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 490:	89 cf                	mov    %ecx,%edi
 492:	31 d2                	xor    %edx,%edx
 494:	f7 f6                	div    %esi
 496:	8d 4f 01             	lea    0x1(%edi),%ecx
 499:	0f b6 92 3b 0a 00 00 	movzbl 0xa3b(%edx),%edx
  }while((x /= base) != 0);
 4a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4a2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4a5:	75 e9                	jne    490 <printint+0x30>
  if(neg)
 4a7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 4aa:	89 c8                	mov    %ecx,%eax
 4ac:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 4af:	85 d2                	test   %edx,%edx
 4b1:	74 08                	je     4bb <printint+0x5b>
    buf[i++] = '-';
 4b3:	8d 4f 02             	lea    0x2(%edi),%ecx
 4b6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 4bb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 4be:	66 90                	xchg   %ax,%ax
 4c0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 4c5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 4c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4cf:	00 
 4d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4d4:	89 34 24             	mov    %esi,(%esp)
 4d7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4da:	e8 e3 fe ff ff       	call   3c2 <write>
  while(--i >= 0)
 4df:	83 ff ff             	cmp    $0xffffffff,%edi
 4e2:	75 dc                	jne    4c0 <printint+0x60>
    putc(fd, buf[i]);
}
 4e4:	83 c4 4c             	add    $0x4c,%esp
 4e7:	5b                   	pop    %ebx
 4e8:	5e                   	pop    %esi
 4e9:	5f                   	pop    %edi
 4ea:	5d                   	pop    %ebp
 4eb:	c3                   	ret    
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 4f0:	89 d0                	mov    %edx,%eax
 4f2:	f7 d8                	neg    %eax
    neg = 1;
 4f4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4fb:	eb 87                	jmp    484 <printint+0x24>
 4fd:	8d 76 00             	lea    0x0(%esi),%esi

00000500 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 504:	31 ff                	xor    %edi,%edi
{
 506:	56                   	push   %esi
 507:	53                   	push   %ebx
 508:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 50b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 50e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 511:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 514:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 517:	0f b6 13             	movzbl (%ebx),%edx
 51a:	83 c3 01             	add    $0x1,%ebx
 51d:	84 d2                	test   %dl,%dl
 51f:	75 39                	jne    55a <printf+0x5a>
 521:	e9 ca 00 00 00       	jmp    5f0 <printf+0xf0>
 526:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 528:	83 fa 25             	cmp    $0x25,%edx
 52b:	0f 84 c7 00 00 00    	je     5f8 <printf+0xf8>
  write(fd, &c, 1);
 531:	8d 45 e0             	lea    -0x20(%ebp),%eax
 534:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 53b:	00 
 53c:	89 44 24 04          	mov    %eax,0x4(%esp)
 540:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 543:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 546:	e8 77 fe ff ff       	call   3c2 <write>
 54b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 54e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 552:	84 d2                	test   %dl,%dl
 554:	0f 84 96 00 00 00    	je     5f0 <printf+0xf0>
    if(state == 0){
 55a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 55c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 55f:	74 c7                	je     528 <printf+0x28>
      }
    } else if(state == '%'){
 561:	83 ff 25             	cmp    $0x25,%edi
 564:	75 e5                	jne    54b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 566:	83 fa 75             	cmp    $0x75,%edx
 569:	0f 84 99 00 00 00    	je     608 <printf+0x108>
 56f:	83 fa 64             	cmp    $0x64,%edx
 572:	0f 84 90 00 00 00    	je     608 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 578:	25 f7 00 00 00       	and    $0xf7,%eax
 57d:	83 f8 70             	cmp    $0x70,%eax
 580:	0f 84 aa 00 00 00    	je     630 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 586:	83 fa 73             	cmp    $0x73,%edx
 589:	0f 84 e9 00 00 00    	je     678 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 58f:	83 fa 63             	cmp    $0x63,%edx
 592:	0f 84 2b 01 00 00    	je     6c3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 598:	83 fa 25             	cmp    $0x25,%edx
 59b:	0f 84 4f 01 00 00    	je     6f0 <printf+0x1f0>
  write(fd, &c, 1);
 5a1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5a4:	83 c3 01             	add    $0x1,%ebx
 5a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ae:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5af:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b5:	89 34 24             	mov    %esi,(%esp)
 5b8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5bb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 5bf:	e8 fe fd ff ff       	call   3c2 <write>
        putc(fd, c);
 5c4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 5c7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5d1:	00 
 5d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 5d9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5dc:	e8 e1 fd ff ff       	call   3c2 <write>
  for(i = 0; fmt[i]; i++){
 5e1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5e5:	84 d2                	test   %dl,%dl
 5e7:	0f 85 6d ff ff ff    	jne    55a <printf+0x5a>
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 5f0:	83 c4 3c             	add    $0x3c,%esp
 5f3:	5b                   	pop    %ebx
 5f4:	5e                   	pop    %esi
 5f5:	5f                   	pop    %edi
 5f6:	5d                   	pop    %ebp
 5f7:	c3                   	ret    
        state = '%';
 5f8:	bf 25 00 00 00       	mov    $0x25,%edi
 5fd:	e9 49 ff ff ff       	jmp    54b <printf+0x4b>
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 608:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 60f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 614:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 617:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 619:	8b 10                	mov    (%eax),%edx
 61b:	89 f0                	mov    %esi,%eax
 61d:	e8 3e fe ff ff       	call   460 <printint>
        ap++;
 622:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 626:	e9 20 ff ff ff       	jmp    54b <printf+0x4b>
 62b:	90                   	nop
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 630:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 633:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 63a:	00 
 63b:	89 44 24 04          	mov    %eax,0x4(%esp)
 63f:	89 34 24             	mov    %esi,(%esp)
 642:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 646:	e8 77 fd ff ff       	call   3c2 <write>
 64b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 64e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 655:	00 
 656:	89 44 24 04          	mov    %eax,0x4(%esp)
 65a:	89 34 24             	mov    %esi,(%esp)
 65d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 661:	e8 5c fd ff ff       	call   3c2 <write>
        printint(fd, *ap, 16, 0);
 666:	b9 10 00 00 00       	mov    $0x10,%ecx
 66b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 672:	eb a0                	jmp    614 <printf+0x114>
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 67b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 67f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 681:	b8 34 0a 00 00       	mov    $0xa34,%eax
 686:	85 ff                	test   %edi,%edi
 688:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 68b:	0f b6 07             	movzbl (%edi),%eax
 68e:	84 c0                	test   %al,%al
 690:	74 2a                	je     6bc <printf+0x1bc>
 692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 698:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 69b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 69e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 6a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6a8:	00 
 6a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ad:	89 34 24             	mov    %esi,(%esp)
 6b0:	e8 0d fd ff ff       	call   3c2 <write>
        while(*s != 0){
 6b5:	0f b6 07             	movzbl (%edi),%eax
 6b8:	84 c0                	test   %al,%al
 6ba:	75 dc                	jne    698 <printf+0x198>
      state = 0;
 6bc:	31 ff                	xor    %edi,%edi
 6be:	e9 88 fe ff ff       	jmp    54b <printf+0x4b>
        putc(fd, *ap);
 6c3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6c6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 6c8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 6ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6d1:	00 
 6d2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 6d5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6d8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6db:	89 44 24 04          	mov    %eax,0x4(%esp)
 6df:	e8 de fc ff ff       	call   3c2 <write>
        ap++;
 6e4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6e8:	e9 5e fe ff ff       	jmp    54b <printf+0x4b>
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6f0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 6f3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 6f5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6fc:	00 
 6fd:	89 44 24 04          	mov    %eax,0x4(%esp)
 701:	89 34 24             	mov    %esi,(%esp)
 704:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 708:	e8 b5 fc ff ff       	call   3c2 <write>
 70d:	e9 39 fe ff ff       	jmp    54b <printf+0x4b>
 712:	66 90                	xchg   %ax,%ax
 714:	66 90                	xchg   %ax,%ax
 716:	66 90                	xchg   %ax,%ax
 718:	66 90                	xchg   %ax,%ax
 71a:	66 90                	xchg   %ax,%ax
 71c:	66 90                	xchg   %ax,%ax
 71e:	66 90                	xchg   %ax,%ax

00000720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	a1 b0 0c 00 00       	mov    0xcb0,%eax
{
 726:	89 e5                	mov    %esp,%ebp
 728:	57                   	push   %edi
 729:	56                   	push   %esi
 72a:	53                   	push   %ebx
 72b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 730:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 733:	39 d0                	cmp    %edx,%eax
 735:	72 11                	jb     748 <free+0x28>
 737:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 738:	39 c8                	cmp    %ecx,%eax
 73a:	72 04                	jb     740 <free+0x20>
 73c:	39 ca                	cmp    %ecx,%edx
 73e:	72 10                	jb     750 <free+0x30>
 740:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 742:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 744:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 746:	73 f0                	jae    738 <free+0x18>
 748:	39 ca                	cmp    %ecx,%edx
 74a:	72 04                	jb     750 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74c:	39 c8                	cmp    %ecx,%eax
 74e:	72 f0                	jb     740 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 750:	8b 73 fc             	mov    -0x4(%ebx),%esi
 753:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 756:	39 cf                	cmp    %ecx,%edi
 758:	74 1e                	je     778 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 75a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 75d:	8b 48 04             	mov    0x4(%eax),%ecx
 760:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 763:	39 f2                	cmp    %esi,%edx
 765:	74 28                	je     78f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 767:	89 10                	mov    %edx,(%eax)
  freep = p;
 769:	a3 b0 0c 00 00       	mov    %eax,0xcb0
}
 76e:	5b                   	pop    %ebx
 76f:	5e                   	pop    %esi
 770:	5f                   	pop    %edi
 771:	5d                   	pop    %ebp
 772:	c3                   	ret    
 773:	90                   	nop
 774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 778:	03 71 04             	add    0x4(%ecx),%esi
 77b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 77e:	8b 08                	mov    (%eax),%ecx
 780:	8b 09                	mov    (%ecx),%ecx
 782:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 785:	8b 48 04             	mov    0x4(%eax),%ecx
 788:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 78b:	39 f2                	cmp    %esi,%edx
 78d:	75 d8                	jne    767 <free+0x47>
    p->s.size += bp->s.size;
 78f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 792:	a3 b0 0c 00 00       	mov    %eax,0xcb0
    p->s.size += bp->s.size;
 797:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 79a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 79d:	89 10                	mov    %edx,(%eax)
}
 79f:	5b                   	pop    %ebx
 7a0:	5e                   	pop    %esi
 7a1:	5f                   	pop    %edi
 7a2:	5d                   	pop    %ebp
 7a3:	c3                   	ret    
 7a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7bc:	8b 1d b0 0c 00 00    	mov    0xcb0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	8d 48 07             	lea    0x7(%eax),%ecx
 7c5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 7c8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ca:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 7cd:	0f 84 9b 00 00 00    	je     86e <malloc+0xbe>
 7d3:	8b 13                	mov    (%ebx),%edx
 7d5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7d8:	39 fe                	cmp    %edi,%esi
 7da:	76 64                	jbe    840 <malloc+0x90>
 7dc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 7e3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 7e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7eb:	eb 0e                	jmp    7fb <malloc+0x4b>
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7f2:	8b 78 04             	mov    0x4(%eax),%edi
 7f5:	39 fe                	cmp    %edi,%esi
 7f7:	76 4f                	jbe    848 <malloc+0x98>
 7f9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7fb:	3b 15 b0 0c 00 00    	cmp    0xcb0,%edx
 801:	75 ed                	jne    7f0 <malloc+0x40>
  if(nu < 4096)
 803:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 806:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 80c:	bf 00 10 00 00       	mov    $0x1000,%edi
 811:	0f 43 fe             	cmovae %esi,%edi
 814:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 817:	89 04 24             	mov    %eax,(%esp)
 81a:	e8 0b fc ff ff       	call   42a <sbrk>
  if(p == (char*)-1)
 81f:	83 f8 ff             	cmp    $0xffffffff,%eax
 822:	74 18                	je     83c <malloc+0x8c>
  hp->s.size = nu;
 824:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 827:	83 c0 08             	add    $0x8,%eax
 82a:	89 04 24             	mov    %eax,(%esp)
 82d:	e8 ee fe ff ff       	call   720 <free>
  return freep;
 832:	8b 15 b0 0c 00 00    	mov    0xcb0,%edx
      if((p = morecore(nunits)) == 0)
 838:	85 d2                	test   %edx,%edx
 83a:	75 b4                	jne    7f0 <malloc+0x40>
        return 0;
 83c:	31 c0                	xor    %eax,%eax
 83e:	eb 20                	jmp    860 <malloc+0xb0>
    if(p->s.size >= nunits){
 840:	89 d0                	mov    %edx,%eax
 842:	89 da                	mov    %ebx,%edx
 844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 848:	39 fe                	cmp    %edi,%esi
 84a:	74 1c                	je     868 <malloc+0xb8>
        p->s.size -= nunits;
 84c:	29 f7                	sub    %esi,%edi
 84e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 851:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 854:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 857:	89 15 b0 0c 00 00    	mov    %edx,0xcb0
      return (void*)(p + 1);
 85d:	83 c0 08             	add    $0x8,%eax
  }
}
 860:	83 c4 1c             	add    $0x1c,%esp
 863:	5b                   	pop    %ebx
 864:	5e                   	pop    %esi
 865:	5f                   	pop    %edi
 866:	5d                   	pop    %ebp
 867:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 868:	8b 08                	mov    (%eax),%ecx
 86a:	89 0a                	mov    %ecx,(%edx)
 86c:	eb e9                	jmp    857 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 86e:	c7 05 b0 0c 00 00 b4 	movl   $0xcb4,0xcb0
 875:	0c 00 00 
    base.s.size = 0;
 878:	ba b4 0c 00 00       	mov    $0xcb4,%edx
    base.s.ptr = freep = prevp = &base;
 87d:	c7 05 b4 0c 00 00 b4 	movl   $0xcb4,0xcb4
 884:	0c 00 00 
    base.s.size = 0;
 887:	c7 05 b8 0c 00 00 00 	movl   $0x0,0xcb8
 88e:	00 00 00 
 891:	e9 46 ff ff ff       	jmp    7dc <malloc+0x2c>
