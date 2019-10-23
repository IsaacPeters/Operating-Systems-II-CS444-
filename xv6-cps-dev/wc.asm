
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  1b:	7e 60                	jle    7d <main+0x7d>
  1d:	8d 76 00             	lea    0x0(%esi),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 c0 03 00 00       	call   3f2 <open>
  32:	85 c0                	test   %eax,%eax
  34:	89 c7                	mov    %eax,%edi
  36:	78 26                	js     5e <main+0x5e>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  38:	8b 13                	mov    (%ebx),%edx
  for(i = 1; i < argc; i++){
  3a:	83 c6 01             	add    $0x1,%esi
  3d:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
  40:	89 04 24             	mov    %eax,(%esp)
  43:	89 54 24 04          	mov    %edx,0x4(%esp)
  47:	e8 54 00 00 00       	call   a0 <wc>
    close(fd);
  4c:	89 3c 24             	mov    %edi,(%esp)
  4f:	e8 86 03 00 00       	call   3da <close>
  for(i = 1; i < argc; i++){
  54:	3b 75 08             	cmp    0x8(%ebp),%esi
  57:	75 c7                	jne    20 <main+0x20>
  }
  exit();
  59:	e8 54 03 00 00       	call   3b2 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  5e:	8b 03                	mov    (%ebx),%eax
  60:	c7 44 24 04 d9 08 00 	movl   $0x8d9,0x4(%esp)
  67:	00 
  68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6f:	89 44 24 08          	mov    %eax,0x8(%esp)
  73:	e8 a8 04 00 00       	call   520 <printf>
      exit();
  78:	e8 35 03 00 00       	call   3b2 <exit>
    wc(0, "");
  7d:	c7 44 24 04 cb 08 00 	movl   $0x8cb,0x4(%esp)
  84:	00 
  85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8c:	e8 0f 00 00 00       	call   a0 <wc>
    exit();
  91:	e8 1c 03 00 00       	call   3b2 <exit>
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  inword = 0;
  a5:	31 f6                	xor    %esi,%esi
{
  a7:	53                   	push   %ebx
  l = w = c = 0;
  a8:	31 db                	xor    %ebx,%ebx
{
  aa:	83 ec 3c             	sub    $0x3c,%esp
  l = w = c = 0;
  ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  ca:	00 
  cb:	c7 44 24 04 e0 0b 00 	movl   $0xbe0,0x4(%esp)
  d2:	00 
  d3:	89 04 24             	mov    %eax,(%esp)
  d6:	e8 ef 02 00 00       	call   3ca <read>
  db:	83 f8 00             	cmp    $0x0,%eax
  de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  e1:	7e 54                	jle    137 <wc+0x97>
  e3:	31 ff                	xor    %edi,%edi
  e5:	eb 0b                	jmp    f2 <wc+0x52>
  e7:	90                   	nop
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
  f0:	74 38                	je     12a <wc+0x8a>
      if(buf[i] == '\n')
  f2:	0f be 87 e0 0b 00 00 	movsbl 0xbe0(%edi),%eax
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
  fb:	c7 04 24 b6 08 00 00 	movl   $0x8b6,(%esp)
        l++;
 102:	3c 0a                	cmp    $0xa,%al
 104:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 107:	89 44 24 04          	mov    %eax,0x4(%esp)
        l++;
 10b:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10d:	e8 4e 01 00 00       	call   260 <strchr>
 112:	85 c0                	test   %eax,%eax
 114:	75 d2                	jne    e8 <wc+0x48>
      else if(!inword){
 116:	85 f6                	test   %esi,%esi
 118:	75 16                	jne    130 <wc+0x90>
        w++;
 11a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    for(i=0; i<n; i++){
 11e:	83 c7 01             	add    $0x1,%edi
 121:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
        inword = 1;
 124:	66 be 01 00          	mov    $0x1,%si
    for(i=0; i<n; i++){
 128:	75 c8                	jne    f2 <wc+0x52>
 12a:	01 7d dc             	add    %edi,-0x24(%ebp)
 12d:	eb 91                	jmp    c0 <wc+0x20>
 12f:	90                   	nop
 130:	be 01 00 00 00       	mov    $0x1,%esi
 135:	eb b3                	jmp    ea <wc+0x4a>
  if(n < 0){
 137:	75 35                	jne    16e <wc+0xce>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 139:	8b 45 0c             	mov    0xc(%ebp),%eax
 13c:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 140:	c7 44 24 04 cc 08 00 	movl   $0x8cc,0x4(%esp)
 147:	00 
 148:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 14f:	89 44 24 14          	mov    %eax,0x14(%esp)
 153:	8b 45 dc             	mov    -0x24(%ebp),%eax
 156:	89 44 24 10          	mov    %eax,0x10(%esp)
 15a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 15d:	89 44 24 0c          	mov    %eax,0xc(%esp)
 161:	e8 ba 03 00 00       	call   520 <printf>
}
 166:	83 c4 3c             	add    $0x3c,%esp
 169:	5b                   	pop    %ebx
 16a:	5e                   	pop    %esi
 16b:	5f                   	pop    %edi
 16c:	5d                   	pop    %ebp
 16d:	c3                   	ret    
    printf(1, "wc: read error\n");
 16e:	c7 44 24 04 bc 08 00 	movl   $0x8bc,0x4(%esp)
 175:	00 
 176:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 17d:	e8 9e 03 00 00       	call   520 <printf>
    exit();
 182:	e8 2b 02 00 00       	call   3b2 <exit>
 187:	66 90                	xchg   %ax,%ax
 189:	66 90                	xchg   %ax,%ax
 18b:	66 90                	xchg   %ax,%ax
 18d:	66 90                	xchg   %ax,%ax
 18f:	90                   	nop

00000190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 199:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 19a:	89 c2                	mov    %eax,%edx
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	83 c1 01             	add    $0x1,%ecx
 1a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1a7:	83 c2 01             	add    $0x1,%edx
 1aa:	84 db                	test   %bl,%bl
 1ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 1af:	75 ef                	jne    1a0 <strcpy+0x10>
    ;
  return os;
}
 1b1:	5b                   	pop    %ebx
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
 1c6:	53                   	push   %ebx
 1c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ca:	0f b6 02             	movzbl (%edx),%eax
 1cd:	84 c0                	test   %al,%al
 1cf:	74 2d                	je     1fe <strcmp+0x3e>
 1d1:	0f b6 19             	movzbl (%ecx),%ebx
 1d4:	38 d8                	cmp    %bl,%al
 1d6:	74 0e                	je     1e6 <strcmp+0x26>
 1d8:	eb 2b                	jmp    205 <strcmp+0x45>
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e0:	38 c8                	cmp    %cl,%al
 1e2:	75 15                	jne    1f9 <strcmp+0x39>
    p++, q++;
 1e4:	89 d9                	mov    %ebx,%ecx
 1e6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1e9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1ec:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1ef:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1f3:	84 c0                	test   %al,%al
 1f5:	75 e9                	jne    1e0 <strcmp+0x20>
 1f7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1f9:	29 c8                	sub    %ecx,%eax
}
 1fb:	5b                   	pop    %ebx
 1fc:	5d                   	pop    %ebp
 1fd:	c3                   	ret    
 1fe:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 201:	31 c0                	xor    %eax,%eax
 203:	eb f4                	jmp    1f9 <strcmp+0x39>
 205:	0f b6 cb             	movzbl %bl,%ecx
 208:	eb ef                	jmp    1f9 <strcmp+0x39>
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 39 00             	cmpb   $0x0,(%ecx)
 219:	74 12                	je     22d <strlen+0x1d>
 21b:	31 d2                	xor    %edx,%edx
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c2 01             	add    $0x1,%edx
 223:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 227:	89 d0                	mov    %edx,%eax
 229:	75 f5                	jne    220 <strlen+0x10>
    ;
  return n;
}
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 22d:	31 c0                	xor    %eax,%eax
}
 22f:	5d                   	pop    %ebp
 230:	c3                   	ret    
 231:	eb 0d                	jmp    240 <memset>
 233:	90                   	nop
 234:	90                   	nop
 235:	90                   	nop
 236:	90                   	nop
 237:	90                   	nop
 238:	90                   	nop
 239:	90                   	nop
 23a:	90                   	nop
 23b:	90                   	nop
 23c:	90                   	nop
 23d:	90                   	nop
 23e:	90                   	nop
 23f:	90                   	nop

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 55 08             	mov    0x8(%ebp),%edx
 246:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld    
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	89 d0                	mov    %edx,%eax
 254:	5f                   	pop    %edi
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	53                   	push   %ebx
 267:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 26a:	0f b6 18             	movzbl (%eax),%ebx
 26d:	84 db                	test   %bl,%bl
 26f:	74 1d                	je     28e <strchr+0x2e>
    if(*s == c)
 271:	38 d3                	cmp    %dl,%bl
 273:	89 d1                	mov    %edx,%ecx
 275:	75 0d                	jne    284 <strchr+0x24>
 277:	eb 17                	jmp    290 <strchr+0x30>
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 280:	38 ca                	cmp    %cl,%dl
 282:	74 0c                	je     290 <strchr+0x30>
  for(; *s; s++)
 284:	83 c0 01             	add    $0x1,%eax
 287:	0f b6 10             	movzbl (%eax),%edx
 28a:	84 d2                	test   %dl,%dl
 28c:	75 f2                	jne    280 <strchr+0x20>
      return (char*)s;
  return 0;
 28e:	31 c0                	xor    %eax,%eax
}
 290:	5b                   	pop    %ebx
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    
 293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a5:	31 f6                	xor    %esi,%esi
{
 2a7:	53                   	push   %ebx
 2a8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 2ab:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 2ae:	eb 31                	jmp    2e1 <gets+0x41>
    cc = read(0, &c, 1);
 2b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2b7:	00 
 2b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2c3:	e8 02 01 00 00       	call   3ca <read>
    if(cc < 1)
 2c8:	85 c0                	test   %eax,%eax
 2ca:	7e 1d                	jle    2e9 <gets+0x49>
      break;
    buf[i++] = c;
 2cc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 2d0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 2d2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2d5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 2d7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2db:	74 0c                	je     2e9 <gets+0x49>
 2dd:	3c 0a                	cmp    $0xa,%al
 2df:	74 08                	je     2e9 <gets+0x49>
  for(i=0; i+1 < max; ){
 2e1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2e7:	7c c7                	jl     2b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2e9:	8b 45 08             	mov    0x8(%ebp),%eax
 2ec:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2f0:	83 c4 2c             	add    $0x2c,%esp
 2f3:	5b                   	pop    %ebx
 2f4:	5e                   	pop    %esi
 2f5:	5f                   	pop    %edi
 2f6:	5d                   	pop    %ebp
 2f7:	c3                   	ret    
 2f8:	90                   	nop
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
 305:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 312:	00 
 313:	89 04 24             	mov    %eax,(%esp)
 316:	e8 d7 00 00 00       	call   3f2 <open>
  if(fd < 0)
 31b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 31d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 31f:	78 27                	js     348 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 321:	8b 45 0c             	mov    0xc(%ebp),%eax
 324:	89 1c 24             	mov    %ebx,(%esp)
 327:	89 44 24 04          	mov    %eax,0x4(%esp)
 32b:	e8 da 00 00 00       	call   40a <fstat>
  close(fd);
 330:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 333:	89 c6                	mov    %eax,%esi
  close(fd);
 335:	e8 a0 00 00 00       	call   3da <close>
  return r;
 33a:	89 f0                	mov    %esi,%eax
}
 33c:	83 c4 10             	add    $0x10,%esp
 33f:	5b                   	pop    %ebx
 340:	5e                   	pop    %esi
 341:	5d                   	pop    %ebp
 342:	c3                   	ret    
 343:	90                   	nop
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 348:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 34d:	eb ed                	jmp    33c <stat+0x3c>
 34f:	90                   	nop

00000350 <atoi>:

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 4d 08             	mov    0x8(%ebp),%ecx
 356:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 357:	0f be 11             	movsbl (%ecx),%edx
 35a:	8d 42 d0             	lea    -0x30(%edx),%eax
 35d:	3c 09                	cmp    $0x9,%al
  n = 0;
 35f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 364:	77 17                	ja     37d <atoi+0x2d>
 366:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 368:	83 c1 01             	add    $0x1,%ecx
 36b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 36e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 372:	0f be 11             	movsbl (%ecx),%edx
 375:	8d 5a d0             	lea    -0x30(%edx),%ebx
 378:	80 fb 09             	cmp    $0x9,%bl
 37b:	76 eb                	jbe    368 <atoi+0x18>
  return n;
}
 37d:	5b                   	pop    %ebx
 37e:	5d                   	pop    %ebp
 37f:	c3                   	ret    

00000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 380:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 381:	31 d2                	xor    %edx,%edx
{
 383:	89 e5                	mov    %esp,%ebp
 385:	56                   	push   %esi
 386:	8b 45 08             	mov    0x8(%ebp),%eax
 389:	53                   	push   %ebx
 38a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 38d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 390:	85 db                	test   %ebx,%ebx
 392:	7e 12                	jle    3a6 <memmove+0x26>
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 398:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 39c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 39f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3a2:	39 da                	cmp    %ebx,%edx
 3a4:	75 f2                	jne    398 <memmove+0x18>
  return vdst;
}
 3a6:	5b                   	pop    %ebx
 3a7:	5e                   	pop    %esi
 3a8:	5d                   	pop    %ebp
 3a9:	c3                   	ret    

000003aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3aa:	b8 01 00 00 00       	mov    $0x1,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <exit>:
SYSCALL(exit)
 3b2:	b8 02 00 00 00       	mov    $0x2,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <wait>:
SYSCALL(wait)
 3ba:	b8 03 00 00 00       	mov    $0x3,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <pipe>:
SYSCALL(pipe)
 3c2:	b8 04 00 00 00       	mov    $0x4,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <read>:
SYSCALL(read)
 3ca:	b8 05 00 00 00       	mov    $0x5,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <write>:
SYSCALL(write)
 3d2:	b8 10 00 00 00       	mov    $0x10,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <close>:
SYSCALL(close)
 3da:	b8 15 00 00 00       	mov    $0x15,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <kill>:
SYSCALL(kill)
 3e2:	b8 06 00 00 00       	mov    $0x6,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <exec>:
SYSCALL(exec)
 3ea:	b8 07 00 00 00       	mov    $0x7,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <open>:
SYSCALL(open)
 3f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mknod>:
SYSCALL(mknod)
 3fa:	b8 11 00 00 00       	mov    $0x11,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <unlink>:
SYSCALL(unlink)
 402:	b8 12 00 00 00       	mov    $0x12,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <fstat>:
SYSCALL(fstat)
 40a:	b8 08 00 00 00       	mov    $0x8,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <link>:
SYSCALL(link)
 412:	b8 13 00 00 00       	mov    $0x13,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <mkdir>:
SYSCALL(mkdir)
 41a:	b8 14 00 00 00       	mov    $0x14,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <chdir>:
SYSCALL(chdir)
 422:	b8 09 00 00 00       	mov    $0x9,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <dup>:
SYSCALL(dup)
 42a:	b8 0a 00 00 00       	mov    $0xa,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <getpid>:
SYSCALL(getpid)
 432:	b8 0b 00 00 00       	mov    $0xb,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <sbrk>:
SYSCALL(sbrk)
 43a:	b8 0c 00 00 00       	mov    $0xc,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <sleep>:
SYSCALL(sleep)
 442:	b8 0d 00 00 00       	mov    $0xd,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <uptime>:
SYSCALL(uptime)
 44a:	b8 0e 00 00 00       	mov    $0xe,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 452:	b8 16 00 00 00       	mov    $0x16,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 45a:	b8 17 00 00 00       	mov    $0x17,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 462:	b8 18 00 00 00       	mov    $0x18,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <halt>:
 46a:	b8 19 00 00 00       	mov    $0x19,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    
 472:	66 90                	xchg   %ax,%ax
 474:	66 90                	xchg   %ax,%ax
 476:	66 90                	xchg   %ax,%ax
 478:	66 90                	xchg   %ax,%ax
 47a:	66 90                	xchg   %ax,%ax
 47c:	66 90                	xchg   %ax,%ax
 47e:	66 90                	xchg   %ax,%ax

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	89 c6                	mov    %eax,%esi
 487:	53                   	push   %ebx
 488:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 48b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 48e:	85 db                	test   %ebx,%ebx
 490:	74 09                	je     49b <printint+0x1b>
 492:	89 d0                	mov    %edx,%eax
 494:	c1 e8 1f             	shr    $0x1f,%eax
 497:	84 c0                	test   %al,%al
 499:	75 75                	jne    510 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 49b:	89 d0                	mov    %edx,%eax
  neg = 0;
 49d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4a4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 4a7:	31 ff                	xor    %edi,%edi
 4a9:	89 ce                	mov    %ecx,%esi
 4ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ae:	eb 02                	jmp    4b2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 4b0:	89 cf                	mov    %ecx,%edi
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	f7 f6                	div    %esi
 4b6:	8d 4f 01             	lea    0x1(%edi),%ecx
 4b9:	0f b6 92 f4 08 00 00 	movzbl 0x8f4(%edx),%edx
  }while((x /= base) != 0);
 4c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4c2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4c5:	75 e9                	jne    4b0 <printint+0x30>
  if(neg)
 4c7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 4ca:	89 c8                	mov    %ecx,%eax
 4cc:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 4cf:	85 d2                	test   %edx,%edx
 4d1:	74 08                	je     4db <printint+0x5b>
    buf[i++] = '-';
 4d3:	8d 4f 02             	lea    0x2(%edi),%ecx
 4d6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 4db:	8d 79 ff             	lea    -0x1(%ecx),%edi
 4de:	66 90                	xchg   %ax,%ax
 4e0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 4e5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 4e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ef:	00 
 4f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4f4:	89 34 24             	mov    %esi,(%esp)
 4f7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4fa:	e8 d3 fe ff ff       	call   3d2 <write>
  while(--i >= 0)
 4ff:	83 ff ff             	cmp    $0xffffffff,%edi
 502:	75 dc                	jne    4e0 <printint+0x60>
    putc(fd, buf[i]);
}
 504:	83 c4 4c             	add    $0x4c,%esp
 507:	5b                   	pop    %ebx
 508:	5e                   	pop    %esi
 509:	5f                   	pop    %edi
 50a:	5d                   	pop    %ebp
 50b:	c3                   	ret    
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 510:	89 d0                	mov    %edx,%eax
 512:	f7 d8                	neg    %eax
    neg = 1;
 514:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 51b:	eb 87                	jmp    4a4 <printint+0x24>
 51d:	8d 76 00             	lea    0x0(%esi),%esi

