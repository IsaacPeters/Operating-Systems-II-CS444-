
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
  int i;

  if(argc < 2){
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
{
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 1b                	jle    37 <main+0x37>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  for(i=1; i<argc; i++)
  23:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  26:	89 04 24             	mov    %eax,(%esp)
  29:	e8 e2 00 00 00       	call   110 <ls>
  for(i=1; i<argc; i++)
  2e:	39 f3                	cmp    %esi,%ebx
  30:	75 ee                	jne    20 <main+0x20>
  exit();
  32:	e8 9b 05 00 00       	call   5d2 <exit>
    ls(".");
  37:	c7 04 24 21 0b 00 00 	movl   $0xb21,(%esp)
  3e:	e8 cd 00 00 00       	call   110 <ls>
    exit();
  43:	e8 8a 05 00 00       	call   5d2 <exit>
  48:	66 90                	xchg   %ax,%ax
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <fmtname>:
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  55:	83 ec 10             	sub    $0x10,%esp
  58:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  5b:	89 1c 24             	mov    %ebx,(%esp)
  5e:	e8 cd 03 00 00       	call   430 <strlen>
  63:	01 d8                	add    %ebx,%eax
  65:	73 10                	jae    77 <fmtname+0x27>
  67:	eb 13                	jmp    7c <fmtname+0x2c>
  69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  70:	83 e8 01             	sub    $0x1,%eax
  73:	39 c3                	cmp    %eax,%ebx
  75:	77 05                	ja     7c <fmtname+0x2c>
  77:	80 38 2f             	cmpb   $0x2f,(%eax)
  7a:	75 f4                	jne    70 <fmtname+0x20>
  p++;
  7c:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
  7f:	89 1c 24             	mov    %ebx,(%esp)
  82:	e8 a9 03 00 00       	call   430 <strlen>
  87:	83 f8 0d             	cmp    $0xd,%eax
  8a:	77 53                	ja     df <fmtname+0x8f>
  memmove(buf, p, strlen(p));
  8c:	89 1c 24             	mov    %ebx,(%esp)
  8f:	e8 9c 03 00 00       	call   430 <strlen>
  94:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  98:	c7 04 24 30 0e 00 00 	movl   $0xe30,(%esp)
  9f:	89 44 24 08          	mov    %eax,0x8(%esp)
  a3:	e8 f8 04 00 00       	call   5a0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  a8:	89 1c 24             	mov    %ebx,(%esp)
  ab:	e8 80 03 00 00       	call   430 <strlen>
  b0:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  b3:	bb 30 0e 00 00       	mov    $0xe30,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 c6                	mov    %eax,%esi
  ba:	e8 71 03 00 00       	call   430 <strlen>
  bf:	ba 0e 00 00 00       	mov    $0xe,%edx
  c4:	29 f2                	sub    %esi,%edx
  c6:	89 54 24 08          	mov    %edx,0x8(%esp)
  ca:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  d1:	00 
  d2:	05 30 0e 00 00       	add    $0xe30,%eax
  d7:	89 04 24             	mov    %eax,(%esp)
  da:	e8 81 03 00 00       	call   460 <memset>
}
  df:	83 c4 10             	add    $0x10,%esp
  e2:	89 d8                	mov    %ebx,%eax
  e4:	5b                   	pop    %ebx
  e5:	5e                   	pop    %esi
  e6:	5d                   	pop    %ebp
  e7:	c3                   	ret    
  e8:	90                   	nop
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <filetype>:
{
  f0:	55                   	push   %ebp
    switch (sttype) {
  f1:	b8 3f 00 00 00       	mov    $0x3f,%eax
{
  f6:	89 e5                	mov    %esp,%ebp
  f8:	8b 55 08             	mov    0x8(%ebp),%edx
  fb:	8d 4a ff             	lea    -0x1(%edx),%ecx
  fe:	83 f9 02             	cmp    $0x2,%ecx
 101:	77 07                	ja     10a <filetype+0x1a>
 103:	0f b6 82 22 0b 00 00 	movzbl 0xb22(%edx),%eax
}
 10a:	5d                   	pop    %ebp
 10b:	c3                   	ret    
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000110 <ls>:
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	81 ec 7c 02 00 00    	sub    $0x27c,%esp
 11c:	8b 75 08             	mov    0x8(%ebp),%esi
  if((fd = open(path, 0)) < 0){
 11f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 126:	00 
 127:	89 34 24             	mov    %esi,(%esp)
 12a:	e8 e3 04 00 00       	call   612 <open>
 12f:	85 c0                	test   %eax,%eax
 131:	89 c3                	mov    %eax,%ebx
 133:	0f 88 e7 01 00 00    	js     320 <ls+0x210>
  if(fstat(fd, &st) < 0){
 139:	8d bd d4 fd ff ff    	lea    -0x22c(%ebp),%edi
 13f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 143:	89 04 24             	mov    %eax,(%esp)
 146:	e8 df 04 00 00       	call   62a <fstat>
 14b:	85 c0                	test   %eax,%eax
 14d:	0f 88 15 02 00 00    	js     368 <ls+0x258>
  switch(st.type){
 153:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 15a:	66 83 f8 01          	cmp    $0x1,%ax
 15e:	74 78                	je     1d8 <ls+0xc8>
 160:	66 83 f8 02          	cmp    $0x2,%ax
 164:	75 5f                	jne    1c5 <ls+0xb5>
      printf(1, "%s %c %d %d %d\n", fmtname(path), filetype(st.type), st.nlink, st.ino, st.size);
 166:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 16c:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 172:	89 34 24             	mov    %esi,(%esp)
 175:	0f bf bd e0 fd ff ff 	movswl -0x220(%ebp),%edi
 17c:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 182:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 188:	e8 c3 fe ff ff       	call   50 <fmtname>
 18d:	8b 8d b0 fd ff ff    	mov    -0x250(%ebp),%ecx
 193:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 199:	89 7c 24 10          	mov    %edi,0x10(%esp)
 19d:	c7 44 24 0c 66 00 00 	movl   $0x66,0xc(%esp)
 1a4:	00 
 1a5:	89 4c 24 18          	mov    %ecx,0x18(%esp)
 1a9:	89 54 24 14          	mov    %edx,0x14(%esp)
 1ad:	89 44 24 08          	mov    %eax,0x8(%esp)
 1b1:	c7 44 24 04 fe 0a 00 	movl   $0xafe,0x4(%esp)
 1b8:	00 
 1b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c0:	e8 7b 05 00 00       	call   740 <printf>
  close(fd);
 1c5:	89 1c 24             	mov    %ebx,(%esp)
 1c8:	e8 2d 04 00 00       	call   5fa <close>
}
 1cd:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 1d3:	5b                   	pop    %ebx
 1d4:	5e                   	pop    %esi
 1d5:	5f                   	pop    %edi
 1d6:	5d                   	pop    %ebp
 1d7:	c3                   	ret    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1d8:	89 34 24             	mov    %esi,(%esp)
 1db:	e8 50 02 00 00       	call   430 <strlen>
 1e0:	83 c0 10             	add    $0x10,%eax
 1e3:	3d 00 02 00 00       	cmp    $0x200,%eax
 1e8:	0f 87 5a 01 00 00    	ja     348 <ls+0x238>
    strcpy(buf, path);
 1ee:	89 74 24 04          	mov    %esi,0x4(%esp)
 1f2:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
 1f8:	89 34 24             	mov    %esi,(%esp)
 1fb:	e8 b0 01 00 00       	call   3b0 <strcpy>
    p = buf+strlen(buf);
 200:	89 34 24             	mov    %esi,(%esp)
 203:	e8 28 02 00 00       	call   430 <strlen>
 208:	01 f0                	add    %esi,%eax
    *p++ = '/';
 20a:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 20d:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
    *p++ = '/';
 213:	89 8d a0 fd ff ff    	mov    %ecx,-0x260(%ebp)
 219:	c6 00 2f             	movb   $0x2f,(%eax)
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 220:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 226:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 22d:	00 
 22e:	89 44 24 04          	mov    %eax,0x4(%esp)
 232:	89 1c 24             	mov    %ebx,(%esp)
 235:	e8 b0 03 00 00       	call   5ea <read>
 23a:	83 f8 10             	cmp    $0x10,%eax
 23d:	75 86                	jne    1c5 <ls+0xb5>
      if(de.inum == 0)
 23f:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 246:	00 
 247:	74 d7                	je     220 <ls+0x110>
      memmove(p, de.name, DIRSIZ);
 249:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 24f:	89 44 24 04          	mov    %eax,0x4(%esp)
 253:	8b 85 a0 fd ff ff    	mov    -0x260(%ebp),%eax
 259:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 260:	00 
 261:	89 04 24             	mov    %eax,(%esp)
 264:	e8 37 03 00 00       	call   5a0 <memmove>
      p[DIRSIZ] = 0;
 269:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 26f:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 273:	89 7c 24 04          	mov    %edi,0x4(%esp)
 277:	89 34 24             	mov    %esi,(%esp)
 27a:	e8 a1 02 00 00       	call   520 <stat>
 27f:	85 c0                	test   %eax,%eax
 281:	0f 88 09 01 00 00    	js     390 <ls+0x280>
      printf(1, "%s %c %d %d %d\n", fmtname(buf), filetype(st.type), st.nlink, st.ino, st.size);
 287:	8b 85 dc fd ff ff    	mov    -0x224(%ebp),%eax
    switch (sttype) {
 28d:	ba 3f 00 00 00       	mov    $0x3f,%edx
      printf(1, "%s %c %d %d %d\n", fmtname(buf), filetype(st.type), st.nlink, st.ino, st.size);
 292:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 298:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 29e:	0f bf 85 e0 fd ff ff 	movswl -0x220(%ebp),%eax
 2a5:	89 85 b0 fd ff ff    	mov    %eax,-0x250(%ebp)
    switch (sttype) {
 2ab:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 2b2:	83 e8 01             	sub    $0x1,%eax
 2b5:	83 f8 02             	cmp    $0x2,%eax
 2b8:	77 07                	ja     2c1 <ls+0x1b1>
 2ba:	0f be 90 23 0b 00 00 	movsbl 0xb23(%eax),%edx
      printf(1, "%s %c %d %d %d\n", fmtname(buf), filetype(st.type), st.nlink, st.ino, st.size);
 2c1:	89 34 24             	mov    %esi,(%esp)
 2c4:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 2ca:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 2d0:	e8 7b fd ff ff       	call   50 <fmtname>
 2d5:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 2db:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 2e1:	c7 44 24 04 fe 0a 00 	movl   $0xafe,0x4(%esp)
 2e8:	00 
 2e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2f0:	89 4c 24 18          	mov    %ecx,0x18(%esp)
 2f4:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 2fa:	89 54 24 10          	mov    %edx,0x10(%esp)
 2fe:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 304:	89 44 24 08          	mov    %eax,0x8(%esp)
 308:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 30c:	89 54 24 0c          	mov    %edx,0xc(%esp)
 310:	e8 2b 04 00 00       	call   740 <printf>
 315:	e9 06 ff ff ff       	jmp    220 <ls+0x110>
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 320:	89 74 24 08          	mov    %esi,0x8(%esp)
 324:	c7 44 24 04 d6 0a 00 	movl   $0xad6,0x4(%esp)
 32b:	00 
 32c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 333:	e8 08 04 00 00       	call   740 <printf>
}
 338:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 33e:	5b                   	pop    %ebx
 33f:	5e                   	pop    %esi
 340:	5f                   	pop    %edi
 341:	5d                   	pop    %ebp
 342:	c3                   	ret    
 343:	90                   	nop
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "ls: path too long\n");
 348:	c7 44 24 04 0e 0b 00 	movl   $0xb0e,0x4(%esp)
 34f:	00 
 350:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 357:	e8 e4 03 00 00       	call   740 <printf>
      break;
 35c:	e9 64 fe ff ff       	jmp    1c5 <ls+0xb5>
 361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot stat %s\n", path);
 368:	89 74 24 08          	mov    %esi,0x8(%esp)
 36c:	c7 44 24 04 ea 0a 00 	movl   $0xaea,0x4(%esp)
 373:	00 
 374:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 37b:	e8 c0 03 00 00       	call   740 <printf>
    close(fd);
 380:	89 1c 24             	mov    %ebx,(%esp)
 383:	e8 72 02 00 00       	call   5fa <close>
    return;
 388:	e9 40 fe ff ff       	jmp    1cd <ls+0xbd>
 38d:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 390:	89 74 24 08          	mov    %esi,0x8(%esp)
 394:	c7 44 24 04 ea 0a 00 	movl   $0xaea,0x4(%esp)
 39b:	00 
 39c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3a3:	e8 98 03 00 00       	call   740 <printf>
        continue;
 3a8:	e9 73 fe ff ff       	jmp    220 <ls+0x110>
 3ad:	66 90                	xchg   %ax,%ax
 3af:	90                   	nop

000003b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 3b9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3ba:	89 c2                	mov    %eax,%edx
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3c0:	83 c1 01             	add    $0x1,%ecx
 3c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 3c7:	83 c2 01             	add    $0x1,%edx
 3ca:	84 db                	test   %bl,%bl
 3cc:	88 5a ff             	mov    %bl,-0x1(%edx)
 3cf:	75 ef                	jne    3c0 <strcpy+0x10>
    ;
  return os;
}
 3d1:	5b                   	pop    %ebx
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 55 08             	mov    0x8(%ebp),%edx
 3e6:	53                   	push   %ebx
 3e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3ea:	0f b6 02             	movzbl (%edx),%eax
 3ed:	84 c0                	test   %al,%al
 3ef:	74 2d                	je     41e <strcmp+0x3e>
 3f1:	0f b6 19             	movzbl (%ecx),%ebx
 3f4:	38 d8                	cmp    %bl,%al
 3f6:	74 0e                	je     406 <strcmp+0x26>
 3f8:	eb 2b                	jmp    425 <strcmp+0x45>
 3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 400:	38 c8                	cmp    %cl,%al
 402:	75 15                	jne    419 <strcmp+0x39>
    p++, q++;
 404:	89 d9                	mov    %ebx,%ecx
 406:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 409:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 40c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 40f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 413:	84 c0                	test   %al,%al
 415:	75 e9                	jne    400 <strcmp+0x20>
 417:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 419:	29 c8                	sub    %ecx,%eax
}
 41b:	5b                   	pop    %ebx
 41c:	5d                   	pop    %ebp
 41d:	c3                   	ret    
 41e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 421:	31 c0                	xor    %eax,%eax
 423:	eb f4                	jmp    419 <strcmp+0x39>
 425:	0f b6 cb             	movzbl %bl,%ecx
 428:	eb ef                	jmp    419 <strcmp+0x39>
 42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000430 <strlen>:

uint
strlen(const char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 436:	80 39 00             	cmpb   $0x0,(%ecx)
 439:	74 12                	je     44d <strlen+0x1d>
 43b:	31 d2                	xor    %edx,%edx
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	83 c2 01             	add    $0x1,%edx
 443:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 447:	89 d0                	mov    %edx,%eax
 449:	75 f5                	jne    440 <strlen+0x10>
    ;
  return n;
}
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 44d:	31 c0                	xor    %eax,%eax
}
 44f:	5d                   	pop    %ebp
 450:	c3                   	ret    
 451:	eb 0d                	jmp    460 <memset>
 453:	90                   	nop
 454:	90                   	nop
 455:	90                   	nop
 456:	90                   	nop
 457:	90                   	nop
 458:	90                   	nop
 459:	90                   	nop
 45a:	90                   	nop
 45b:	90                   	nop
 45c:	90                   	nop
 45d:	90                   	nop
 45e:	90                   	nop
 45f:	90                   	nop

00000460 <memset>:

void*
memset(void *dst, int c, uint n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	8b 55 08             	mov    0x8(%ebp),%edx
 466:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 467:	8b 4d 10             	mov    0x10(%ebp),%ecx
 46a:	8b 45 0c             	mov    0xc(%ebp),%eax
 46d:	89 d7                	mov    %edx,%edi
 46f:	fc                   	cld    
 470:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 472:	89 d0                	mov    %edx,%eax
 474:	5f                   	pop    %edi
 475:	5d                   	pop    %ebp
 476:	c3                   	ret    
 477:	89 f6                	mov    %esi,%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <strchr>:

char*
strchr(const char *s, char c)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	8b 45 08             	mov    0x8(%ebp),%eax
 486:	53                   	push   %ebx
 487:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 48a:	0f b6 18             	movzbl (%eax),%ebx
 48d:	84 db                	test   %bl,%bl
 48f:	74 1d                	je     4ae <strchr+0x2e>
    if(*s == c)
 491:	38 d3                	cmp    %dl,%bl
 493:	89 d1                	mov    %edx,%ecx
 495:	75 0d                	jne    4a4 <strchr+0x24>
 497:	eb 17                	jmp    4b0 <strchr+0x30>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a0:	38 ca                	cmp    %cl,%dl
 4a2:	74 0c                	je     4b0 <strchr+0x30>
  for(; *s; s++)
 4a4:	83 c0 01             	add    $0x1,%eax
 4a7:	0f b6 10             	movzbl (%eax),%edx
 4aa:	84 d2                	test   %dl,%dl
 4ac:	75 f2                	jne    4a0 <strchr+0x20>
      return (char*)s;
  return 0;
 4ae:	31 c0                	xor    %eax,%eax
}
 4b0:	5b                   	pop    %ebx
 4b1:	5d                   	pop    %ebp
 4b2:	c3                   	ret    
 4b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <gets>:

char*
gets(char *buf, int max)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c5:	31 f6                	xor    %esi,%esi
{
 4c7:	53                   	push   %ebx
 4c8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 4cb:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 4ce:	eb 31                	jmp    501 <gets+0x41>
    cc = read(0, &c, 1);
 4d0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d7:	00 
 4d8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4e3:	e8 02 01 00 00       	call   5ea <read>
    if(cc < 1)
 4e8:	85 c0                	test   %eax,%eax
 4ea:	7e 1d                	jle    509 <gets+0x49>
      break;
    buf[i++] = c;
 4ec:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 4f0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 4f2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 4f5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 4f7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 4fb:	74 0c                	je     509 <gets+0x49>
 4fd:	3c 0a                	cmp    $0xa,%al
 4ff:	74 08                	je     509 <gets+0x49>
  for(i=0; i+1 < max; ){
 501:	8d 5e 01             	lea    0x1(%esi),%ebx
 504:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 507:	7c c7                	jl     4d0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 509:	8b 45 08             	mov    0x8(%ebp),%eax
 50c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 510:	83 c4 2c             	add    $0x2c,%esp
 513:	5b                   	pop    %ebx
 514:	5e                   	pop    %esi
 515:	5f                   	pop    %edi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    
 518:	90                   	nop
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000520 <stat>:

int
stat(const char *n, struct stat *st)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	56                   	push   %esi
 524:	53                   	push   %ebx
 525:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 528:	8b 45 08             	mov    0x8(%ebp),%eax
 52b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 532:	00 
 533:	89 04 24             	mov    %eax,(%esp)
 536:	e8 d7 00 00 00       	call   612 <open>
  if(fd < 0)
 53b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 53d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 53f:	78 27                	js     568 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 541:	8b 45 0c             	mov    0xc(%ebp),%eax
 544:	89 1c 24             	mov    %ebx,(%esp)
 547:	89 44 24 04          	mov    %eax,0x4(%esp)
 54b:	e8 da 00 00 00       	call   62a <fstat>
  close(fd);
 550:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 553:	89 c6                	mov    %eax,%esi
  close(fd);
 555:	e8 a0 00 00 00       	call   5fa <close>
  return r;
 55a:	89 f0                	mov    %esi,%eax
}
 55c:	83 c4 10             	add    $0x10,%esp
 55f:	5b                   	pop    %ebx
 560:	5e                   	pop    %esi
 561:	5d                   	pop    %ebp
 562:	c3                   	ret    
 563:	90                   	nop
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 568:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 56d:	eb ed                	jmp    55c <stat+0x3c>
 56f:	90                   	nop

00000570 <atoi>:

int
atoi(const char *s)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	8b 4d 08             	mov    0x8(%ebp),%ecx
 576:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 577:	0f be 11             	movsbl (%ecx),%edx
 57a:	8d 42 d0             	lea    -0x30(%edx),%eax
 57d:	3c 09                	cmp    $0x9,%al
  n = 0;
 57f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 584:	77 17                	ja     59d <atoi+0x2d>
 586:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 588:	83 c1 01             	add    $0x1,%ecx
 58b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 58e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 592:	0f be 11             	movsbl (%ecx),%edx
 595:	8d 5a d0             	lea    -0x30(%edx),%ebx
 598:	80 fb 09             	cmp    $0x9,%bl
 59b:	76 eb                	jbe    588 <atoi+0x18>
  return n;
}
 59d:	5b                   	pop    %ebx
 59e:	5d                   	pop    %ebp
 59f:	c3                   	ret    

000005a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5a0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5a1:	31 d2                	xor    %edx,%edx
{
 5a3:	89 e5                	mov    %esp,%ebp
 5a5:	56                   	push   %esi
 5a6:	8b 45 08             	mov    0x8(%ebp),%eax
 5a9:	53                   	push   %ebx
 5aa:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5ad:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 5b0:	85 db                	test   %ebx,%ebx
 5b2:	7e 12                	jle    5c6 <memmove+0x26>
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 5b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 5bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 5c2:	39 da                	cmp    %ebx,%edx
 5c4:	75 f2                	jne    5b8 <memmove+0x18>
  return vdst;
}
 5c6:	5b                   	pop    %ebx
 5c7:	5e                   	pop    %esi
 5c8:	5d                   	pop    %ebp
 5c9:	c3                   	ret    

000005ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ca:	b8 01 00 00 00       	mov    $0x1,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <exit>:
SYSCALL(exit)
 5d2:	b8 02 00 00 00       	mov    $0x2,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <wait>:
SYSCALL(wait)
 5da:	b8 03 00 00 00       	mov    $0x3,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <pipe>:
SYSCALL(pipe)
 5e2:	b8 04 00 00 00       	mov    $0x4,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <read>:
SYSCALL(read)
 5ea:	b8 05 00 00 00       	mov    $0x5,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <write>:
SYSCALL(write)
 5f2:	b8 10 00 00 00       	mov    $0x10,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <close>:
SYSCALL(close)
 5fa:	b8 15 00 00 00       	mov    $0x15,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <kill>:
SYSCALL(kill)
 602:	b8 06 00 00 00       	mov    $0x6,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <exec>:
SYSCALL(exec)
 60a:	b8 07 00 00 00       	mov    $0x7,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <open>:
SYSCALL(open)
 612:	b8 0f 00 00 00       	mov    $0xf,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <mknod>:
SYSCALL(mknod)
 61a:	b8 11 00 00 00       	mov    $0x11,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <unlink>:
SYSCALL(unlink)
 622:	b8 12 00 00 00       	mov    $0x12,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <fstat>:
SYSCALL(fstat)
 62a:	b8 08 00 00 00       	mov    $0x8,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <link>:
SYSCALL(link)
 632:	b8 13 00 00 00       	mov    $0x13,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <mkdir>:
SYSCALL(mkdir)
 63a:	b8 14 00 00 00       	mov    $0x14,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <chdir>:
SYSCALL(chdir)
 642:	b8 09 00 00 00       	mov    $0x9,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <dup>:
SYSCALL(dup)
 64a:	b8 0a 00 00 00       	mov    $0xa,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <getpid>:
SYSCALL(getpid)
 652:	b8 0b 00 00 00       	mov    $0xb,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <sbrk>:
SYSCALL(sbrk)
 65a:	b8 0c 00 00 00       	mov    $0xc,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <sleep>:
SYSCALL(sleep)
 662:	b8 0d 00 00 00       	mov    $0xd,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <uptime>:
SYSCALL(uptime)
 66a:	b8 0e 00 00 00       	mov    $0xe,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 672:	b8 16 00 00 00       	mov    $0x16,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 67a:	b8 17 00 00 00       	mov    $0x17,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 682:	b8 18 00 00 00       	mov    $0x18,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <halt>:
 68a:	b8 19 00 00 00       	mov    $0x19,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    
 692:	66 90                	xchg   %ax,%ax
 694:	66 90                	xchg   %ax,%ax
 696:	66 90                	xchg   %ax,%ax
 698:	66 90                	xchg   %ax,%ax
 69a:	66 90                	xchg   %ax,%ax
 69c:	66 90                	xchg   %ax,%ax
 69e:	66 90                	xchg   %ax,%ax

000006a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	89 c6                	mov    %eax,%esi
 6a7:	53                   	push   %ebx
 6a8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ae:	85 db                	test   %ebx,%ebx
 6b0:	74 09                	je     6bb <printint+0x1b>
 6b2:	89 d0                	mov    %edx,%eax
 6b4:	c1 e8 1f             	shr    $0x1f,%eax
 6b7:	84 c0                	test   %al,%al
 6b9:	75 75                	jne    730 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6bb:	89 d0                	mov    %edx,%eax
  neg = 0;
 6bd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6c4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 6c7:	31 ff                	xor    %edi,%edi
 6c9:	89 ce                	mov    %ecx,%esi
 6cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 6ce:	eb 02                	jmp    6d2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 6d0:	89 cf                	mov    %ecx,%edi
 6d2:	31 d2                	xor    %edx,%edx
 6d4:	f7 f6                	div    %esi
 6d6:	8d 4f 01             	lea    0x1(%edi),%ecx
 6d9:	0f b6 92 2d 0b 00 00 	movzbl 0xb2d(%edx),%edx
  }while((x /= base) != 0);
 6e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 6e2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 6e5:	75 e9                	jne    6d0 <printint+0x30>
  if(neg)
 6e7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 6ea:	89 c8                	mov    %ecx,%eax
 6ec:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 6ef:	85 d2                	test   %edx,%edx
 6f1:	74 08                	je     6fb <printint+0x5b>
    buf[i++] = '-';
 6f3:	8d 4f 02             	lea    0x2(%edi),%ecx
 6f6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 6fb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 6fe:	66 90                	xchg   %ax,%ax
 700:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 705:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 708:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 70f:	00 
 710:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 714:	89 34 24             	mov    %esi,(%esp)
 717:	88 45 d7             	mov    %al,-0x29(%ebp)
 71a:	e8 d3 fe ff ff       	call   5f2 <write>
  while(--i >= 0)
 71f:	83 ff ff             	cmp    $0xffffffff,%edi
 722:	75 dc                	jne    700 <printint+0x60>
    putc(fd, buf[i]);
}
 724:	83 c4 4c             	add    $0x4c,%esp
 727:	5b                   	pop    %ebx
 728:	5e                   	pop    %esi
 729:	5f                   	pop    %edi
 72a:	5d                   	pop    %ebp
 72b:	c3                   	ret    
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 730:	89 d0                	mov    %edx,%eax
 732:	f7 d8                	neg    %eax
    neg = 1;
 734:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 73b:	eb 87                	jmp    6c4 <printint+0x24>
 73d:	8d 76 00             	lea    0x0(%esi),%esi

