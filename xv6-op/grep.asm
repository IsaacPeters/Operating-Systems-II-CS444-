
_grep:     file format elf32-i386


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
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
   c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
   f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  13:	0f 8e 8b 00 00 00    	jle    a4 <main+0xa4>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  19:	8b 43 04             	mov    0x4(%ebx),%eax
  1c:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  1f:	be 02 00 00 00       	mov    $0x2,%esi
  24:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  pattern = argv[1];
  28:	89 44 24 0c          	mov    %eax,0xc(%esp)
  if(argc <= 2){
  2c:	74 61                	je     8f <main+0x8f>
  2e:	66 90                	xchg   %ax,%ax
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  37:	00 
  38:	8b 03                	mov    (%ebx),%eax
  3a:	89 04 24             	mov    %eax,(%esp)
  3d:	e8 30 05 00 00       	call   572 <open>
  42:	85 c0                	test   %eax,%eax
  44:	89 c7                	mov    %eax,%edi
  46:	78 28                	js     70 <main+0x70>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  48:	89 44 24 04          	mov    %eax,0x4(%esp)
  4c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  for(i = 2; i < argc; i++){
  50:	83 c6 01             	add    $0x1,%esi
  53:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  56:	89 04 24             	mov    %eax,(%esp)
  59:	e8 a2 01 00 00       	call   200 <grep>
    close(fd);
  5e:	89 3c 24             	mov    %edi,(%esp)
  61:	e8 f4 04 00 00       	call   55a <close>
  for(i = 2; i < argc; i++){
  66:	39 75 08             	cmp    %esi,0x8(%ebp)
  69:	7f c5                	jg     30 <main+0x30>
  }
  exit();
  6b:	e8 c2 04 00 00       	call   532 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  70:	8b 03                	mov    (%ebx),%eax
  72:	c7 44 24 04 48 0a 00 	movl   $0xa48,0x4(%esp)
  79:	00 
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	e8 06 06 00 00       	call   690 <printf>
      exit();
  8a:	e8 a3 04 00 00       	call   532 <exit>
    grep(pattern, 0);
  8f:	89 04 24             	mov    %eax,(%esp)
  92:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  99:	00 
  9a:	e8 61 01 00 00       	call   200 <grep>
    exit();
  9f:	e8 8e 04 00 00       	call   532 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  a4:	c7 44 24 04 28 0a 00 	movl   $0xa28,0x4(%esp)
  ab:	00 
  ac:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  b3:	e8 d8 05 00 00       	call   690 <printf>
    exit();
  b8:	e8 75 04 00 00       	call   532 <exit>
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 1c             	sub    $0x1c,%esp
  c9:	8b 75 08             	mov    0x8(%ebp),%esi
  cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cf:	8b 5d 10             	mov    0x10(%ebp),%ebx
  d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  d8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  dc:	89 3c 24             	mov    %edi,(%esp)
  df:	e8 3c 00 00 00       	call   120 <matchhere>
  e4:	85 c0                	test   %eax,%eax
  e6:	75 20                	jne    108 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  e8:	0f be 13             	movsbl (%ebx),%edx
  eb:	84 d2                	test   %dl,%dl
  ed:	74 0c                	je     fb <matchstar+0x3b>
  ef:	83 c3 01             	add    $0x1,%ebx
  f2:	39 f2                	cmp    %esi,%edx
  f4:	74 e2                	je     d8 <matchstar+0x18>
  f6:	83 fe 2e             	cmp    $0x2e,%esi
  f9:	74 dd                	je     d8 <matchstar+0x18>
  return 0;
}
  fb:	83 c4 1c             	add    $0x1c,%esp
  fe:	5b                   	pop    %ebx
  ff:	5e                   	pop    %esi
 100:	5f                   	pop    %edi
 101:	5d                   	pop    %ebp
 102:	c3                   	ret    
 103:	90                   	nop
 104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 108:	83 c4 1c             	add    $0x1c,%esp
      return 1;
 10b:	b8 01 00 00 00       	mov    $0x1,%eax
}
 110:	5b                   	pop    %ebx
 111:	5e                   	pop    %esi
 112:	5f                   	pop    %edi
 113:	5d                   	pop    %ebp
 114:	c3                   	ret    
 115:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <matchhere>:
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	83 ec 14             	sub    $0x14,%esp
 127:	8b 55 08             	mov    0x8(%ebp),%edx
 12a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(re[0] == '\0')
 12d:	0f be 02             	movsbl (%edx),%eax
 130:	84 c0                	test   %al,%al
 132:	75 20                	jne    154 <matchhere+0x34>
 134:	eb 42                	jmp    178 <matchhere+0x58>
 136:	66 90                	xchg   %ax,%ax
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 138:	0f b6 19             	movzbl (%ecx),%ebx
 13b:	84 db                	test   %bl,%bl
 13d:	74 31                	je     170 <matchhere+0x50>
 13f:	3c 2e                	cmp    $0x2e,%al
 141:	74 04                	je     147 <matchhere+0x27>
 143:	38 d8                	cmp    %bl,%al
 145:	75 29                	jne    170 <matchhere+0x50>
    return matchhere(re+1, text+1);
 147:	83 c2 01             	add    $0x1,%edx
  if(re[0] == '\0')
 14a:	0f be 02             	movsbl (%edx),%eax
    return matchhere(re+1, text+1);
 14d:	83 c1 01             	add    $0x1,%ecx
  if(re[0] == '\0')
 150:	84 c0                	test   %al,%al
 152:	74 24                	je     178 <matchhere+0x58>
  if(re[1] == '*')
 154:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
 158:	80 fb 2a             	cmp    $0x2a,%bl
 15b:	74 2b                	je     188 <matchhere+0x68>
  if(re[0] == '$' && re[1] == '\0')
 15d:	3c 24                	cmp    $0x24,%al
 15f:	75 d7                	jne    138 <matchhere+0x18>
 161:	84 db                	test   %bl,%bl
 163:	74 3c                	je     1a1 <matchhere+0x81>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 165:	0f b6 19             	movzbl (%ecx),%ebx
 168:	84 db                	test   %bl,%bl
 16a:	75 d7                	jne    143 <matchhere+0x23>
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 170:	31 c0                	xor    %eax,%eax
}
 172:	83 c4 14             	add    $0x14,%esp
 175:	5b                   	pop    %ebx
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
 178:	83 c4 14             	add    $0x14,%esp
    return 1;
 17b:	b8 01 00 00 00       	mov    $0x1,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	90                   	nop
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchstar(re[0], re+2, text);
 188:	83 c2 02             	add    $0x2,%edx
 18b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 18f:	89 54 24 04          	mov    %edx,0x4(%esp)
 193:	89 04 24             	mov    %eax,(%esp)
 196:	e8 25 ff ff ff       	call   c0 <matchstar>
}
 19b:	83 c4 14             	add    $0x14,%esp
 19e:	5b                   	pop    %ebx
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
    return *text == '\0';
 1a1:	31 c0                	xor    %eax,%eax
 1a3:	80 39 00             	cmpb   $0x0,(%ecx)
 1a6:	0f 94 c0             	sete   %al
 1a9:	eb c7                	jmp    172 <matchhere+0x52>
 1ab:	90                   	nop
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <match>:
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
 1b5:	83 ec 10             	sub    $0x10,%esp
 1b8:	8b 75 08             	mov    0x8(%ebp),%esi
 1bb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1be:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1c1:	75 0e                	jne    1d1 <match+0x21>
 1c3:	eb 28                	jmp    1ed <match+0x3d>
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1c8:	83 c3 01             	add    $0x1,%ebx
 1cb:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1cf:	74 15                	je     1e6 <match+0x36>
    if(matchhere(re, text))
 1d1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 1d5:	89 34 24             	mov    %esi,(%esp)
 1d8:	e8 43 ff ff ff       	call   120 <matchhere>
 1dd:	85 c0                	test   %eax,%eax
 1df:	74 e7                	je     1c8 <match+0x18>
      return 1;
 1e1:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1e6:	83 c4 10             	add    $0x10,%esp
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    
    return matchhere(re+1, text);
 1ed:	83 c6 01             	add    $0x1,%esi
 1f0:	89 75 08             	mov    %esi,0x8(%ebp)
}
 1f3:	83 c4 10             	add    $0x10,%esp
 1f6:	5b                   	pop    %ebx
 1f7:	5e                   	pop    %esi
 1f8:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1f9:	e9 22 ff ff ff       	jmp    120 <matchhere>
 1fe:	66 90                	xchg   %ax,%ax

