
_mv:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
		}
	}
	return res;
}

int main (int argc, char **argv) {
   0:	55                   	push   %ebp
    int i = 0;
    int res = -1;
    char* dest = NULL;
    struct stat st;
    char dirstr[DIRSTR] = {0};
   1:	31 c0                	xor    %eax,%eax
int main (int argc, char **argv) {
   3:	89 e5                	mov    %esp,%ebp
    char dirstr[DIRSTR] = {0};
   5:	b9 20 00 00 00       	mov    $0x20,%ecx
int main (int argc, char **argv) {
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
  27:	c7 44 24 04 f0 08 00 	movl   $0x8f0,0x4(%esp)
  2e:	00 
  2f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  36:	e8 05 05 00 00       	call   540 <printf>
        exit();
  3b:	e8 a2 03 00 00       	call   3e2 <exit>
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
  58:	e8 d3 02 00 00       	call   330 <stat>
    if (res < 0) {
  5d:	85 c0                	test   %eax,%eax
  5f:	78 47                	js     a8 <main+0xa8>
		// dest does not exist
		mv(argv[1], dest);
	} else {
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
  72:	c7 44 24 04 ea 08 00 	movl   $0x8ea,0x4(%esp)
  79:	00 
  7a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  81:	e8 ba 04 00 00       	call   540 <printf>
				break;

		}
	}

	exit();
  86:	e8 57 03 00 00       	call   3e2 <exit>
				unlink(dest);
  8b:	8b 7c 24 18          	mov    0x18(%esp),%edi
  8f:	89 3c 24             	mov    %edi,(%esp)
  92:	e8 9b 03 00 00       	call   432 <unlink>
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
  e3:	e8 88 01 00 00       	call   270 <memset>
					strcpy(dirstr, dest);
  e8:	8b 44 24 18          	mov    0x18(%esp),%eax
  ec:	89 1c 24             	mov    %ebx,(%esp)
  ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  f3:	e8 c8 00 00 00       	call   1c0 <strcpy>
					dirstr[strlen(dirstr)] = '/';
  f8:	89 1c 24             	mov    %ebx,(%esp)
  fb:	e8 40 01 00 00       	call   240 <strlen>
					strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
 100:	8b 14 be             	mov    (%esi,%edi,4),%edx
 103:	89 54 24 1c          	mov    %edx,0x1c(%esp)
					dirstr[strlen(dirstr)] = '/';
 107:	c6 44 04 40 2f       	movb   $0x2f,0x40(%esp,%eax,1)
					strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
 10c:	89 1c 24             	mov    %ebx,(%esp)
 10f:	e8 2c 01 00 00       	call   240 <strlen>
 114:	8b 54 24 1c          	mov    0x1c(%esp),%edx
 118:	89 54 24 04          	mov    %edx,0x4(%esp)
 11c:	01 d8                	add    %ebx,%eax
 11e:	89 04 24             	mov    %eax,(%esp)
 121:	e8 9a 00 00 00       	call   1c0 <strcpy>
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
int mv(char* src, char* dest) {
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	83 ec 14             	sub    $0x14,%esp
 157:	8b 5d 08             	mov    0x8(%ebp),%ebx
	if (link(src, dest) < 0) {
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 1c 24             	mov    %ebx,(%esp)
 160:	89 44 24 04          	mov    %eax,0x4(%esp)
 164:	e8 d9 02 00 00       	call   442 <link>
 169:	85 c0                	test   %eax,%eax
 16b:	78 1b                	js     188 <mv+0x38>
		if (unlink(src) < 0) {
 16d:	89 1c 24             	mov    %ebx,(%esp)
 170:	e8 bd 02 00 00       	call   432 <unlink>
 175:	85 c0                	test   %eax,%eax
 177:	78 2a                	js     1a3 <mv+0x53>
			res = 0;
 179:	31 c0                	xor    %eax,%eax
}
 17b:	83 c4 14             	add    $0x14,%esp
 17e:	5b                   	pop    %ebx
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		printf(2, "barf again\n");
 188:	c7 44 24 04 d6 08 00 	movl   $0x8d6,0x4(%esp)
 18f:	00 
 190:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 197:	e8 a4 03 00 00       	call   540 <printf>
	int res = -1;
 19c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1a1:	eb d8                	jmp    17b <mv+0x2b>
			printf(2, "barf 3\n");
 1a3:	c7 44 24 04 e2 08 00 	movl   $0x8e2,0x4(%esp)
 1aa:	00 
 1ab:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1b2:	e8 89 03 00 00       	call   540 <printf>
 1b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1bc:	eb bd                	jmp    17b <mv+0x2b>
 1be:	66 90                	xchg   %ax,%ax

000001c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1c9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ca:	89 c2                	mov    %eax,%edx
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	83 c1 01             	add    $0x1,%ecx
 1d3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1d7:	83 c2 01             	add    $0x1,%edx
 1da:	84 db                	test   %bl,%bl
 1dc:	88 5a ff             	mov    %bl,-0x1(%edx)
 1df:	75 ef                	jne    1d0 <strcpy+0x10>
    ;
  return os;
}
 1e1:	5b                   	pop    %ebx
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
 1f6:	53                   	push   %ebx
 1f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1fa:	0f b6 02             	movzbl (%edx),%eax
 1fd:	84 c0                	test   %al,%al
 1ff:	74 2d                	je     22e <strcmp+0x3e>
 201:	0f b6 19             	movzbl (%ecx),%ebx
 204:	38 d8                	cmp    %bl,%al
 206:	74 0e                	je     216 <strcmp+0x26>
 208:	eb 2b                	jmp    235 <strcmp+0x45>
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 210:	38 c8                	cmp    %cl,%al
 212:	75 15                	jne    229 <strcmp+0x39>
    p++, q++;
 214:	89 d9                	mov    %ebx,%ecx
 216:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 219:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 21c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 21f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 223:	84 c0                	test   %al,%al
 225:	75 e9                	jne    210 <strcmp+0x20>
 227:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 229:	29 c8                	sub    %ecx,%eax
}
 22b:	5b                   	pop    %ebx
 22c:	5d                   	pop    %ebp
 22d:	c3                   	ret    
 22e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 231:	31 c0                	xor    %eax,%eax
 233:	eb f4                	jmp    229 <strcmp+0x39>
 235:	0f b6 cb             	movzbl %bl,%ecx
 238:	eb ef                	jmp    229 <strcmp+0x39>
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <strlen>:

uint
strlen(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 246:	80 39 00             	cmpb   $0x0,(%ecx)
 249:	74 12                	je     25d <strlen+0x1d>
 24b:	31 d2                	xor    %edx,%edx
 24d:	8d 76 00             	lea    0x0(%esi),%esi
 250:	83 c2 01             	add    $0x1,%edx
 253:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 257:	89 d0                	mov    %edx,%eax
 259:	75 f5                	jne    250 <strlen+0x10>
    ;
  return n;
}
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 25d:	31 c0                	xor    %eax,%eax
}
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	eb 0d                	jmp    270 <memset>
 263:	90                   	nop
 264:	90                   	nop
 265:	90                   	nop
 266:	90                   	nop
 267:	90                   	nop
 268:	90                   	nop
 269:	90                   	nop
 26a:	90                   	nop
 26b:	90                   	nop
 26c:	90                   	nop
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

00000270 <memset>:

void*
memset(void *dst, int c, uint n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 55 08             	mov    0x8(%ebp),%edx
 276:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 277:	8b 4d 10             	mov    0x10(%ebp),%ecx
 27a:	8b 45 0c             	mov    0xc(%ebp),%eax
 27d:	89 d7                	mov    %edx,%edi
 27f:	fc                   	cld    
 280:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 282:	89 d0                	mov    %edx,%eax
 284:	5f                   	pop    %edi
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <strchr>:

char*
strchr(const char *s, char c)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	53                   	push   %ebx
 297:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 29a:	0f b6 18             	movzbl (%eax),%ebx
 29d:	84 db                	test   %bl,%bl
 29f:	74 1d                	je     2be <strchr+0x2e>
    if(*s == c)
 2a1:	38 d3                	cmp    %dl,%bl
 2a3:	89 d1                	mov    %edx,%ecx
 2a5:	75 0d                	jne    2b4 <strchr+0x24>
 2a7:	eb 17                	jmp    2c0 <strchr+0x30>
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2b0:	38 ca                	cmp    %cl,%dl
 2b2:	74 0c                	je     2c0 <strchr+0x30>
  for(; *s; s++)
 2b4:	83 c0 01             	add    $0x1,%eax
 2b7:	0f b6 10             	movzbl (%eax),%edx
 2ba:	84 d2                	test   %dl,%dl
 2bc:	75 f2                	jne    2b0 <strchr+0x20>
      return (char*)s;
  return 0;
 2be:	31 c0                	xor    %eax,%eax
}
 2c0:	5b                   	pop    %ebx
 2c1:	5d                   	pop    %ebp
 2c2:	c3                   	ret    
 2c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <gets>:

char*
gets(char *buf, int max)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d5:	31 f6                	xor    %esi,%esi
{
 2d7:	53                   	push   %ebx
 2d8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 2db:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 2de:	eb 31                	jmp    311 <gets+0x41>
    cc = read(0, &c, 1);
 2e0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2e7:	00 
 2e8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2f3:	e8 02 01 00 00       	call   3fa <read>
    if(cc < 1)
 2f8:	85 c0                	test   %eax,%eax
 2fa:	7e 1d                	jle    319 <gets+0x49>
      break;
    buf[i++] = c;
 2fc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 300:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 302:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 305:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 307:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 30b:	74 0c                	je     319 <gets+0x49>
 30d:	3c 0a                	cmp    $0xa,%al
 30f:	74 08                	je     319 <gets+0x49>
  for(i=0; i+1 < max; ){
 311:	8d 5e 01             	lea    0x1(%esi),%ebx
 314:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 317:	7c c7                	jl     2e0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 320:	83 c4 2c             	add    $0x2c,%esp
 323:	5b                   	pop    %ebx
 324:	5e                   	pop    %esi
 325:	5f                   	pop    %edi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <stat>:

int
stat(const char *n, struct stat *st)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 342:	00 
 343:	89 04 24             	mov    %eax,(%esp)
 346:	e8 d7 00 00 00       	call   422 <open>
  if(fd < 0)
 34b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 34d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 34f:	78 27                	js     378 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 351:	8b 45 0c             	mov    0xc(%ebp),%eax
 354:	89 1c 24             	mov    %ebx,(%esp)
 357:	89 44 24 04          	mov    %eax,0x4(%esp)
 35b:	e8 da 00 00 00       	call   43a <fstat>
  close(fd);
 360:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 363:	89 c6                	mov    %eax,%esi
  close(fd);
 365:	e8 a0 00 00 00       	call   40a <close>
  return r;
 36a:	89 f0                	mov    %esi,%eax
}
 36c:	83 c4 10             	add    $0x10,%esp
 36f:	5b                   	pop    %ebx
 370:	5e                   	pop    %esi
 371:	5d                   	pop    %ebp
 372:	c3                   	ret    
 373:	90                   	nop
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 37d:	eb ed                	jmp    36c <stat+0x3c>
 37f:	90                   	nop

00000380 <atoi>:

int
atoi(const char *s)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 4d 08             	mov    0x8(%ebp),%ecx
 386:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 387:	0f be 11             	movsbl (%ecx),%edx
 38a:	8d 42 d0             	lea    -0x30(%edx),%eax
 38d:	3c 09                	cmp    $0x9,%al
  n = 0;
 38f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 394:	77 17                	ja     3ad <atoi+0x2d>
 396:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 398:	83 c1 01             	add    $0x1,%ecx
 39b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 39e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3a2:	0f be 11             	movsbl (%ecx),%edx
 3a5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3a8:	80 fb 09             	cmp    $0x9,%bl
 3ab:	76 eb                	jbe    398 <atoi+0x18>
  return n;
}
 3ad:	5b                   	pop    %ebx
 3ae:	5d                   	pop    %ebp
 3af:	c3                   	ret    

000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3b1:	31 d2                	xor    %edx,%edx
{
 3b3:	89 e5                	mov    %esp,%ebp
 3b5:	56                   	push   %esi
 3b6:	8b 45 08             	mov    0x8(%ebp),%eax
 3b9:	53                   	push   %ebx
 3ba:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3bd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 3c0:	85 db                	test   %ebx,%ebx
 3c2:	7e 12                	jle    3d6 <memmove+0x26>
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3cf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3d2:	39 da                	cmp    %ebx,%edx
 3d4:	75 f2                	jne    3c8 <memmove+0x18>
  return vdst;
}
 3d6:	5b                   	pop    %ebx
 3d7:	5e                   	pop    %esi
 3d8:	5d                   	pop    %ebp
 3d9:	c3                   	ret    

000003da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3da:	b8 01 00 00 00       	mov    $0x1,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <exit>:
SYSCALL(exit)
 3e2:	b8 02 00 00 00       	mov    $0x2,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <wait>:
SYSCALL(wait)
 3ea:	b8 03 00 00 00       	mov    $0x3,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <pipe>:
SYSCALL(pipe)
 3f2:	b8 04 00 00 00       	mov    $0x4,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <read>:
SYSCALL(read)
 3fa:	b8 05 00 00 00       	mov    $0x5,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <write>:
SYSCALL(write)
 402:	b8 10 00 00 00       	mov    $0x10,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <close>:
SYSCALL(close)
 40a:	b8 15 00 00 00       	mov    $0x15,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <kill>:
SYSCALL(kill)
 412:	b8 06 00 00 00       	mov    $0x6,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <exec>:
SYSCALL(exec)
 41a:	b8 07 00 00 00       	mov    $0x7,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <open>:
SYSCALL(open)
 422:	b8 0f 00 00 00       	mov    $0xf,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <mknod>:
SYSCALL(mknod)
 42a:	b8 11 00 00 00       	mov    $0x11,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <unlink>:
SYSCALL(unlink)
 432:	b8 12 00 00 00       	mov    $0x12,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <fstat>:
SYSCALL(fstat)
 43a:	b8 08 00 00 00       	mov    $0x8,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <link>:
SYSCALL(link)
 442:	b8 13 00 00 00       	mov    $0x13,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <mkdir>:
SYSCALL(mkdir)
 44a:	b8 14 00 00 00       	mov    $0x14,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <chdir>:
SYSCALL(chdir)
 452:	b8 09 00 00 00       	mov    $0x9,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <dup>:
SYSCALL(dup)
 45a:	b8 0a 00 00 00       	mov    $0xa,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <getpid>:
SYSCALL(getpid)
 462:	b8 0b 00 00 00       	mov    $0xb,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <sbrk>:
SYSCALL(sbrk)
 46a:	b8 0c 00 00 00       	mov    $0xc,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <sleep>:
SYSCALL(sleep)
 472:	b8 0d 00 00 00       	mov    $0xd,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <uptime>:
SYSCALL(uptime)
 47a:	b8 0e 00 00 00       	mov    $0xe,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 482:	b8 16 00 00 00       	mov    $0x16,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 48a:	b8 17 00 00 00       	mov    $0x17,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 492:	b8 18 00 00 00       	mov    $0x18,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    
 49a:	66 90                	xchg   %ax,%ax
 49c:	66 90                	xchg   %ax,%ax
 49e:	66 90                	xchg   %ax,%ax

000004a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	89 c6                	mov    %eax,%esi
 4a7:	53                   	push   %ebx
 4a8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4ae:	85 db                	test   %ebx,%ebx
 4b0:	74 09                	je     4bb <printint+0x1b>
 4b2:	89 d0                	mov    %edx,%eax
 4b4:	c1 e8 1f             	shr    $0x1f,%eax
 4b7:	84 c0                	test   %al,%al
 4b9:	75 75                	jne    530 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4bb:	89 d0                	mov    %edx,%eax
  neg = 0;
 4bd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4c4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 4c7:	31 ff                	xor    %edi,%edi
 4c9:	89 ce                	mov    %ecx,%esi
 4cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ce:	eb 02                	jmp    4d2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 4d0:	89 cf                	mov    %ecx,%edi
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	f7 f6                	div    %esi
 4d6:	8d 4f 01             	lea    0x1(%edi),%ecx
 4d9:	0f b6 92 fd 08 00 00 	movzbl 0x8fd(%edx),%edx
  }while((x /= base) != 0);
 4e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4e2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4e5:	75 e9                	jne    4d0 <printint+0x30>
  if(neg)
 4e7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 4ea:	89 c8                	mov    %ecx,%eax
 4ec:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 4ef:	85 d2                	test   %edx,%edx
 4f1:	74 08                	je     4fb <printint+0x5b>
    buf[i++] = '-';
 4f3:	8d 4f 02             	lea    0x2(%edi),%ecx
 4f6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 4fb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 4fe:	66 90                	xchg   %ax,%ax
 500:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 505:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 508:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 50f:	00 
 510:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 514:	89 34 24             	mov    %esi,(%esp)
 517:	88 45 d7             	mov    %al,-0x29(%ebp)
 51a:	e8 e3 fe ff ff       	call   402 <write>
  while(--i >= 0)
 51f:	83 ff ff             	cmp    $0xffffffff,%edi
 522:	75 dc                	jne    500 <printint+0x60>
    putc(fd, buf[i]);
}
 524:	83 c4 4c             	add    $0x4c,%esp
 527:	5b                   	pop    %ebx
 528:	5e                   	pop    %esi
 529:	5f                   	pop    %edi
 52a:	5d                   	pop    %ebp
 52b:	c3                   	ret    
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 530:	89 d0                	mov    %edx,%eax
 532:	f7 d8                	neg    %eax
    neg = 1;
 534:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 53b:	eb 87                	jmp    4c4 <printint+0x24>
 53d:	8d 76 00             	lea    0x0(%esi),%esi

