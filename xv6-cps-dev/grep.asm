
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
  72:	c7 44 24 04 58 0a 00 	movl   $0xa58,0x4(%esp)
  79:	00 
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	e8 16 06 00 00       	call   6a0 <printf>
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
  a4:	c7 44 24 04 38 0a 00 	movl   $0xa38,0x4(%esp)
  ab:	00 
  ac:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  b3:	e8 e8 05 00 00       	call   6a0 <printf>
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
 228:	05 00 0e 00 00       	add    $0xe00,%eax
 22d:	89 44 24 04          	mov    %eax,0x4(%esp)
 231:	8b 45 0c             	mov    0xc(%ebp),%eax
 234:	89 04 24             	mov    %eax,(%esp)
 237:	e8 0e 03 00 00       	call   54a <read>
 23c:	85 c0                	test   %eax,%eax
 23e:	0f 8e b8 00 00 00    	jle    2fc <grep+0xfc>
    m += n;
 244:	01 45 e4             	add    %eax,-0x1c(%ebp)
    p = buf;
 247:	bb 00 0e 00 00       	mov    $0xe00,%ebx
    buf[m] = '\0';
 24c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 24f:	c6 80 00 0e 00 00 00 	movb   $0x0,0xe00(%eax)
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
 2b0:	81 fb 00 0e 00 00    	cmp    $0xe00,%ebx
 2b6:	74 38                	je     2f0 <grep+0xf0>
    if(m > 0){
 2b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2bb:	85 c0                	test   %eax,%eax
 2bd:	0f 8e 55 ff ff ff    	jle    218 <grep+0x18>
      m -= p - buf;
 2c3:	b8 00 0e 00 00       	mov    $0xe00,%eax
 2c8:	29 d8                	sub    %ebx,%eax
 2ca:	01 45 e4             	add    %eax,-0x1c(%ebp)
      memmove(buf, p, m);
 2cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2d4:	c7 04 24 00 0e 00 00 	movl   $0xe00,(%esp)
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

000005ea <halt>:
 5ea:	b8 19 00 00 00       	mov    $0x19,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    
 5f2:	66 90                	xchg   %ax,%ax
 5f4:	66 90                	xchg   %ax,%ax
 5f6:	66 90                	xchg   %ax,%ax
 5f8:	66 90                	xchg   %ax,%ax
 5fa:	66 90                	xchg   %ax,%ax
 5fc:	66 90                	xchg   %ax,%ax
 5fe:	66 90                	xchg   %ax,%ax

00000600 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	89 c6                	mov    %eax,%esi
 607:	53                   	push   %ebx
 608:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 60e:	85 db                	test   %ebx,%ebx
 610:	74 09                	je     61b <printint+0x1b>
 612:	89 d0                	mov    %edx,%eax
 614:	c1 e8 1f             	shr    $0x1f,%eax
 617:	84 c0                	test   %al,%al
 619:	75 75                	jne    690 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 61b:	89 d0                	mov    %edx,%eax
  neg = 0;
 61d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 624:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 627:	31 ff                	xor    %edi,%edi
 629:	89 ce                	mov    %ecx,%esi
 62b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 62e:	eb 02                	jmp    632 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 630:	89 cf                	mov    %ecx,%edi
 632:	31 d2                	xor    %edx,%edx
 634:	f7 f6                	div    %esi
 636:	8d 4f 01             	lea    0x1(%edi),%ecx
 639:	0f b6 92 75 0a 00 00 	movzbl 0xa75(%edx),%edx
  }while((x /= base) != 0);
 640:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 642:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 645:	75 e9                	jne    630 <printint+0x30>
  if(neg)
 647:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 64a:	89 c8                	mov    %ecx,%eax
 64c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 64f:	85 d2                	test   %edx,%edx
 651:	74 08                	je     65b <printint+0x5b>
    buf[i++] = '-';
 653:	8d 4f 02             	lea    0x2(%edi),%ecx
 656:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 65b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 65e:	66 90                	xchg   %ax,%ax
 660:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 665:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 668:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 66f:	00 
 670:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 674:	89 34 24             	mov    %esi,(%esp)
 677:	88 45 d7             	mov    %al,-0x29(%ebp)
 67a:	e8 d3 fe ff ff       	call   552 <write>
  while(--i >= 0)
 67f:	83 ff ff             	cmp    $0xffffffff,%edi
 682:	75 dc                	jne    660 <printint+0x60>
    putc(fd, buf[i]);
}
 684:	83 c4 4c             	add    $0x4c,%esp
 687:	5b                   	pop    %ebx
 688:	5e                   	pop    %esi
 689:	5f                   	pop    %edi
 68a:	5d                   	pop    %ebp
 68b:	c3                   	ret    
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 690:	89 d0                	mov    %edx,%eax
 692:	f7 d8                	neg    %eax
    neg = 1;
 694:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 69b:	eb 87                	jmp    624 <printint+0x24>
 69d:	8d 76 00             	lea    0x0(%esi),%esi