00000200 <grep>:
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
 206:	83 ec 1c             	sub    $0x1c,%esp
 209:	8b 75 08             	mov    0x8(%ebp),%esi
  m = 0;
 20c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 213:	90                   	nop
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 218:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 21b:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 220:	29 d0                	sub    %edx,%eax
 222:	89 44 24 08          	mov    %eax,0x8(%esp)
 226:	89 d0                	mov    %edx,%eax
 228:	05 e0 0d 00 00       	add    $0xde0,%eax
 22d:	89 44 24 04          	mov    %eax,0x4(%esp)
 231:	8b 45 0c             	mov    0xc(%ebp),%eax
 234:	89 04 24             	mov    %eax,(%esp)
 237:	e8 0e 03 00 00       	call   54a <read>
 23c:	85 c0                	test   %eax,%eax
 23e:	0f 8e b8 00 00 00    	jle    2fc <grep+0xfc>
    m += n;
 244:	01 45 e4             	add    %eax,-0x1c(%ebp)
    p = buf;
 247:	bb e0 0d 00 00       	mov    $0xde0,%ebx
    buf[m] = '\0';
 24c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 24f:	c6 80 e0 0d 00 00 00 	movb   $0x0,0xde0(%eax)
 256:	66 90                	xchg   %ax,%ax
    while((q = strchr(p, '\n')) != 0){
 258:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
 25f:	00 
 260:	89 1c 24             	mov    %ebx,(%esp)
 263:	e8 78 01 00 00       	call   3e0 <strchr>
 268:	85 c0                	test   %eax,%eax
 26a:	89 c7                	mov    %eax,%edi
 26c:	74 42                	je     2b0 <grep+0xb0>
      *q = 0;
 26e:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 271:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 275:	89 34 24             	mov    %esi,(%esp)
 278:	e8 33 ff ff ff       	call   1b0 <match>
 27d:	85 c0                	test   %eax,%eax
 27f:	75 07                	jne    288 <grep+0x88>
 281:	8d 5f 01             	lea    0x1(%edi),%ebx
 284:	eb d2                	jmp    258 <grep+0x58>
 286:	66 90                	xchg   %ax,%ax
        *q = '\n';
 288:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 28b:	83 c7 01             	add    $0x1,%edi
 28e:	89 f8                	mov    %edi,%eax
 290:	29 d8                	sub    %ebx,%eax
 292:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 296:	89 fb                	mov    %edi,%ebx
 298:	89 44 24 08          	mov    %eax,0x8(%esp)
 29c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a3:	e8 aa 02 00 00       	call   552 <write>
 2a8:	eb ae                	jmp    258 <grep+0x58>
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p == buf)
 2b0:	81 fb e0 0d 00 00    	cmp    $0xde0,%ebx
 2b6:	74 38                	je     2f0 <grep+0xf0>
    if(m > 0){
 2b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2bb:	85 c0                	test   %eax,%eax
 2bd:	0f 8e 55 ff ff ff    	jle    218 <grep+0x18>
      m -= p - buf;
 2c3:	b8 e0 0d 00 00       	mov    $0xde0,%eax
 2c8:	29 d8                	sub    %ebx,%eax
 2ca:	01 45 e4             	add    %eax,-0x1c(%ebp)
      memmove(buf, p, m);
 2cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2d4:	c7 04 24 e0 0d 00 00 	movl   $0xde0,(%esp)
 2db:	89 44 24 08          	mov    %eax,0x8(%esp)
 2df:	e8 1c 02 00 00       	call   500 <memmove>
 2e4:	e9 2f ff ff ff       	jmp    218 <grep+0x18>
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      m = 0;
 2f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 2f7:	e9 1c ff ff ff       	jmp    218 <grep+0x18>
}
 2fc:	83 c4 1c             	add    $0x1c,%esp
 2ff:	5b                   	pop    %ebx
 300:	5e                   	pop    %esi
 301:	5f                   	pop    %edi
 302:	5d                   	pop    %ebp
 303:	c3                   	ret    
 304:	66 90                	xchg   %ax,%ax
 306:	66 90                	xchg   %ax,%ax
 308:	66 90                	xchg   %ax,%ax
 30a:	66 90                	xchg   %ax,%ax
 30c:	66 90                	xchg   %ax,%ax
 30e:	66 90                	xchg   %ax,%ax

