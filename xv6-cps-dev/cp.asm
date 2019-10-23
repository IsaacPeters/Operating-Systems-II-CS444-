
_cp:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        exit();
    }
}

int main(int argc, char **argv)
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
  25:	7f 31                	jg     58 <main+0x58>
        printf(2, "barf %d %s %s\n", __LINE__, __FILE__, __FUNCTION__);
  27:	c7 44 24 10 78 09 00 	movl   $0x978,0x10(%esp)
  2e:	00 
  2f:	c7 44 24 0c 64 09 00 	movl   $0x964,0xc(%esp)
  36:	00 
  37:	c7 44 24 08 38 00 00 	movl   $0x38,0x8(%esp)
  3e:	00 
  3f:	c7 44 24 04 69 09 00 	movl   $0x969,0x4(%esp)
  46:	00 
  47:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4e:	e8 6d 05 00 00       	call   5c0 <printf>
        exit();
  53:	e8 fa 03 00 00       	call   452 <exit>
    }
    dest = argv[argc - 1];
  58:	8b 45 08             	mov    0x8(%ebp),%eax
  5b:	8b 44 86 fc          	mov    -0x4(%esi,%eax,4),%eax
  5f:	89 c1                	mov    %eax,%ecx
  61:	89 44 24 18          	mov    %eax,0x18(%esp)
    res = stat(dest, &st);
  65:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  69:	89 44 24 04          	mov    %eax,0x4(%esp)
  6d:	89 0c 24             	mov    %ecx,(%esp)
  70:	e8 2b 03 00 00       	call   3a0 <stat>
    if (res < 0) {
  75:	85 c0                	test   %eax,%eax
  77:	78 31                	js     aa <main+0xaa>
        // dest does not exist
        cp(argv[1], dest);
    }
    else {
        // looks like code from mv
        switch(st.type) {
  79:	0f b7 44 24 2c       	movzwl 0x2c(%esp),%eax
  7e:	66 83 f8 01          	cmp    $0x1,%ax
  82:	74 3b                	je     bf <main+0xbf>
  84:	66 83 f8 02          	cmp    $0x2,%ax
  88:	75 1b                	jne    a5 <main+0xa5>
                cp(argv[i], dirstr);
            }
            break;
        case T_FILE:
            // single file
            unlink(dest);
  8a:	8b 7c 24 18          	mov    0x18(%esp),%edi
  8e:	89 3c 24             	mov    %edi,(%esp)
  91:	e8 0c 04 00 00       	call   4a2 <unlink>
            cp(argv[1], dest);
  96:	89 7c 24 04          	mov    %edi,0x4(%esp)
  9a:	8b 46 04             	mov    0x4(%esi),%eax
  9d:	89 04 24             	mov    %eax,(%esp)
  a0:	e8 ab 00 00 00       	call   150 <cp>
        default:
            break;
        }
    }

    exit();
  a5:	e8 a8 03 00 00       	call   452 <exit>
        cp(argv[1], dest);
  aa:	8b 44 24 18          	mov    0x18(%esp),%eax
  ae:	89 44 24 04          	mov    %eax,0x4(%esp)
  b2:	8b 46 04             	mov    0x4(%esi),%eax
  b5:	89 04 24             	mov    %eax,(%esp)
  b8:	e8 93 00 00 00       	call   150 <cp>
  bd:	eb e6                	jmp    a5 <main+0xa5>
  bf:	8b 45 08             	mov    0x8(%ebp),%eax
        switch(st.type) {
  c2:	bf 01 00 00 00       	mov    $0x1,%edi
  c7:	83 e8 01             	sub    $0x1,%eax
  ca:	89 44 24 14          	mov    %eax,0x14(%esp)
  ce:	66 90                	xchg   %ax,%ax
                memset(dirstr, 0, DIRSTR);
  d0:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  d7:	00 
  d8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  df:	00 
  e0:	89 1c 24             	mov    %ebx,(%esp)
  e3:	e8 f8 01 00 00       	call   2e0 <memset>
                strcpy(dirstr, dest);
  e8:	8b 44 24 18          	mov    0x18(%esp),%eax
  ec:	89 1c 24             	mov    %ebx,(%esp)
  ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  f3:	e8 38 01 00 00       	call   230 <strcpy>
                dirstr[strlen(dirstr)] = '/';
  f8:	89 1c 24             	mov    %ebx,(%esp)
  fb:	e8 b0 01 00 00       	call   2b0 <strlen>
                strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
 100:	8b 14 be             	mov    (%esi,%edi,4),%edx
 103:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                dirstr[strlen(dirstr)] = '/';
 107:	c6 44 04 40 2f       	movb   $0x2f,0x40(%esp,%eax,1)
                strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
 10c:	89 1c 24             	mov    %ebx,(%esp)
 10f:	e8 9c 01 00 00       	call   2b0 <strlen>
 114:	8b 54 24 1c          	mov    0x1c(%esp),%edx
 118:	89 54 24 04          	mov    %edx,0x4(%esp)
 11c:	01 d8                	add    %ebx,%eax
 11e:	89 04 24             	mov    %eax,(%esp)
 121:	e8 0a 01 00 00       	call   230 <strcpy>
                cp(argv[i], dirstr);
 126:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 12a:	8b 04 be             	mov    (%esi,%edi,4),%eax
            for (i = 1; i < (argc - 1); i++) {
 12d:	83 c7 01             	add    $0x1,%edi
                cp(argv[i], dirstr);
 130:	89 04 24             	mov    %eax,(%esp)
 133:	e8 18 00 00 00       	call   150 <cp>
            for (i = 1; i < (argc - 1); i++) {
 138:	3b 7c 24 14          	cmp    0x14(%esp),%edi
 13c:	75 92                	jne    d0 <main+0xd0>
 13e:	e9 62 ff ff ff       	jmp    a5 <main+0xa5>
 143:	66 90                	xchg   %ax,%ax
 145:	66 90                	xchg   %ax,%ax
 147:	66 90                	xchg   %ax,%ax
 149:	66 90                	xchg   %ax,%ax
 14b:	66 90                	xchg   %ax,%ax
 14d:	66 90                	xchg   %ax,%ax
 14f:	90                   	nop

00000150 <cp>:
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	56                   	push   %esi
 154:	53                   	push   %ebx
 155:	83 ec 30             	sub    $0x30,%esp
    if ((sfd = open(src, O_RDONLY)) >= 0) {
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 162:	00 
{
 163:	8b 75 0c             	mov    0xc(%ebp),%esi
    if ((sfd = open(src, O_RDONLY)) >= 0) {
 166:	89 04 24             	mov    %eax,(%esp)
 169:	e8 24 03 00 00       	call   492 <open>
 16e:	85 c0                	test   %eax,%eax
 170:	89 c3                	mov    %eax,%ebx
 172:	78 7f                	js     1f3 <cp+0xa3>
        res = stat(dest, &st);
 174:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 177:	89 44 24 04          	mov    %eax,0x4(%esp)
 17b:	89 34 24             	mov    %esi,(%esp)
 17e:	e8 1d 02 00 00       	call   3a0 <stat>
        if (res >= 0) {
 183:	85 c0                	test   %eax,%eax
 185:	78 08                	js     18f <cp+0x3f>
            unlink(dest); // should check for errors
 187:	89 34 24             	mov    %esi,(%esp)
 18a:	e8 13 03 00 00       	call   4a2 <unlink>
        if ((dfd = open(dest, flags)) >= 0) {
 18f:	89 34 24             	mov    %esi,(%esp)
 192:	c7 44 24 04 01 02 00 	movl   $0x201,0x4(%esp)
 199:	00 
 19a:	e8 f3 02 00 00       	call   492 <open>
 19f:	85 c0                	test   %eax,%eax
 1a1:	89 c6                	mov    %eax,%esi
 1a3:	79 1b                	jns    1c0 <cp+0x70>
 1a5:	eb 65                	jmp    20c <cp+0xbc>
 1a7:	90                   	nop
                ((n = read(sfd, buf, BUFSIZE)) > 0) && ((res = write(dfd, buf, n)));
 1a8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1ac:	c7 44 24 04 40 0c 00 	movl   $0xc40,0x4(%esp)
 1b3:	00 
 1b4:	89 34 24             	mov    %esi,(%esp)
 1b7:	e8 b6 02 00 00       	call   472 <write>
 1bc:	85 c0                	test   %eax,%eax
 1be:	74 1c                	je     1dc <cp+0x8c>
            for (
 1c0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 1c7:	00 
 1c8:	c7 44 24 04 40 0c 00 	movl   $0xc40,0x4(%esp)
 1cf:	00 
 1d0:	89 1c 24             	mov    %ebx,(%esp)
 1d3:	e8 92 02 00 00       	call   46a <read>
 1d8:	85 c0                	test   %eax,%eax
 1da:	7f cc                	jg     1a8 <cp+0x58>
            close(dfd);
 1dc:	89 34 24             	mov    %esi,(%esp)
 1df:	e8 96 02 00 00       	call   47a <close>
        close(sfd);
 1e4:	89 1c 24             	mov    %ebx,(%esp)
 1e7:	e8 8e 02 00 00       	call   47a <close>
}
 1ec:	83 c4 30             	add    $0x30,%esp
 1ef:	5b                   	pop    %ebx
 1f0:	5e                   	pop    %esi
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    
        printf(2, "gack1\n");
 1f3:	c7 44 24 04 5d 09 00 	movl   $0x95d,0x4(%esp)
 1fa:	00 
 1fb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 202:	e8 b9 03 00 00       	call   5c0 <printf>
        exit();
 207:	e8 46 02 00 00       	call   452 <exit>
            printf(2, "gack3\n");
 20c:	c7 44 24 04 56 09 00 	movl   $0x956,0x4(%esp)
 213:	00 
 214:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 21b:	e8 a0 03 00 00       	call   5c0 <printf>
            exit();
 220:	e8 2d 02 00 00       	call   452 <exit>
 225:	66 90                	xchg   %ax,%ax
 227:	66 90                	xchg   %ax,%ax
 229:	66 90                	xchg   %ax,%ax
 22b:	66 90                	xchg   %ax,%ax
 22d:	66 90                	xchg   %ax,%ax
 22f:	90                   	nop

00000230 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 239:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 23a:	89 c2                	mov    %eax,%edx
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 240:	83 c1 01             	add    $0x1,%ecx
 243:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 247:	83 c2 01             	add    $0x1,%edx
 24a:	84 db                	test   %bl,%bl
 24c:	88 5a ff             	mov    %bl,-0x1(%edx)
 24f:	75 ef                	jne    240 <strcpy+0x10>
    ;
  return os;
}
 251:	5b                   	pop    %ebx
 252:	5d                   	pop    %ebp
 253:	c3                   	ret    
 254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 25a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000260 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 55 08             	mov    0x8(%ebp),%edx
 266:	53                   	push   %ebx
 267:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 26a:	0f b6 02             	movzbl (%edx),%eax
 26d:	84 c0                	test   %al,%al
 26f:	74 2d                	je     29e <strcmp+0x3e>
 271:	0f b6 19             	movzbl (%ecx),%ebx
 274:	38 d8                	cmp    %bl,%al
 276:	74 0e                	je     286 <strcmp+0x26>
 278:	eb 2b                	jmp    2a5 <strcmp+0x45>
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 280:	38 c8                	cmp    %cl,%al
 282:	75 15                	jne    299 <strcmp+0x39>
    p++, q++;
 284:	89 d9                	mov    %ebx,%ecx
 286:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 289:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 28c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 28f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 293:	84 c0                	test   %al,%al
 295:	75 e9                	jne    280 <strcmp+0x20>
 297:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 299:	29 c8                	sub    %ecx,%eax
}
 29b:	5b                   	pop    %ebx
 29c:	5d                   	pop    %ebp
 29d:	c3                   	ret    
 29e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 2a1:	31 c0                	xor    %eax,%eax
 2a3:	eb f4                	jmp    299 <strcmp+0x39>
 2a5:	0f b6 cb             	movzbl %bl,%ecx
 2a8:	eb ef                	jmp    299 <strcmp+0x39>
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <strlen>:

uint
strlen(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2b6:	80 39 00             	cmpb   $0x0,(%ecx)
 2b9:	74 12                	je     2cd <strlen+0x1d>
 2bb:	31 d2                	xor    %edx,%edx
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2c7:	89 d0                	mov    %edx,%eax
 2c9:	75 f5                	jne    2c0 <strlen+0x10>
    ;
  return n;
}
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 2cd:	31 c0                	xor    %eax,%eax
}
 2cf:	5d                   	pop    %ebp
 2d0:	c3                   	ret    
 2d1:	eb 0d                	jmp    2e0 <memset>
 2d3:	90                   	nop
 2d4:	90                   	nop
 2d5:	90                   	nop
 2d6:	90                   	nop
 2d7:	90                   	nop
 2d8:	90                   	nop
 2d9:	90                   	nop
 2da:	90                   	nop
 2db:	90                   	nop
 2dc:	90                   	nop
 2dd:	90                   	nop
 2de:	90                   	nop
 2df:	90                   	nop

000002e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 55 08             	mov    0x8(%ebp),%edx
 2e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ed:	89 d7                	mov    %edx,%edi
 2ef:	fc                   	cld    
 2f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2f2:	89 d0                	mov    %edx,%eax
 2f4:	5f                   	pop    %edi
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <strchr>:

char*
strchr(const char *s, char c)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	53                   	push   %ebx
 307:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 30a:	0f b6 18             	movzbl (%eax),%ebx
 30d:	84 db                	test   %bl,%bl
 30f:	74 1d                	je     32e <strchr+0x2e>
    if(*s == c)
 311:	38 d3                	cmp    %dl,%bl
 313:	89 d1                	mov    %edx,%ecx
 315:	75 0d                	jne    324 <strchr+0x24>
 317:	eb 17                	jmp    330 <strchr+0x30>
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 320:	38 ca                	cmp    %cl,%dl
 322:	74 0c                	je     330 <strchr+0x30>
  for(; *s; s++)
 324:	83 c0 01             	add    $0x1,%eax
 327:	0f b6 10             	movzbl (%eax),%edx
 32a:	84 d2                	test   %dl,%dl
 32c:	75 f2                	jne    320 <strchr+0x20>
      return (char*)s;
  return 0;
 32e:	31 c0                	xor    %eax,%eax
}
 330:	5b                   	pop    %ebx
 331:	5d                   	pop    %ebp
 332:	c3                   	ret    
 333:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <gets>:

char*
gets(char *buf, int max)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 345:	31 f6                	xor    %esi,%esi
{
 347:	53                   	push   %ebx
 348:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 34b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 34e:	eb 31                	jmp    381 <gets+0x41>
    cc = read(0, &c, 1);
 350:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 357:	00 
 358:	89 7c 24 04          	mov    %edi,0x4(%esp)
 35c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 363:	e8 02 01 00 00       	call   46a <read>
    if(cc < 1)
 368:	85 c0                	test   %eax,%eax
 36a:	7e 1d                	jle    389 <gets+0x49>
      break;
    buf[i++] = c;
 36c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 370:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 372:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 375:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 377:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 37b:	74 0c                	je     389 <gets+0x49>
 37d:	3c 0a                	cmp    $0xa,%al
 37f:	74 08                	je     389 <gets+0x49>
  for(i=0; i+1 < max; ){
 381:	8d 5e 01             	lea    0x1(%esi),%ebx
 384:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 387:	7c c7                	jl     350 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 389:	8b 45 08             	mov    0x8(%ebp),%eax
 38c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 390:	83 c4 2c             	add    $0x2c,%esp
 393:	5b                   	pop    %ebx
 394:	5e                   	pop    %esi
 395:	5f                   	pop    %edi
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	53                   	push   %ebx
 3a5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3b2:	00 
 3b3:	89 04 24             	mov    %eax,(%esp)
 3b6:	e8 d7 00 00 00       	call   492 <open>
  if(fd < 0)
 3bb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 3bd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3bf:	78 27                	js     3e8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 3c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c4:	89 1c 24             	mov    %ebx,(%esp)
 3c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3cb:	e8 da 00 00 00       	call   4aa <fstat>
  close(fd);
 3d0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3d3:	89 c6                	mov    %eax,%esi
  close(fd);
 3d5:	e8 a0 00 00 00       	call   47a <close>
  return r;
 3da:	89 f0                	mov    %esi,%eax
}
 3dc:	83 c4 10             	add    $0x10,%esp
 3df:	5b                   	pop    %ebx
 3e0:	5e                   	pop    %esi
 3e1:	5d                   	pop    %ebp
 3e2:	c3                   	ret    
 3e3:	90                   	nop
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 3e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3ed:	eb ed                	jmp    3dc <stat+0x3c>
 3ef:	90                   	nop

000003f0 <atoi>:

int
atoi(const char *s)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f7:	0f be 11             	movsbl (%ecx),%edx
 3fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 3fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 3ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 404:	77 17                	ja     41d <atoi+0x2d>
 406:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 408:	83 c1 01             	add    $0x1,%ecx
 40b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 40e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 412:	0f be 11             	movsbl (%ecx),%edx
 415:	8d 5a d0             	lea    -0x30(%edx),%ebx
 418:	80 fb 09             	cmp    $0x9,%bl
 41b:	76 eb                	jbe    408 <atoi+0x18>
  return n;
}
 41d:	5b                   	pop    %ebx
 41e:	5d                   	pop    %ebp
 41f:	c3                   	ret    

00000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 421:	31 d2                	xor    %edx,%edx
{
 423:	89 e5                	mov    %esp,%ebp
 425:	56                   	push   %esi
 426:	8b 45 08             	mov    0x8(%ebp),%eax
 429:	53                   	push   %ebx
 42a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 42d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 430:	85 db                	test   %ebx,%ebx
 432:	7e 12                	jle    446 <memmove+0x26>
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 438:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 43c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 43f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 442:	39 da                	cmp    %ebx,%edx
 444:	75 f2                	jne    438 <memmove+0x18>
  return vdst;
}
 446:	5b                   	pop    %ebx
 447:	5e                   	pop    %esi
 448:	5d                   	pop    %ebp
 449:	c3                   	ret    

0000044a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 44a:	b8 01 00 00 00       	mov    $0x1,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <exit>:
SYSCALL(exit)
 452:	b8 02 00 00 00       	mov    $0x2,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <wait>:
SYSCALL(wait)
 45a:	b8 03 00 00 00       	mov    $0x3,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <pipe>:
SYSCALL(pipe)
 462:	b8 04 00 00 00       	mov    $0x4,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <read>:
SYSCALL(read)
 46a:	b8 05 00 00 00       	mov    $0x5,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <write>:
SYSCALL(write)
 472:	b8 10 00 00 00       	mov    $0x10,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <close>:
SYSCALL(close)
 47a:	b8 15 00 00 00       	mov    $0x15,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <kill>:
SYSCALL(kill)
 482:	b8 06 00 00 00       	mov    $0x6,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <exec>:
SYSCALL(exec)
 48a:	b8 07 00 00 00       	mov    $0x7,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <open>:
SYSCALL(open)
 492:	b8 0f 00 00 00       	mov    $0xf,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <mknod>:
SYSCALL(mknod)
 49a:	b8 11 00 00 00       	mov    $0x11,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <unlink>:
SYSCALL(unlink)
 4a2:	b8 12 00 00 00       	mov    $0x12,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <fstat>:
SYSCALL(fstat)
 4aa:	b8 08 00 00 00       	mov    $0x8,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <link>:
SYSCALL(link)
 4b2:	b8 13 00 00 00       	mov    $0x13,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <mkdir>:
SYSCALL(mkdir)
 4ba:	b8 14 00 00 00       	mov    $0x14,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <chdir>:
SYSCALL(chdir)
 4c2:	b8 09 00 00 00       	mov    $0x9,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <dup>:
SYSCALL(dup)
 4ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <getpid>:
SYSCALL(getpid)
 4d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <sbrk>:
SYSCALL(sbrk)
 4da:	b8 0c 00 00 00       	mov    $0xc,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <sleep>:
SYSCALL(sleep)
 4e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <uptime>:
SYSCALL(uptime)
 4ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 4f2:	b8 16 00 00 00       	mov    $0x16,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 4fa:	b8 17 00 00 00       	mov    $0x17,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 502:	b8 18 00 00 00       	mov    $0x18,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <halt>:
 50a:	b8 19 00 00 00       	mov    $0x19,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    
 512:	66 90                	xchg   %ax,%ax
 514:	66 90                	xchg   %ax,%ax
 516:	66 90                	xchg   %ax,%ax
 518:	66 90                	xchg   %ax,%ax
 51a:	66 90                	xchg   %ax,%ax
 51c:	66 90                	xchg   %ax,%ax
 51e:	66 90                	xchg   %ax,%ax

00000520 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	89 c6                	mov    %eax,%esi
 527:	53                   	push   %ebx
 528:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 52b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 52e:	85 db                	test   %ebx,%ebx
 530:	74 09                	je     53b <printint+0x1b>
 532:	89 d0                	mov    %edx,%eax
 534:	c1 e8 1f             	shr    $0x1f,%eax
 537:	84 c0                	test   %al,%al
 539:	75 75                	jne    5b0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 53b:	89 d0                	mov    %edx,%eax
  neg = 0;
 53d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 544:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 547:	31 ff                	xor    %edi,%edi
 549:	89 ce                	mov    %ecx,%esi
 54b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 54e:	eb 02                	jmp    552 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 550:	89 cf                	mov    %ecx,%edi
 552:	31 d2                	xor    %edx,%edx
 554:	f7 f6                	div    %esi
 556:	8d 4f 01             	lea    0x1(%edi),%ecx
 559:	0f b6 92 84 09 00 00 	movzbl 0x984(%edx),%edx
  }while((x /= base) != 0);
 560:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 562:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 565:	75 e9                	jne    550 <printint+0x30>
  if(neg)
 567:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 56a:	89 c8                	mov    %ecx,%eax
 56c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 56f:	85 d2                	test   %edx,%edx
 571:	74 08                	je     57b <printint+0x5b>
    buf[i++] = '-';
 573:	8d 4f 02             	lea    0x2(%edi),%ecx
 576:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 57b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 57e:	66 90                	xchg   %ax,%ax
 580:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 585:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 588:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 58f:	00 
 590:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 594:	89 34 24             	mov    %esi,(%esp)
 597:	88 45 d7             	mov    %al,-0x29(%ebp)
 59a:	e8 d3 fe ff ff       	call   472 <write>
  while(--i >= 0)
 59f:	83 ff ff             	cmp    $0xffffffff,%edi
 5a2:	75 dc                	jne    580 <printint+0x60>
    putc(fd, buf[i]);
}
 5a4:	83 c4 4c             	add    $0x4c,%esp
 5a7:	5b                   	pop    %ebx
 5a8:	5e                   	pop    %esi
 5a9:	5f                   	pop    %edi
 5aa:	5d                   	pop    %ebp
 5ab:	c3                   	ret    
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 5b0:	89 d0                	mov    %edx,%eax
 5b2:	f7 d8                	neg    %eax
    neg = 1;
 5b4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 5bb:	eb 87                	jmp    544 <printint+0x24>
 5bd:	8d 76 00             	lea    0x0(%esi),%esi

000005c0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5c4:	31 ff                	xor    %edi,%edi
{
 5c6:	56                   	push   %esi
 5c7:	53                   	push   %ebx
 5c8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5cb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 5ce:	8d 45 10             	lea    0x10(%ebp),%eax
{
 5d1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 5d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5d7:	0f b6 13             	movzbl (%ebx),%edx
 5da:	83 c3 01             	add    $0x1,%ebx
 5dd:	84 d2                	test   %dl,%dl
 5df:	75 39                	jne    61a <printf+0x5a>
 5e1:	e9 ca 00 00 00       	jmp    6b0 <printf+0xf0>
 5e6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5e8:	83 fa 25             	cmp    $0x25,%edx
 5eb:	0f 84 c7 00 00 00    	je     6b8 <printf+0xf8>
  write(fd, &c, 1);
 5f1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 5f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5fb:	00 
 5fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 600:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 603:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 606:	e8 67 fe ff ff       	call   472 <write>
 60b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 60e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 612:	84 d2                	test   %dl,%dl
 614:	0f 84 96 00 00 00    	je     6b0 <printf+0xf0>
    if(state == 0){
 61a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 61c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 61f:	74 c7                	je     5e8 <printf+0x28>
      }
    } else if(state == '%'){
 621:	83 ff 25             	cmp    $0x25,%edi
 624:	75 e5                	jne    60b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 626:	83 fa 75             	cmp    $0x75,%edx
 629:	0f 84 99 00 00 00    	je     6c8 <printf+0x108>
 62f:	83 fa 64             	cmp    $0x64,%edx
 632:	0f 84 90 00 00 00    	je     6c8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 638:	25 f7 00 00 00       	and    $0xf7,%eax
 63d:	83 f8 70             	cmp    $0x70,%eax
 640:	0f 84 aa 00 00 00    	je     6f0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 646:	83 fa 73             	cmp    $0x73,%edx
 649:	0f 84 e9 00 00 00    	je     738 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 64f:	83 fa 63             	cmp    $0x63,%edx
 652:	0f 84 2b 01 00 00    	je     783 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 658:	83 fa 25             	cmp    $0x25,%edx
 65b:	0f 84 4f 01 00 00    	je     7b0 <printf+0x1f0>
  write(fd, &c, 1);
 661:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 664:	83 c3 01             	add    $0x1,%ebx
 667:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 66e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 671:	89 44 24 04          	mov    %eax,0x4(%esp)
 675:	89 34 24             	mov    %esi,(%esp)
 678:	89 55 d0             	mov    %edx,-0x30(%ebp)
 67b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 67f:	e8 ee fd ff ff       	call   472 <write>
        putc(fd, c);
 684:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 687:	8d 45 e7             	lea    -0x19(%ebp),%eax
 68a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 691:	00 
 692:	89 44 24 04          	mov    %eax,0x4(%esp)
 696:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 699:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 69c:	e8 d1 fd ff ff       	call   472 <write>
  for(i = 0; fmt[i]; i++){
 6a1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6a5:	84 d2                	test   %dl,%dl
 6a7:	0f 85 6d ff ff ff    	jne    61a <printf+0x5a>
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 6b0:	83 c4 3c             	add    $0x3c,%esp
 6b3:	5b                   	pop    %ebx
 6b4:	5e                   	pop    %esi
 6b5:	5f                   	pop    %edi
 6b6:	5d                   	pop    %ebp
 6b7:	c3                   	ret    
        state = '%';
 6b8:	bf 25 00 00 00       	mov    $0x25,%edi
 6bd:	e9 49 ff ff ff       	jmp    60b <printf+0x4b>
 6c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 6c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 6d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6d7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	89 f0                	mov    %esi,%eax
 6dd:	e8 3e fe ff ff       	call   520 <printint>
        ap++;
 6e2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6e6:	e9 20 ff ff ff       	jmp    60b <printf+0x4b>
 6eb:	90                   	nop
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6f0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 6f3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6fa:	00 
 6fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ff:	89 34 24             	mov    %esi,(%esp)
 702:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 706:	e8 67 fd ff ff       	call   472 <write>
 70b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 70e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 715:	00 
 716:	89 44 24 04          	mov    %eax,0x4(%esp)
 71a:	89 34 24             	mov    %esi,(%esp)
 71d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 721:	e8 4c fd ff ff       	call   472 <write>
        printint(fd, *ap, 16, 0);
 726:	b9 10 00 00 00       	mov    $0x10,%ecx
 72b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 732:	eb a0                	jmp    6d4 <printf+0x114>
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 738:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 73b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 73f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 741:	b8 7d 09 00 00       	mov    $0x97d,%eax
 746:	85 ff                	test   %edi,%edi
 748:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 74b:	0f b6 07             	movzbl (%edi),%eax
 74e:	84 c0                	test   %al,%al
 750:	74 2a                	je     77c <printf+0x1bc>
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 758:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 75b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 75e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 761:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 768:	00 
 769:	89 44 24 04          	mov    %eax,0x4(%esp)
 76d:	89 34 24             	mov    %esi,(%esp)
 770:	e8 fd fc ff ff       	call   472 <write>
        while(*s != 0){
 775:	0f b6 07             	movzbl (%edi),%eax
 778:	84 c0                	test   %al,%al
 77a:	75 dc                	jne    758 <printf+0x198>
      state = 0;
 77c:	31 ff                	xor    %edi,%edi
 77e:	e9 88 fe ff ff       	jmp    60b <printf+0x4b>
        putc(fd, *ap);
 783:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 786:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 788:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 78a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 791:	00 
 792:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 795:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 798:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 79b:	89 44 24 04          	mov    %eax,0x4(%esp)
 79f:	e8 ce fc ff ff       	call   472 <write>
        ap++;
 7a4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 7a8:	e9 5e fe ff ff       	jmp    60b <printf+0x4b>
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7b0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 7b3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 7b5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7bc:	00 
 7bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 7c1:	89 34 24             	mov    %esi,(%esp)
 7c4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 7c8:	e8 a5 fc ff ff       	call   472 <write>
 7cd:	e9 39 fe ff ff       	jmp    60b <printf+0x4b>
 7d2:	66 90                	xchg   %ax,%ax
 7d4:	66 90                	xchg   %ax,%ax
 7d6:	66 90                	xchg   %ax,%ax
 7d8:	66 90                	xchg   %ax,%ax
 7da:	66 90                	xchg   %ax,%ax
 7dc:	66 90                	xchg   %ax,%ax
 7de:	66 90                	xchg   %ax,%ax

000007e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e1:	a1 40 0e 00 00       	mov    0xe40,%eax
{
 7e6:	89 e5                	mov    %esp,%ebp
 7e8:	57                   	push   %edi
 7e9:	56                   	push   %esi
 7ea:	53                   	push   %ebx
 7eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 7f0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f3:	39 d0                	cmp    %edx,%eax
 7f5:	72 11                	jb     808 <free+0x28>
 7f7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f8:	39 c8                	cmp    %ecx,%eax
 7fa:	72 04                	jb     800 <free+0x20>
 7fc:	39 ca                	cmp    %ecx,%edx
 7fe:	72 10                	jb     810 <free+0x30>
 800:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 802:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 806:	73 f0                	jae    7f8 <free+0x18>
 808:	39 ca                	cmp    %ecx,%edx
 80a:	72 04                	jb     810 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80c:	39 c8                	cmp    %ecx,%eax
 80e:	72 f0                	jb     800 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 810:	8b 73 fc             	mov    -0x4(%ebx),%esi
 813:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 816:	39 cf                	cmp    %ecx,%edi
 818:	74 1e                	je     838 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 81a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 81d:	8b 48 04             	mov    0x4(%eax),%ecx
 820:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 823:	39 f2                	cmp    %esi,%edx
 825:	74 28                	je     84f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 827:	89 10                	mov    %edx,(%eax)
  freep = p;
 829:	a3 40 0e 00 00       	mov    %eax,0xe40
}
 82e:	5b                   	pop    %ebx
 82f:	5e                   	pop    %esi
 830:	5f                   	pop    %edi
 831:	5d                   	pop    %ebp
 832:	c3                   	ret    
 833:	90                   	nop
 834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 838:	03 71 04             	add    0x4(%ecx),%esi
 83b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 83e:	8b 08                	mov    (%eax),%ecx
 840:	8b 09                	mov    (%ecx),%ecx
 842:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 845:	8b 48 04             	mov    0x4(%eax),%ecx
 848:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 84b:	39 f2                	cmp    %esi,%edx
 84d:	75 d8                	jne    827 <free+0x47>
    p->s.size += bp->s.size;
 84f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 852:	a3 40 0e 00 00       	mov    %eax,0xe40
    p->s.size += bp->s.size;
 857:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 85a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 85d:	89 10                	mov    %edx,(%eax)
}
 85f:	5b                   	pop    %ebx
 860:	5e                   	pop    %esi
 861:	5f                   	pop    %edi
 862:	5d                   	pop    %ebp
 863:	c3                   	ret    
 864:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 86a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000870 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 879:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 87c:	8b 1d 40 0e 00 00    	mov    0xe40,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 882:	8d 48 07             	lea    0x7(%eax),%ecx
 885:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 888:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 88d:	0f 84 9b 00 00 00    	je     92e <malloc+0xbe>
 893:	8b 13                	mov    (%ebx),%edx
 895:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 898:	39 fe                	cmp    %edi,%esi
 89a:	76 64                	jbe    900 <malloc+0x90>
 89c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 8a3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 8a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 8ab:	eb 0e                	jmp    8bb <malloc+0x4b>
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8b2:	8b 78 04             	mov    0x4(%eax),%edi
 8b5:	39 fe                	cmp    %edi,%esi
 8b7:	76 4f                	jbe    908 <malloc+0x98>
 8b9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8bb:	3b 15 40 0e 00 00    	cmp    0xe40,%edx
 8c1:	75 ed                	jne    8b0 <malloc+0x40>
  if(nu < 4096)
 8c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8c6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 8cc:	bf 00 10 00 00       	mov    $0x1000,%edi
 8d1:	0f 43 fe             	cmovae %esi,%edi
 8d4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 8d7:	89 04 24             	mov    %eax,(%esp)
 8da:	e8 fb fb ff ff       	call   4da <sbrk>
  if(p == (char*)-1)
 8df:	83 f8 ff             	cmp    $0xffffffff,%eax
 8e2:	74 18                	je     8fc <malloc+0x8c>
  hp->s.size = nu;
 8e4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8e7:	83 c0 08             	add    $0x8,%eax
 8ea:	89 04 24             	mov    %eax,(%esp)
 8ed:	e8 ee fe ff ff       	call   7e0 <free>
  return freep;
 8f2:	8b 15 40 0e 00 00    	mov    0xe40,%edx
      if((p = morecore(nunits)) == 0)
 8f8:	85 d2                	test   %edx,%edx
 8fa:	75 b4                	jne    8b0 <malloc+0x40>
        return 0;
 8fc:	31 c0                	xor    %eax,%eax
 8fe:	eb 20                	jmp    920 <malloc+0xb0>
    if(p->s.size >= nunits){
 900:	89 d0                	mov    %edx,%eax
 902:	89 da                	mov    %ebx,%edx
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 908:	39 fe                	cmp    %edi,%esi
 90a:	74 1c                	je     928 <malloc+0xb8>
        p->s.size -= nunits;
 90c:	29 f7                	sub    %esi,%edi
 90e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 911:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 914:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 917:	89 15 40 0e 00 00    	mov    %edx,0xe40
      return (void*)(p + 1);
 91d:	83 c0 08             	add    $0x8,%eax
  }
}
 920:	83 c4 1c             	add    $0x1c,%esp
 923:	5b                   	pop    %ebx
 924:	5e                   	pop    %esi
 925:	5f                   	pop    %edi
 926:	5d                   	pop    %ebp
 927:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 928:	8b 08                	mov    (%eax),%ecx
 92a:	89 0a                	mov    %ecx,(%edx)
 92c:	eb e9                	jmp    917 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 92e:	c7 05 40 0e 00 00 44 	movl   $0xe44,0xe40
 935:	0e 00 00 
    base.s.size = 0;
 938:	ba 44 0e 00 00       	mov    $0xe44,%edx
    base.s.ptr = freep = prevp = &base;
 93d:	c7 05 44 0e 00 00 44 	movl   $0xe44,0xe44
 944:	0e 00 00 
    base.s.size = 0;
 947:	c7 05 48 0e 00 00 00 	movl   $0x0,0xe48
 94e:	00 00 00 
 951:	e9 46 ff ff ff       	jmp    89c <malloc+0x2c>