00000740 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 744:	31 ff                	xor    %edi,%edi
{
 746:	56                   	push   %esi
 747:	53                   	push   %ebx
 748:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 74b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 74e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 751:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 754:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 757:	0f b6 13             	movzbl (%ebx),%edx
 75a:	83 c3 01             	add    $0x1,%ebx
 75d:	84 d2                	test   %dl,%dl
 75f:	75 39                	jne    79a <printf+0x5a>
 761:	e9 ca 00 00 00       	jmp    830 <printf+0xf0>
 766:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 768:	83 fa 25             	cmp    $0x25,%edx
 76b:	0f 84 c7 00 00 00    	je     838 <printf+0xf8>
  write(fd, &c, 1);
 771:	8d 45 e0             	lea    -0x20(%ebp),%eax
 774:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 77b:	00 
 77c:	89 44 24 04          	mov    %eax,0x4(%esp)
 780:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 783:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 786:	e8 67 fe ff ff       	call   5f2 <write>
 78b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 78e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 792:	84 d2                	test   %dl,%dl
 794:	0f 84 96 00 00 00    	je     830 <printf+0xf0>
    if(state == 0){
 79a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 79c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 79f:	74 c7                	je     768 <printf+0x28>
      }
    } else if(state == '%'){
 7a1:	83 ff 25             	cmp    $0x25,%edi
 7a4:	75 e5                	jne    78b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 7a6:	83 fa 75             	cmp    $0x75,%edx
 7a9:	0f 84 99 00 00 00    	je     848 <printf+0x108>
 7af:	83 fa 64             	cmp    $0x64,%edx
 7b2:	0f 84 90 00 00 00    	je     848 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7b8:	25 f7 00 00 00       	and    $0xf7,%eax
 7bd:	83 f8 70             	cmp    $0x70,%eax
 7c0:	0f 84 aa 00 00 00    	je     870 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7c6:	83 fa 73             	cmp    $0x73,%edx
 7c9:	0f 84 e9 00 00 00    	je     8b8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7cf:	83 fa 63             	cmp    $0x63,%edx
 7d2:	0f 84 2b 01 00 00    	je     903 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7d8:	83 fa 25             	cmp    $0x25,%edx
 7db:	0f 84 4f 01 00 00    	je     930 <printf+0x1f0>
  write(fd, &c, 1);
 7e1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 7e4:	83 c3 01             	add    $0x1,%ebx
 7e7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7ee:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7ef:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 7f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 7f5:	89 34 24             	mov    %esi,(%esp)
 7f8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 7fb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 7ff:	e8 ee fd ff ff       	call   5f2 <write>
        putc(fd, c);
 804:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 807:	8d 45 e7             	lea    -0x19(%ebp),%eax
 80a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 811:	00 
 812:	89 44 24 04          	mov    %eax,0x4(%esp)
 816:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 819:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 81c:	e8 d1 fd ff ff       	call   5f2 <write>
  for(i = 0; fmt[i]; i++){
 821:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 825:	84 d2                	test   %dl,%dl
 827:	0f 85 6d ff ff ff    	jne    79a <printf+0x5a>
 82d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 830:	83 c4 3c             	add    $0x3c,%esp
 833:	5b                   	pop    %ebx
 834:	5e                   	pop    %esi
 835:	5f                   	pop    %edi
 836:	5d                   	pop    %ebp
 837:	c3                   	ret    
        state = '%';
 838:	bf 25 00 00 00       	mov    $0x25,%edi
 83d:	e9 49 ff ff ff       	jmp    78b <printf+0x4b>
 842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 848:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 84f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 854:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 857:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 859:	8b 10                	mov    (%eax),%edx
 85b:	89 f0                	mov    %esi,%eax
 85d:	e8 3e fe ff ff       	call   6a0 <printint>
        ap++;
 862:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 866:	e9 20 ff ff ff       	jmp    78b <printf+0x4b>
 86b:	90                   	nop
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 870:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 873:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 87a:	00 
 87b:	89 44 24 04          	mov    %eax,0x4(%esp)
 87f:	89 34 24             	mov    %esi,(%esp)
 882:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 886:	e8 67 fd ff ff       	call   5f2 <write>
 88b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 88e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 895:	00 
 896:	89 44 24 04          	mov    %eax,0x4(%esp)
 89a:	89 34 24             	mov    %esi,(%esp)
 89d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 8a1:	e8 4c fd ff ff       	call   5f2 <write>
        printint(fd, *ap, 16, 0);
 8a6:	b9 10 00 00 00       	mov    $0x10,%ecx
 8ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 8b2:	eb a0                	jmp    854 <printf+0x114>
 8b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 8b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 8bb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 8bf:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 8c1:	b8 26 0b 00 00       	mov    $0xb26,%eax
 8c6:	85 ff                	test   %edi,%edi
 8c8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 8cb:	0f b6 07             	movzbl (%edi),%eax
 8ce:	84 c0                	test   %al,%al
 8d0:	74 2a                	je     8fc <printf+0x1bc>
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8d8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 8db:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 8de:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 8e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8e8:	00 
 8e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ed:	89 34 24             	mov    %esi,(%esp)
 8f0:	e8 fd fc ff ff       	call   5f2 <write>
        while(*s != 0){
 8f5:	0f b6 07             	movzbl (%edi),%eax
 8f8:	84 c0                	test   %al,%al
 8fa:	75 dc                	jne    8d8 <printf+0x198>
      state = 0;
 8fc:	31 ff                	xor    %edi,%edi
 8fe:	e9 88 fe ff ff       	jmp    78b <printf+0x4b>
        putc(fd, *ap);
 903:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 906:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 908:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 90a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 911:	00 
 912:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 915:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 918:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 91b:	89 44 24 04          	mov    %eax,0x4(%esp)
 91f:	e8 ce fc ff ff       	call   5f2 <write>
        ap++;
 924:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 928:	e9 5e fe ff ff       	jmp    78b <printf+0x4b>
 92d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 930:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 933:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 935:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 93c:	00 
 93d:	89 44 24 04          	mov    %eax,0x4(%esp)
 941:	89 34 24             	mov    %esi,(%esp)
 944:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 948:	e8 a5 fc ff ff       	call   5f2 <write>
 94d:	e9 39 fe ff ff       	jmp    78b <printf+0x4b>
 952:	66 90                	xchg   %ax,%ax
 954:	66 90                	xchg   %ax,%ax
 956:	66 90                	xchg   %ax,%ax
 958:	66 90                	xchg   %ax,%ax
 95a:	66 90                	xchg   %ax,%ax
 95c:	66 90                	xchg   %ax,%ax
 95e:	66 90                	xchg   %ax,%ax

00000960 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 960:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 961:	a1 40 0e 00 00       	mov    0xe40,%eax
{
 966:	89 e5                	mov    %esp,%ebp
 968:	57                   	push   %edi
 969:	56                   	push   %esi
 96a:	53                   	push   %ebx
 96b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 970:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 973:	39 d0                	cmp    %edx,%eax
 975:	72 11                	jb     988 <free+0x28>
 977:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	39 c8                	cmp    %ecx,%eax
 97a:	72 04                	jb     980 <free+0x20>
 97c:	39 ca                	cmp    %ecx,%edx
 97e:	72 10                	jb     990 <free+0x30>
 980:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 982:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 984:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 986:	73 f0                	jae    978 <free+0x18>
 988:	39 ca                	cmp    %ecx,%edx
 98a:	72 04                	jb     990 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98c:	39 c8                	cmp    %ecx,%eax
 98e:	72 f0                	jb     980 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 990:	8b 73 fc             	mov    -0x4(%ebx),%esi
 993:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 996:	39 cf                	cmp    %ecx,%edi
 998:	74 1e                	je     9b8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 99a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 99d:	8b 48 04             	mov    0x4(%eax),%ecx
 9a0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 9a3:	39 f2                	cmp    %esi,%edx
 9a5:	74 28                	je     9cf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9a7:	89 10                	mov    %edx,(%eax)
  freep = p;
 9a9:	a3 40 0e 00 00       	mov    %eax,0xe40
}
 9ae:	5b                   	pop    %ebx
 9af:	5e                   	pop    %esi
 9b0:	5f                   	pop    %edi
 9b1:	5d                   	pop    %ebp
 9b2:	c3                   	ret    
 9b3:	90                   	nop
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 9b8:	03 71 04             	add    0x4(%ecx),%esi
 9bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9be:	8b 08                	mov    (%eax),%ecx
 9c0:	8b 09                	mov    (%ecx),%ecx
 9c2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9c5:	8b 48 04             	mov    0x4(%eax),%ecx
 9c8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 9cb:	39 f2                	cmp    %esi,%edx
 9cd:	75 d8                	jne    9a7 <free+0x47>
    p->s.size += bp->s.size;
 9cf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 9d2:	a3 40 0e 00 00       	mov    %eax,0xe40
    p->s.size += bp->s.size;
 9d7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9da:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9dd:	89 10                	mov    %edx,(%eax)
}
 9df:	5b                   	pop    %ebx
 9e0:	5e                   	pop    %esi
 9e1:	5f                   	pop    %edi
 9e2:	5d                   	pop    %ebp
 9e3:	c3                   	ret    
 9e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000009f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
 9f3:	57                   	push   %edi
 9f4:	56                   	push   %esi
 9f5:	53                   	push   %ebx
 9f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9fc:	8b 1d 40 0e 00 00    	mov    0xe40,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a02:	8d 48 07             	lea    0x7(%eax),%ecx
 a05:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 a08:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 a0d:	0f 84 9b 00 00 00    	je     aae <malloc+0xbe>
 a13:	8b 13                	mov    (%ebx),%edx
 a15:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a18:	39 fe                	cmp    %edi,%esi
 a1a:	76 64                	jbe    a80 <malloc+0x90>
 a1c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 a23:	bb 00 80 00 00       	mov    $0x8000,%ebx
 a28:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 a2b:	eb 0e                	jmp    a3b <malloc+0x4b>
 a2d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a30:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a32:	8b 78 04             	mov    0x4(%eax),%edi
 a35:	39 fe                	cmp    %edi,%esi
 a37:	76 4f                	jbe    a88 <malloc+0x98>
 a39:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a3b:	3b 15 40 0e 00 00    	cmp    0xe40,%edx
 a41:	75 ed                	jne    a30 <malloc+0x40>
  if(nu < 4096)
 a43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 a46:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 a4c:	bf 00 10 00 00       	mov    $0x1000,%edi
 a51:	0f 43 fe             	cmovae %esi,%edi
 a54:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 a57:	89 04 24             	mov    %eax,(%esp)
 a5a:	e8 fb fb ff ff       	call   65a <sbrk>
  if(p == (char*)-1)
 a5f:	83 f8 ff             	cmp    $0xffffffff,%eax
 a62:	74 18                	je     a7c <malloc+0x8c>
  hp->s.size = nu;
 a64:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 a67:	83 c0 08             	add    $0x8,%eax
 a6a:	89 04 24             	mov    %eax,(%esp)
 a6d:	e8 ee fe ff ff       	call   960 <free>
  return freep;
 a72:	8b 15 40 0e 00 00    	mov    0xe40,%edx
      if((p = morecore(nunits)) == 0)
 a78:	85 d2                	test   %edx,%edx
 a7a:	75 b4                	jne    a30 <malloc+0x40>
        return 0;
 a7c:	31 c0                	xor    %eax,%eax
 a7e:	eb 20                	jmp    aa0 <malloc+0xb0>
    if(p->s.size >= nunits){
 a80:	89 d0                	mov    %edx,%eax
 a82:	89 da                	mov    %ebx,%edx
 a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 a88:	39 fe                	cmp    %edi,%esi
 a8a:	74 1c                	je     aa8 <malloc+0xb8>
        p->s.size -= nunits;
 a8c:	29 f7                	sub    %esi,%edi
 a8e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 a91:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 a94:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 a97:	89 15 40 0e 00 00    	mov    %edx,0xe40
      return (void*)(p + 1);
 a9d:	83 c0 08             	add    $0x8,%eax
  }
}
 aa0:	83 c4 1c             	add    $0x1c,%esp
 aa3:	5b                   	pop    %ebx
 aa4:	5e                   	pop    %esi
 aa5:	5f                   	pop    %edi
 aa6:	5d                   	pop    %ebp
 aa7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 aa8:	8b 08                	mov    (%eax),%ecx
 aaa:	89 0a                	mov    %ecx,(%edx)
 aac:	eb e9                	jmp    a97 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 aae:	c7 05 40 0e 00 00 44 	movl   $0xe44,0xe40
 ab5:	0e 00 00 
    base.s.size = 0;
 ab8:	ba 44 0e 00 00       	mov    $0xe44,%edx
    base.s.ptr = freep = prevp = &base;
 abd:	c7 05 44 0e 00 00 44 	movl   $0xe44,0xe44
 ac4:	0e 00 00 
    base.s.size = 0;
 ac7:	c7 05 48 0e 00 00 00 	movl   $0x0,0xe48
 ace:	00 00 00 
 ad1:	e9 46 ff ff ff       	jmp    a1c <malloc+0x2c>