00000540 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 544:	31 ff                	xor    %edi,%edi
{
 546:	56                   	push   %esi
 547:	53                   	push   %ebx
 548:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 54b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 54e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 551:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 554:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 557:	0f b6 13             	movzbl (%ebx),%edx
 55a:	83 c3 01             	add    $0x1,%ebx
 55d:	84 d2                	test   %dl,%dl
 55f:	75 39                	jne    59a <printf+0x5a>
 561:	e9 ca 00 00 00       	jmp    630 <printf+0xf0>
 566:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 568:	83 fa 25             	cmp    $0x25,%edx
 56b:	0f 84 c7 00 00 00    	je     638 <printf+0xf8>
  write(fd, &c, 1);
 571:	8d 45 e0             	lea    -0x20(%ebp),%eax
 574:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 57b:	00 
 57c:	89 44 24 04          	mov    %eax,0x4(%esp)
 580:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 583:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 586:	e8 77 fe ff ff       	call   402 <write>
 58b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 58e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 592:	84 d2                	test   %dl,%dl
 594:	0f 84 96 00 00 00    	je     630 <printf+0xf0>
    if(state == 0){
 59a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 59c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 59f:	74 c7                	je     568 <printf+0x28>
      }
    } else if(state == '%'){
 5a1:	83 ff 25             	cmp    $0x25,%edi
 5a4:	75 e5                	jne    58b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 5a6:	83 fa 75             	cmp    $0x75,%edx
 5a9:	0f 84 99 00 00 00    	je     648 <printf+0x108>
 5af:	83 fa 64             	cmp    $0x64,%edx
 5b2:	0f 84 90 00 00 00    	je     648 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5b8:	25 f7 00 00 00       	and    $0xf7,%eax
 5bd:	83 f8 70             	cmp    $0x70,%eax
 5c0:	0f 84 aa 00 00 00    	je     670 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5c6:	83 fa 73             	cmp    $0x73,%edx
 5c9:	0f 84 e9 00 00 00    	je     6b8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cf:	83 fa 63             	cmp    $0x63,%edx
 5d2:	0f 84 2b 01 00 00    	je     703 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5d8:	83 fa 25             	cmp    $0x25,%edx
 5db:	0f 84 4f 01 00 00    	je     730 <printf+0x1f0>
  write(fd, &c, 1);
 5e1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5e4:	83 c3 01             	add    $0x1,%ebx
 5e7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ee:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ef:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f5:	89 34 24             	mov    %esi,(%esp)
 5f8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5fb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 5ff:	e8 fe fd ff ff       	call   402 <write>
        putc(fd, c);
 604:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 607:	8d 45 e7             	lea    -0x19(%ebp),%eax
 60a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 611:	00 
 612:	89 44 24 04          	mov    %eax,0x4(%esp)
 616:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 619:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 61c:	e8 e1 fd ff ff       	call   402 <write>
  for(i = 0; fmt[i]; i++){
 621:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 625:	84 d2                	test   %dl,%dl
 627:	0f 85 6d ff ff ff    	jne    59a <printf+0x5a>
 62d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 630:	83 c4 3c             	add    $0x3c,%esp
 633:	5b                   	pop    %ebx
 634:	5e                   	pop    %esi
 635:	5f                   	pop    %edi
 636:	5d                   	pop    %ebp
 637:	c3                   	ret    
        state = '%';
 638:	bf 25 00 00 00       	mov    $0x25,%edi
 63d:	e9 49 ff ff ff       	jmp    58b <printf+0x4b>
 642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 648:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 64f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 654:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 657:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 659:	8b 10                	mov    (%eax),%edx
 65b:	89 f0                	mov    %esi,%eax
 65d:	e8 3e fe ff ff       	call   4a0 <printint>
        ap++;
 662:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 666:	e9 20 ff ff ff       	jmp    58b <printf+0x4b>
 66b:	90                   	nop
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 670:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 673:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 67a:	00 
 67b:	89 44 24 04          	mov    %eax,0x4(%esp)
 67f:	89 34 24             	mov    %esi,(%esp)
 682:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 686:	e8 77 fd ff ff       	call   402 <write>
 68b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 68e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 695:	00 
 696:	89 44 24 04          	mov    %eax,0x4(%esp)
 69a:	89 34 24             	mov    %esi,(%esp)
 69d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 6a1:	e8 5c fd ff ff       	call   402 <write>
        printint(fd, *ap, 16, 0);
 6a6:	b9 10 00 00 00       	mov    $0x10,%ecx
 6ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6b2:	eb a0                	jmp    654 <printf+0x114>
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 6bb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 6bf:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 6c1:	b8 f6 08 00 00       	mov    $0x8f6,%eax
 6c6:	85 ff                	test   %edi,%edi
 6c8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 6cb:	0f b6 07             	movzbl (%edi),%eax
 6ce:	84 c0                	test   %al,%al
 6d0:	74 2a                	je     6fc <printf+0x1bc>
 6d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6d8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6db:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 6de:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 6e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6e8:	00 
 6e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ed:	89 34 24             	mov    %esi,(%esp)
 6f0:	e8 0d fd ff ff       	call   402 <write>
        while(*s != 0){
 6f5:	0f b6 07             	movzbl (%edi),%eax
 6f8:	84 c0                	test   %al,%al
 6fa:	75 dc                	jne    6d8 <printf+0x198>
      state = 0;
 6fc:	31 ff                	xor    %edi,%edi
 6fe:	e9 88 fe ff ff       	jmp    58b <printf+0x4b>
        putc(fd, *ap);
 703:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 706:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 708:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 70a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 711:	00 
 712:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 715:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 718:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 71b:	89 44 24 04          	mov    %eax,0x4(%esp)
 71f:	e8 de fc ff ff       	call   402 <write>
        ap++;
 724:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 728:	e9 5e fe ff ff       	jmp    58b <printf+0x4b>
 72d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 730:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 733:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 735:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 73c:	00 
 73d:	89 44 24 04          	mov    %eax,0x4(%esp)
 741:	89 34 24             	mov    %esi,(%esp)
 744:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 748:	e8 b5 fc ff ff       	call   402 <write>
 74d:	e9 39 fe ff ff       	jmp    58b <printf+0x4b>
 752:	66 90                	xchg   %ax,%ax
 754:	66 90                	xchg   %ax,%ax
 756:	66 90                	xchg   %ax,%ax
 758:	66 90                	xchg   %ax,%ax
 75a:	66 90                	xchg   %ax,%ax
 75c:	66 90                	xchg   %ax,%ax
 75e:	66 90                	xchg   %ax,%ax

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 761:	a1 a0 0b 00 00       	mov    0xba0,%eax
{
 766:	89 e5                	mov    %esp,%ebp
 768:	57                   	push   %edi
 769:	56                   	push   %esi
 76a:	53                   	push   %ebx
 76b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 770:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 773:	39 d0                	cmp    %edx,%eax
 775:	72 11                	jb     788 <free+0x28>
 777:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	39 c8                	cmp    %ecx,%eax
 77a:	72 04                	jb     780 <free+0x20>
 77c:	39 ca                	cmp    %ecx,%edx
 77e:	72 10                	jb     790 <free+0x30>
 780:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 782:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 784:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 786:	73 f0                	jae    778 <free+0x18>
 788:	39 ca                	cmp    %ecx,%edx
 78a:	72 04                	jb     790 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78c:	39 c8                	cmp    %ecx,%eax
 78e:	72 f0                	jb     780 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 790:	8b 73 fc             	mov    -0x4(%ebx),%esi
 793:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 796:	39 cf                	cmp    %ecx,%edi
 798:	74 1e                	je     7b8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 79a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 48 04             	mov    0x4(%eax),%ecx
 7a0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7a3:	39 f2                	cmp    %esi,%edx
 7a5:	74 28                	je     7cf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7a7:	89 10                	mov    %edx,(%eax)
  freep = p;
 7a9:	a3 a0 0b 00 00       	mov    %eax,0xba0
}
 7ae:	5b                   	pop    %ebx
 7af:	5e                   	pop    %esi
 7b0:	5f                   	pop    %edi
 7b1:	5d                   	pop    %ebp
 7b2:	c3                   	ret    
 7b3:	90                   	nop
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7b8:	03 71 04             	add    0x4(%ecx),%esi
 7bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7be:	8b 08                	mov    (%eax),%ecx
 7c0:	8b 09                	mov    (%ecx),%ecx
 7c2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7c5:	8b 48 04             	mov    0x4(%eax),%ecx
 7c8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7cb:	39 f2                	cmp    %esi,%edx
 7cd:	75 d8                	jne    7a7 <free+0x47>
    p->s.size += bp->s.size;
 7cf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 7d2:	a3 a0 0b 00 00       	mov    %eax,0xba0
    p->s.size += bp->s.size;
 7d7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7da:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7dd:	89 10                	mov    %edx,(%eax)
}
 7df:	5b                   	pop    %ebx
 7e0:	5e                   	pop    %esi
 7e1:	5f                   	pop    %edi
 7e2:	5d                   	pop    %ebp
 7e3:	c3                   	ret    
 7e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7fc:	8b 1d a0 0b 00 00    	mov    0xba0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	8d 48 07             	lea    0x7(%eax),%ecx
 805:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 808:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 80a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 80d:	0f 84 9b 00 00 00    	je     8ae <malloc+0xbe>
 813:	8b 13                	mov    (%ebx),%edx
 815:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 818:	39 fe                	cmp    %edi,%esi
 81a:	76 64                	jbe    880 <malloc+0x90>
 81c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 823:	bb 00 80 00 00       	mov    $0x8000,%ebx
 828:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 82b:	eb 0e                	jmp    83b <malloc+0x4b>
 82d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 830:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 832:	8b 78 04             	mov    0x4(%eax),%edi
 835:	39 fe                	cmp    %edi,%esi
 837:	76 4f                	jbe    888 <malloc+0x98>
 839:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 83b:	3b 15 a0 0b 00 00    	cmp    0xba0,%edx
 841:	75 ed                	jne    830 <malloc+0x40>
  if(nu < 4096)
 843:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 846:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 84c:	bf 00 10 00 00       	mov    $0x1000,%edi
 851:	0f 43 fe             	cmovae %esi,%edi
 854:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 857:	89 04 24             	mov    %eax,(%esp)
 85a:	e8 0b fc ff ff       	call   46a <sbrk>
  if(p == (char*)-1)
 85f:	83 f8 ff             	cmp    $0xffffffff,%eax
 862:	74 18                	je     87c <malloc+0x8c>
  hp->s.size = nu;
 864:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 867:	83 c0 08             	add    $0x8,%eax
 86a:	89 04 24             	mov    %eax,(%esp)
 86d:	e8 ee fe ff ff       	call   760 <free>
  return freep;
 872:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
      if((p = morecore(nunits)) == 0)
 878:	85 d2                	test   %edx,%edx
 87a:	75 b4                	jne    830 <malloc+0x40>
        return 0;
 87c:	31 c0                	xor    %eax,%eax
 87e:	eb 20                	jmp    8a0 <malloc+0xb0>
    if(p->s.size >= nunits){
 880:	89 d0                	mov    %edx,%eax
 882:	89 da                	mov    %ebx,%edx
 884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 888:	39 fe                	cmp    %edi,%esi
 88a:	74 1c                	je     8a8 <malloc+0xb8>
        p->s.size -= nunits;
 88c:	29 f7                	sub    %esi,%edi
 88e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 891:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 894:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 897:	89 15 a0 0b 00 00    	mov    %edx,0xba0
      return (void*)(p + 1);
 89d:	83 c0 08             	add    $0x8,%eax
  }
}
 8a0:	83 c4 1c             	add    $0x1c,%esp
 8a3:	5b                   	pop    %ebx
 8a4:	5e                   	pop    %esi
 8a5:	5f                   	pop    %edi
 8a6:	5d                   	pop    %ebp
 8a7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 8a8:	8b 08                	mov    (%eax),%ecx
 8aa:	89 0a                	mov    %ecx,(%edx)
 8ac:	eb e9                	jmp    897 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 8ae:	c7 05 a0 0b 00 00 a4 	movl   $0xba4,0xba0
 8b5:	0b 00 00 
    base.s.size = 0;
 8b8:	ba a4 0b 00 00       	mov    $0xba4,%edx
    base.s.ptr = freep = prevp = &base;
 8bd:	c7 05 a4 0b 00 00 a4 	movl   $0xba4,0xba4
 8c4:	0b 00 00 
    base.s.size = 0;
 8c7:	c7 05 a8 0b 00 00 00 	movl   $0x0,0xba8
 8ce:	00 00 00 
 8d1:	e9 46 ff ff ff       	jmp    81c <malloc+0x2c>
