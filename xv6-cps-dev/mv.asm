
_mv:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return res;
}

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
    int i = 0;
    int res = -1;
    char *dest = NULL;
    struct stat st;
    char dirstr[DIRSTR] = {0};
   1:	31 c0                	xor    %eax,%eax
{
   3:	89 e5                	mov    %esp,%ebp
    char dirstr[DIRSTR] = {0};
   5:	b9 20 00 00 00       	mov    $0x20,%ecx
{
   a:	57                   	push   %edi
   b:	56                   	push   %esi
   c:	53                   	push   %ebx
   d:	83 e4 f0             	and    $0xfffffff0,%esp
  10:	81 ec c0 00 00 00    	sub    $0xc0,%esp
  16:	8b 75 0c             	mov    0xc(%ebp),%esi

    if (argc < 3) {
  19:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
    char dirstr[DIRSTR] = {0};
  1d:	8d 5c 24 40          	lea    0x40(%esp),%ebx
  21:	89 df                	mov    %ebx,%edi
  23:	f3 ab                	rep stos %eax,%es:(%edi)
    if (argc < 3) {
  25:	7f 19                	jg     40 <main+0x40>
        printf(2, "barf\n");
  27:	c7 44 24 04 13 09 00 	movl   $0x913,0x4(%esp)
  2e:	00 
  2f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  36:	e8 35 05 00 00       	call   570 <printf>
        exit();
  3b:	e8 c2 03 00 00       	call   402 <exit>
    }
    dest = argv[argc - 1];
  40:	8b 45 08             	mov    0x8(%ebp),%eax
  43:	8b 44 86 fc          	mov    -0x4(%esi,%eax,4),%eax
  47:	89 c1                	mov    %eax,%ecx
  49:	89 44 24 18          	mov    %eax,0x18(%esp)
    res = stat(dest, &st);
  4d:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  51:	89 44 24 04          	mov    %eax,0x4(%esp)
  55:	89 0c 24             	mov    %ecx,(%esp)
  58:	e8 f3 02 00 00       	call   350 <stat>
    if (res < 0) {
  5d:	85 c0                	test   %eax,%eax
  5f:	78 47                	js     a8 <main+0xa8>
        // dest does not exist
        mv(argv[1], dest);
    }
    else {
        switch(st.type) {
  61:	0f b7 44 24 2c       	movzwl 0x2c(%esp),%eax
  66:	66 83 f8 01          	cmp    $0x1,%ax
  6a:	74 51                	je     bd <main+0xbd>
  6c:	66 83 f8 02          	cmp    $0x2,%ax
  70:	74 19                	je     8b <main+0x8b>
        case T_FILE:
            unlink(dest);
            mv(argv[1], dest);
            break;
        default:
            printf(2, "extra barf\n");
  72:	c7 44 24 04 0d 09 00 	movl   $0x90d,0x4(%esp)
  79:	00 
  7a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  81:	e8 ea 04 00 00       	call   570 <printf>
            break;
        }
    }
    exit();
  86:	e8 77 03 00 00       	call   402 <exit>
            unlink(dest);
  8b:	8b 7c 24 18          	mov    0x18(%esp),%edi
  8f:	89 3c 24             	mov    %edi,(%esp)
  92:	e8 bb 03 00 00       	call   452 <unlink>
            mv(argv[1], dest);
  97:	89 7c 24 04          	mov    %edi,0x4(%esp)
  9b:	8b 46 04             	mov    0x4(%esi),%eax
  9e:	89 04 24             	mov    %eax,(%esp)
  a1:	e8 aa 00 00 00       	call   150 <mv>
            break;
  a6:	eb de                	jmp    86 <main+0x86>
        mv(argv[1], dest);
  a8:	8b 44 24 18          	mov    0x18(%esp),%eax
  ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  b0:	8b 46 04             	mov    0x4(%esi),%eax
  b3:	89 04 24             	mov    %eax,(%esp)
  b6:	e8 95 00 00 00       	call   150 <mv>
  bb:	eb c9                	jmp    86 <main+0x86>
  bd:	8b 45 08             	mov    0x8(%ebp),%eax
        switch(st.type) {
  c0:	bf 01 00 00 00       	mov    $0x1,%edi
  c5:	83 e8 01             	sub    $0x1,%eax
  c8:	89 44 24 14          	mov    %eax,0x14(%esp)
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                memset(dirstr, 0, DIRSTR);
  d0:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  d7:	00 
  d8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  df:	00 
  e0:	89 1c 24             	mov    %ebx,(%esp)
  e3:	e8 a8 01 00 00       	call   290 <memset>
                strcpy(dirstr, dest);
  e8:	8b 44 24 18          	mov    0x18(%esp),%eax
  ec:	89 1c 24             	mov    %ebx,(%esp)
  ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  f3:	e8 e8 00 00 00       	call   1e0 <strcpy>
                dirstr[strlen(dirstr)] = '/';
  f8:	89 1c 24             	mov    %ebx,(%esp)
  fb:	e8 60 01 00 00       	call   260 <strlen>
                strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
 100:	8b 14 be             	mov    (%esi,%edi,4),%edx
 103:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                dirstr[strlen(dirstr)] = '/';
 107:	c6 44 04 40 2f       	movb   $0x2f,0x40(%esp,%eax,1)
                strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
 10c:	89 1c 24             	mov    %ebx,(%esp)
 10f:	e8 4c 01 00 00       	call   260 <strlen>
 114:	8b 54 24 1c          	mov    0x1c(%esp),%edx
 118:	89 54 24 04          	mov    %edx,0x4(%esp)
 11c:	01 d8                	add    %ebx,%eax
 11e:	89 04 24             	mov    %eax,(%esp)
 121:	e8 ba 00 00 00       	call   1e0 <strcpy>
                mv(argv[i], dirstr);
 126:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 12a:	8b 04 be             	mov    (%esi,%edi,4),%eax
            for (i = 1; i < (argc - 1); i++) {
 12d:	83 c7 01             	add    $0x1,%edi
                mv(argv[i], dirstr);
 130:	89 04 24             	mov    %eax,(%esp)
 133:	e8 18 00 00 00       	call   150 <mv>
            for (i = 1; i < (argc - 1); i++) {
 138:	3b 7c 24 14          	cmp    0x14(%esp),%edi
 13c:	75 92                	jne    d0 <main+0xd0>
 13e:	e9 43 ff ff ff       	jmp    86 <main+0x86>
 143:	66 90                	xchg   %ax,%ax
 145:	66 90                	xchg   %ax,%ax
 147:	66 90                	xchg   %ax,%ax
 149:	66 90                	xchg   %ax,%ax
 14b:	66 90                	xchg   %ax,%ax
 14d:	66 90                	xchg   %ax,%ax
 14f:	90                   	nop

00000150 <mv>:
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	83 ec 14             	sub    $0x14,%esp
 157:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (link(src, dest) < 0) {
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 1c 24             	mov    %ebx,(%esp)
 160:	89 44 24 04          	mov    %eax,0x4(%esp)
 164:	e8 f9 02 00 00       	call   462 <link>
 169:	85 c0                	test   %eax,%eax
 16b:	78 1b                	js     188 <mv+0x38>
        if (unlink(src) < 0) {
 16d:	89 1c 24             	mov    %ebx,(%esp)
 170:	e8 dd 02 00 00       	call   452 <unlink>
 175:	85 c0                	test   %eax,%eax
 177:	78 3a                	js     1b3 <mv+0x63>
            res = 0;
 179:	31 c0                	xor    %eax,%eax
}
 17b:	83 c4 14             	add    $0x14,%esp
 17e:	5b                   	pop    %ebx
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "ERROR %s %d: failed to create link\n", __FILE__, __LINE__);
 188:	c7 44 24 0c 0d 00 00 	movl   $0xd,0xc(%esp)
 18f:	00 
 190:	c7 44 24 08 08 09 00 	movl   $0x908,0x8(%esp)
 197:	00 
 198:	c7 44 24 04 1c 09 00 	movl   $0x91c,0x4(%esp)
 19f:	00 
 1a0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1a7:	e8 c4 03 00 00       	call   570 <printf>
    int res = -1;
 1ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b1:	eb c8                	jmp    17b <mv+0x2b>
            printf(2, "ERROR %s %d: failed to remove link\n", __FILE__, __LINE__);
 1b3:	c7 44 24 0c 11 00 00 	movl   $0x11,0xc(%esp)
 1ba:	00 
 1bb:	c7 44 24 08 08 09 00 	movl   $0x908,0x8(%esp)
 1c2:	00 
 1c3:	c7 44 24 04 40 09 00 	movl   $0x940,0x4(%esp)
 1ca:	00 
 1cb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1d2:	e8 99 03 00 00       	call   570 <printf>
 1d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1dc:	eb 9d                	jmp    17b <mv+0x2b>
 1de:	66 90                	xchg   %ax,%ax

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1e9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ea:	89 c2                	mov    %eax,%edx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 c1 01             	add    $0x1,%ecx
 1f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1f7:	83 c2 01             	add    $0x1,%edx
 1fa:	84 db                	test   %bl,%bl
 1fc:	88 5a ff             	mov    %bl,-0x1(%edx)
 1ff:	75 ef                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 201:	5b                   	pop    %ebx
 202:	5d                   	pop    %ebp
 203:	c3                   	ret    
 204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 20a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
 216:	53                   	push   %ebx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 21a:	0f b6 02             	movzbl (%edx),%eax
 21d:	84 c0                	test   %al,%al
 21f:	74 2d                	je     24e <strcmp+0x3e>
 221:	0f b6 19             	movzbl (%ecx),%ebx
 224:	38 d8                	cmp    %bl,%al
 226:	74 0e                	je     236 <strcmp+0x26>
 228:	eb 2b                	jmp    255 <strcmp+0x45>
 22a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 230:	38 c8                	cmp    %cl,%al
 232:	75 15                	jne    249 <strcmp+0x39>
    p++, q++;
 234:	89 d9                	mov    %ebx,%ecx
 236:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 239:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 23c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 23f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 243:	84 c0                	test   %al,%al
 245:	75 e9                	jne    230 <strcmp+0x20>
 247:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 249:	29 c8                	sub    %ecx,%eax
}
 24b:	5b                   	pop    %ebx
 24c:	5d                   	pop    %ebp
 24d:	c3                   	ret    
 24e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 251:	31 c0                	xor    %eax,%eax
 253:	eb f4                	jmp    249 <strcmp+0x39>
 255:	0f b6 cb             	movzbl %bl,%ecx
 258:	eb ef                	jmp    249 <strcmp+0x39>
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000260 <strlen>:

uint
strlen(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 266:	80 39 00             	cmpb   $0x0,(%ecx)
 269:	74 12                	je     27d <strlen+0x1d>
 26b:	31 d2                	xor    %edx,%edx
 26d:	8d 76 00             	lea    0x0(%esi),%esi
 270:	83 c2 01             	add    $0x1,%edx
 273:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 277:	89 d0                	mov    %edx,%eax
 279:	75 f5                	jne    270 <strlen+0x10>
    ;
  return n;
}
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 27d:	31 c0                	xor    %eax,%eax
}
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	eb 0d                	jmp    290 <memset>
 283:	90                   	nop
 284:	90                   	nop
 285:	90                   	nop
 286:	90                   	nop
 287:	90                   	nop
 288:	90                   	nop
 289:	90                   	nop
 28a:	90                   	nop
 28b:	90                   	nop
 28c:	90                   	nop
 28d:	90                   	nop
 28e:	90                   	nop
 28f:	90                   	nop

00000290 <memset>:

void*
memset(void *dst, int c, uint n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 55 08             	mov    0x8(%ebp),%edx
 296:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 297:	8b 4d 10             	mov    0x10(%ebp),%ecx
 29a:	8b 45 0c             	mov    0xc(%ebp),%eax
 29d:	89 d7                	mov    %edx,%edi
 29f:	fc                   	cld    
 2a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2a2:	89 d0                	mov    %edx,%eax
 2a4:	5f                   	pop    %edi
 2a5:	5d                   	pop    %ebp
 2a6:	c3                   	ret    
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <strchr>:

char*
strchr(const char *s, char c)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	53                   	push   %ebx
 2b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 2ba:	0f b6 18             	movzbl (%eax),%ebx
 2bd:	84 db                	test   %bl,%bl
 2bf:	74 1d                	je     2de <strchr+0x2e>
    if(*s == c)
 2c1:	38 d3                	cmp    %dl,%bl
 2c3:	89 d1                	mov    %edx,%ecx
 2c5:	75 0d                	jne    2d4 <strchr+0x24>
 2c7:	eb 17                	jmp    2e0 <strchr+0x30>
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2d0:	38 ca                	cmp    %cl,%dl
 2d2:	74 0c                	je     2e0 <strchr+0x30>
  for(; *s; s++)
 2d4:	83 c0 01             	add    $0x1,%eax
 2d7:	0f b6 10             	movzbl (%eax),%edx
 2da:	84 d2                	test   %dl,%dl
 2dc:	75 f2                	jne    2d0 <strchr+0x20>
      return (char*)s;
  return 0;
 2de:	31 c0                	xor    %eax,%eax
}
 2e0:	5b                   	pop    %ebx
 2e1:	5d                   	pop    %ebp
 2e2:	c3                   	ret    
 2e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <gets>:

char*
gets(char *buf, int max)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f5:	31 f6                	xor    %esi,%esi
{
 2f7:	53                   	push   %ebx
 2f8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 2fb:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 2fe:	eb 31                	jmp    331 <gets+0x41>
    cc = read(0, &c, 1);
 300:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 307:	00 
 308:	89 7c 24 04          	mov    %edi,0x4(%esp)
 30c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 313:	e8 02 01 00 00       	call   41a <read>
    if(cc < 1)
 318:	85 c0                	test   %eax,%eax
 31a:	7e 1d                	jle    339 <gets+0x49>
      break;
    buf[i++] = c;
 31c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 320:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 322:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 325:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 327:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 32b:	74 0c                	je     339 <gets+0x49>
 32d:	3c 0a                	cmp    $0xa,%al
 32f:	74 08                	je     339 <gets+0x49>
  for(i=0; i+1 < max; ){
 331:	8d 5e 01             	lea    0x1(%esi),%ebx
 334:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 337:	7c c7                	jl     300 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 339:	8b 45 08             	mov    0x8(%ebp),%eax
 33c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 340:	83 c4 2c             	add    $0x2c,%esp
 343:	5b                   	pop    %ebx
 344:	5e                   	pop    %esi
 345:	5f                   	pop    %edi
 346:	5d                   	pop    %ebp
 347:	c3                   	ret    
 348:	90                   	nop
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000350 <stat>:

int
stat(const char *n, struct stat *st)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 358:	8b 45 08             	mov    0x8(%ebp),%eax
 35b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 362:	00 
 363:	89 04 24             	mov    %eax,(%esp)
 366:	e8 d7 00 00 00       	call   442 <open>
  if(fd < 0)
 36b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 36d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 36f:	78 27                	js     398 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 371:	8b 45 0c             	mov    0xc(%ebp),%eax
 374:	89 1c 24             	mov    %ebx,(%esp)
 377:	89 44 24 04          	mov    %eax,0x4(%esp)
 37b:	e8 da 00 00 00       	call   45a <fstat>
  close(fd);
 380:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 383:	89 c6                	mov    %eax,%esi
  close(fd);
 385:	e8 a0 00 00 00       	call   42a <close>
  return r;
 38a:	89 f0                	mov    %esi,%eax
}
 38c:	83 c4 10             	add    $0x10,%esp
 38f:	5b                   	pop    %ebx
 390:	5e                   	pop    %esi
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
 393:	90                   	nop
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 398:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 39d:	eb ed                	jmp    38c <stat+0x3c>
 39f:	90                   	nop

000003a0 <atoi>:

int
atoi(const char *s)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3a7:	0f be 11             	movsbl (%ecx),%edx
 3aa:	8d 42 d0             	lea    -0x30(%edx),%eax
 3ad:	3c 09                	cmp    $0x9,%al
  n = 0;
 3af:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 3b4:	77 17                	ja     3cd <atoi+0x2d>
 3b6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 3b8:	83 c1 01             	add    $0x1,%ecx
 3bb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3be:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3c2:	0f be 11             	movsbl (%ecx),%edx
 3c5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3c8:	80 fb 09             	cmp    $0x9,%bl
 3cb:	76 eb                	jbe    3b8 <atoi+0x18>
  return n;
}
 3cd:	5b                   	pop    %ebx
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    

000003d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3d0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3d1:	31 d2                	xor    %edx,%edx
{
 3d3:	89 e5                	mov    %esp,%ebp
 3d5:	56                   	push   %esi
 3d6:	8b 45 08             	mov    0x8(%ebp),%eax
 3d9:	53                   	push   %ebx
 3da:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3dd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 3e0:	85 db                	test   %ebx,%ebx
 3e2:	7e 12                	jle    3f6 <memmove+0x26>
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3f2:	39 da                	cmp    %ebx,%edx
 3f4:	75 f2                	jne    3e8 <memmove+0x18>
  return vdst;
}
 3f6:	5b                   	pop    %ebx
 3f7:	5e                   	pop    %esi
 3f8:	5d                   	pop    %ebp
 3f9:	c3                   	ret    

000003fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3fa:	b8 01 00 00 00       	mov    $0x1,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <exit>:
SYSCALL(exit)
 402:	b8 02 00 00 00       	mov    $0x2,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <wait>:
SYSCALL(wait)
 40a:	b8 03 00 00 00       	mov    $0x3,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <pipe>:
SYSCALL(pipe)
 412:	b8 04 00 00 00       	mov    $0x4,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <read>:
SYSCALL(read)
 41a:	b8 05 00 00 00       	mov    $0x5,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <write>:
SYSCALL(write)
 422:	b8 10 00 00 00       	mov    $0x10,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <close>:
SYSCALL(close)
 42a:	b8 15 00 00 00       	mov    $0x15,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <kill>:
SYSCALL(kill)
 432:	b8 06 00 00 00       	mov    $0x6,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <exec>:
SYSCALL(exec)
 43a:	b8 07 00 00 00       	mov    $0x7,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <open>:
SYSCALL(open)
 442:	b8 0f 00 00 00       	mov    $0xf,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <mknod>:
SYSCALL(mknod)
 44a:	b8 11 00 00 00       	mov    $0x11,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <unlink>:
SYSCALL(unlink)
 452:	b8 12 00 00 00       	mov    $0x12,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <fstat>:
SYSCALL(fstat)
 45a:	b8 08 00 00 00       	mov    $0x8,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <link>:
SYSCALL(link)
 462:	b8 13 00 00 00       	mov    $0x13,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <mkdir>:
SYSCALL(mkdir)
 46a:	b8 14 00 00 00       	mov    $0x14,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <chdir>:
SYSCALL(chdir)
 472:	b8 09 00 00 00       	mov    $0x9,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <dup>:
SYSCALL(dup)
 47a:	b8 0a 00 00 00       	mov    $0xa,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <getpid>:
SYSCALL(getpid)
 482:	b8 0b 00 00 00       	mov    $0xb,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <sbrk>:
SYSCALL(sbrk)
 48a:	b8 0c 00 00 00       	mov    $0xc,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <sleep>:
SYSCALL(sleep)
 492:	b8 0d 00 00 00       	mov    $0xd,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <uptime>:
SYSCALL(uptime)
 49a:	b8 0e 00 00 00       	mov    $0xe,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 4a2:	b8 16 00 00 00       	mov    $0x16,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 4aa:	b8 17 00 00 00       	mov    $0x17,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 4b2:	b8 18 00 00 00       	mov    $0x18,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <halt>:
 4ba:	b8 19 00 00 00       	mov    $0x19,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    
 4c2:	66 90                	xchg   %ax,%ax
 4c4:	66 90                	xchg   %ax,%ax
 4c6:	66 90                	xchg   %ax,%ax
 4c8:	66 90                	xchg   %ax,%ax
 4ca:	66 90                	xchg   %ax,%ax
 4cc:	66 90                	xchg   %ax,%ax
 4ce:	66 90                	xchg   %ax,%ax

000004d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	89 c6                	mov    %eax,%esi
 4d7:	53                   	push   %ebx
 4d8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4db:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4de:	85 db                	test   %ebx,%ebx
 4e0:	74 09                	je     4eb <printint+0x1b>
 4e2:	89 d0                	mov    %edx,%eax
 4e4:	c1 e8 1f             	shr    $0x1f,%eax
 4e7:	84 c0                	test   %al,%al
 4e9:	75 75                	jne    560 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4eb:	89 d0                	mov    %edx,%eax
  neg = 0;
 4ed:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4f4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 4f7:	31 ff                	xor    %edi,%edi
 4f9:	89 ce                	mov    %ecx,%esi
 4fb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4fe:	eb 02                	jmp    502 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 500:	89 cf                	mov    %ecx,%edi
 502:	31 d2                	xor    %edx,%edx
 504:	f7 f6                	div    %esi
 506:	8d 4f 01             	lea    0x1(%edi),%ecx
 509:	0f b6 92 6b 09 00 00 	movzbl 0x96b(%edx),%edx
  }while((x /= base) != 0);
 510:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 512:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 515:	75 e9                	jne    500 <printint+0x30>
  if(neg)
 517:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 51a:	89 c8                	mov    %ecx,%eax
 51c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 51f:	85 d2                	test   %edx,%edx
 521:	74 08                	je     52b <printint+0x5b>
    buf[i++] = '-';
 523:	8d 4f 02             	lea    0x2(%edi),%ecx
 526:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 52b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 52e:	66 90                	xchg   %ax,%ax
 530:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 535:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 538:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 53f:	00 
 540:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 544:	89 34 24             	mov    %esi,(%esp)
 547:	88 45 d7             	mov    %al,-0x29(%ebp)
 54a:	e8 d3 fe ff ff       	call   422 <write>
  while(--i >= 0)
 54f:	83 ff ff             	cmp    $0xffffffff,%edi
 552:	75 dc                	jne    530 <printint+0x60>
    putc(fd, buf[i]);
}
 554:	83 c4 4c             	add    $0x4c,%esp
 557:	5b                   	pop    %ebx
 558:	5e                   	pop    %esi
 559:	5f                   	pop    %edi
 55a:	5d                   	pop    %ebp
 55b:	c3                   	ret    
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 560:	89 d0                	mov    %edx,%eax
 562:	f7 d8                	neg    %eax
    neg = 1;
 564:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 56b:	eb 87                	jmp    4f4 <printint+0x24>
 56d:	8d 76 00             	lea    0x0(%esi),%esi

00000570 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 574:	31 ff                	xor    %edi,%edi
{
 576:	56                   	push   %esi
 577:	53                   	push   %ebx
 578:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 57b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 57e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 581:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 584:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 587:	0f b6 13             	movzbl (%ebx),%edx
 58a:	83 c3 01             	add    $0x1,%ebx
 58d:	84 d2                	test   %dl,%dl
 58f:	75 39                	jne    5ca <printf+0x5a>
 591:	e9 ca 00 00 00       	jmp    660 <printf+0xf0>
 596:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 598:	83 fa 25             	cmp    $0x25,%edx
 59b:	0f 84 c7 00 00 00    	je     668 <printf+0xf8>
  write(fd, &c, 1);
 5a1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 5a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ab:	00 
 5ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 5b3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 5b6:	e8 67 fe ff ff       	call   422 <write>
 5bb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 5be:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5c2:	84 d2                	test   %dl,%dl
 5c4:	0f 84 96 00 00 00    	je     660 <printf+0xf0>
    if(state == 0){
 5ca:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 5cc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 5cf:	74 c7                	je     598 <printf+0x28>
      }
    } else if(state == '%'){
 5d1:	83 ff 25             	cmp    $0x25,%edi
 5d4:	75 e5                	jne    5bb <printf+0x4b>
      if(c == 'd' || c == 'u'){
 5d6:	83 fa 75             	cmp    $0x75,%edx
 5d9:	0f 84 99 00 00 00    	je     678 <printf+0x108>
 5df:	83 fa 64             	cmp    $0x64,%edx
 5e2:	0f 84 90 00 00 00    	je     678 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5e8:	25 f7 00 00 00       	and    $0xf7,%eax
 5ed:	83 f8 70             	cmp    $0x70,%eax
 5f0:	0f 84 aa 00 00 00    	je     6a0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5f6:	83 fa 73             	cmp    $0x73,%edx
 5f9:	0f 84 e9 00 00 00    	je     6e8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ff:	83 fa 63             	cmp    $0x63,%edx
 602:	0f 84 2b 01 00 00    	je     733 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 608:	83 fa 25             	cmp    $0x25,%edx
 60b:	0f 84 4f 01 00 00    	je     760 <printf+0x1f0>
  write(fd, &c, 1);
 611:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 614:	83 c3 01             	add    $0x1,%ebx
 617:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 61e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 621:	89 44 24 04          	mov    %eax,0x4(%esp)
 625:	89 34 24             	mov    %esi,(%esp)
 628:	89 55 d0             	mov    %edx,-0x30(%ebp)
 62b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 62f:	e8 ee fd ff ff       	call   422 <write>
        putc(fd, c);
 634:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 637:	8d 45 e7             	lea    -0x19(%ebp),%eax
 63a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 641:	00 
 642:	89 44 24 04          	mov    %eax,0x4(%esp)
 646:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 649:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 64c:	e8 d1 fd ff ff       	call   422 <write>
  for(i = 0; fmt[i]; i++){
 651:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 655:	84 d2                	test   %dl,%dl
 657:	0f 85 6d ff ff ff    	jne    5ca <printf+0x5a>
 65d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 660:	83 c4 3c             	add    $0x3c,%esp
 663:	5b                   	pop    %ebx
 664:	5e                   	pop    %esi
 665:	5f                   	pop    %edi
 666:	5d                   	pop    %ebp
 667:	c3                   	ret    
        state = '%';
 668:	bf 25 00 00 00       	mov    $0x25,%edi
 66d:	e9 49 ff ff ff       	jmp    5bb <printf+0x4b>
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 678:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 67f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 684:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 687:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 689:	8b 10                	mov    (%eax),%edx
 68b:	89 f0                	mov    %esi,%eax
 68d:	e8 3e fe ff ff       	call   4d0 <printint>
        ap++;
 692:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 696:	e9 20 ff ff ff       	jmp    5bb <printf+0x4b>
 69b:	90                   	nop
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6a0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 6a3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6aa:	00 
 6ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 6af:	89 34 24             	mov    %esi,(%esp)
 6b2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 6b6:	e8 67 fd ff ff       	call   422 <write>
 6bb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6be:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6c5:	00 
 6c6:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ca:	89 34 24             	mov    %esi,(%esp)
 6cd:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 6d1:	e8 4c fd ff ff       	call   422 <write>
        printint(fd, *ap, 16, 0);
 6d6:	b9 10 00 00 00       	mov    $0x10,%ecx
 6db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6e2:	eb a0                	jmp    684 <printf+0x114>
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 6eb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 6ef:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 6f1:	b8 64 09 00 00       	mov    $0x964,%eax
 6f6:	85 ff                	test   %edi,%edi
 6f8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 6fb:	0f b6 07             	movzbl (%edi),%eax
 6fe:	84 c0                	test   %al,%al
 700:	74 2a                	je     72c <printf+0x1bc>
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 708:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 70b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 70e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 711:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 718:	00 
 719:	89 44 24 04          	mov    %eax,0x4(%esp)
 71d:	89 34 24             	mov    %esi,(%esp)
 720:	e8 fd fc ff ff       	call   422 <write>
        while(*s != 0){
 725:	0f b6 07             	movzbl (%edi),%eax
 728:	84 c0                	test   %al,%al
 72a:	75 dc                	jne    708 <printf+0x198>
      state = 0;
 72c:	31 ff                	xor    %edi,%edi
 72e:	e9 88 fe ff ff       	jmp    5bb <printf+0x4b>
        putc(fd, *ap);
 733:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 736:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 738:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 73a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 741:	00 
 742:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 745:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 748:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 74b:	89 44 24 04          	mov    %eax,0x4(%esp)
 74f:	e8 ce fc ff ff       	call   422 <write>
        ap++;
 754:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 758:	e9 5e fe ff ff       	jmp    5bb <printf+0x4b>
 75d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 760:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 763:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 765:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 76c:	00 
 76d:	89 44 24 04          	mov    %eax,0x4(%esp)
 771:	89 34 24             	mov    %esi,(%esp)
 774:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 778:	e8 a5 fc ff ff       	call   422 <write>
 77d:	e9 39 fe ff ff       	jmp    5bb <printf+0x4b>
 782:	66 90                	xchg   %ax,%ax
 784:	66 90                	xchg   %ax,%ax
 786:	66 90                	xchg   %ax,%ax
 788:	66 90                	xchg   %ax,%ax
 78a:	66 90                	xchg   %ax,%ax
 78c:	66 90                	xchg   %ax,%ax
 78e:	66 90                	xchg   %ax,%ax

00000790 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 790:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 791:	a1 0c 0c 00 00       	mov    0xc0c,%eax
{
 796:	89 e5                	mov    %esp,%ebp
 798:	57                   	push   %edi
 799:	56                   	push   %esi
 79a:	53                   	push   %ebx
 79b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 7a0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a3:	39 d0                	cmp    %edx,%eax
 7a5:	72 11                	jb     7b8 <free+0x28>
 7a7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a8:	39 c8                	cmp    %ecx,%eax
 7aa:	72 04                	jb     7b0 <free+0x20>
 7ac:	39 ca                	cmp    %ecx,%edx
 7ae:	72 10                	jb     7c0 <free+0x30>
 7b0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b6:	73 f0                	jae    7a8 <free+0x18>
 7b8:	39 ca                	cmp    %ecx,%edx
 7ba:	72 04                	jb     7c0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bc:	39 c8                	cmp    %ecx,%eax
 7be:	72 f0                	jb     7b0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7c3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 7c6:	39 cf                	cmp    %ecx,%edi
 7c8:	74 1e                	je     7e8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ca:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7cd:	8b 48 04             	mov    0x4(%eax),%ecx
 7d0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7d3:	39 f2                	cmp    %esi,%edx
 7d5:	74 28                	je     7ff <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7d7:	89 10                	mov    %edx,(%eax)
  freep = p;
 7d9:	a3 0c 0c 00 00       	mov    %eax,0xc0c
}
 7de:	5b                   	pop    %ebx
 7df:	5e                   	pop    %esi
 7e0:	5f                   	pop    %edi
 7e1:	5d                   	pop    %ebp
 7e2:	c3                   	ret    
 7e3:	90                   	nop
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7e8:	03 71 04             	add    0x4(%ecx),%esi
 7eb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ee:	8b 08                	mov    (%eax),%ecx
 7f0:	8b 09                	mov    (%ecx),%ecx
 7f2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7f5:	8b 48 04             	mov    0x4(%eax),%ecx
 7f8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7fb:	39 f2                	cmp    %esi,%edx
 7fd:	75 d8                	jne    7d7 <free+0x47>
    p->s.size += bp->s.size;
 7ff:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 802:	a3 0c 0c 00 00       	mov    %eax,0xc0c
    p->s.size += bp->s.size;
 807:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 80a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 80d:	89 10                	mov    %edx,(%eax)
}
 80f:	5b                   	pop    %ebx
 810:	5e                   	pop    %esi
 811:	5f                   	pop    %edi
 812:	5d                   	pop    %ebp
 813:	c3                   	ret    
 814:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 81a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000820 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	57                   	push   %edi
 824:	56                   	push   %esi
 825:	53                   	push   %ebx
 826:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 829:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 82c:	8b 1d 0c 0c 00 00    	mov    0xc0c,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 832:	8d 48 07             	lea    0x7(%eax),%ecx
 835:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 838:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 83d:	0f 84 9b 00 00 00    	je     8de <malloc+0xbe>
 843:	8b 13                	mov    (%ebx),%edx
 845:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 848:	39 fe                	cmp    %edi,%esi
 84a:	76 64                	jbe    8b0 <malloc+0x90>
 84c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 853:	bb 00 80 00 00       	mov    $0x8000,%ebx
 858:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 85b:	eb 0e                	jmp    86b <malloc+0x4b>
 85d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 862:	8b 78 04             	mov    0x4(%eax),%edi
 865:	39 fe                	cmp    %edi,%esi
 867:	76 4f                	jbe    8b8 <malloc+0x98>
 869:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 86b:	3b 15 0c 0c 00 00    	cmp    0xc0c,%edx
 871:	75 ed                	jne    860 <malloc+0x40>
  if(nu < 4096)
 873:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 876:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 87c:	bf 00 10 00 00       	mov    $0x1000,%edi
 881:	0f 43 fe             	cmovae %esi,%edi
 884:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 887:	89 04 24             	mov    %eax,(%esp)
 88a:	e8 fb fb ff ff       	call   48a <sbrk>
  if(p == (char*)-1)
 88f:	83 f8 ff             	cmp    $0xffffffff,%eax
 892:	74 18                	je     8ac <malloc+0x8c>
  hp->s.size = nu;
 894:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 897:	83 c0 08             	add    $0x8,%eax
 89a:	89 04 24             	mov    %eax,(%esp)
 89d:	e8 ee fe ff ff       	call   790 <free>
  return freep;
 8a2:	8b 15 0c 0c 00 00    	mov    0xc0c,%edx
      if((p = morecore(nunits)) == 0)
 8a8:	85 d2                	test   %edx,%edx
 8aa:	75 b4                	jne    860 <malloc+0x40>
        return 0;
 8ac:	31 c0                	xor    %eax,%eax
 8ae:	eb 20                	jmp    8d0 <malloc+0xb0>
    if(p->s.size >= nunits){
 8b0:	89 d0                	mov    %edx,%eax
 8b2:	89 da                	mov    %ebx,%edx
 8b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 8b8:	39 fe                	cmp    %edi,%esi
 8ba:	74 1c                	je     8d8 <malloc+0xb8>
        p->s.size -= nunits;
 8bc:	29 f7                	sub    %esi,%edi
 8be:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 8c1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 8c4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8c7:	89 15 0c 0c 00 00    	mov    %edx,0xc0c
      return (void*)(p + 1);
 8cd:	83 c0 08             	add    $0x8,%eax
  }
}
 8d0:	83 c4 1c             	add    $0x1c,%esp
 8d3:	5b                   	pop    %ebx
 8d4:	5e                   	pop    %esi
 8d5:	5f                   	pop    %edi
 8d6:	5d                   	pop    %ebp
 8d7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 8d8:	8b 08                	mov    (%eax),%ecx
 8da:	89 0a                	mov    %ecx,(%edx)
 8dc:	eb e9                	jmp    8c7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 8de:	c7 05 0c 0c 00 00 10 	movl   $0xc10,0xc0c
 8e5:	0c 00 00 
    base.s.size = 0;
 8e8:	ba 10 0c 00 00       	mov    $0xc10,%edx
    base.s.ptr = freep = prevp = &base;
 8ed:	c7 05 10 0c 00 00 10 	movl   $0xc10,0xc10
 8f4:	0c 00 00 
    base.s.size = 0;
 8f7:	c7 05 14 0c 00 00 00 	movl   $0x0,0xc14
 8fe:	00 00 00 
 901:	e9 46 ff ff ff       	jmp    84c <malloc+0x2c>