00000310 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 45 08             	mov    0x8(%ebp),%eax
 316:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 319:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 31a:	89 c2                	mov    %eax,%edx
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 320:	83 c1 01             	add    $0x1,%ecx
 323:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 327:	83 c2 01             	add    $0x1,%edx
 32a:	84 db                	test   %bl,%bl
 32c:	88 5a ff             	mov    %bl,-0x1(%edx)
 32f:	75 ef                	jne    320 <strcpy+0x10>
    ;
  return os;
}
 331:	5b                   	pop    %ebx
 332:	5d                   	pop    %ebp
 333:	c3                   	ret    
 334:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 33a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000340 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 55 08             	mov    0x8(%ebp),%edx
 346:	53                   	push   %ebx
 347:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 34a:	0f b6 02             	movzbl (%edx),%eax
 34d:	84 c0                	test   %al,%al
 34f:	74 2d                	je     37e <strcmp+0x3e>
 351:	0f b6 19             	movzbl (%ecx),%ebx
 354:	38 d8                	cmp    %bl,%al
 356:	74 0e                	je     366 <strcmp+0x26>
 358:	eb 2b                	jmp    385 <strcmp+0x45>
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 360:	38 c8                	cmp    %cl,%al
 362:	75 15                	jne    379 <strcmp+0x39>
    p++, q++;
 364:	89 d9                	mov    %ebx,%ecx
 366:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 369:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 36c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 36f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 373:	84 c0                	test   %al,%al
 375:	75 e9                	jne    360 <strcmp+0x20>
 377:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 379:	29 c8                	sub    %ecx,%eax
}
 37b:	5b                   	pop    %ebx
 37c:	5d                   	pop    %ebp
 37d:	c3                   	ret    
 37e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 381:	31 c0                	xor    %eax,%eax
 383:	eb f4                	jmp    379 <strcmp+0x39>
 385:	0f b6 cb             	movzbl %bl,%ecx
 388:	eb ef                	jmp    379 <strcmp+0x39>
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000390 <strlen>:

uint
strlen(const char *s)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 396:	80 39 00             	cmpb   $0x0,(%ecx)
 399:	74 12                	je     3ad <strlen+0x1d>
 39b:	31 d2                	xor    %edx,%edx
 39d:	8d 76 00             	lea    0x0(%esi),%esi
 3a0:	83 c2 01             	add    $0x1,%edx
 3a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3a7:	89 d0                	mov    %edx,%eax
 3a9:	75 f5                	jne    3a0 <strlen+0x10>
    ;
  return n;
}
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret    
  for(n = 0; s[n]; n++)
 3ad:	31 c0                	xor    %eax,%eax
}
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret    
 3b1:	eb 0d                	jmp    3c0 <memset>
 3b3:	90                   	nop
 3b4:	90                   	nop
 3b5:	90                   	nop
 3b6:	90                   	nop
 3b7:	90                   	nop
 3b8:	90                   	nop
 3b9:	90                   	nop
 3ba:	90                   	nop
 3bb:	90                   	nop
 3bc:	90                   	nop
 3bd:	90                   	nop
 3be:	90                   	nop
 3bf:	90                   	nop

000003c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 55 08             	mov    0x8(%ebp),%edx
 3c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cd:	89 d7                	mov    %edx,%edi
 3cf:	fc                   	cld    
 3d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3d2:	89 d0                	mov    %edx,%eax
 3d4:	5f                   	pop    %edi
 3d5:	5d                   	pop    %ebp
 3d6:	c3                   	ret    
 3d7:	89 f6                	mov    %esi,%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003e0 <strchr>:

char*
strchr(const char *s, char c)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	53                   	push   %ebx
 3e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 3ea:	0f b6 18             	movzbl (%eax),%ebx
 3ed:	84 db                	test   %bl,%bl
 3ef:	74 1d                	je     40e <strchr+0x2e>
    if(*s == c)
 3f1:	38 d3                	cmp    %dl,%bl
 3f3:	89 d1                	mov    %edx,%ecx
 3f5:	75 0d                	jne    404 <strchr+0x24>
 3f7:	eb 17                	jmp    410 <strchr+0x30>
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 400:	38 ca                	cmp    %cl,%dl
 402:	74 0c                	je     410 <strchr+0x30>
  for(; *s; s++)
 404:	83 c0 01             	add    $0x1,%eax
 407:	0f b6 10             	movzbl (%eax),%edx
 40a:	84 d2                	test   %dl,%dl
 40c:	75 f2                	jne    400 <strchr+0x20>
      return (char*)s;
  return 0;
 40e:	31 c0                	xor    %eax,%eax
}
 410:	5b                   	pop    %ebx
 411:	5d                   	pop    %ebp
 412:	c3                   	ret    
 413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <gets>:

char*
gets(char *buf, int max)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 425:	31 f6                	xor    %esi,%esi
{
 427:	53                   	push   %ebx
 428:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 42b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 42e:	eb 31                	jmp    461 <gets+0x41>
    cc = read(0, &c, 1);
 430:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 437:	00 
 438:	89 7c 24 04          	mov    %edi,0x4(%esp)
 43c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 443:	e8 02 01 00 00       	call   54a <read>
    if(cc < 1)
 448:	85 c0                	test   %eax,%eax
 44a:	7e 1d                	jle    469 <gets+0x49>
      break;
    buf[i++] = c;
 44c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 450:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 452:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 455:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 457:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 45b:	74 0c                	je     469 <gets+0x49>
 45d:	3c 0a                	cmp    $0xa,%al
 45f:	74 08                	je     469 <gets+0x49>
  for(i=0; i+1 < max; ){
 461:	8d 5e 01             	lea    0x1(%esi),%ebx
 464:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 467:	7c c7                	jl     430 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 469:	8b 45 08             	mov    0x8(%ebp),%eax
 46c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 470:	83 c4 2c             	add    $0x2c,%esp
 473:	5b                   	pop    %ebx
 474:	5e                   	pop    %esi
 475:	5f                   	pop    %edi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
 478:	90                   	nop
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000480 <stat>:

int
stat(const char *n, struct stat *st)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	56                   	push   %esi
 484:	53                   	push   %ebx
 485:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 488:	8b 45 08             	mov    0x8(%ebp),%eax
 48b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 492:	00 
 493:	89 04 24             	mov    %eax,(%esp)
 496:	e8 d7 00 00 00       	call   572 <open>
  if(fd < 0)
 49b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 49d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 49f:	78 27                	js     4c8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 4a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a4:	89 1c 24             	mov    %ebx,(%esp)
 4a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ab:	e8 da 00 00 00       	call   58a <fstat>
  close(fd);
 4b0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4b3:	89 c6                	mov    %eax,%esi
  close(fd);
 4b5:	e8 a0 00 00 00       	call   55a <close>
  return r;
 4ba:	89 f0                	mov    %esi,%eax
}
 4bc:	83 c4 10             	add    $0x10,%esp
 4bf:	5b                   	pop    %ebx
 4c0:	5e                   	pop    %esi
 4c1:	5d                   	pop    %ebp
 4c2:	c3                   	ret    
 4c3:	90                   	nop
 4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 4c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4cd:	eb ed                	jmp    4bc <stat+0x3c>
 4cf:	90                   	nop

000004d0 <atoi>:

int
atoi(const char *s)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4d6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4d7:	0f be 11             	movsbl (%ecx),%edx
 4da:	8d 42 d0             	lea    -0x30(%edx),%eax
 4dd:	3c 09                	cmp    $0x9,%al
  n = 0;
 4df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 4e4:	77 17                	ja     4fd <atoi+0x2d>
 4e6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 4e8:	83 c1 01             	add    $0x1,%ecx
 4eb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4ee:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 4f2:	0f be 11             	movsbl (%ecx),%edx
 4f5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4f8:	80 fb 09             	cmp    $0x9,%bl
 4fb:	76 eb                	jbe    4e8 <atoi+0x18>
  return n;
}
 4fd:	5b                   	pop    %ebx
 4fe:	5d                   	pop    %ebp
 4ff:	c3                   	ret    