00000520 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 524:	31 ff                	xor    %edi,%edi
{
 526:	56                   	push   %esi
 527:	53                   	push   %ebx
 528:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 52b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 52e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 531:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 534:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 537:	0f b6 13             	movzbl (%ebx),%edx
 53a:	83 c3 01             	add    $0x1,%ebx
 53d:	84 d2                	test   %dl,%dl
 53f:	75 39                	jne    57a <printf+0x5a>
 541:	e9 ca 00 00 00       	jmp    610 <printf+0xf0>
 546:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 548:	83 fa 25             	cmp    $0x25,%edx
 54b:	0f 84 c7 00 00 00    	je     618 <printf+0xf8>
  write(fd, &c, 1);
 551:	8d 45 e0             	lea    -0x20(%ebp),%eax
 554:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 55b:	00 
 55c:	89 44 24 04          	mov    %eax,0x4(%esp)
 560:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 563:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 566:	e8 67 fe ff ff       	call   3d2 <write>
 56b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 56e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 572:	84 d2                	test   %dl,%dl
 574:	0f 84 96 00 00 00    	je     610 <printf+0xf0>
    if(state == 0){
 57a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 57c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 57f:	74 c7                	je     548 <printf+0x28>
      }
    } else if(state == '%'){
 581:	83 ff 25             	cmp    $0x25,%edi
 584:	75 e5                	jne    56b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 586:	83 fa 75             	cmp    $0x75,%edx
 589:	0f 84 99 00 00 00    	je     628 <printf+0x108>
 58f:	83 fa 64             	cmp    $0x64,%edx
 592:	0f 84 90 00 00 00    	je     628 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 598:	25 f7 00 00 00       	and    $0xf7,%eax
 59d:	83 f8 70             	cmp    $0x70,%eax
 5a0:	0f 84 aa 00 00 00    	je     650 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5a6:	83 fa 73             	cmp    $0x73,%edx
 5a9:	0f 84 e9 00 00 00    	je     698 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5af:	83 fa 63             	cmp    $0x63,%edx
 5b2:	0f 84 2b 01 00 00    	je     6e3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5b8:	83 fa 25             	cmp    $0x25,%edx
 5bb:	0f 84 4f 01 00 00    	je     710 <printf+0x1f0>
  write(fd, &c, 1);
 5c1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5c4:	83 c3 01             	add    $0x1,%ebx
 5c7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ce:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5cf:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d5:	89 34 24             	mov    %esi,(%esp)
 5d8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5db:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 5df:	e8 ee fd ff ff       	call   3d2 <write>
        putc(fd, c);
 5e4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 5e7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5f1:	00 
 5f2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 5f9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5fc:	e8 d1 fd ff ff       	call   3d2 <write>
  for(i = 0; fmt[i]; i++){
 601:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 605:	84 d2                	test   %dl,%dl
 607:	0f 85 6d ff ff ff    	jne    57a <printf+0x5a>
 60d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 610:	83 c4 3c             	add    $0x3c,%esp
 613:	5b                   	pop    %ebx
 614:	5e                   	pop    %esi
 615:	5f                   	pop    %edi
 616:	5d                   	pop    %ebp
 617:	c3                   	ret    
        state = '%';
 618:	bf 25 00 00 00       	mov    $0x25,%edi
 61d:	e9 49 ff ff ff       	jmp    56b <printf+0x4b>
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 628:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 62f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 634:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 637:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 639:	8b 10                	mov    (%eax),%edx
 63b:	89 f0                	mov    %esi,%eax
 63d:	e8 3e fe ff ff       	call   480 <printint>
        ap++;
 642:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 646:	e9 20 ff ff ff       	jmp    56b <printf+0x4b>
 64b:	90                   	nop
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 650:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 653:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 65a:	00 
 65b:	89 44 24 04          	mov    %eax,0x4(%esp)
 65f:	89 34 24             	mov    %esi,(%esp)
 662:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 666:	e8 67 fd ff ff       	call   3d2 <write>
 66b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 66e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 675:	00 
 676:	89 44 24 04          	mov    %eax,0x4(%esp)
 67a:	89 34 24             	mov    %esi,(%esp)
 67d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 681:	e8 4c fd ff ff       	call   3d2 <write>
        printint(fd, *ap, 16, 0);
 686:	b9 10 00 00 00       	mov    $0x10,%ecx
 68b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 692:	eb a0                	jmp    634 <printf+0x114>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 698:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 69b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 69f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 6a1:	b8 ed 08 00 00       	mov    $0x8ed,%eax
 6a6:	85 ff                	test   %edi,%edi
 6a8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 6ab:	0f b6 07             	movzbl (%edi),%eax
 6ae:	84 c0                	test   %al,%al
 6b0:	74 2a                	je     6dc <printf+0x1bc>
 6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6b8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6bb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 6be:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 6c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6c8:	00 
 6c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6cd:	89 34 24             	mov    %esi,(%esp)
 6d0:	e8 fd fc ff ff       	call   3d2 <write>
        while(*s != 0){
 6d5:	0f b6 07             	movzbl (%edi),%eax
 6d8:	84 c0                	test   %al,%al
 6da:	75 dc                	jne    6b8 <printf+0x198>
      state = 0;
 6dc:	31 ff                	xor    %edi,%edi
 6de:	e9 88 fe ff ff       	jmp    56b <printf+0x4b>
        putc(fd, *ap);
 6e3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6e6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 6e8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 6ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6f1:	00 
 6f2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 6f5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6f8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ff:	e8 ce fc ff ff       	call   3d2 <write>
        ap++;
 704:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 708:	e9 5e fe ff ff       	jmp    56b <printf+0x4b>
 70d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 710:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 713:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 715:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 71c:	00 
 71d:	89 44 24 04          	mov    %eax,0x4(%esp)
 721:	89 34 24             	mov    %esi,(%esp)
 724:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 728:	e8 a5 fc ff ff       	call   3d2 <write>
 72d:	e9 39 fe ff ff       	jmp    56b <printf+0x4b>
 732:	66 90                	xchg   %ax,%ax
 734:	66 90                	xchg   %ax,%ax
 736:	66 90                	xchg   %ax,%ax
 738:	66 90                	xchg   %ax,%ax
 73a:	66 90                	xchg   %ax,%ax
 73c:	66 90                	xchg   %ax,%ax
 73e:	66 90                	xchg   %ax,%ax

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	a1 c0 0b 00 00       	mov    0xbc0,%eax
{
 746:	89 e5                	mov    %esp,%ebp
 748:	57                   	push   %edi
 749:	56                   	push   %esi
 74a:	53                   	push   %ebx
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 750:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 753:	39 d0                	cmp    %edx,%eax
 755:	72 11                	jb     768 <free+0x28>
 757:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 758:	39 c8                	cmp    %ecx,%eax
 75a:	72 04                	jb     760 <free+0x20>
 75c:	39 ca                	cmp    %ecx,%edx
 75e:	72 10                	jb     770 <free+0x30>
 760:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 762:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 766:	73 f0                	jae    758 <free+0x18>
 768:	39 ca                	cmp    %ecx,%edx
 76a:	72 04                	jb     770 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	39 c8                	cmp    %ecx,%eax
 76e:	72 f0                	jb     760 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 770:	8b 73 fc             	mov    -0x4(%ebx),%esi
 773:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 776:	39 cf                	cmp    %ecx,%edi
 778:	74 1e                	je     798 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 77a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 77d:	8b 48 04             	mov    0x4(%eax),%ecx
 780:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 783:	39 f2                	cmp    %esi,%edx
 785:	74 28                	je     7af <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 787:	89 10                	mov    %edx,(%eax)
  freep = p;
 789:	a3 c0 0b 00 00       	mov    %eax,0xbc0
}
 78e:	5b                   	pop    %ebx
 78f:	5e                   	pop    %esi
 790:	5f                   	pop    %edi
 791:	5d                   	pop    %ebp
 792:	c3                   	ret    
 793:	90                   	nop
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 798:	03 71 04             	add    0x4(%ecx),%esi
 79b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 79e:	8b 08                	mov    (%eax),%ecx
 7a0:	8b 09                	mov    (%ecx),%ecx
 7a2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7a5:	8b 48 04             	mov    0x4(%eax),%ecx
 7a8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7ab:	39 f2                	cmp    %esi,%edx
 7ad:	75 d8                	jne    787 <free+0x47>
    p->s.size += bp->s.size;
 7af:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 7b2:	a3 c0 0b 00 00       	mov    %eax,0xbc0
    p->s.size += bp->s.size;
 7b7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7ba:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7bd:	89 10                	mov    %edx,(%eax)
}
 7bf:	5b                   	pop    %ebx
 7c0:	5e                   	pop    %esi
 7c1:	5f                   	pop    %edi
 7c2:	5d                   	pop    %ebp
 7c3:	c3                   	ret    
 7c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	57                   	push   %edi
 7d4:	56                   	push   %esi
 7d5:	53                   	push   %ebx
 7d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7dc:	8b 1d c0 0b 00 00    	mov    0xbc0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e2:	8d 48 07             	lea    0x7(%eax),%ecx
 7e5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 7e8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ea:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 7ed:	0f 84 9b 00 00 00    	je     88e <malloc+0xbe>
 7f3:	8b 13                	mov    (%ebx),%edx
 7f5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7f8:	39 fe                	cmp    %edi,%esi
 7fa:	76 64                	jbe    860 <malloc+0x90>
 7fc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 803:	bb 00 80 00 00       	mov    $0x8000,%ebx
 808:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 80b:	eb 0e                	jmp    81b <malloc+0x4b>
 80d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 810:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 812:	8b 78 04             	mov    0x4(%eax),%edi
 815:	39 fe                	cmp    %edi,%esi
 817:	76 4f                	jbe    868 <malloc+0x98>
 819:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 81b:	3b 15 c0 0b 00 00    	cmp    0xbc0,%edx
 821:	75 ed                	jne    810 <malloc+0x40>
  if(nu < 4096)
 823:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 826:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 82c:	bf 00 10 00 00       	mov    $0x1000,%edi
 831:	0f 43 fe             	cmovae %esi,%edi
 834:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 837:	89 04 24             	mov    %eax,(%esp)
 83a:	e8 fb fb ff ff       	call   43a <sbrk>
  if(p == (char*)-1)
 83f:	83 f8 ff             	cmp    $0xffffffff,%eax
 842:	74 18                	je     85c <malloc+0x8c>
  hp->s.size = nu;
 844:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 847:	83 c0 08             	add    $0x8,%eax
 84a:	89 04 24             	mov    %eax,(%esp)
 84d:	e8 ee fe ff ff       	call   740 <free>
  return freep;
 852:	8b 15 c0 0b 00 00    	mov    0xbc0,%edx
      if((p = morecore(nunits)) == 0)
 858:	85 d2                	test   %edx,%edx
 85a:	75 b4                	jne    810 <malloc+0x40>
        return 0;
 85c:	31 c0                	xor    %eax,%eax
 85e:	eb 20                	jmp    880 <malloc+0xb0>
    if(p->s.size >= nunits){
 860:	89 d0                	mov    %edx,%eax
 862:	89 da                	mov    %ebx,%edx
 864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 868:	39 fe                	cmp    %edi,%esi
 86a:	74 1c                	je     888 <malloc+0xb8>
        p->s.size -= nunits;
 86c:	29 f7                	sub    %esi,%edi
 86e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 871:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 874:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 877:	89 15 c0 0b 00 00    	mov    %edx,0xbc0
      return (void*)(p + 1);
 87d:	83 c0 08             	add    $0x8,%eax
  }
}
 880:	83 c4 1c             	add    $0x1c,%esp
 883:	5b                   	pop    %ebx
 884:	5e                   	pop    %esi
 885:	5f                   	pop    %edi
 886:	5d                   	pop    %ebp
 887:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 888:	8b 08                	mov    (%eax),%ecx
 88a:	89 0a                	mov    %ecx,(%edx)
 88c:	eb e9                	jmp    877 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 88e:	c7 05 c0 0b 00 00 c4 	movl   $0xbc4,0xbc0
 895:	0b 00 00 
    base.s.size = 0;
 898:	ba c4 0b 00 00       	mov    $0xbc4,%edx
    base.s.ptr = freep = prevp = &base;
 89d:	c7 05 c4 0b 00 00 c4 	movl   $0xbc4,0xbc4
 8a4:	0b 00 00 
    base.s.size = 0;
 8a7:	c7 05 c8 0b 00 00 00 	movl   $0x0,0xbc8
 8ae:	00 00 00 
 8b1:	e9 46 ff ff ff       	jmp    7fc <malloc+0x2c>