000006a0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6a4:	31 ff                	xor    %edi,%edi
{
 6a6:	56                   	push   %esi
 6a7:	53                   	push   %ebx
 6a8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 6ae:	8d 45 10             	lea    0x10(%ebp),%eax
{
 6b1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 6b4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 6b7:	0f b6 13             	movzbl (%ebx),%edx
 6ba:	83 c3 01             	add    $0x1,%ebx
 6bd:	84 d2                	test   %dl,%dl
 6bf:	75 39                	jne    6fa <printf+0x5a>
 6c1:	e9 ca 00 00 00       	jmp    790 <printf+0xf0>
 6c6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6c8:	83 fa 25             	cmp    $0x25,%edx
 6cb:	0f 84 c7 00 00 00    	je     798 <printf+0xf8>
  write(fd, &c, 1);
 6d1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 6d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6db:	00 
 6dc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 6e3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 6e6:	e8 67 fe ff ff       	call   552 <write>
 6eb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 6ee:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6f2:	84 d2                	test   %dl,%dl
 6f4:	0f 84 96 00 00 00    	je     790 <printf+0xf0>
    if(state == 0){
 6fa:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 6fc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 6ff:	74 c7                	je     6c8 <printf+0x28>
      }
    } else if(state == '%'){
 701:	83 ff 25             	cmp    $0x25,%edi
 704:	75 e5                	jne    6eb <printf+0x4b>
      if(c == 'd' || c == 'u'){
 706:	83 fa 75             	cmp    $0x75,%edx
 709:	0f 84 99 00 00 00    	je     7a8 <printf+0x108>
 70f:	83 fa 64             	cmp    $0x64,%edx
 712:	0f 84 90 00 00 00    	je     7a8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 718:	25 f7 00 00 00       	and    $0xf7,%eax
 71d:	83 f8 70             	cmp    $0x70,%eax
 720:	0f 84 aa 00 00 00    	je     7d0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 726:	83 fa 73             	cmp    $0x73,%edx
 729:	0f 84 e9 00 00 00    	je     818 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 72f:	83 fa 63             	cmp    $0x63,%edx
 732:	0f 84 2b 01 00 00    	je     863 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 738:	83 fa 25             	cmp    $0x25,%edx
 73b:	0f 84 4f 01 00 00    	je     890 <printf+0x1f0>
  write(fd, &c, 1);
 741:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 744:	83 c3 01             	add    $0x1,%ebx
 747:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 74e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 74f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 751:	89 44 24 04          	mov    %eax,0x4(%esp)
 755:	89 34 24             	mov    %esi,(%esp)
 758:	89 55 d0             	mov    %edx,-0x30(%ebp)
 75b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 75f:	e8 ee fd ff ff       	call   552 <write>
        putc(fd, c);
 764:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 767:	8d 45 e7             	lea    -0x19(%ebp),%eax
 76a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 771:	00 
 772:	89 44 24 04          	mov    %eax,0x4(%esp)
 776:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 779:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 77c:	e8 d1 fd ff ff       	call   552 <write>
  for(i = 0; fmt[i]; i++){
 781:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 785:	84 d2                	test   %dl,%dl
 787:	0f 85 6d ff ff ff    	jne    6fa <printf+0x5a>
 78d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 790:	83 c4 3c             	add    $0x3c,%esp
 793:	5b                   	pop    %ebx
 794:	5e                   	pop    %esi
 795:	5f                   	pop    %edi
 796:	5d                   	pop    %ebp
 797:	c3                   	ret    
        state = '%';
 798:	bf 25 00 00 00       	mov    $0x25,%edi
 79d:	e9 49 ff ff ff       	jmp    6eb <printf+0x4b>
 7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 7a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7af:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 7b4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 7b7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 7b9:	8b 10                	mov    (%eax),%edx
 7bb:	89 f0                	mov    %esi,%eax
 7bd:	e8 3e fe ff ff       	call   600 <printint>
        ap++;
 7c2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 7c6:	e9 20 ff ff ff       	jmp    6eb <printf+0x4b>
 7cb:	90                   	nop
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 7d0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 7d3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7da:	00 
 7db:	89 44 24 04          	mov    %eax,0x4(%esp)
 7df:	89 34 24             	mov    %esi,(%esp)
 7e2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 7e6:	e8 67 fd ff ff       	call   552 <write>
 7eb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 7ee:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7f5:	00 
 7f6:	89 44 24 04          	mov    %eax,0x4(%esp)
 7fa:	89 34 24             	mov    %esi,(%esp)
 7fd:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 801:	e8 4c fd ff ff       	call   552 <write>
        printint(fd, *ap, 16, 0);
 806:	b9 10 00 00 00       	mov    $0x10,%ecx
 80b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 812:	eb a0                	jmp    7b4 <printf+0x114>
 814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 818:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 81b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 81f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 821:	b8 6e 0a 00 00       	mov    $0xa6e,%eax
 826:	85 ff                	test   %edi,%edi
 828:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 82b:	0f b6 07             	movzbl (%edi),%eax
 82e:	84 c0                	test   %al,%al
 830:	74 2a                	je     85c <printf+0x1bc>
 832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 838:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 83b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 83e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 841:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 848:	00 
 849:	89 44 24 04          	mov    %eax,0x4(%esp)
 84d:	89 34 24             	mov    %esi,(%esp)
 850:	e8 fd fc ff ff       	call   552 <write>
        while(*s != 0){
 855:	0f b6 07             	movzbl (%edi),%eax
 858:	84 c0                	test   %al,%al
 85a:	75 dc                	jne    838 <printf+0x198>
      state = 0;
 85c:	31 ff                	xor    %edi,%edi
 85e:	e9 88 fe ff ff       	jmp    6eb <printf+0x4b>
        putc(fd, *ap);
 863:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 866:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 868:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 86a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 871:	00 
 872:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 875:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 878:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 87b:	89 44 24 04          	mov    %eax,0x4(%esp)
 87f:	e8 ce fc ff ff       	call   552 <write>
        ap++;
 884:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 888:	e9 5e fe ff ff       	jmp    6eb <printf+0x4b>
 88d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 890:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 893:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 895:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 89c:	00 
 89d:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a1:	89 34 24             	mov    %esi,(%esp)
 8a4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 8a8:	e8 a5 fc ff ff       	call   552 <write>
 8ad:	e9 39 fe ff ff       	jmp    6eb <printf+0x4b>
 8b2:	66 90                	xchg   %ax,%ax
 8b4:	66 90                	xchg   %ax,%ax
 8b6:	66 90                	xchg   %ax,%ax
 8b8:	66 90                	xchg   %ax,%ax
 8ba:	66 90                	xchg   %ax,%ax
 8bc:	66 90                	xchg   %ax,%ax
 8be:	66 90                	xchg   %ax,%ax

000008c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c1:	a1 e0 0d 00 00       	mov    0xde0,%eax
{
 8c6:	89 e5                	mov    %esp,%ebp
 8c8:	57                   	push   %edi
 8c9:	56                   	push   %esi
 8ca:	53                   	push   %ebx
 8cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ce:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 8d0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d3:	39 d0                	cmp    %edx,%eax
 8d5:	72 11                	jb     8e8 <free+0x28>
 8d7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d8:	39 c8                	cmp    %ecx,%eax
 8da:	72 04                	jb     8e0 <free+0x20>
 8dc:	39 ca                	cmp    %ecx,%edx
 8de:	72 10                	jb     8f0 <free+0x30>
 8e0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e6:	73 f0                	jae    8d8 <free+0x18>
 8e8:	39 ca                	cmp    %ecx,%edx
 8ea:	72 04                	jb     8f0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ec:	39 c8                	cmp    %ecx,%eax
 8ee:	72 f0                	jb     8e0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8f3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 8f6:	39 cf                	cmp    %ecx,%edi
 8f8:	74 1e                	je     918 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8fa:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8fd:	8b 48 04             	mov    0x4(%eax),%ecx
 900:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 903:	39 f2                	cmp    %esi,%edx
 905:	74 28                	je     92f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 907:	89 10                	mov    %edx,(%eax)
  freep = p;
 909:	a3 e0 0d 00 00       	mov    %eax,0xde0
}
 90e:	5b                   	pop    %ebx
 90f:	5e                   	pop    %esi
 910:	5f                   	pop    %edi
 911:	5d                   	pop    %ebp
 912:	c3                   	ret    
 913:	90                   	nop
 914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 918:	03 71 04             	add    0x4(%ecx),%esi
 91b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 91e:	8b 08                	mov    (%eax),%ecx
 920:	8b 09                	mov    (%ecx),%ecx
 922:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 925:	8b 48 04             	mov    0x4(%eax),%ecx
 928:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 92b:	39 f2                	cmp    %esi,%edx
 92d:	75 d8                	jne    907 <free+0x47>
    p->s.size += bp->s.size;
 92f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 932:	a3 e0 0d 00 00       	mov    %eax,0xde0
    p->s.size += bp->s.size;
 937:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 93a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 93d:	89 10                	mov    %edx,(%eax)
}
 93f:	5b                   	pop    %ebx
 940:	5e                   	pop    %esi
 941:	5f                   	pop    %edi
 942:	5d                   	pop    %ebp
 943:	c3                   	ret    
 944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 94a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000950 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	57                   	push   %edi
 954:	56                   	push   %esi
 955:	53                   	push   %ebx
 956:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 959:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 95c:	8b 1d e0 0d 00 00    	mov    0xde0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 962:	8d 48 07             	lea    0x7(%eax),%ecx
 965:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 968:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 96a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 96d:	0f 84 9b 00 00 00    	je     a0e <malloc+0xbe>
 973:	8b 13                	mov    (%ebx),%edx
 975:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 978:	39 fe                	cmp    %edi,%esi
 97a:	76 64                	jbe    9e0 <malloc+0x90>
 97c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 983:	bb 00 80 00 00       	mov    $0x8000,%ebx
 988:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 98b:	eb 0e                	jmp    99b <malloc+0x4b>
 98d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 990:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 992:	8b 78 04             	mov    0x4(%eax),%edi
 995:	39 fe                	cmp    %edi,%esi
 997:	76 4f                	jbe    9e8 <malloc+0x98>
 999:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 99b:	3b 15 e0 0d 00 00    	cmp    0xde0,%edx
 9a1:	75 ed                	jne    990 <malloc+0x40>
  if(nu < 4096)
 9a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9a6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 9ac:	bf 00 10 00 00       	mov    $0x1000,%edi
 9b1:	0f 43 fe             	cmovae %esi,%edi
 9b4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 9b7:	89 04 24             	mov    %eax,(%esp)
 9ba:	e8 fb fb ff ff       	call   5ba <sbrk>
  if(p == (char*)-1)
 9bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 9c2:	74 18                	je     9dc <malloc+0x8c>
  hp->s.size = nu;
 9c4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 9c7:	83 c0 08             	add    $0x8,%eax
 9ca:	89 04 24             	mov    %eax,(%esp)
 9cd:	e8 ee fe ff ff       	call   8c0 <free>
  return freep;
 9d2:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
      if((p = morecore(nunits)) == 0)
 9d8:	85 d2                	test   %edx,%edx
 9da:	75 b4                	jne    990 <malloc+0x40>
        return 0;
 9dc:	31 c0                	xor    %eax,%eax
 9de:	eb 20                	jmp    a00 <malloc+0xb0>
    if(p->s.size >= nunits){
 9e0:	89 d0                	mov    %edx,%eax
 9e2:	89 da                	mov    %ebx,%edx
 9e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 9e8:	39 fe                	cmp    %edi,%esi
 9ea:	74 1c                	je     a08 <malloc+0xb8>
        p->s.size -= nunits;
 9ec:	29 f7                	sub    %esi,%edi
 9ee:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 9f1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 9f4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 9f7:	89 15 e0 0d 00 00    	mov    %edx,0xde0
      return (void*)(p + 1);
 9fd:	83 c0 08             	add    $0x8,%eax
  }
}
 a00:	83 c4 1c             	add    $0x1c,%esp
 a03:	5b                   	pop    %ebx
 a04:	5e                   	pop    %esi
 a05:	5f                   	pop    %edi
 a06:	5d                   	pop    %ebp
 a07:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 a08:	8b 08                	mov    (%eax),%ecx
 a0a:	89 0a                	mov    %ecx,(%edx)
 a0c:	eb e9                	jmp    9f7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 a0e:	c7 05 e0 0d 00 00 e4 	movl   $0xde4,0xde0
 a15:	0d 00 00 
    base.s.size = 0;
 a18:	ba e4 0d 00 00       	mov    $0xde4,%edx
    base.s.ptr = freep = prevp = &base;
 a1d:	c7 05 e4 0d 00 00 e4 	movl   $0xde4,0xde4
 a24:	0d 00 00 
    base.s.size = 0;
 a27:	c7 05 e8 0d 00 00 00 	movl   $0x0,0xde8
 a2e:	00 00 00 
 a31:	e9 46 ff ff ff       	jmp    97c <malloc+0x2c>