00000500 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 500:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 501:	31 d2                	xor    %edx,%edx
{
 503:	89 e5                	mov    %esp,%ebp
 505:	56                   	push   %esi
 506:	8b 45 08             	mov    0x8(%ebp),%eax
 509:	53                   	push   %ebx
 50a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 50d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 510:	85 db                	test   %ebx,%ebx
 512:	7e 12                	jle    526 <memmove+0x26>
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 518:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 51c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 51f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 522:	39 da                	cmp    %ebx,%edx
 524:	75 f2                	jne    518 <memmove+0x18>
  return vdst;
}
 526:	5b                   	pop    %ebx
 527:	5e                   	pop    %esi
 528:	5d                   	pop    %ebp
 529:	c3                   	ret    

0000052a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 52a:	b8 01 00 00 00       	mov    $0x1,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <exit>:
SYSCALL(exit)
 532:	b8 02 00 00 00       	mov    $0x2,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <wait>:
SYSCALL(wait)
 53a:	b8 03 00 00 00       	mov    $0x3,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <pipe>:
SYSCALL(pipe)
 542:	b8 04 00 00 00       	mov    $0x4,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <read>:
SYSCALL(read)
 54a:	b8 05 00 00 00       	mov    $0x5,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <write>:
SYSCALL(write)
 552:	b8 10 00 00 00       	mov    $0x10,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <close>:
SYSCALL(close)
 55a:	b8 15 00 00 00       	mov    $0x15,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <kill>:
SYSCALL(kill)
 562:	b8 06 00 00 00       	mov    $0x6,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <exec>:
SYSCALL(exec)
 56a:	b8 07 00 00 00       	mov    $0x7,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <open>:
SYSCALL(open)
 572:	b8 0f 00 00 00       	mov    $0xf,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <mknod>:
SYSCALL(mknod)
 57a:	b8 11 00 00 00       	mov    $0x11,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <unlink>:
SYSCALL(unlink)
 582:	b8 12 00 00 00       	mov    $0x12,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <fstat>:
SYSCALL(fstat)
 58a:	b8 08 00 00 00       	mov    $0x8,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <link>:
SYSCALL(link)
 592:	b8 13 00 00 00       	mov    $0x13,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <mkdir>:
SYSCALL(mkdir)
 59a:	b8 14 00 00 00       	mov    $0x14,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <chdir>:
SYSCALL(chdir)
 5a2:	b8 09 00 00 00       	mov    $0x9,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <dup>:
SYSCALL(dup)
 5aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <getpid>:
SYSCALL(getpid)
 5b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <sbrk>:
SYSCALL(sbrk)
 5ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <sleep>:
SYSCALL(sleep)
 5c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <uptime>:
SYSCALL(uptime)
 5ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 5d2:	b8 16 00 00 00       	mov    $0x16,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 5da:	b8 17 00 00 00       	mov    $0x17,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 5e2:	b8 18 00 00 00       	mov    $0x18,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    
 5ea:	66 90                	xchg   %ax,%ax
 5ec:	66 90                	xchg   %ax,%ax
 5ee:	66 90                	xchg   %ax,%ax

000005f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	89 c6                	mov    %eax,%esi
 5f7:	53                   	push   %ebx
 5f8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5fe:	85 db                	test   %ebx,%ebx
 600:	74 09                	je     60b <printint+0x1b>
 602:	89 d0                	mov    %edx,%eax
 604:	c1 e8 1f             	shr    $0x1f,%eax
 607:	84 c0                	test   %al,%al
 609:	75 75                	jne    680 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 60b:	89 d0                	mov    %edx,%eax
  neg = 0;
 60d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 614:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 617:	31 ff                	xor    %edi,%edi
 619:	89 ce                	mov    %ecx,%esi
 61b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 61e:	eb 02                	jmp    622 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 620:	89 cf                	mov    %ecx,%edi
 622:	31 d2                	xor    %edx,%edx
 624:	f7 f6                	div    %esi
 626:	8d 4f 01             	lea    0x1(%edi),%ecx
 629:	0f b6 92 65 0a 00 00 	movzbl 0xa65(%edx),%edx
  }while((x /= base) != 0);
 630:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 632:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 635:	75 e9                	jne    620 <printint+0x30>
  if(neg)
 637:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 63a:	89 c8                	mov    %ecx,%eax
 63c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 63f:	85 d2                	test   %edx,%edx
 641:	74 08                	je     64b <printint+0x5b>
    buf[i++] = '-';
 643:	8d 4f 02             	lea    0x2(%edi),%ecx
 646:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 64b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 64e:	66 90                	xchg   %ax,%ax
 650:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 655:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 658:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 65f:	00 
 660:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 664:	89 34 24             	mov    %esi,(%esp)
 667:	88 45 d7             	mov    %al,-0x29(%ebp)
 66a:	e8 e3 fe ff ff       	call   552 <write>
  while(--i >= 0)
 66f:	83 ff ff             	cmp    $0xffffffff,%edi
 672:	75 dc                	jne    650 <printint+0x60>
    putc(fd, buf[i]);
}
 674:	83 c4 4c             	add    $0x4c,%esp
 677:	5b                   	pop    %ebx
 678:	5e                   	pop    %esi
 679:	5f                   	pop    %edi
 67a:	5d                   	pop    %ebp
 67b:	c3                   	ret    
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 680:	89 d0                	mov    %edx,%eax
 682:	f7 d8                	neg    %eax
    neg = 1;
 684:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 68b:	eb 87                	jmp    614 <printint+0x24>
 68d:	8d 76 00             	lea    0x0(%esi),%esi

00000690 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 694:	31 ff                	xor    %edi,%edi
{
 696:	56                   	push   %esi
 697:	53                   	push   %ebx
 698:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 69b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 69e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 6a1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 6a4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 6a7:	0f b6 13             	movzbl (%ebx),%edx
 6aa:	83 c3 01             	add    $0x1,%ebx
 6ad:	84 d2                	test   %dl,%dl
 6af:	75 39                	jne    6ea <printf+0x5a>
 6b1:	e9 ca 00 00 00       	jmp    780 <printf+0xf0>
 6b6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6b8:	83 fa 25             	cmp    $0x25,%edx
 6bb:	0f 84 c7 00 00 00    	je     788 <printf+0xf8>
  write(fd, &c, 1);
 6c1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 6c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6cb:	00 
 6cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 6d3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 6d6:	e8 77 fe ff ff       	call   552 <write>
 6db:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 6de:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6e2:	84 d2                	test   %dl,%dl
 6e4:	0f 84 96 00 00 00    	je     780 <printf+0xf0>
    if(state == 0){
 6ea:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 6ec:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 6ef:	74 c7                	je     6b8 <printf+0x28>
      }
    } else if(state == '%'){
 6f1:	83 ff 25             	cmp    $0x25,%edi
 6f4:	75 e5                	jne    6db <printf+0x4b>
      if(c == 'd' || c == 'u'){
 6f6:	83 fa 75             	cmp    $0x75,%edx
 6f9:	0f 84 99 00 00 00    	je     798 <printf+0x108>
 6ff:	83 fa 64             	cmp    $0x64,%edx
 702:	0f 84 90 00 00 00    	je     798 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 708:	25 f7 00 00 00       	and    $0xf7,%eax
 70d:	83 f8 70             	cmp    $0x70,%eax
 710:	0f 84 aa 00 00 00    	je     7c0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 716:	83 fa 73             	cmp    $0x73,%edx
 719:	0f 84 e9 00 00 00    	je     808 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 71f:	83 fa 63             	cmp    $0x63,%edx
 722:	0f 84 2b 01 00 00    	je     853 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 728:	83 fa 25             	cmp    $0x25,%edx
 72b:	0f 84 4f 01 00 00    	je     880 <printf+0x1f0>
  write(fd, &c, 1);
 731:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 734:	83 c3 01             	add    $0x1,%ebx
 737:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 73e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 73f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 741:	89 44 24 04          	mov    %eax,0x4(%esp)
 745:	89 34 24             	mov    %esi,(%esp)
 748:	89 55 d0             	mov    %edx,-0x30(%ebp)
 74b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 74f:	e8 fe fd ff ff       	call   552 <write>
        putc(fd, c);
 754:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 757:	8d 45 e7             	lea    -0x19(%ebp),%eax
 75a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 761:	00 
 762:	89 44 24 04          	mov    %eax,0x4(%esp)
 766:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 769:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 76c:	e8 e1 fd ff ff       	call   552 <write>
  for(i = 0; fmt[i]; i++){
 771:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 775:	84 d2                	test   %dl,%dl
 777:	0f 85 6d ff ff ff    	jne    6ea <printf+0x5a>
 77d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 780:	83 c4 3c             	add    $0x3c,%esp
 783:	5b                   	pop    %ebx
 784:	5e                   	pop    %esi
 785:	5f                   	pop    %edi
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
        state = '%';
 788:	bf 25 00 00 00       	mov    $0x25,%edi
 78d:	e9 49 ff ff ff       	jmp    6db <printf+0x4b>
 792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 798:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 79f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 7a4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 7a7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 7a9:	8b 10                	mov    (%eax),%edx
 7ab:	89 f0                	mov    %esi,%eax
 7ad:	e8 3e fe ff ff       	call   5f0 <printint>
        ap++;
 7b2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 7b6:	e9 20 ff ff ff       	jmp    6db <printf+0x4b>
 7bb:	90                   	nop
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 7c0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 7c3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7ca:	00 
 7cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 7cf:	89 34 24             	mov    %esi,(%esp)
 7d2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 7d6:	e8 77 fd ff ff       	call   552 <write>
 7db:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 7de:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7e5:	00 
 7e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ea:	89 34 24             	mov    %esi,(%esp)
 7ed:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 7f1:	e8 5c fd ff ff       	call   552 <write>
        printint(fd, *ap, 16, 0);
 7f6:	b9 10 00 00 00       	mov    $0x10,%ecx
 7fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 802:	eb a0                	jmp    7a4 <printf+0x114>
 804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 808:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 80b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 80f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 811:	b8 5e 0a 00 00       	mov    $0xa5e,%eax
 816:	85 ff                	test   %edi,%edi
 818:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 81b:	0f b6 07             	movzbl (%edi),%eax
 81e:	84 c0                	test   %al,%al
 820:	74 2a                	je     84c <printf+0x1bc>
 822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 828:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 82b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 82e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 831:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 838:	00 
 839:	89 44 24 04          	mov    %eax,0x4(%esp)
 83d:	89 34 24             	mov    %esi,(%esp)
 840:	e8 0d fd ff ff       	call   552 <write>
        while(*s != 0){
 845:	0f b6 07             	movzbl (%edi),%eax
 848:	84 c0                	test   %al,%al
 84a:	75 dc                	jne    828 <printf+0x198>
      state = 0;
 84c:	31 ff                	xor    %edi,%edi
 84e:	e9 88 fe ff ff       	jmp    6db <printf+0x4b>
        putc(fd, *ap);
 853:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 856:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 858:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 85a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 861:	00 
 862:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 865:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 868:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 86b:	89 44 24 04          	mov    %eax,0x4(%esp)
 86f:	e8 de fc ff ff       	call   552 <write>
        ap++;
 874:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 878:	e9 5e fe ff ff       	jmp    6db <printf+0x4b>
 87d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 880:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 883:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 885:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 88c:	00 
 88d:	89 44 24 04          	mov    %eax,0x4(%esp)
 891:	89 34 24             	mov    %esi,(%esp)
 894:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 898:	e8 b5 fc ff ff       	call   552 <write>
 89d:	e9 39 fe ff ff       	jmp    6db <printf+0x4b>
 8a2:	66 90                	xchg   %ax,%ax
 8a4:	66 90                	xchg   %ax,%ax
 8a6:	66 90                	xchg   %ax,%ax
 8a8:	66 90                	xchg   %ax,%ax
 8aa:	66 90                	xchg   %ax,%ax
 8ac:	66 90                	xchg   %ax,%ax
 8ae:	66 90                	xchg   %ax,%ax

000008b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b1:	a1 c0 0d 00 00       	mov    0xdc0,%eax
{
 8b6:	89 e5                	mov    %esp,%ebp
 8b8:	57                   	push   %edi
 8b9:	56                   	push   %esi
 8ba:	53                   	push   %ebx
 8bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8be:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 8c0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c3:	39 d0                	cmp    %edx,%eax
 8c5:	72 11                	jb     8d8 <free+0x28>
 8c7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c8:	39 c8                	cmp    %ecx,%eax
 8ca:	72 04                	jb     8d0 <free+0x20>
 8cc:	39 ca                	cmp    %ecx,%edx
 8ce:	72 10                	jb     8e0 <free+0x30>
 8d0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d6:	73 f0                	jae    8c8 <free+0x18>
 8d8:	39 ca                	cmp    %ecx,%edx
 8da:	72 04                	jb     8e0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8dc:	39 c8                	cmp    %ecx,%eax
 8de:	72 f0                	jb     8d0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8e3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 8e6:	39 cf                	cmp    %ecx,%edi
 8e8:	74 1e                	je     908 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8ea:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8ed:	8b 48 04             	mov    0x4(%eax),%ecx
 8f0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 8f3:	39 f2                	cmp    %esi,%edx
 8f5:	74 28                	je     91f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8f7:	89 10                	mov    %edx,(%eax)
  freep = p;
 8f9:	a3 c0 0d 00 00       	mov    %eax,0xdc0
}
 8fe:	5b                   	pop    %ebx
 8ff:	5e                   	pop    %esi
 900:	5f                   	pop    %edi
 901:	5d                   	pop    %ebp
 902:	c3                   	ret    
 903:	90                   	nop
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 908:	03 71 04             	add    0x4(%ecx),%esi
 90b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 90e:	8b 08                	mov    (%eax),%ecx
 910:	8b 09                	mov    (%ecx),%ecx
 912:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 915:	8b 48 04             	mov    0x4(%eax),%ecx
 918:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 91b:	39 f2                	cmp    %esi,%edx
 91d:	75 d8                	jne    8f7 <free+0x47>
    p->s.size += bp->s.size;
 91f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 922:	a3 c0 0d 00 00       	mov    %eax,0xdc0
    p->s.size += bp->s.size;
 927:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 92a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 92d:	89 10                	mov    %edx,(%eax)
}
 92f:	5b                   	pop    %ebx
 930:	5e                   	pop    %esi
 931:	5f                   	pop    %edi
 932:	5d                   	pop    %ebp
 933:	c3                   	ret    
 934:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 93a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000940 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	57                   	push   %edi
 944:	56                   	push   %esi
 945:	53                   	push   %ebx
 946:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 949:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 94c:	8b 1d c0 0d 00 00    	mov    0xdc0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 952:	8d 48 07             	lea    0x7(%eax),%ecx
 955:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 958:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 95a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 95d:	0f 84 9b 00 00 00    	je     9fe <malloc+0xbe>
 963:	8b 13                	mov    (%ebx),%edx
 965:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 968:	39 fe                	cmp    %edi,%esi
 96a:	76 64                	jbe    9d0 <malloc+0x90>
 96c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 973:	bb 00 80 00 00       	mov    $0x8000,%ebx
 978:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 97b:	eb 0e                	jmp    98b <malloc+0x4b>
 97d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 980:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 982:	8b 78 04             	mov    0x4(%eax),%edi
 985:	39 fe                	cmp    %edi,%esi
 987:	76 4f                	jbe    9d8 <malloc+0x98>
 989:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 98b:	3b 15 c0 0d 00 00    	cmp    0xdc0,%edx
 991:	75 ed                	jne    980 <malloc+0x40>
  if(nu < 4096)
 993:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 996:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 99c:	bf 00 10 00 00       	mov    $0x1000,%edi
 9a1:	0f 43 fe             	cmovae %esi,%edi
 9a4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 9a7:	89 04 24             	mov    %eax,(%esp)
 9aa:	e8 0b fc ff ff       	call   5ba <sbrk>
  if(p == (char*)-1)
 9af:	83 f8 ff             	cmp    $0xffffffff,%eax
 9b2:	74 18                	je     9cc <malloc+0x8c>
  hp->s.size = nu;
 9b4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 9b7:	83 c0 08             	add    $0x8,%eax
 9ba:	89 04 24             	mov    %eax,(%esp)
 9bd:	e8 ee fe ff ff       	call   8b0 <free>
  return freep;
 9c2:	8b 15 c0 0d 00 00    	mov    0xdc0,%edx
      if((p = morecore(nunits)) == 0)
 9c8:	85 d2                	test   %edx,%edx
 9ca:	75 b4                	jne    980 <malloc+0x40>
        return 0;
 9cc:	31 c0                	xor    %eax,%eax
 9ce:	eb 20                	jmp    9f0 <malloc+0xb0>
    if(p->s.size >= nunits){
 9d0:	89 d0                	mov    %edx,%eax
 9d2:	89 da                	mov    %ebx,%edx
 9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 9d8:	39 fe                	cmp    %edi,%esi
 9da:	74 1c                	je     9f8 <malloc+0xb8>
        p->s.size -= nunits;
 9dc:	29 f7                	sub    %esi,%edi
 9de:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 9e1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 9e4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 9e7:	89 15 c0 0d 00 00    	mov    %edx,0xdc0
      return (void*)(p + 1);
 9ed:	83 c0 08             	add    $0x8,%eax
  }
}
 9f0:	83 c4 1c             	add    $0x1c,%esp
 9f3:	5b                   	pop    %ebx
 9f4:	5e                   	pop    %esi
 9f5:	5f                   	pop    %edi
 9f6:	5d                   	pop    %ebp
 9f7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 9f8:	8b 08                	mov    (%eax),%ecx
 9fa:	89 0a                	mov    %ecx,(%edx)
 9fc:	eb e9                	jmp    9e7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 9fe:	c7 05 c0 0d 00 00 c4 	movl   $0xdc4,0xdc0
 a05:	0d 00 00 
    base.s.size = 0;
 a08:	ba c4 0d 00 00       	mov    $0xdc4,%edx
    base.s.ptr = freep = prevp = &base;
 a0d:	c7 05 c4 0d 00 00 c4 	movl   $0xdc4,0xdc4
 a14:	0d 00 00 
    base.s.size = 0;
 a17:	c7 05 c8 0d 00 00 00 	movl   $0x0,0xdc8
 a1e:	00 00 00 
 a21:	e9 46 ff ff ff       	jmp    96c <malloc+0x2c>
