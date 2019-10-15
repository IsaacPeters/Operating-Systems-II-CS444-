
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 20 2e 10 80       	mov    $0x80102e20,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	c7 44 24 04 20 6d 10 	movl   $0x80106d20,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010005b:	e8 20 41 00 00       	call   80104180 <initlock>
  bcache.head.next = &bcache.head;
80100060:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
  bcache.head.prev = &bcache.head;
80100065:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006f:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100076:	fc 10 80 
80100079:	eb 09                	jmp    80100084 <binit+0x44>
8010007b:	90                   	nop
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100082:	89 c3                	mov    %eax,%ebx
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 04 24             	mov    %eax,(%esp)
80100094:	c7 44 24 04 27 6d 10 	movl   $0x80106d27,0x4(%esp)
8010009b:	80 
8010009c:	e8 af 3f 00 00       	call   80104050 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a6:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000af:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
    bcache.head.next = b;
801000b4:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ba:	75 c4                	jne    80100080 <binit+0x40>
  }
}
801000bc:	83 c4 14             	add    $0x14,%esp
801000bf:	5b                   	pop    %ebx
801000c0:	5d                   	pop    %ebp
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&bcache.lock);
801000dc:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
{
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 05 42 00 00       	call   801042f0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000f1:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100161:	e8 fa 41 00 00       	call   80104360 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 1f 3f 00 00       	call   80104090 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 d2 1f 00 00       	call   80102150 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
  panic("bget: no buffers");
80100188:	c7 04 24 2e 6d 10 80 	movl   $0x80106d2e,(%esp)
8010018f:	e8 cc 01 00 00       	call   80100360 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 7b 3f 00 00       	call   80104130 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
  iderw(b);
801001c4:	e9 87 1f 00 00       	jmp    80102150 <iderw>
    panic("bwrite");
801001c9:	c7 04 24 3f 6d 10 80 	movl   $0x80106d3f,(%esp)
801001d0:	e8 8b 01 00 00       	call   80100360 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 3a 3f 00 00       	call   80104130 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5b                	je     80100255 <brelse+0x75>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 ee 3e 00 00       	call   801040f0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100209:	e8 e2 40 00 00       	call   801042f0 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
8010020e:	83 6b 4c 01          	subl   $0x1,0x4c(%ebx)
80100212:	75 2f                	jne    80100243 <brelse+0x63>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100214:	8b 43 54             	mov    0x54(%ebx),%eax
80100217:	8b 53 50             	mov    0x50(%ebx),%edx
8010021a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021d:	8b 43 50             	mov    0x50(%ebx),%eax
80100220:	8b 53 54             	mov    0x54(%ebx),%edx
80100223:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100226:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
8010022b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
80100232:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100235:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
8010023a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023d:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
80100243:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
8010024a:	83 c4 10             	add    $0x10,%esp
8010024d:	5b                   	pop    %ebx
8010024e:	5e                   	pop    %esi
8010024f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100250:	e9 0b 41 00 00       	jmp    80104360 <release>
    panic("brelse");
80100255:	c7 04 24 46 6d 10 80 	movl   $0x80106d46,(%esp)
8010025c:	e8 ff 00 00 00       	call   80100360 <panic>
80100261:	66 90                	xchg   %ax,%ax
80100263:	66 90                	xchg   %ax,%ax
80100265:	66 90                	xchg   %ax,%ax
80100267:	66 90                	xchg   %ax,%ax
80100269:	66 90                	xchg   %ax,%ax
8010026b:	66 90                	xchg   %ax,%ax
8010026d:	66 90                	xchg   %ax,%ax
8010026f:	90                   	nop

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 1c             	sub    $0x1c,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	89 3c 24             	mov    %edi,(%esp)
80100282:	e8 39 15 00 00       	call   801017c0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028e:	e8 5d 40 00 00       	call   801042f0 <acquire>
  while(n > 0){
80100293:	8b 55 10             	mov    0x10(%ebp),%edx
80100296:	85 d2                	test   %edx,%edx
80100298:	0f 8e bc 00 00 00    	jle    8010035a <consoleread+0xea>
8010029e:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002a1:	eb 25                	jmp    801002c8 <consoleread+0x58>
801002a3:	90                   	nop
801002a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(myproc()->killed){
801002a8:	e8 23 34 00 00       	call   801036d0 <myproc>
801002ad:	8b 40 24             	mov    0x24(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 74                	jne    80100328 <consoleread+0xb8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b4:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
801002bb:	80 
801002bc:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801002c3:	e8 68 39 00 00       	call   80103c30 <sleep>
    while(input.r == input.w){
801002c8:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002cd:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d3:	74 d3                	je     801002a8 <consoleread+0x38>
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d5:	8d 50 01             	lea    0x1(%eax),%edx
801002d8:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
801002de:	89 c2                	mov    %eax,%edx
801002e0:	83 e2 7f             	and    $0x7f,%edx
801002e3:	0f b6 8a 20 ff 10 80 	movzbl -0x7fef00e0(%edx),%ecx
801002ea:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
801002ed:	83 fa 04             	cmp    $0x4,%edx
801002f0:	74 57                	je     80100349 <consoleread+0xd9>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f2:	83 c6 01             	add    $0x1,%esi
    --n;
801002f5:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
801002f8:	83 fa 0a             	cmp    $0xa,%edx
    *dst++ = c;
801002fb:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
801002fe:	74 53                	je     80100353 <consoleread+0xe3>
  while(n > 0){
80100300:	85 db                	test   %ebx,%ebx
80100302:	75 c4                	jne    801002c8 <consoleread+0x58>
80100304:	8b 45 10             	mov    0x10(%ebp),%eax
      break;
  }
  release(&cons.lock);
80100307:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010030e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100311:	e8 4a 40 00 00       	call   80104360 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 c2 13 00 00       	call   801016e0 <ilock>
8010031e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return target - n;
80100321:	eb 1e                	jmp    80100341 <consoleread+0xd1>
80100323:	90                   	nop
80100324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&cons.lock);
80100328:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010032f:	e8 2c 40 00 00       	call   80104360 <release>
        ilock(ip);
80100334:	89 3c 24             	mov    %edi,(%esp)
80100337:	e8 a4 13 00 00       	call   801016e0 <ilock>
        return -1;
8010033c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100341:	83 c4 1c             	add    $0x1c,%esp
80100344:	5b                   	pop    %ebx
80100345:	5e                   	pop    %esi
80100346:	5f                   	pop    %edi
80100347:	5d                   	pop    %ebp
80100348:	c3                   	ret    
      if(n < target){
80100349:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010034c:	76 05                	jbe    80100353 <consoleread+0xe3>
        input.r--;
8010034e:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100353:	8b 45 10             	mov    0x10(%ebp),%eax
80100356:	29 d8                	sub    %ebx,%eax
80100358:	eb ad                	jmp    80100307 <consoleread+0x97>
  while(n > 0){
8010035a:	31 c0                	xor    %eax,%eax
8010035c:	eb a9                	jmp    80100307 <consoleread+0x97>
8010035e:	66 90                	xchg   %ax,%ax

80100360 <panic>:
{
80100360:	55                   	push   %ebp
80100361:	89 e5                	mov    %esp,%ebp
80100363:	56                   	push   %esi
80100364:	53                   	push   %ebx
80100365:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100368:	fa                   	cli    
  cons.locking = 0;
80100369:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100370:	00 00 00 
  getcallerpcs(&s, pcs);
80100373:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100376:	e8 15 24 00 00       	call   80102790 <lapicid>
8010037b:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010037e:	c7 04 24 4d 6d 10 80 	movl   $0x80106d4d,(%esp)
80100385:	89 44 24 04          	mov    %eax,0x4(%esp)
80100389:	e8 c2 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010038e:	8b 45 08             	mov    0x8(%ebp),%eax
80100391:	89 04 24             	mov    %eax,(%esp)
80100394:	e8 b7 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
80100399:	c7 04 24 df 76 10 80 	movl   $0x801076df,(%esp)
801003a0:	e8 ab 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003a5:	8d 45 08             	lea    0x8(%ebp),%eax
801003a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ac:	89 04 24             	mov    %eax,(%esp)
801003af:	e8 ec 3d 00 00       	call   801041a0 <getcallerpcs>
801003b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003b8:	8b 03                	mov    (%ebx),%eax
801003ba:	83 c3 04             	add    $0x4,%ebx
801003bd:	c7 04 24 61 6d 10 80 	movl   $0x80106d61,(%esp)
801003c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c8:	e8 83 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003cd:	39 f3                	cmp    %esi,%ebx
801003cf:	75 e7                	jne    801003b8 <panic+0x58>
  panicked = 1; // freeze other CPU
801003d1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003d8:	00 00 00 
801003db:	eb fe                	jmp    801003db <panic+0x7b>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi

801003e0 <consputc>:
  if(panicked){
801003e0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003e6:	85 d2                	test   %edx,%edx
801003e8:	74 06                	je     801003f0 <consputc+0x10>
801003ea:	fa                   	cli    
801003eb:	eb fe                	jmp    801003eb <consputc+0xb>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	53                   	push   %ebx
801003f6:	89 c3                	mov    %eax,%ebx
801003f8:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
801003fb:	3d 00 01 00 00       	cmp    $0x100,%eax
80100400:	0f 84 ac 00 00 00    	je     801004b2 <consputc+0xd2>
    uartputc(c);
80100406:	89 04 24             	mov    %eax,(%esp)
80100409:	e8 82 54 00 00       	call   80105890 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010040e:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100413:	b8 0e 00 00 00       	mov    $0xe,%eax
80100418:	89 fa                	mov    %edi,%edx
8010041a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041b:	be d5 03 00 00       	mov    $0x3d5,%esi
80100420:	89 f2                	mov    %esi,%edx
80100422:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100423:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100426:	89 fa                	mov    %edi,%edx
80100428:	c1 e1 08             	shl    $0x8,%ecx
8010042b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100430:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100434:	0f b6 c0             	movzbl %al,%eax
80100437:	09 c1                	or     %eax,%ecx
  if(c == '\n')
80100439:	83 fb 0a             	cmp    $0xa,%ebx
8010043c:	0f 84 0d 01 00 00    	je     8010054f <consputc+0x16f>
  else if(c == BACKSPACE){
80100442:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100448:	0f 84 e8 00 00 00    	je     80100536 <consputc+0x156>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010044e:	0f b6 db             	movzbl %bl,%ebx
80100451:	80 cf 07             	or     $0x7,%bh
80100454:	8d 79 01             	lea    0x1(%ecx),%edi
80100457:	66 89 9c 09 00 80 0b 	mov    %bx,-0x7ff48000(%ecx,%ecx,1)
8010045e:	80 
  if(pos < 0 || pos > 25*80)
8010045f:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
80100465:	0f 87 bf 00 00 00    	ja     8010052a <consputc+0x14a>
  if((pos/80) >= 24){  // Scroll up.
8010046b:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100471:	7f 68                	jg     801004db <consputc+0xfb>
80100473:	89 f8                	mov    %edi,%eax
80100475:	89 fb                	mov    %edi,%ebx
80100477:	c1 e8 08             	shr    $0x8,%eax
8010047a:	89 c6                	mov    %eax,%esi
8010047c:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100483:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100488:	b8 0e 00 00 00       	mov    $0xe,%eax
8010048d:	89 fa                	mov    %edi,%edx
8010048f:	ee                   	out    %al,(%dx)
80100490:	89 f0                	mov    %esi,%eax
80100492:	b2 d5                	mov    $0xd5,%dl
80100494:	ee                   	out    %al,(%dx)
80100495:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049a:	89 fa                	mov    %edi,%edx
8010049c:	ee                   	out    %al,(%dx)
8010049d:	89 d8                	mov    %ebx,%eax
8010049f:	b2 d5                	mov    $0xd5,%dl
801004a1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a2:	b8 20 07 00 00       	mov    $0x720,%eax
801004a7:	66 89 01             	mov    %ax,(%ecx)
}
801004aa:	83 c4 1c             	add    $0x1c,%esp
801004ad:	5b                   	pop    %ebx
801004ae:	5e                   	pop    %esi
801004af:	5f                   	pop    %edi
801004b0:	5d                   	pop    %ebp
801004b1:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004b2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004b9:	e8 d2 53 00 00       	call   80105890 <uartputc>
801004be:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004c5:	e8 c6 53 00 00       	call   80105890 <uartputc>
801004ca:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004d1:	e8 ba 53 00 00       	call   80105890 <uartputc>
801004d6:	e9 33 ff ff ff       	jmp    8010040e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004db:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004e2:	00 
    pos -= 80;
801004e3:	8d 5f b0             	lea    -0x50(%edi),%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004e6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004ed:	80 
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004ee:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f5:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
801004fc:	e8 4f 3f 00 00       	call   80104450 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100501:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100506:	29 f8                	sub    %edi,%eax
80100508:	01 c0                	add    %eax,%eax
8010050a:	89 34 24             	mov    %esi,(%esp)
8010050d:	89 44 24 08          	mov    %eax,0x8(%esp)
80100511:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100518:	00 
80100519:	e8 92 3e 00 00       	call   801043b0 <memset>
8010051e:	89 f1                	mov    %esi,%ecx
80100520:	be 07 00 00 00       	mov    $0x7,%esi
80100525:	e9 59 ff ff ff       	jmp    80100483 <consputc+0xa3>
    panic("pos under/overflow");
8010052a:	c7 04 24 65 6d 10 80 	movl   $0x80106d65,(%esp)
80100531:	e8 2a fe ff ff       	call   80100360 <panic>
    if(pos > 0) --pos;
80100536:	85 c9                	test   %ecx,%ecx
80100538:	8d 79 ff             	lea    -0x1(%ecx),%edi
8010053b:	0f 85 1e ff ff ff    	jne    8010045f <consputc+0x7f>
80100541:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
80100546:	31 db                	xor    %ebx,%ebx
80100548:	31 f6                	xor    %esi,%esi
8010054a:	e9 34 ff ff ff       	jmp    80100483 <consputc+0xa3>
    pos += 80 - pos%80;
8010054f:	89 c8                	mov    %ecx,%eax
80100551:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100556:	f7 ea                	imul   %edx
80100558:	c1 ea 05             	shr    $0x5,%edx
8010055b:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010055e:	c1 e0 04             	shl    $0x4,%eax
80100561:	8d 78 50             	lea    0x50(%eax),%edi
80100564:	e9 f6 fe ff ff       	jmp    8010045f <consputc+0x7f>
80100569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	89 d6                	mov    %edx,%esi
80100577:	53                   	push   %ebx
80100578:	83 ec 1c             	sub    $0x1c,%esp
  if(sign && (sign = xx < 0))
8010057b:	85 c9                	test   %ecx,%ecx
8010057d:	74 61                	je     801005e0 <printint+0x70>
8010057f:	85 c0                	test   %eax,%eax
80100581:	79 5d                	jns    801005e0 <printint+0x70>
    x = -xx;
80100583:	f7 d8                	neg    %eax
80100585:	bf 01 00 00 00       	mov    $0x1,%edi
  i = 0;
8010058a:	31 c9                	xor    %ecx,%ecx
8010058c:	eb 04                	jmp    80100592 <printint+0x22>
8010058e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100590:	89 d9                	mov    %ebx,%ecx
80100592:	31 d2                	xor    %edx,%edx
80100594:	f7 f6                	div    %esi
80100596:	8d 59 01             	lea    0x1(%ecx),%ebx
80100599:	0f b6 92 90 6d 10 80 	movzbl -0x7fef9270(%edx),%edx
  }while((x /= base) != 0);
801005a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005a2:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005a6:	75 e8                	jne    80100590 <printint+0x20>
  if(sign)
801005a8:	85 ff                	test   %edi,%edi
    buf[i++] = digits[x % base];
801005aa:	89 d8                	mov    %ebx,%eax
  if(sign)
801005ac:	74 08                	je     801005b6 <printint+0x46>
    buf[i++] = '-';
801005ae:	8d 59 02             	lea    0x2(%ecx),%ebx
801005b1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
  while(--i >= 0)
801005b6:	83 eb 01             	sub    $0x1,%ebx
801005b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
801005c0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  while(--i >= 0)
801005c5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801005c8:	e8 13 fe ff ff       	call   801003e0 <consputc>
  while(--i >= 0)
801005cd:	83 fb ff             	cmp    $0xffffffff,%ebx
801005d0:	75 ee                	jne    801005c0 <printint+0x50>
}
801005d2:	83 c4 1c             	add    $0x1c,%esp
801005d5:	5b                   	pop    %ebx
801005d6:	5e                   	pop    %esi
801005d7:	5f                   	pop    %edi
801005d8:	5d                   	pop    %ebp
801005d9:	c3                   	ret    
801005da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    x = xx;
801005e0:	31 ff                	xor    %edi,%edi
801005e2:	eb a6                	jmp    8010058a <printint+0x1a>
801005e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801005f0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005f9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801005fc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ff:	89 04 24             	mov    %eax,(%esp)
80100602:	e8 b9 11 00 00       	call   801017c0 <iunlock>
  acquire(&cons.lock);
80100607:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010060e:	e8 dd 3c 00 00       	call   801042f0 <acquire>
80100613:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100616:	85 f6                	test   %esi,%esi
80100618:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010061b:	7e 12                	jle    8010062f <consolewrite+0x3f>
8010061d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100620:	0f b6 07             	movzbl (%edi),%eax
80100623:	83 c7 01             	add    $0x1,%edi
80100626:	e8 b5 fd ff ff       	call   801003e0 <consputc>
  for(i = 0; i < n; i++)
8010062b:	39 df                	cmp    %ebx,%edi
8010062d:	75 f1                	jne    80100620 <consolewrite+0x30>
  release(&cons.lock);
8010062f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100636:	e8 25 3d 00 00       	call   80104360 <release>
  ilock(ip);
8010063b:	8b 45 08             	mov    0x8(%ebp),%eax
8010063e:	89 04 24             	mov    %eax,(%esp)
80100641:	e8 9a 10 00 00       	call   801016e0 <ilock>

  return n;
}
80100646:	83 c4 1c             	add    $0x1c,%esp
80100649:	89 f0                	mov    %esi,%eax
8010064b:	5b                   	pop    %ebx
8010064c:	5e                   	pop    %esi
8010064d:	5f                   	pop    %edi
8010064e:	5d                   	pop    %ebp
8010064f:	c3                   	ret    

80100650 <cprintf>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100659:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010065e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100660:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100663:	0f 85 3f 01 00 00    	jne    801007a8 <cprintf+0x158>
  if (fmt == 0)
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	89 c1                	mov    %eax,%ecx
80100670:	0f 84 43 01 00 00    	je     801007b9 <cprintf+0x169>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100676:	0f b6 00             	movzbl (%eax),%eax
80100679:	31 db                	xor    %ebx,%ebx
8010067b:	89 cf                	mov    %ecx,%edi
8010067d:	8d 75 0c             	lea    0xc(%ebp),%esi
80100680:	85 c0                	test   %eax,%eax
80100682:	74 7f                	je     80100703 <cprintf+0xb3>
80100684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c != '%'){
80100688:	83 f8 25             	cmp    $0x25,%eax
8010068b:	0f 85 a7 00 00 00    	jne    80100738 <cprintf+0xe8>
    c = fmt[++i] & 0xff;
80100691:	83 c3 01             	add    $0x1,%ebx
80100694:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
80100698:	85 d2                	test   %edx,%edx
8010069a:	74 67                	je     80100703 <cprintf+0xb3>
    switch(c){
8010069c:	83 fa 70             	cmp    $0x70,%edx
8010069f:	0f 84 d3 00 00 00    	je     80100778 <cprintf+0x128>
801006a5:	0f 8e 95 00 00 00    	jle    80100740 <cprintf+0xf0>
801006ab:	83 fa 75             	cmp    $0x75,%edx
801006ae:	66 90                	xchg   %ax,%ax
801006b0:	0f 84 94 00 00 00    	je     8010074a <cprintf+0xfa>
801006b6:	83 fa 78             	cmp    $0x78,%edx
801006b9:	0f 84 b9 00 00 00    	je     80100778 <cprintf+0x128>
801006bf:	83 fa 73             	cmp    $0x73,%edx
801006c2:	75 5c                	jne    80100720 <cprintf+0xd0>
      if((s = (char*)*argp++) == 0)
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	8b 36                	mov    (%esi),%esi
801006c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
801006cc:	b8 78 6d 10 80       	mov    $0x80106d78,%eax
801006d1:	85 f6                	test   %esi,%esi
801006d3:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
801006d6:	0f be 06             	movsbl (%esi),%eax
801006d9:	84 c0                	test   %al,%al
801006db:	74 12                	je     801006ef <cprintf+0x9f>
801006dd:	8d 76 00             	lea    0x0(%esi),%esi
801006e0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801006e3:	e8 f8 fc ff ff       	call   801003e0 <consputc>
      for(; *s; s++)
801006e8:	0f be 06             	movsbl (%esi),%eax
801006eb:	84 c0                	test   %al,%al
801006ed:	75 f1                	jne    801006e0 <cprintf+0x90>
      if((s = (char*)*argp++) == 0)
801006ef:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801006f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f8:	83 c3 01             	add    $0x1,%ebx
801006fb:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006ff:	85 c0                	test   %eax,%eax
80100701:	75 85                	jne    80100688 <cprintf+0x38>
  if(locking)
80100703:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100706:	85 c0                	test   %eax,%eax
80100708:	74 0c                	je     80100716 <cprintf+0xc6>
    release(&cons.lock);
8010070a:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100711:	e8 4a 3c 00 00       	call   80104360 <release>
}
80100716:	83 c4 1c             	add    $0x1c,%esp
80100719:	5b                   	pop    %ebx
8010071a:	5e                   	pop    %esi
8010071b:	5f                   	pop    %edi
8010071c:	5d                   	pop    %ebp
8010071d:	c3                   	ret    
8010071e:	66 90                	xchg   %ax,%ax
      consputc('%');
80100720:	b8 25 00 00 00       	mov    $0x25,%eax
80100725:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100728:	e8 b3 fc ff ff       	call   801003e0 <consputc>
      consputc(c);
8010072d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100730:	89 d0                	mov    %edx,%eax
80100732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100738:	e8 a3 fc ff ff       	call   801003e0 <consputc>
      break;
8010073d:	eb b9                	jmp    801006f8 <cprintf+0xa8>
8010073f:	90                   	nop
    switch(c){
80100740:	83 fa 25             	cmp    $0x25,%edx
80100743:	74 23                	je     80100768 <cprintf+0x118>
80100745:	83 fa 64             	cmp    $0x64,%edx
80100748:	75 d6                	jne    80100720 <cprintf+0xd0>
      printint(*argp++, 10, 1);
8010074a:	8d 46 04             	lea    0x4(%esi),%eax
8010074d:	b9 01 00 00 00       	mov    $0x1,%ecx
80100752:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100755:	8b 06                	mov    (%esi),%eax
80100757:	ba 0a 00 00 00       	mov    $0xa,%edx
8010075c:	e8 0f fe ff ff       	call   80100570 <printint>
80100761:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100764:	eb 92                	jmp    801006f8 <cprintf+0xa8>
80100766:	66 90                	xchg   %ax,%ax
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 6e fc ff ff       	call   801003e0 <consputc>
      break;
80100772:	eb 84                	jmp    801006f8 <cprintf+0xa8>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('0');
80100778:	b8 30 00 00 00       	mov    $0x30,%eax
8010077d:	e8 5e fc ff ff       	call   801003e0 <consputc>
      consputc('x');
80100782:	b8 78 00 00 00       	mov    $0x78,%eax
80100787:	e8 54 fc ff ff       	call   801003e0 <consputc>
      printint(*argp++, 16, 0);
8010078c:	8d 46 04             	lea    0x4(%esi),%eax
8010078f:	31 c9                	xor    %ecx,%ecx
80100791:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100794:	8b 06                	mov    (%esi),%eax
80100796:	ba 10 00 00 00       	mov    $0x10,%edx
8010079b:	e8 d0 fd ff ff       	call   80100570 <printint>
801007a0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
801007a3:	e9 50 ff ff ff       	jmp    801006f8 <cprintf+0xa8>
    acquire(&cons.lock);
801007a8:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007af:	e8 3c 3b 00 00       	call   801042f0 <acquire>
801007b4:	e9 b0 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007b9:	c7 04 24 7f 6d 10 80 	movl   $0x80106d7f,(%esp)
801007c0:	e8 9b fb ff ff       	call   80100360 <panic>
801007c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801007c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007d0 <consoleintr>:
{
801007d0:	55                   	push   %ebp
801007d1:	89 e5                	mov    %esp,%ebp
801007d3:	57                   	push   %edi
801007d4:	56                   	push   %esi
  int c, doprocdump = 0;
801007d5:	31 f6                	xor    %esi,%esi
{
801007d7:	53                   	push   %ebx
801007d8:	83 ec 1c             	sub    $0x1c,%esp
801007db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007de:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007e5:	e8 06 3b 00 00       	call   801042f0 <acquire>
801007ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
801007f0:	ff d3                	call   *%ebx
801007f2:	85 c0                	test   %eax,%eax
801007f4:	89 c7                	mov    %eax,%edi
801007f6:	78 48                	js     80100840 <consoleintr+0x70>
    switch(c){
801007f8:	83 ff 10             	cmp    $0x10,%edi
801007fb:	0f 84 2f 01 00 00    	je     80100930 <consoleintr+0x160>
80100801:	7e 5d                	jle    80100860 <consoleintr+0x90>
80100803:	83 ff 15             	cmp    $0x15,%edi
80100806:	0f 84 d4 00 00 00    	je     801008e0 <consoleintr+0x110>
8010080c:	83 ff 7f             	cmp    $0x7f,%edi
8010080f:	90                   	nop
80100810:	75 53                	jne    80100865 <consoleintr+0x95>
      if(input.e != input.w){
80100812:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100817:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010081d:	74 d1                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081f:	83 e8 01             	sub    $0x1,%eax
80100822:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100827:	b8 00 01 00 00       	mov    $0x100,%eax
8010082c:	e8 af fb ff ff       	call   801003e0 <consputc>
  while((c = getc()) >= 0){
80100831:	ff d3                	call   *%ebx
80100833:	85 c0                	test   %eax,%eax
80100835:	89 c7                	mov    %eax,%edi
80100837:	79 bf                	jns    801007f8 <consoleintr+0x28>
80100839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100840:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100847:	e8 14 3b 00 00       	call   80104360 <release>
  if(doprocdump) {
8010084c:	85 f6                	test   %esi,%esi
8010084e:	0f 85 ec 00 00 00    	jne    80100940 <consoleintr+0x170>
}
80100854:	83 c4 1c             	add    $0x1c,%esp
80100857:	5b                   	pop    %ebx
80100858:	5e                   	pop    %esi
80100859:	5f                   	pop    %edi
8010085a:	5d                   	pop    %ebp
8010085b:	c3                   	ret    
8010085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100860:	83 ff 08             	cmp    $0x8,%edi
80100863:	74 ad                	je     80100812 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100865:	85 ff                	test   %edi,%edi
80100867:	74 87                	je     801007f0 <consoleintr+0x20>
80100869:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010086e:	89 c2                	mov    %eax,%edx
80100870:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100876:	83 fa 7f             	cmp    $0x7f,%edx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
8010087f:	8d 50 01             	lea    0x1(%eax),%edx
80100882:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100885:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 b8 00 00 00    	je     8010094c <consoleintr+0x17c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	89 f9                	mov    %edi,%ecx
80100896:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
8010089c:	89 f8                	mov    %edi,%eax
8010089e:	e8 3d fb ff ff       	call   801003e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008a3:	83 ff 04             	cmp    $0x4,%edi
801008a6:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ab:	74 19                	je     801008c6 <consoleintr+0xf6>
801008ad:	83 ff 0a             	cmp    $0xa,%edi
801008b0:	74 14                	je     801008c6 <consoleintr+0xf6>
801008b2:	8b 0d a0 ff 10 80    	mov    0x8010ffa0,%ecx
801008b8:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
801008be:	39 d0                	cmp    %edx,%eax
801008c0:	0f 85 2a ff ff ff    	jne    801007f0 <consoleintr+0x20>
          wakeup(&input.r);
801008c6:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
          input.w = input.e;
801008cd:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801008d2:	e8 e9 34 00 00       	call   80103dc0 <wakeup>
801008d7:	e9 14 ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
801008e0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008e5:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008eb:	75 2b                	jne    80100918 <consoleintr+0x148>
801008ed:	e9 fe fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
801008f8:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
801008fd:	b8 00 01 00 00       	mov    $0x100,%eax
80100902:	e8 d9 fa ff ff       	call   801003e0 <consputc>
      while(input.e != input.w &&
80100907:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010090c:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100912:	0f 84 d8 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100918:	83 e8 01             	sub    $0x1,%eax
8010091b:	89 c2                	mov    %eax,%edx
8010091d:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100920:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100927:	75 cf                	jne    801008f8 <consoleintr+0x128>
80100929:	e9 c2 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010092e:	66 90                	xchg   %ax,%ax
      doprocdump = 1;
80100930:	be 01 00 00 00       	mov    $0x1,%esi
80100935:	e9 b6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010093a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80100940:	83 c4 1c             	add    $0x1c,%esp
80100943:	5b                   	pop    %ebx
80100944:	5e                   	pop    %esi
80100945:	5f                   	pop    %edi
80100946:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100947:	e9 34 36 00 00       	jmp    80103f80 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
8010094c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100953:	b8 0a 00 00 00       	mov    $0xa,%eax
80100958:	e8 83 fa ff ff       	call   801003e0 <consputc>
8010095d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100962:	e9 5f ff ff ff       	jmp    801008c6 <consoleintr+0xf6>
80100967:	89 f6                	mov    %esi,%esi
80100969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100970 <consoleinit>:

void
consoleinit(void)
{
80100970:	55                   	push   %ebp
80100971:	89 e5                	mov    %esp,%ebp
80100973:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100976:	c7 44 24 04 88 6d 10 	movl   $0x80106d88,0x4(%esp)
8010097d:	80 
8010097e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100985:	e8 f6 37 00 00       	call   80104180 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
8010098a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100991:	00 
80100992:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
80100999:	c7 05 6c 09 11 80 f0 	movl   $0x801005f0,0x8011096c
801009a0:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801009a3:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009aa:	02 10 80 
  cons.locking = 1;
801009ad:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009b4:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009b7:	e8 24 19 00 00       	call   801022e0 <ioapicenable>
}
801009bc:	c9                   	leave  
801009bd:	c3                   	ret    
801009be:	66 90                	xchg   %ax,%ax

801009c0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	57                   	push   %edi
801009c4:	56                   	push   %esi
801009c5:	53                   	push   %ebx
801009c6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009cc:	e8 ff 2c 00 00       	call   801036d0 <myproc>
801009d1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009d7:	e8 64 21 00 00       	call   80102b40 <begin_op>

  if((ip = namei(path)) == 0){
801009dc:	8b 45 08             	mov    0x8(%ebp),%eax
801009df:	89 04 24             	mov    %eax,(%esp)
801009e2:	e8 49 15 00 00       	call   80101f30 <namei>
801009e7:	85 c0                	test   %eax,%eax
801009e9:	89 c3                	mov    %eax,%ebx
801009eb:	0f 84 c2 01 00 00    	je     80100bb3 <exec+0x1f3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009f1:	89 04 24             	mov    %eax,(%esp)
801009f4:	e8 e7 0c 00 00       	call   801016e0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801009f9:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801009ff:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100a06:	00 
80100a07:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100a0e:	00 
80100a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a13:	89 1c 24             	mov    %ebx,(%esp)
80100a16:	e8 75 0f 00 00       	call   80101990 <readi>
80100a1b:	83 f8 34             	cmp    $0x34,%eax
80100a1e:	74 20                	je     80100a40 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a20:	89 1c 24             	mov    %ebx,(%esp)
80100a23:	e8 18 0f 00 00       	call   80101940 <iunlockput>
    end_op();
80100a28:	e8 83 21 00 00       	call   80102bb0 <end_op>
  }
  return -1;
80100a2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a32:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100a38:	5b                   	pop    %ebx
80100a39:	5e                   	pop    %esi
80100a3a:	5f                   	pop    %edi
80100a3b:	5d                   	pop    %ebp
80100a3c:	c3                   	ret    
80100a3d:	8d 76 00             	lea    0x0(%esi),%esi
  if(elf.magic != ELF_MAGIC)
80100a40:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a47:	45 4c 46 
80100a4a:	75 d4                	jne    80100a20 <exec+0x60>
  if((pgdir = setupkvm()) == 0)
80100a4c:	e8 2f 60 00 00       	call   80106a80 <setupkvm>
80100a51:	85 c0                	test   %eax,%eax
80100a53:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a59:	74 c5                	je     80100a20 <exec+0x60>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a5b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a62:	00 
80100a63:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
  sz = 0;
80100a69:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a70:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a73:	0f 84 da 00 00 00    	je     80100b53 <exec+0x193>
80100a79:	31 ff                	xor    %edi,%edi
80100a7b:	eb 18                	jmp    80100a95 <exec+0xd5>
80100a7d:	8d 76 00             	lea    0x0(%esi),%esi
80100a80:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a87:	83 c7 01             	add    $0x1,%edi
80100a8a:	83 c6 20             	add    $0x20,%esi
80100a8d:	39 f8                	cmp    %edi,%eax
80100a8f:	0f 8e be 00 00 00    	jle    80100b53 <exec+0x193>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a95:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100a9b:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100aa2:	00 
80100aa3:	89 74 24 08          	mov    %esi,0x8(%esp)
80100aa7:	89 44 24 04          	mov    %eax,0x4(%esp)
80100aab:	89 1c 24             	mov    %ebx,(%esp)
80100aae:	e8 dd 0e 00 00       	call   80101990 <readi>
80100ab3:	83 f8 20             	cmp    $0x20,%eax
80100ab6:	0f 85 84 00 00 00    	jne    80100b40 <exec+0x180>
    if(ph.type != ELF_PROG_LOAD)
80100abc:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ac3:	75 bb                	jne    80100a80 <exec+0xc0>
    if(ph.memsz < ph.filesz)
80100ac5:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100acb:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ad1:	72 6d                	jb     80100b40 <exec+0x180>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ad3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ad9:	72 65                	jb     80100b40 <exec+0x180>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100adb:	89 44 24 08          	mov    %eax,0x8(%esp)
80100adf:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100ae5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ae9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100aef:	89 04 24             	mov    %eax,(%esp)
80100af2:	e8 f9 5d 00 00       	call   801068f0 <allocuvm>
80100af7:	85 c0                	test   %eax,%eax
80100af9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100aff:	74 3f                	je     80100b40 <exec+0x180>
    if(ph.vaddr % PGSIZE != 0)
80100b01:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b07:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0c:	75 32                	jne    80100b40 <exec+0x180>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b0e:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100b14:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b18:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b1e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b22:	89 54 24 10          	mov    %edx,0x10(%esp)
80100b26:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100b2c:	89 04 24             	mov    %eax,(%esp)
80100b2f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b33:	e8 f8 5c 00 00       	call   80106830 <loaduvm>
80100b38:	85 c0                	test   %eax,%eax
80100b3a:	0f 89 40 ff ff ff    	jns    80100a80 <exec+0xc0>
    freevm(pgdir);
80100b40:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b46:	89 04 24             	mov    %eax,(%esp)
80100b49:	e8 b2 5e 00 00       	call   80106a00 <freevm>
80100b4e:	e9 cd fe ff ff       	jmp    80100a20 <exec+0x60>
  iunlockput(ip);
80100b53:	89 1c 24             	mov    %ebx,(%esp)
80100b56:	e8 e5 0d 00 00       	call   80101940 <iunlockput>
80100b5b:	90                   	nop
80100b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100b60:	e8 4b 20 00 00       	call   80102bb0 <end_op>
  sz = PGROUNDUP(sz);
80100b65:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b6b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b70:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b75:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b7f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b85:	89 54 24 08          	mov    %edx,0x8(%esp)
80100b89:	89 04 24             	mov    %eax,(%esp)
80100b8c:	e8 5f 5d 00 00       	call   801068f0 <allocuvm>
80100b91:	85 c0                	test   %eax,%eax
80100b93:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100b99:	75 33                	jne    80100bce <exec+0x20e>
    freevm(pgdir);
80100b9b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba1:	89 04 24             	mov    %eax,(%esp)
80100ba4:	e8 57 5e 00 00       	call   80106a00 <freevm>
  return -1;
80100ba9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bae:	e9 7f fe ff ff       	jmp    80100a32 <exec+0x72>
    end_op();
80100bb3:	e8 f8 1f 00 00       	call   80102bb0 <end_op>
    cprintf("exec: fail\n");
80100bb8:	c7 04 24 a1 6d 10 80 	movl   $0x80106da1,(%esp)
80100bbf:	e8 8c fa ff ff       	call   80100650 <cprintf>
    return -1;
80100bc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc9:	e9 64 fe ff ff       	jmp    80100a32 <exec+0x72>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bce:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100bd4:	89 d8                	mov    %ebx,%eax
80100bd6:	2d 00 20 00 00       	sub    $0x2000,%eax
80100bdb:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bdf:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100be5:	89 04 24             	mov    %eax,(%esp)
80100be8:	e8 43 5f 00 00       	call   80106b30 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bed:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bf0:	8b 00                	mov    (%eax),%eax
80100bf2:	85 c0                	test   %eax,%eax
80100bf4:	0f 84 59 01 00 00    	je     80100d53 <exec+0x393>
80100bfa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100bfd:	31 d2                	xor    %edx,%edx
80100bff:	8d 71 04             	lea    0x4(%ecx),%esi
80100c02:	89 cf                	mov    %ecx,%edi
80100c04:	89 d1                	mov    %edx,%ecx
80100c06:	89 f2                	mov    %esi,%edx
80100c08:	89 fe                	mov    %edi,%esi
80100c0a:	89 cf                	mov    %ecx,%edi
80100c0c:	eb 0a                	jmp    80100c18 <exec+0x258>
80100c0e:	66 90                	xchg   %ax,%ax
80100c10:	83 c2 04             	add    $0x4,%edx
    if(argc >= MAXARG)
80100c13:	83 ff 20             	cmp    $0x20,%edi
80100c16:	74 83                	je     80100b9b <exec+0x1db>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c18:	89 04 24             	mov    %eax,(%esp)
80100c1b:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100c21:	e8 aa 39 00 00       	call   801045d0 <strlen>
80100c26:	f7 d0                	not    %eax
80100c28:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c2a:	8b 06                	mov    (%esi),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c2c:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c2f:	89 04 24             	mov    %eax,(%esp)
80100c32:	e8 99 39 00 00       	call   801045d0 <strlen>
80100c37:	83 c0 01             	add    $0x1,%eax
80100c3a:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c3e:	8b 06                	mov    (%esi),%eax
80100c40:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c4e:	89 04 24             	mov    %eax,(%esp)
80100c51:	e8 3a 60 00 00       	call   80106c90 <copyout>
80100c56:	85 c0                	test   %eax,%eax
80100c58:	0f 88 3d ff ff ff    	js     80100b9b <exec+0x1db>
  for(argc = 0; argv[argc]; argc++) {
80100c5e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
    ustack[3+argc] = sp;
80100c64:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100c6a:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c71:	83 c7 01             	add    $0x1,%edi
80100c74:	8b 02                	mov    (%edx),%eax
80100c76:	89 d6                	mov    %edx,%esi
80100c78:	85 c0                	test   %eax,%eax
80100c7a:	75 94                	jne    80100c10 <exec+0x250>
80100c7c:	89 fa                	mov    %edi,%edx
  ustack[3+argc] = 0;
80100c7e:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100c85:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c89:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
  ustack[1] = argc;
80100c90:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c96:	89 da                	mov    %ebx,%edx
80100c98:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100c9a:	83 c0 0c             	add    $0xc,%eax
80100c9d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9f:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100ca3:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ca9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100cad:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[0] = 0xffffffff;  // fake return PC
80100cb1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100cb8:	ff ff ff 
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbb:	89 04 24             	mov    %eax,(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cbe:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc4:	e8 c7 5f 00 00       	call   80106c90 <copyout>
80100cc9:	85 c0                	test   %eax,%eax
80100ccb:	0f 88 ca fe ff ff    	js     80100b9b <exec+0x1db>
  for(last=s=path; *s; s++)
80100cd1:	8b 45 08             	mov    0x8(%ebp),%eax
80100cd4:	0f b6 10             	movzbl (%eax),%edx
80100cd7:	84 d2                	test   %dl,%dl
80100cd9:	74 19                	je     80100cf4 <exec+0x334>
80100cdb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cde:	83 c0 01             	add    $0x1,%eax
      last = s+1;
80100ce1:	80 fa 2f             	cmp    $0x2f,%dl
  for(last=s=path; *s; s++)
80100ce4:	0f b6 10             	movzbl (%eax),%edx
      last = s+1;
80100ce7:	0f 44 c8             	cmove  %eax,%ecx
80100cea:	83 c0 01             	add    $0x1,%eax
  for(last=s=path; *s; s++)
80100ced:	84 d2                	test   %dl,%dl
80100cef:	75 f0                	jne    80100ce1 <exec+0x321>
80100cf1:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfa:	8b 45 08             	mov    0x8(%ebp),%eax
80100cfd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100d04:	00 
80100d05:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d09:	89 f8                	mov    %edi,%eax
80100d0b:	83 c0 6c             	add    $0x6c,%eax
80100d0e:	89 04 24             	mov    %eax,(%esp)
80100d11:	e8 7a 38 00 00       	call   80104590 <safestrcpy>
  curproc->pgdir = pgdir;
80100d16:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d1c:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->tf->eip = elf.entry;  // main
80100d1f:	8b 47 18             	mov    0x18(%edi),%eax
  curproc->pgdir = pgdir;
80100d22:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100d25:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100d2b:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100d2d:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d33:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d36:	8b 47 18             	mov    0x18(%edi),%eax
80100d39:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d3c:	89 3c 24             	mov    %edi,(%esp)
80100d3f:	e8 5c 59 00 00       	call   801066a0 <switchuvm>
  freevm(oldpgdir);
80100d44:	89 34 24             	mov    %esi,(%esp)
80100d47:	e8 b4 5c 00 00       	call   80106a00 <freevm>
  return 0;
80100d4c:	31 c0                	xor    %eax,%eax
80100d4e:	e9 df fc ff ff       	jmp    80100a32 <exec+0x72>
  for(argc = 0; argv[argc]; argc++) {
80100d53:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100d59:	31 d2                	xor    %edx,%edx
80100d5b:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d61:	e9 18 ff ff ff       	jmp    80100c7e <exec+0x2be>
80100d66:	66 90                	xchg   %ax,%ax
80100d68:	66 90                	xchg   %ax,%ax
80100d6a:	66 90                	xchg   %ax,%ax
80100d6c:	66 90                	xchg   %ax,%ax
80100d6e:	66 90                	xchg   %ax,%ax

80100d70 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d76:	c7 44 24 04 ad 6d 10 	movl   $0x80106dad,0x4(%esp)
80100d7d:	80 
80100d7e:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d85:	e8 f6 33 00 00       	call   80104180 <initlock>
}
80100d8a:	c9                   	leave  
80100d8b:	c3                   	ret    
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d90 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d90:	55                   	push   %ebp
80100d91:	89 e5                	mov    %esp,%ebp
80100d93:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d94:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100d99:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d9c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100da3:	e8 48 35 00 00       	call   801042f0 <acquire>
80100da8:	eb 11                	jmp    80100dbb <filealloc+0x2b>
80100daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100db0:	83 c3 18             	add    $0x18,%ebx
80100db3:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100db9:	74 25                	je     80100de0 <filealloc+0x50>
    if(f->ref == 0){
80100dbb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dbe:	85 c0                	test   %eax,%eax
80100dc0:	75 ee                	jne    80100db0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100dc2:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
      f->ref = 1;
80100dc9:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dd0:	e8 8b 35 00 00       	call   80104360 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dd5:	83 c4 14             	add    $0x14,%esp
      return f;
80100dd8:	89 d8                	mov    %ebx,%eax
}
80100dda:	5b                   	pop    %ebx
80100ddb:	5d                   	pop    %ebp
80100ddc:	c3                   	ret    
80100ddd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100de0:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100de7:	e8 74 35 00 00       	call   80104360 <release>
}
80100dec:	83 c4 14             	add    $0x14,%esp
  return 0;
80100def:	31 c0                	xor    %eax,%eax
}
80100df1:	5b                   	pop    %ebx
80100df2:	5d                   	pop    %ebp
80100df3:	c3                   	ret    
80100df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100e00 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	53                   	push   %ebx
80100e04:	83 ec 14             	sub    $0x14,%esp
80100e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e0a:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e11:	e8 da 34 00 00       	call   801042f0 <acquire>
  if(f->ref < 1)
80100e16:	8b 43 04             	mov    0x4(%ebx),%eax
80100e19:	85 c0                	test   %eax,%eax
80100e1b:	7e 1a                	jle    80100e37 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100e1d:	83 c0 01             	add    $0x1,%eax
80100e20:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e23:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e2a:	e8 31 35 00 00       	call   80104360 <release>
  return f;
}
80100e2f:	83 c4 14             	add    $0x14,%esp
80100e32:	89 d8                	mov    %ebx,%eax
80100e34:	5b                   	pop    %ebx
80100e35:	5d                   	pop    %ebp
80100e36:	c3                   	ret    
    panic("filedup");
80100e37:	c7 04 24 b4 6d 10 80 	movl   $0x80106db4,(%esp)
80100e3e:	e8 1d f5 ff ff       	call   80100360 <panic>
80100e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e50 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	57                   	push   %edi
80100e54:	56                   	push   %esi
80100e55:	53                   	push   %ebx
80100e56:	83 ec 1c             	sub    $0x1c,%esp
80100e59:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e5c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e63:	e8 88 34 00 00       	call   801042f0 <acquire>
  if(f->ref < 1)
80100e68:	8b 57 04             	mov    0x4(%edi),%edx
80100e6b:	85 d2                	test   %edx,%edx
80100e6d:	0f 8e 89 00 00 00    	jle    80100efc <fileclose+0xac>
    panic("fileclose");
  if(--f->ref > 0){
80100e73:	83 ea 01             	sub    $0x1,%edx
80100e76:	85 d2                	test   %edx,%edx
80100e78:	89 57 04             	mov    %edx,0x4(%edi)
80100e7b:	74 13                	je     80100e90 <fileclose+0x40>
    release(&ftable.lock);
80100e7d:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e84:	83 c4 1c             	add    $0x1c,%esp
80100e87:	5b                   	pop    %ebx
80100e88:	5e                   	pop    %esi
80100e89:	5f                   	pop    %edi
80100e8a:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e8b:	e9 d0 34 00 00       	jmp    80104360 <release>
  ff = *f;
80100e90:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e94:	8b 37                	mov    (%edi),%esi
80100e96:	8b 5f 0c             	mov    0xc(%edi),%ebx
  f->type = FD_NONE;
80100e99:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  ff = *f;
80100e9f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ea2:	8b 47 10             	mov    0x10(%edi),%eax
  release(&ftable.lock);
80100ea5:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
  ff = *f;
80100eac:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100eaf:	e8 ac 34 00 00       	call   80104360 <release>
  if(ff.type == FD_PIPE)
80100eb4:	83 fe 01             	cmp    $0x1,%esi
80100eb7:	74 0f                	je     80100ec8 <fileclose+0x78>
  else if(ff.type == FD_INODE){
80100eb9:	83 fe 02             	cmp    $0x2,%esi
80100ebc:	74 22                	je     80100ee0 <fileclose+0x90>
}
80100ebe:	83 c4 1c             	add    $0x1c,%esp
80100ec1:	5b                   	pop    %ebx
80100ec2:	5e                   	pop    %esi
80100ec3:	5f                   	pop    %edi
80100ec4:	5d                   	pop    %ebp
80100ec5:	c3                   	ret    
80100ec6:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
80100ecc:	89 1c 24             	mov    %ebx,(%esp)
80100ecf:	89 74 24 04          	mov    %esi,0x4(%esp)
80100ed3:	e8 b8 23 00 00       	call   80103290 <pipeclose>
80100ed8:	eb e4                	jmp    80100ebe <fileclose+0x6e>
80100eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    begin_op();
80100ee0:	e8 5b 1c 00 00       	call   80102b40 <begin_op>
    iput(ff.ip);
80100ee5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ee8:	89 04 24             	mov    %eax,(%esp)
80100eeb:	e8 10 09 00 00       	call   80101800 <iput>
}
80100ef0:	83 c4 1c             	add    $0x1c,%esp
80100ef3:	5b                   	pop    %ebx
80100ef4:	5e                   	pop    %esi
80100ef5:	5f                   	pop    %edi
80100ef6:	5d                   	pop    %ebp
    end_op();
80100ef7:	e9 b4 1c 00 00       	jmp    80102bb0 <end_op>
    panic("fileclose");
80100efc:	c7 04 24 bc 6d 10 80 	movl   $0x80106dbc,(%esp)
80100f03:	e8 58 f4 ff ff       	call   80100360 <panic>
80100f08:	90                   	nop
80100f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 14             	sub    $0x14,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	8b 43 10             	mov    0x10(%ebx),%eax
80100f22:	89 04 24             	mov    %eax,(%esp)
80100f25:	e8 b6 07 00 00       	call   801016e0 <ilock>
    stati(f->ip, st);
80100f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f2d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
80100f34:	89 04 24             	mov    %eax,(%esp)
80100f37:	e8 24 0a 00 00       	call   80101960 <stati>
    iunlock(f->ip);
80100f3c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f3f:	89 04 24             	mov    %eax,(%esp)
80100f42:	e8 79 08 00 00       	call   801017c0 <iunlock>
    return 0;
  }
  return -1;
}
80100f47:	83 c4 14             	add    $0x14,%esp
    return 0;
80100f4a:	31 c0                	xor    %eax,%eax
}
80100f4c:	5b                   	pop    %ebx
80100f4d:	5d                   	pop    %ebp
80100f4e:	c3                   	ret    
80100f4f:	90                   	nop
80100f50:	83 c4 14             	add    $0x14,%esp
  return -1;
80100f53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f58:	5b                   	pop    %ebx
80100f59:	5d                   	pop    %ebp
80100f5a:	c3                   	ret    
80100f5b:	90                   	nop
80100f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 1c             	sub    $0x1c,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 68                	je     80100fe0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 49                	je     80100fc8 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 63                	jne    80100fe7 <fileread+0x87>
    ilock(f->ip);
80100f84:	8b 43 10             	mov    0x10(%ebx),%eax
80100f87:	89 04 24             	mov    %eax,(%esp)
80100f8a:	e8 51 07 00 00       	call   801016e0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f93:	8b 43 14             	mov    0x14(%ebx),%eax
80100f96:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f9a:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f9e:	8b 43 10             	mov    0x10(%ebx),%eax
80100fa1:	89 04 24             	mov    %eax,(%esp)
80100fa4:	e8 e7 09 00 00       	call   80101990 <readi>
80100fa9:	85 c0                	test   %eax,%eax
80100fab:	89 c6                	mov    %eax,%esi
80100fad:	7e 03                	jle    80100fb2 <fileread+0x52>
      f->off += r;
80100faf:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fb2:	8b 43 10             	mov    0x10(%ebx),%eax
80100fb5:	89 04 24             	mov    %eax,(%esp)
80100fb8:	e8 03 08 00 00       	call   801017c0 <iunlock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fbd:	89 f0                	mov    %esi,%eax
    return r;
  }
  panic("fileread");
}
80100fbf:	83 c4 1c             	add    $0x1c,%esp
80100fc2:	5b                   	pop    %ebx
80100fc3:	5e                   	pop    %esi
80100fc4:	5f                   	pop    %edi
80100fc5:	5d                   	pop    %ebp
80100fc6:	c3                   	ret    
80100fc7:	90                   	nop
    return piperead(f->pipe, addr, n);
80100fc8:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fcb:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fce:	83 c4 1c             	add    $0x1c,%esp
80100fd1:	5b                   	pop    %ebx
80100fd2:	5e                   	pop    %esi
80100fd3:	5f                   	pop    %edi
80100fd4:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fd5:	e9 36 24 00 00       	jmp    80103410 <piperead>
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fe5:	eb d8                	jmp    80100fbf <fileread+0x5f>
  panic("fileread");
80100fe7:	c7 04 24 c6 6d 10 80 	movl   $0x80106dc6,(%esp)
80100fee:	e8 6d f3 ff ff       	call   80100360 <panic>
80100ff3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101000 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 2c             	sub    $0x2c,%esp
80101009:	8b 45 0c             	mov    0xc(%ebp),%eax
8010100c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010100f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101012:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101015:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
80101019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010101c:	0f 84 ae 00 00 00    	je     801010d0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101022:	8b 07                	mov    (%edi),%eax
80101024:	83 f8 01             	cmp    $0x1,%eax
80101027:	0f 84 c2 00 00 00    	je     801010ef <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010102d:	83 f8 02             	cmp    $0x2,%eax
80101030:	0f 85 d7 00 00 00    	jne    8010110d <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101036:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101039:	31 db                	xor    %ebx,%ebx
8010103b:	85 c0                	test   %eax,%eax
8010103d:	7f 31                	jg     80101070 <filewrite+0x70>
8010103f:	e9 9c 00 00 00       	jmp    801010e0 <filewrite+0xe0>
80101044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101048:	8b 4f 10             	mov    0x10(%edi),%ecx
        f->off += r;
8010104b:	01 47 14             	add    %eax,0x14(%edi)
8010104e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101051:	89 0c 24             	mov    %ecx,(%esp)
80101054:	e8 67 07 00 00       	call   801017c0 <iunlock>
      end_op();
80101059:	e8 52 1b 00 00       	call   80102bb0 <end_op>
8010105e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101061:	39 f0                	cmp    %esi,%eax
80101063:	0f 85 98 00 00 00    	jne    80101101 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101069:	01 c3                	add    %eax,%ebx
    while(i < n){
8010106b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010106e:	7e 70                	jle    801010e0 <filewrite+0xe0>
      int n1 = n - i;
80101070:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101073:	b8 00 06 00 00       	mov    $0x600,%eax
80101078:	29 de                	sub    %ebx,%esi
8010107a:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80101080:	0f 4f f0             	cmovg  %eax,%esi
      begin_op();
80101083:	e8 b8 1a 00 00       	call   80102b40 <begin_op>
      ilock(f->ip);
80101088:	8b 47 10             	mov    0x10(%edi),%eax
8010108b:	89 04 24             	mov    %eax,(%esp)
8010108e:	e8 4d 06 00 00       	call   801016e0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101093:	89 74 24 0c          	mov    %esi,0xc(%esp)
80101097:	8b 47 14             	mov    0x14(%edi),%eax
8010109a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010109e:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010a1:	01 d8                	add    %ebx,%eax
801010a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801010a7:	8b 47 10             	mov    0x10(%edi),%eax
801010aa:	89 04 24             	mov    %eax,(%esp)
801010ad:	e8 de 09 00 00       	call   80101a90 <writei>
801010b2:	85 c0                	test   %eax,%eax
801010b4:	7f 92                	jg     80101048 <filewrite+0x48>
      iunlock(f->ip);
801010b6:	8b 4f 10             	mov    0x10(%edi),%ecx
801010b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010bc:	89 0c 24             	mov    %ecx,(%esp)
801010bf:	e8 fc 06 00 00       	call   801017c0 <iunlock>
      end_op();
801010c4:	e8 e7 1a 00 00       	call   80102bb0 <end_op>
      if(r < 0)
801010c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010cc:	85 c0                	test   %eax,%eax
801010ce:	74 91                	je     80101061 <filewrite+0x61>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d0:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801010d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
801010dc:	c3                   	ret    
801010dd:	8d 76 00             	lea    0x0(%esi),%esi
    return i == n ? n : -1;
801010e0:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
801010e3:	89 d8                	mov    %ebx,%eax
801010e5:	75 e9                	jne    801010d0 <filewrite+0xd0>
}
801010e7:	83 c4 2c             	add    $0x2c,%esp
801010ea:	5b                   	pop    %ebx
801010eb:	5e                   	pop    %esi
801010ec:	5f                   	pop    %edi
801010ed:	5d                   	pop    %ebp
801010ee:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801010ef:	8b 47 0c             	mov    0xc(%edi),%eax
801010f2:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010f5:	83 c4 2c             	add    $0x2c,%esp
801010f8:	5b                   	pop    %ebx
801010f9:	5e                   	pop    %esi
801010fa:	5f                   	pop    %edi
801010fb:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010fc:	e9 1f 22 00 00       	jmp    80103320 <pipewrite>
        panic("short filewrite");
80101101:	c7 04 24 cf 6d 10 80 	movl   $0x80106dcf,(%esp)
80101108:	e8 53 f2 ff ff       	call   80100360 <panic>
  panic("filewrite");
8010110d:	c7 04 24 d5 6d 10 80 	movl   $0x80106dd5,(%esp)
80101114:	e8 47 f2 ff ff       	call   80100360 <panic>
80101119:	66 90                	xchg   %ax,%ax
8010111b:	66 90                	xchg   %ax,%ax
8010111d:	66 90                	xchg   %ax,%ax
8010111f:	90                   	nop

80101120 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	56                   	push   %esi
80101125:	53                   	push   %ebx
80101126:	83 ec 2c             	sub    $0x2c,%esp
80101129:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010112c:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101131:	85 c0                	test   %eax,%eax
80101133:	0f 84 8c 00 00 00    	je     801011c5 <balloc+0xa5>
80101139:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101140:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101143:	89 f0                	mov    %esi,%eax
80101145:	c1 f8 0c             	sar    $0xc,%eax
80101148:	03 05 d8 09 11 80    	add    0x801109d8,%eax
8010114e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101152:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101155:	89 04 24             	mov    %eax,(%esp)
80101158:	e8 73 ef ff ff       	call   801000d0 <bread>
8010115d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101160:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101165:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101168:	31 c0                	xor    %eax,%eax
8010116a:	eb 33                	jmp    8010119f <balloc+0x7f>
8010116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101170:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101173:	89 c2                	mov    %eax,%edx
      m = 1 << (bi % 8);
80101175:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101177:	c1 fa 03             	sar    $0x3,%edx
      m = 1 << (bi % 8);
8010117a:	83 e1 07             	and    $0x7,%ecx
8010117d:	bf 01 00 00 00       	mov    $0x1,%edi
80101182:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101184:	0f b6 5c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ebx
      m = 1 << (bi % 8);
80101189:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010118b:	0f b6 fb             	movzbl %bl,%edi
8010118e:	85 cf                	test   %ecx,%edi
80101190:	74 46                	je     801011d8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101192:	83 c0 01             	add    $0x1,%eax
80101195:	83 c6 01             	add    $0x1,%esi
80101198:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010119d:	74 05                	je     801011a4 <balloc+0x84>
8010119f:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801011a2:	72 cc                	jb     80101170 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011a7:	89 04 24             	mov    %eax,(%esp)
801011aa:	e8 31 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801011af:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011b9:	3b 05 c0 09 11 80    	cmp    0x801109c0,%eax
801011bf:	0f 82 7b ff ff ff    	jb     80101140 <balloc+0x20>
  }
  panic("balloc: out of blocks");
801011c5:	c7 04 24 df 6d 10 80 	movl   $0x80106ddf,(%esp)
801011cc:	e8 8f f1 ff ff       	call   80100360 <panic>
801011d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801011d8:	09 d9                	or     %ebx,%ecx
801011da:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011dd:	88 4c 13 5c          	mov    %cl,0x5c(%ebx,%edx,1)
        log_write(bp);
801011e1:	89 1c 24             	mov    %ebx,(%esp)
801011e4:	e8 f7 1a 00 00       	call   80102ce0 <log_write>
        brelse(bp);
801011e9:	89 1c 24             	mov    %ebx,(%esp)
801011ec:	e8 ef ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011f1:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011f4:	89 74 24 04          	mov    %esi,0x4(%esp)
801011f8:	89 04 24             	mov    %eax,(%esp)
801011fb:	e8 d0 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101200:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101207:	00 
80101208:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010120f:	00 
  bp = bread(dev, bno);
80101210:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101212:	8d 40 5c             	lea    0x5c(%eax),%eax
80101215:	89 04 24             	mov    %eax,(%esp)
80101218:	e8 93 31 00 00       	call   801043b0 <memset>
  log_write(bp);
8010121d:	89 1c 24             	mov    %ebx,(%esp)
80101220:	e8 bb 1a 00 00       	call   80102ce0 <log_write>
  brelse(bp);
80101225:	89 1c 24             	mov    %ebx,(%esp)
80101228:	e8 b3 ef ff ff       	call   801001e0 <brelse>
}
8010122d:	83 c4 2c             	add    $0x2c,%esp
80101230:	89 f0                	mov    %esi,%eax
80101232:	5b                   	pop    %ebx
80101233:	5e                   	pop    %esi
80101234:	5f                   	pop    %edi
80101235:	5d                   	pop    %ebp
80101236:	c3                   	ret    
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101240 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	89 c7                	mov    %eax,%edi
80101246:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101247:	31 f6                	xor    %esi,%esi
{
80101249:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010124a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
8010124f:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&icache.lock);
80101252:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
{
80101259:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010125c:	e8 8f 30 00 00       	call   801042f0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101261:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101264:	eb 14                	jmp    8010127a <iget+0x3a>
80101266:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101268:	85 f6                	test   %esi,%esi
8010126a:	74 3c                	je     801012a8 <iget+0x68>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010126c:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101272:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101278:	74 46                	je     801012c0 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010127a:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010127d:	85 c9                	test   %ecx,%ecx
8010127f:	7e e7                	jle    80101268 <iget+0x28>
80101281:	39 3b                	cmp    %edi,(%ebx)
80101283:	75 e3                	jne    80101268 <iget+0x28>
80101285:	39 53 04             	cmp    %edx,0x4(%ebx)
80101288:	75 de                	jne    80101268 <iget+0x28>
      ip->ref++;
8010128a:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010128d:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010128f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
      ip->ref++;
80101296:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101299:	e8 c2 30 00 00       	call   80104360 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010129e:	83 c4 1c             	add    $0x1c,%esp
801012a1:	89 f0                	mov    %esi,%eax
801012a3:	5b                   	pop    %ebx
801012a4:	5e                   	pop    %esi
801012a5:	5f                   	pop    %edi
801012a6:	5d                   	pop    %ebp
801012a7:	c3                   	ret    
801012a8:	85 c9                	test   %ecx,%ecx
801012aa:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ad:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012b3:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012b9:	75 bf                	jne    8010127a <iget+0x3a>
801012bb:	90                   	nop
801012bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(empty == 0)
801012c0:	85 f6                	test   %esi,%esi
801012c2:	74 29                	je     801012ed <iget+0xad>
  ip->dev = dev;
801012c4:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012c6:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012c9:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012d0:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012d7:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801012de:	e8 7d 30 00 00       	call   80104360 <release>
}
801012e3:	83 c4 1c             	add    $0x1c,%esp
801012e6:	89 f0                	mov    %esi,%eax
801012e8:	5b                   	pop    %ebx
801012e9:	5e                   	pop    %esi
801012ea:	5f                   	pop    %edi
801012eb:	5d                   	pop    %ebp
801012ec:	c3                   	ret    
    panic("iget: no inodes");
801012ed:	c7 04 24 f5 6d 10 80 	movl   $0x80106df5,(%esp)
801012f4:	e8 67 f0 ff ff       	call   80100360 <panic>
801012f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101300 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	57                   	push   %edi
80101304:	56                   	push   %esi
80101305:	53                   	push   %ebx
80101306:	89 c3                	mov    %eax,%ebx
80101308:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010130b:	83 fa 0b             	cmp    $0xb,%edx
8010130e:	77 18                	ja     80101328 <bmap+0x28>
80101310:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
80101313:	8b 46 5c             	mov    0x5c(%esi),%eax
80101316:	85 c0                	test   %eax,%eax
80101318:	74 66                	je     80101380 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010131a:	83 c4 1c             	add    $0x1c,%esp
8010131d:	5b                   	pop    %ebx
8010131e:	5e                   	pop    %esi
8010131f:	5f                   	pop    %edi
80101320:	5d                   	pop    %ebp
80101321:	c3                   	ret    
80101322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;
80101328:	8d 72 f4             	lea    -0xc(%edx),%esi
  if(bn < NINDIRECT){
8010132b:	83 fe 7f             	cmp    $0x7f,%esi
8010132e:	77 77                	ja     801013a7 <bmap+0xa7>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101330:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101336:	85 c0                	test   %eax,%eax
80101338:	74 5e                	je     80101398 <bmap+0x98>
    bp = bread(ip->dev, addr);
8010133a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010133e:	8b 03                	mov    (%ebx),%eax
80101340:	89 04 24             	mov    %eax,(%esp)
80101343:	e8 88 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
80101348:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx
    bp = bread(ip->dev, addr);
8010134c:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010134e:	8b 32                	mov    (%edx),%esi
80101350:	85 f6                	test   %esi,%esi
80101352:	75 19                	jne    8010136d <bmap+0x6d>
      a[bn] = addr = balloc(ip->dev);
80101354:	8b 03                	mov    (%ebx),%eax
80101356:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101359:	e8 c2 fd ff ff       	call   80101120 <balloc>
8010135e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101361:	89 02                	mov    %eax,(%edx)
80101363:	89 c6                	mov    %eax,%esi
      log_write(bp);
80101365:	89 3c 24             	mov    %edi,(%esp)
80101368:	e8 73 19 00 00       	call   80102ce0 <log_write>
    brelse(bp);
8010136d:	89 3c 24             	mov    %edi,(%esp)
80101370:	e8 6b ee ff ff       	call   801001e0 <brelse>
}
80101375:	83 c4 1c             	add    $0x1c,%esp
    brelse(bp);
80101378:	89 f0                	mov    %esi,%eax
}
8010137a:	5b                   	pop    %ebx
8010137b:	5e                   	pop    %esi
8010137c:	5f                   	pop    %edi
8010137d:	5d                   	pop    %ebp
8010137e:	c3                   	ret    
8010137f:	90                   	nop
      ip->addrs[bn] = addr = balloc(ip->dev);
80101380:	8b 03                	mov    (%ebx),%eax
80101382:	e8 99 fd ff ff       	call   80101120 <balloc>
80101387:	89 46 5c             	mov    %eax,0x5c(%esi)
}
8010138a:	83 c4 1c             	add    $0x1c,%esp
8010138d:	5b                   	pop    %ebx
8010138e:	5e                   	pop    %esi
8010138f:	5f                   	pop    %edi
80101390:	5d                   	pop    %ebp
80101391:	c3                   	ret    
80101392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101398:	8b 03                	mov    (%ebx),%eax
8010139a:	e8 81 fd ff ff       	call   80101120 <balloc>
8010139f:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
801013a5:	eb 93                	jmp    8010133a <bmap+0x3a>
  panic("bmap: out of range");
801013a7:	c7 04 24 05 6e 10 80 	movl   $0x80106e05,(%esp)
801013ae:	e8 ad ef ff ff       	call   80100360 <panic>
801013b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013c0 <readsb>:
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	56                   	push   %esi
801013c4:	53                   	push   %ebx
801013c5:	83 ec 10             	sub    $0x10,%esp
  bp = bread(dev, 1);
801013c8:	8b 45 08             	mov    0x8(%ebp),%eax
801013cb:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801013d2:	00 
{
801013d3:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013d6:	89 04 24             	mov    %eax,(%esp)
801013d9:	e8 f2 ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013de:	89 34 24             	mov    %esi,(%esp)
801013e1:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
801013e8:	00 
  bp = bread(dev, 1);
801013e9:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013eb:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ee:	89 44 24 04          	mov    %eax,0x4(%esp)
801013f2:	e8 59 30 00 00       	call   80104450 <memmove>
  brelse(bp);
801013f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801013fa:	83 c4 10             	add    $0x10,%esp
801013fd:	5b                   	pop    %ebx
801013fe:	5e                   	pop    %esi
801013ff:	5d                   	pop    %ebp
  brelse(bp);
80101400:	e9 db ed ff ff       	jmp    801001e0 <brelse>
80101405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101410 <bfree>:
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	57                   	push   %edi
80101414:	89 d7                	mov    %edx,%edi
80101416:	56                   	push   %esi
80101417:	53                   	push   %ebx
80101418:	89 c3                	mov    %eax,%ebx
8010141a:	83 ec 1c             	sub    $0x1c,%esp
  readsb(dev, &sb);
8010141d:	89 04 24             	mov    %eax,(%esp)
80101420:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
80101427:	80 
80101428:	e8 93 ff ff ff       	call   801013c0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010142d:	89 fa                	mov    %edi,%edx
8010142f:	c1 ea 0c             	shr    $0xc,%edx
80101432:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101438:	89 1c 24             	mov    %ebx,(%esp)
  m = 1 << (bi % 8);
8010143b:	bb 01 00 00 00       	mov    $0x1,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101440:	89 54 24 04          	mov    %edx,0x4(%esp)
80101444:	e8 87 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101449:	89 f9                	mov    %edi,%ecx
  bi = b % BPB;
8010144b:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
80101451:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
80101453:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101456:	c1 fa 03             	sar    $0x3,%edx
  m = 1 << (bi % 8);
80101459:	d3 e3                	shl    %cl,%ebx
  bp = bread(dev, BBLOCK(b, sb));
8010145b:	89 c6                	mov    %eax,%esi
  if((bp->data[bi/8] & m) == 0)
8010145d:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101462:	0f b6 c8             	movzbl %al,%ecx
80101465:	85 d9                	test   %ebx,%ecx
80101467:	74 20                	je     80101489 <bfree+0x79>
  bp->data[bi/8] &= ~m;
80101469:	f7 d3                	not    %ebx
8010146b:	21 c3                	and    %eax,%ebx
8010146d:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
80101471:	89 34 24             	mov    %esi,(%esp)
80101474:	e8 67 18 00 00       	call   80102ce0 <log_write>
  brelse(bp);
80101479:	89 34 24             	mov    %esi,(%esp)
8010147c:	e8 5f ed ff ff       	call   801001e0 <brelse>
}
80101481:	83 c4 1c             	add    $0x1c,%esp
80101484:	5b                   	pop    %ebx
80101485:	5e                   	pop    %esi
80101486:	5f                   	pop    %edi
80101487:	5d                   	pop    %ebp
80101488:	c3                   	ret    
    panic("freeing free block");
80101489:	c7 04 24 18 6e 10 80 	movl   $0x80106e18,(%esp)
80101490:	e8 cb ee ff ff       	call   80100360 <panic>
80101495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014a0 <iinit>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	53                   	push   %ebx
801014a4:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
801014a9:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014ac:	c7 44 24 04 2b 6e 10 	movl   $0x80106e2b,0x4(%esp)
801014b3:	80 
801014b4:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801014bb:	e8 c0 2c 00 00       	call   80104180 <initlock>
    initsleeplock(&icache.inode[i].lock, "inode");
801014c0:	89 1c 24             	mov    %ebx,(%esp)
801014c3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014c9:	c7 44 24 04 32 6e 10 	movl   $0x80106e32,0x4(%esp)
801014d0:	80 
801014d1:	e8 7a 2b 00 00       	call   80104050 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014d6:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014dc:	75 e2                	jne    801014c0 <iinit+0x20>
  readsb(dev, &sb);
801014de:	8b 45 08             	mov    0x8(%ebp),%eax
801014e1:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801014e8:	80 
801014e9:	89 04 24             	mov    %eax,(%esp)
801014ec:	e8 cf fe ff ff       	call   801013c0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014f1:	a1 d8 09 11 80       	mov    0x801109d8,%eax
801014f6:	c7 04 24 98 6e 10 80 	movl   $0x80106e98,(%esp)
801014fd:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101501:	a1 d4 09 11 80       	mov    0x801109d4,%eax
80101506:	89 44 24 18          	mov    %eax,0x18(%esp)
8010150a:	a1 d0 09 11 80       	mov    0x801109d0,%eax
8010150f:	89 44 24 14          	mov    %eax,0x14(%esp)
80101513:	a1 cc 09 11 80       	mov    0x801109cc,%eax
80101518:	89 44 24 10          	mov    %eax,0x10(%esp)
8010151c:	a1 c8 09 11 80       	mov    0x801109c8,%eax
80101521:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101525:	a1 c4 09 11 80       	mov    0x801109c4,%eax
8010152a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010152e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101533:	89 44 24 04          	mov    %eax,0x4(%esp)
80101537:	e8 14 f1 ff ff       	call   80100650 <cprintf>
}
8010153c:	83 c4 24             	add    $0x24,%esp
8010153f:	5b                   	pop    %ebx
80101540:	5d                   	pop    %ebp
80101541:	c3                   	ret    
80101542:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101550 <ialloc>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	57                   	push   %edi
80101554:	56                   	push   %esi
80101555:	53                   	push   %ebx
80101556:	83 ec 2c             	sub    $0x2c,%esp
80101559:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010155c:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101563:	8b 7d 08             	mov    0x8(%ebp),%edi
80101566:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101569:	0f 86 a2 00 00 00    	jbe    80101611 <ialloc+0xc1>
8010156f:	be 01 00 00 00       	mov    $0x1,%esi
80101574:	bb 01 00 00 00       	mov    $0x1,%ebx
80101579:	eb 1a                	jmp    80101595 <ialloc+0x45>
8010157b:	90                   	nop
8010157c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    brelse(bp);
80101580:	89 14 24             	mov    %edx,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101583:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101586:	e8 55 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010158b:	89 de                	mov    %ebx,%esi
8010158d:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
80101593:	73 7c                	jae    80101611 <ialloc+0xc1>
    bp = bread(dev, IBLOCK(inum, sb));
80101595:	89 f0                	mov    %esi,%eax
80101597:	c1 e8 03             	shr    $0x3,%eax
8010159a:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015a0:	89 3c 24             	mov    %edi,(%esp)
801015a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801015a7:	e8 24 eb ff ff       	call   801000d0 <bread>
801015ac:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
801015ae:	89 f0                	mov    %esi,%eax
801015b0:	83 e0 07             	and    $0x7,%eax
801015b3:	c1 e0 06             	shl    $0x6,%eax
801015b6:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015ba:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015be:	75 c0                	jne    80101580 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015c0:	89 0c 24             	mov    %ecx,(%esp)
801015c3:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
801015ca:	00 
801015cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801015d2:	00 
801015d3:	89 55 dc             	mov    %edx,-0x24(%ebp)
801015d6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015d9:	e8 d2 2d 00 00       	call   801043b0 <memset>
      dip->type = type;
801015de:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      log_write(bp);   // mark it allocated on the disk
801015e2:	8b 55 dc             	mov    -0x24(%ebp),%edx
      dip->type = type;
801015e5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);   // mark it allocated on the disk
801015e8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      dip->type = type;
801015eb:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ee:	89 14 24             	mov    %edx,(%esp)
801015f1:	e8 ea 16 00 00       	call   80102ce0 <log_write>
      brelse(bp);
801015f6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015f9:	89 14 24             	mov    %edx,(%esp)
801015fc:	e8 df eb ff ff       	call   801001e0 <brelse>
}
80101601:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
80101604:	89 f2                	mov    %esi,%edx
}
80101606:	5b                   	pop    %ebx
      return iget(dev, inum);
80101607:	89 f8                	mov    %edi,%eax
}
80101609:	5e                   	pop    %esi
8010160a:	5f                   	pop    %edi
8010160b:	5d                   	pop    %ebp
      return iget(dev, inum);
8010160c:	e9 2f fc ff ff       	jmp    80101240 <iget>
  panic("ialloc: no inodes");
80101611:	c7 04 24 38 6e 10 80 	movl   $0x80106e38,(%esp)
80101618:	e8 43 ed ff ff       	call   80100360 <panic>
8010161d:	8d 76 00             	lea    0x0(%esi),%esi

80101620 <iupdate>:
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	56                   	push   %esi
80101624:	53                   	push   %ebx
80101625:	83 ec 10             	sub    $0x10,%esp
80101628:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010162b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101631:	c1 e8 03             	shr    $0x3,%eax
80101634:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010163a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010163e:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101641:	89 04 24             	mov    %eax,(%esp)
80101644:	e8 87 ea ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101649:	8b 53 a8             	mov    -0x58(%ebx),%edx
8010164c:	83 e2 07             	and    $0x7,%edx
8010164f:	c1 e2 06             	shl    $0x6,%edx
80101652:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101656:	89 c6                	mov    %eax,%esi
  dip->type = ip->type;
80101658:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165c:	83 c2 0c             	add    $0xc,%edx
  dip->type = ip->type;
8010165f:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
80101663:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
80101667:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
8010166b:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
8010166f:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
80101673:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
80101677:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
8010167b:	8b 43 fc             	mov    -0x4(%ebx),%eax
8010167e:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101681:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101685:	89 14 24             	mov    %edx,(%esp)
80101688:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010168f:	00 
80101690:	e8 bb 2d 00 00       	call   80104450 <memmove>
  log_write(bp);
80101695:	89 34 24             	mov    %esi,(%esp)
80101698:	e8 43 16 00 00       	call   80102ce0 <log_write>
  brelse(bp);
8010169d:	89 75 08             	mov    %esi,0x8(%ebp)
}
801016a0:	83 c4 10             	add    $0x10,%esp
801016a3:	5b                   	pop    %ebx
801016a4:	5e                   	pop    %esi
801016a5:	5d                   	pop    %ebp
  brelse(bp);
801016a6:	e9 35 eb ff ff       	jmp    801001e0 <brelse>
801016ab:	90                   	nop
801016ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016b0 <idup>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	53                   	push   %ebx
801016b4:	83 ec 14             	sub    $0x14,%esp
801016b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016ba:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016c1:	e8 2a 2c 00 00       	call   801042f0 <acquire>
  ip->ref++;
801016c6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016ca:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016d1:	e8 8a 2c 00 00       	call   80104360 <release>
}
801016d6:	83 c4 14             	add    $0x14,%esp
801016d9:	89 d8                	mov    %ebx,%eax
801016db:	5b                   	pop    %ebx
801016dc:	5d                   	pop    %ebp
801016dd:	c3                   	ret    
801016de:	66 90                	xchg   %ax,%ax

801016e0 <ilock>:
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	56                   	push   %esi
801016e4:	53                   	push   %ebx
801016e5:	83 ec 10             	sub    $0x10,%esp
801016e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016eb:	85 db                	test   %ebx,%ebx
801016ed:	0f 84 b3 00 00 00    	je     801017a6 <ilock+0xc6>
801016f3:	8b 53 08             	mov    0x8(%ebx),%edx
801016f6:	85 d2                	test   %edx,%edx
801016f8:	0f 8e a8 00 00 00    	jle    801017a6 <ilock+0xc6>
  acquiresleep(&ip->lock);
801016fe:	8d 43 0c             	lea    0xc(%ebx),%eax
80101701:	89 04 24             	mov    %eax,(%esp)
80101704:	e8 87 29 00 00       	call   80104090 <acquiresleep>
  if(ip->valid == 0){
80101709:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010170c:	85 c0                	test   %eax,%eax
8010170e:	74 08                	je     80101718 <ilock+0x38>
}
80101710:	83 c4 10             	add    $0x10,%esp
80101713:	5b                   	pop    %ebx
80101714:	5e                   	pop    %esi
80101715:	5d                   	pop    %ebp
80101716:	c3                   	ret    
80101717:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101718:	8b 43 04             	mov    0x4(%ebx),%eax
8010171b:	c1 e8 03             	shr    $0x3,%eax
8010171e:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101724:	89 44 24 04          	mov    %eax,0x4(%esp)
80101728:	8b 03                	mov    (%ebx),%eax
8010172a:	89 04 24             	mov    %eax,(%esp)
8010172d:	e8 9e e9 ff ff       	call   801000d0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101732:	8b 53 04             	mov    0x4(%ebx),%edx
80101735:	83 e2 07             	and    $0x7,%edx
80101738:	c1 e2 06             	shl    $0x6,%edx
8010173b:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010173f:	89 c6                	mov    %eax,%esi
    ip->type = dip->type;
80101741:	0f b7 02             	movzwl (%edx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101744:	83 c2 0c             	add    $0xc,%edx
    ip->type = dip->type;
80101747:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
8010174b:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
8010174f:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
80101753:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
80101757:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
8010175b:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
8010175f:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
80101763:	8b 42 fc             	mov    -0x4(%edx),%eax
80101766:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101769:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010176c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101770:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101777:	00 
80101778:	89 04 24             	mov    %eax,(%esp)
8010177b:	e8 d0 2c 00 00       	call   80104450 <memmove>
    brelse(bp);
80101780:	89 34 24             	mov    %esi,(%esp)
80101783:	e8 58 ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101788:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010178d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101794:	0f 85 76 ff ff ff    	jne    80101710 <ilock+0x30>
      panic("ilock: no type");
8010179a:	c7 04 24 50 6e 10 80 	movl   $0x80106e50,(%esp)
801017a1:	e8 ba eb ff ff       	call   80100360 <panic>
    panic("ilock");
801017a6:	c7 04 24 4a 6e 10 80 	movl   $0x80106e4a,(%esp)
801017ad:	e8 ae eb ff ff       	call   80100360 <panic>
801017b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801017c0 <iunlock>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	56                   	push   %esi
801017c4:	53                   	push   %ebx
801017c5:	83 ec 10             	sub    $0x10,%esp
801017c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017cb:	85 db                	test   %ebx,%ebx
801017cd:	74 24                	je     801017f3 <iunlock+0x33>
801017cf:	8d 73 0c             	lea    0xc(%ebx),%esi
801017d2:	89 34 24             	mov    %esi,(%esp)
801017d5:	e8 56 29 00 00       	call   80104130 <holdingsleep>
801017da:	85 c0                	test   %eax,%eax
801017dc:	74 15                	je     801017f3 <iunlock+0x33>
801017de:	8b 43 08             	mov    0x8(%ebx),%eax
801017e1:	85 c0                	test   %eax,%eax
801017e3:	7e 0e                	jle    801017f3 <iunlock+0x33>
  releasesleep(&ip->lock);
801017e5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017e8:	83 c4 10             	add    $0x10,%esp
801017eb:	5b                   	pop    %ebx
801017ec:	5e                   	pop    %esi
801017ed:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017ee:	e9 fd 28 00 00       	jmp    801040f0 <releasesleep>
    panic("iunlock");
801017f3:	c7 04 24 5f 6e 10 80 	movl   $0x80106e5f,(%esp)
801017fa:	e8 61 eb ff ff       	call   80100360 <panic>
801017ff:	90                   	nop

80101800 <iput>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	57                   	push   %edi
80101804:	56                   	push   %esi
80101805:	53                   	push   %ebx
80101806:	83 ec 1c             	sub    $0x1c,%esp
80101809:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010180c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010180f:	89 3c 24             	mov    %edi,(%esp)
80101812:	e8 79 28 00 00       	call   80104090 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101817:	8b 56 4c             	mov    0x4c(%esi),%edx
8010181a:	85 d2                	test   %edx,%edx
8010181c:	74 07                	je     80101825 <iput+0x25>
8010181e:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101823:	74 2b                	je     80101850 <iput+0x50>
  releasesleep(&ip->lock);
80101825:	89 3c 24             	mov    %edi,(%esp)
80101828:	e8 c3 28 00 00       	call   801040f0 <releasesleep>
  acquire(&icache.lock);
8010182d:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101834:	e8 b7 2a 00 00       	call   801042f0 <acquire>
  ip->ref--;
80101839:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010183d:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101844:	83 c4 1c             	add    $0x1c,%esp
80101847:	5b                   	pop    %ebx
80101848:	5e                   	pop    %esi
80101849:	5f                   	pop    %edi
8010184a:	5d                   	pop    %ebp
  release(&icache.lock);
8010184b:	e9 10 2b 00 00       	jmp    80104360 <release>
    acquire(&icache.lock);
80101850:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101857:	e8 94 2a 00 00       	call   801042f0 <acquire>
    int r = ip->ref;
8010185c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010185f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101866:	e8 f5 2a 00 00       	call   80104360 <release>
    if(r == 1){
8010186b:	83 fb 01             	cmp    $0x1,%ebx
8010186e:	75 b5                	jne    80101825 <iput+0x25>
80101870:	8d 4e 30             	lea    0x30(%esi),%ecx
80101873:	89 f3                	mov    %esi,%ebx
80101875:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101878:	89 cf                	mov    %ecx,%edi
8010187a:	eb 0b                	jmp    80101887 <iput+0x87>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101880:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101883:	39 fb                	cmp    %edi,%ebx
80101885:	74 19                	je     801018a0 <iput+0xa0>
    if(ip->addrs[i]){
80101887:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010188a:	85 d2                	test   %edx,%edx
8010188c:	74 f2                	je     80101880 <iput+0x80>
      bfree(ip->dev, ip->addrs[i]);
8010188e:	8b 06                	mov    (%esi),%eax
80101890:	e8 7b fb ff ff       	call   80101410 <bfree>
      ip->addrs[i] = 0;
80101895:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
8010189c:	eb e2                	jmp    80101880 <iput+0x80>
8010189e:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
801018a0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801018a6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018a9:	85 c0                	test   %eax,%eax
801018ab:	75 2b                	jne    801018d8 <iput+0xd8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801018ad:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801018b4:	89 34 24             	mov    %esi,(%esp)
801018b7:	e8 64 fd ff ff       	call   80101620 <iupdate>
      ip->type = 0;
801018bc:	31 c0                	xor    %eax,%eax
801018be:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
801018c2:	89 34 24             	mov    %esi,(%esp)
801018c5:	e8 56 fd ff ff       	call   80101620 <iupdate>
      ip->valid = 0;
801018ca:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801018d1:	e9 4f ff ff ff       	jmp    80101825 <iput+0x25>
801018d6:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018d8:	89 44 24 04          	mov    %eax,0x4(%esp)
801018dc:	8b 06                	mov    (%esi),%eax
    for(j = 0; j < NINDIRECT; j++){
801018de:	31 db                	xor    %ebx,%ebx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018e0:	89 04 24             	mov    %eax,(%esp)
801018e3:	e8 e8 e7 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801018e8:	89 7d e0             	mov    %edi,-0x20(%ebp)
    a = (uint*)bp->data;
801018eb:	8d 48 5c             	lea    0x5c(%eax),%ecx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801018f1:	89 cf                	mov    %ecx,%edi
801018f3:	31 c0                	xor    %eax,%eax
801018f5:	eb 0e                	jmp    80101905 <iput+0x105>
801018f7:	90                   	nop
801018f8:	83 c3 01             	add    $0x1,%ebx
801018fb:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80101901:	89 d8                	mov    %ebx,%eax
80101903:	74 10                	je     80101915 <iput+0x115>
      if(a[j])
80101905:	8b 14 87             	mov    (%edi,%eax,4),%edx
80101908:	85 d2                	test   %edx,%edx
8010190a:	74 ec                	je     801018f8 <iput+0xf8>
        bfree(ip->dev, a[j]);
8010190c:	8b 06                	mov    (%esi),%eax
8010190e:	e8 fd fa ff ff       	call   80101410 <bfree>
80101913:	eb e3                	jmp    801018f8 <iput+0xf8>
    brelse(bp);
80101915:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101918:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010191b:	89 04 24             	mov    %eax,(%esp)
8010191e:	e8 bd e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101923:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101929:	8b 06                	mov    (%esi),%eax
8010192b:	e8 e0 fa ff ff       	call   80101410 <bfree>
    ip->addrs[NDIRECT] = 0;
80101930:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101937:	00 00 00 
8010193a:	e9 6e ff ff ff       	jmp    801018ad <iput+0xad>
8010193f:	90                   	nop

80101940 <iunlockput>:
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	53                   	push   %ebx
80101944:	83 ec 14             	sub    $0x14,%esp
80101947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010194a:	89 1c 24             	mov    %ebx,(%esp)
8010194d:	e8 6e fe ff ff       	call   801017c0 <iunlock>
  iput(ip);
80101952:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101955:	83 c4 14             	add    $0x14,%esp
80101958:	5b                   	pop    %ebx
80101959:	5d                   	pop    %ebp
  iput(ip);
8010195a:	e9 a1 fe ff ff       	jmp    80101800 <iput>
8010195f:	90                   	nop

80101960 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	8b 55 08             	mov    0x8(%ebp),%edx
80101966:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101969:	8b 0a                	mov    (%edx),%ecx
8010196b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010196e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101971:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101974:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101978:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010197b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010197f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101983:	8b 52 58             	mov    0x58(%edx),%edx
80101986:	89 50 10             	mov    %edx,0x10(%eax)
}
80101989:	5d                   	pop    %ebp
8010198a:	c3                   	ret    
8010198b:	90                   	nop
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101990 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	57                   	push   %edi
80101994:	56                   	push   %esi
80101995:	53                   	push   %ebx
80101996:	83 ec 2c             	sub    $0x2c,%esp
80101999:	8b 45 0c             	mov    0xc(%ebp),%eax
8010199c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010199f:	8b 75 10             	mov    0x10(%ebp),%esi
801019a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801019a5:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019a8:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
801019ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(ip->type == T_DEV){
801019b0:	0f 84 aa 00 00 00    	je     80101a60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019b6:	8b 47 58             	mov    0x58(%edi),%eax
801019b9:	39 f0                	cmp    %esi,%eax
801019bb:	0f 82 c7 00 00 00    	jb     80101a88 <readi+0xf8>
801019c1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801019c4:	89 da                	mov    %ebx,%edx
801019c6:	01 f2                	add    %esi,%edx
801019c8:	0f 82 ba 00 00 00    	jb     80101a88 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019ce:	89 c1                	mov    %eax,%ecx
801019d0:	29 f1                	sub    %esi,%ecx
801019d2:	39 d0                	cmp    %edx,%eax
801019d4:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d7:	31 c0                	xor    %eax,%eax
801019d9:	85 c9                	test   %ecx,%ecx
    n = ip->size - off;
801019db:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019de:	74 70                	je     80101a50 <readi+0xc0>
801019e0:	89 7d d8             	mov    %edi,-0x28(%ebp)
801019e3:	89 c7                	mov    %eax,%edi
801019e5:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019e8:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019eb:	89 f2                	mov    %esi,%edx
801019ed:	c1 ea 09             	shr    $0x9,%edx
801019f0:	89 d8                	mov    %ebx,%eax
801019f2:	e8 09 f9 ff ff       	call   80101300 <bmap>
801019f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801019fb:	8b 03                	mov    (%ebx),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019fd:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a02:	89 04 24             	mov    %eax,(%esp)
80101a05:	e8 c6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a0a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101a0d:	29 f9                	sub    %edi,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a0f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a11:	89 f0                	mov    %esi,%eax
80101a13:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a18:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a1a:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a1e:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a20:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a24:	8b 45 e0             	mov    -0x20(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a27:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a2a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a2e:	01 df                	add    %ebx,%edi
80101a30:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a32:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101a35:	89 04 24             	mov    %eax,(%esp)
80101a38:	e8 13 2a 00 00       	call   80104450 <memmove>
    brelse(bp);
80101a3d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a40:	89 14 24             	mov    %edx,(%esp)
80101a43:	e8 98 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a48:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a4b:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a4e:	77 98                	ja     801019e8 <readi+0x58>
  }
  return n;
80101a50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a53:	83 c4 2c             	add    $0x2c,%esp
80101a56:	5b                   	pop    %ebx
80101a57:	5e                   	pop    %esi
80101a58:	5f                   	pop    %edi
80101a59:	5d                   	pop    %ebp
80101a5a:	c3                   	ret    
80101a5b:	90                   	nop
80101a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a60:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101a64:	66 83 f8 09          	cmp    $0x9,%ax
80101a68:	77 1e                	ja     80101a88 <readi+0xf8>
80101a6a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a71:	85 c0                	test   %eax,%eax
80101a73:	74 13                	je     80101a88 <readi+0xf8>
    return devsw[ip->major].read(ip, dst, n);
80101a75:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101a78:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101a7b:	83 c4 2c             	add    $0x2c,%esp
80101a7e:	5b                   	pop    %ebx
80101a7f:	5e                   	pop    %esi
80101a80:	5f                   	pop    %edi
80101a81:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a82:	ff e0                	jmp    *%eax
80101a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101a88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a8d:	eb c4                	jmp    80101a53 <readi+0xc3>
80101a8f:	90                   	nop

80101a90 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 2c             	sub    $0x2c,%esp
80101a99:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a9f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101aa2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101aa7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101aaa:	8b 75 10             	mov    0x10(%ebp),%esi
80101aad:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ab0:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101ab3:	0f 84 b7 00 00 00    	je     80101b70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ab9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101abc:	39 70 58             	cmp    %esi,0x58(%eax)
80101abf:	0f 82 e3 00 00 00    	jb     80101ba8 <writei+0x118>
80101ac5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101ac8:	89 c8                	mov    %ecx,%eax
80101aca:	01 f0                	add    %esi,%eax
80101acc:	0f 82 d6 00 00 00    	jb     80101ba8 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ad2:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ad7:	0f 87 cb 00 00 00    	ja     80101ba8 <writei+0x118>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101add:	85 c9                	test   %ecx,%ecx
80101adf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ae6:	74 77                	je     80101b5f <writei+0xcf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae8:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101aeb:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101aed:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af2:	c1 ea 09             	shr    $0x9,%edx
80101af5:	89 f8                	mov    %edi,%eax
80101af7:	e8 04 f8 ff ff       	call   80101300 <bmap>
80101afc:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b00:	8b 07                	mov    (%edi),%eax
80101b02:	89 04 24             	mov    %eax,(%esp)
80101b05:	e8 c6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b0a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b0d:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b10:	8b 55 dc             	mov    -0x24(%ebp),%edx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b13:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b15:	89 f0                	mov    %esi,%eax
80101b17:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b1c:	29 c3                	sub    %eax,%ebx
80101b1e:	39 cb                	cmp    %ecx,%ebx
80101b20:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b23:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b27:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b29:	89 54 24 04          	mov    %edx,0x4(%esp)
80101b2d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101b31:	89 04 24             	mov    %eax,(%esp)
80101b34:	e8 17 29 00 00       	call   80104450 <memmove>
    log_write(bp);
80101b39:	89 3c 24             	mov    %edi,(%esp)
80101b3c:	e8 9f 11 00 00       	call   80102ce0 <log_write>
    brelse(bp);
80101b41:	89 3c 24             	mov    %edi,(%esp)
80101b44:	e8 97 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b49:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b4f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b52:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b55:	77 91                	ja     80101ae8 <writei+0x58>
  }

  if(n > 0 && off > ip->size){
80101b57:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b5a:	39 70 58             	cmp    %esi,0x58(%eax)
80101b5d:	72 39                	jb     80101b98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b5f:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b62:	83 c4 2c             	add    $0x2c,%esp
80101b65:	5b                   	pop    %ebx
80101b66:	5e                   	pop    %esi
80101b67:	5f                   	pop    %edi
80101b68:	5d                   	pop    %ebp
80101b69:	c3                   	ret    
80101b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b74:	66 83 f8 09          	cmp    $0x9,%ax
80101b78:	77 2e                	ja     80101ba8 <writei+0x118>
80101b7a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b81:	85 c0                	test   %eax,%eax
80101b83:	74 23                	je     80101ba8 <writei+0x118>
    return devsw[ip->major].write(ip, src, n);
80101b85:	89 4d 10             	mov    %ecx,0x10(%ebp)
}
80101b88:	83 c4 2c             	add    $0x2c,%esp
80101b8b:	5b                   	pop    %ebx
80101b8c:	5e                   	pop    %esi
80101b8d:	5f                   	pop    %edi
80101b8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b8f:	ff e0                	jmp    *%eax
80101b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b98:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b9b:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b9e:	89 04 24             	mov    %eax,(%esp)
80101ba1:	e8 7a fa ff ff       	call   80101620 <iupdate>
80101ba6:	eb b7                	jmp    80101b5f <writei+0xcf>
}
80101ba8:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80101bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101bb0:	5b                   	pop    %ebx
80101bb1:	5e                   	pop    %esi
80101bb2:	5f                   	pop    %edi
80101bb3:	5d                   	pop    %ebp
80101bb4:	c3                   	ret    
80101bb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bc9:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101bd0:	00 
80101bd1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101bd5:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd8:	89 04 24             	mov    %eax,(%esp)
80101bdb:	e8 f0 28 00 00       	call   801044d0 <strncmp>
}
80101be0:	c9                   	leave  
80101be1:	c3                   	ret    
80101be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 2c             	sub    $0x2c,%esp
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bfc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c01:	0f 85 97 00 00 00    	jne    80101c9e <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c07:	8b 53 58             	mov    0x58(%ebx),%edx
80101c0a:	31 ff                	xor    %edi,%edi
80101c0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c0f:	85 d2                	test   %edx,%edx
80101c11:	75 0d                	jne    80101c20 <dirlookup+0x30>
80101c13:	eb 73                	jmp    80101c88 <dirlookup+0x98>
80101c15:	8d 76 00             	lea    0x0(%esi),%esi
80101c18:	83 c7 10             	add    $0x10,%edi
80101c1b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101c1e:	76 68                	jbe    80101c88 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c20:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101c27:	00 
80101c28:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101c2c:	89 74 24 04          	mov    %esi,0x4(%esp)
80101c30:	89 1c 24             	mov    %ebx,(%esp)
80101c33:	e8 58 fd ff ff       	call   80101990 <readi>
80101c38:	83 f8 10             	cmp    $0x10,%eax
80101c3b:	75 55                	jne    80101c92 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101c3d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c42:	74 d4                	je     80101c18 <dirlookup+0x28>
  return strncmp(s, t, DIRSIZ);
80101c44:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c47:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c4e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101c55:	00 
80101c56:	89 04 24             	mov    %eax,(%esp)
80101c59:	e8 72 28 00 00       	call   801044d0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c5e:	85 c0                	test   %eax,%eax
80101c60:	75 b6                	jne    80101c18 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c62:	8b 45 10             	mov    0x10(%ebp),%eax
80101c65:	85 c0                	test   %eax,%eax
80101c67:	74 05                	je     80101c6e <dirlookup+0x7e>
        *poff = off;
80101c69:	8b 45 10             	mov    0x10(%ebp),%eax
80101c6c:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c6e:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c72:	8b 03                	mov    (%ebx),%eax
80101c74:	e8 c7 f5 ff ff       	call   80101240 <iget>
    }
  }

  return 0;
}
80101c79:	83 c4 2c             	add    $0x2c,%esp
80101c7c:	5b                   	pop    %ebx
80101c7d:	5e                   	pop    %esi
80101c7e:	5f                   	pop    %edi
80101c7f:	5d                   	pop    %ebp
80101c80:	c3                   	ret    
80101c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c88:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101c8b:	31 c0                	xor    %eax,%eax
}
80101c8d:	5b                   	pop    %ebx
80101c8e:	5e                   	pop    %esi
80101c8f:	5f                   	pop    %edi
80101c90:	5d                   	pop    %ebp
80101c91:	c3                   	ret    
      panic("dirlookup read");
80101c92:	c7 04 24 79 6e 10 80 	movl   $0x80106e79,(%esp)
80101c99:	e8 c2 e6 ff ff       	call   80100360 <panic>
    panic("dirlookup not DIR");
80101c9e:	c7 04 24 67 6e 10 80 	movl   $0x80106e67,(%esp)
80101ca5:	e8 b6 e6 ff ff       	call   80100360 <panic>
80101caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101cb0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	57                   	push   %edi
80101cb4:	89 cf                	mov    %ecx,%edi
80101cb6:	56                   	push   %esi
80101cb7:	53                   	push   %ebx
80101cb8:	89 c3                	mov    %eax,%ebx
80101cba:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cbd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101cc0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101cc3:	0f 84 51 01 00 00    	je     80101e1a <namex+0x16a>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101cc9:	e8 02 1a 00 00       	call   801036d0 <myproc>
80101cce:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101cd1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cd8:	e8 13 26 00 00       	call   801042f0 <acquire>
  ip->ref++;
80101cdd:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ce1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101ce8:	e8 73 26 00 00       	call   80104360 <release>
80101ced:	eb 04                	jmp    80101cf3 <namex+0x43>
80101cef:	90                   	nop
    path++;
80101cf0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cf3:	0f b6 03             	movzbl (%ebx),%eax
80101cf6:	3c 2f                	cmp    $0x2f,%al
80101cf8:	74 f6                	je     80101cf0 <namex+0x40>
  if(*path == 0)
80101cfa:	84 c0                	test   %al,%al
80101cfc:	0f 84 ed 00 00 00    	je     80101def <namex+0x13f>
  while(*path != '/' && *path != 0)
80101d02:	0f b6 03             	movzbl (%ebx),%eax
80101d05:	89 da                	mov    %ebx,%edx
80101d07:	84 c0                	test   %al,%al
80101d09:	0f 84 b1 00 00 00    	je     80101dc0 <namex+0x110>
80101d0f:	3c 2f                	cmp    $0x2f,%al
80101d11:	75 0f                	jne    80101d22 <namex+0x72>
80101d13:	e9 a8 00 00 00       	jmp    80101dc0 <namex+0x110>
80101d18:	3c 2f                	cmp    $0x2f,%al
80101d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d20:	74 0a                	je     80101d2c <namex+0x7c>
    path++;
80101d22:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101d25:	0f b6 02             	movzbl (%edx),%eax
80101d28:	84 c0                	test   %al,%al
80101d2a:	75 ec                	jne    80101d18 <namex+0x68>
80101d2c:	89 d1                	mov    %edx,%ecx
80101d2e:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d30:	83 f9 0d             	cmp    $0xd,%ecx
80101d33:	0f 8e 8f 00 00 00    	jle    80101dc8 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d39:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101d3d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d44:	00 
80101d45:	89 3c 24             	mov    %edi,(%esp)
80101d48:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d4b:	e8 00 27 00 00       	call   80104450 <memmove>
    path++;
80101d50:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d53:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d55:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d58:	75 0e                	jne    80101d68 <namex+0xb8>
80101d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101d60:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d63:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d66:	74 f8                	je     80101d60 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d68:	89 34 24             	mov    %esi,(%esp)
80101d6b:	e8 70 f9 ff ff       	call   801016e0 <ilock>
    if(ip->type != T_DIR){
80101d70:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d75:	0f 85 85 00 00 00    	jne    80101e00 <namex+0x150>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d7b:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d7e:	85 d2                	test   %edx,%edx
80101d80:	74 09                	je     80101d8b <namex+0xdb>
80101d82:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d85:	0f 84 a5 00 00 00    	je     80101e30 <namex+0x180>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d8b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101d92:	00 
80101d93:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101d97:	89 34 24             	mov    %esi,(%esp)
80101d9a:	e8 51 fe ff ff       	call   80101bf0 <dirlookup>
80101d9f:	85 c0                	test   %eax,%eax
80101da1:	74 5d                	je     80101e00 <namex+0x150>
  iunlock(ip);
80101da3:	89 34 24             	mov    %esi,(%esp)
80101da6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101da9:	e8 12 fa ff ff       	call   801017c0 <iunlock>
  iput(ip);
80101dae:	89 34 24             	mov    %esi,(%esp)
80101db1:	e8 4a fa ff ff       	call   80101800 <iput>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101db6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101db9:	89 c6                	mov    %eax,%esi
80101dbb:	e9 33 ff ff ff       	jmp    80101cf3 <namex+0x43>
  while(*path != '/' && *path != 0)
80101dc0:	31 c9                	xor    %ecx,%ecx
80101dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(name, s, len);
80101dc8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101dcc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101dd0:	89 3c 24             	mov    %edi,(%esp)
80101dd3:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dd6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101dd9:	e8 72 26 00 00       	call   80104450 <memmove>
    name[len] = 0;
80101dde:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101de1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101de4:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101de8:	89 d3                	mov    %edx,%ebx
80101dea:	e9 66 ff ff ff       	jmp    80101d55 <namex+0xa5>
  }
  if(nameiparent){
80101def:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101df2:	85 c0                	test   %eax,%eax
80101df4:	75 4c                	jne    80101e42 <namex+0x192>
80101df6:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101df8:	83 c4 2c             	add    $0x2c,%esp
80101dfb:	5b                   	pop    %ebx
80101dfc:	5e                   	pop    %esi
80101dfd:	5f                   	pop    %edi
80101dfe:	5d                   	pop    %ebp
80101dff:	c3                   	ret    
  iunlock(ip);
80101e00:	89 34 24             	mov    %esi,(%esp)
80101e03:	e8 b8 f9 ff ff       	call   801017c0 <iunlock>
  iput(ip);
80101e08:	89 34 24             	mov    %esi,(%esp)
80101e0b:	e8 f0 f9 ff ff       	call   80101800 <iput>
}
80101e10:	83 c4 2c             	add    $0x2c,%esp
      return 0;
80101e13:	31 c0                	xor    %eax,%eax
}
80101e15:	5b                   	pop    %ebx
80101e16:	5e                   	pop    %esi
80101e17:	5f                   	pop    %edi
80101e18:	5d                   	pop    %ebp
80101e19:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e1a:	ba 01 00 00 00       	mov    $0x1,%edx
80101e1f:	b8 01 00 00 00       	mov    $0x1,%eax
80101e24:	e8 17 f4 ff ff       	call   80101240 <iget>
80101e29:	89 c6                	mov    %eax,%esi
80101e2b:	e9 c3 fe ff ff       	jmp    80101cf3 <namex+0x43>
      iunlock(ip);
80101e30:	89 34 24             	mov    %esi,(%esp)
80101e33:	e8 88 f9 ff ff       	call   801017c0 <iunlock>
}
80101e38:	83 c4 2c             	add    $0x2c,%esp
      return ip;
80101e3b:	89 f0                	mov    %esi,%eax
}
80101e3d:	5b                   	pop    %ebx
80101e3e:	5e                   	pop    %esi
80101e3f:	5f                   	pop    %edi
80101e40:	5d                   	pop    %ebp
80101e41:	c3                   	ret    
    iput(ip);
80101e42:	89 34 24             	mov    %esi,(%esp)
80101e45:	e8 b6 f9 ff ff       	call   80101800 <iput>
    return 0;
80101e4a:	31 c0                	xor    %eax,%eax
80101e4c:	eb aa                	jmp    80101df8 <namex+0x148>
80101e4e:	66 90                	xchg   %ax,%ax

80101e50 <dirlink>:
{
80101e50:	55                   	push   %ebp
80101e51:	89 e5                	mov    %esp,%ebp
80101e53:	57                   	push   %edi
80101e54:	56                   	push   %esi
80101e55:	53                   	push   %ebx
80101e56:	83 ec 2c             	sub    $0x2c,%esp
80101e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e5f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e66:	00 
80101e67:	89 1c 24             	mov    %ebx,(%esp)
80101e6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e6e:	e8 7d fd ff ff       	call   80101bf0 <dirlookup>
80101e73:	85 c0                	test   %eax,%eax
80101e75:	0f 85 8b 00 00 00    	jne    80101f06 <dirlink+0xb6>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e7b:	8b 43 58             	mov    0x58(%ebx),%eax
80101e7e:	31 ff                	xor    %edi,%edi
80101e80:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e83:	85 c0                	test   %eax,%eax
80101e85:	75 13                	jne    80101e9a <dirlink+0x4a>
80101e87:	eb 35                	jmp    80101ebe <dirlink+0x6e>
80101e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e90:	8d 57 10             	lea    0x10(%edi),%edx
80101e93:	39 53 58             	cmp    %edx,0x58(%ebx)
80101e96:	89 d7                	mov    %edx,%edi
80101e98:	76 24                	jbe    80101ebe <dirlink+0x6e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e9a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ea1:	00 
80101ea2:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ea6:	89 74 24 04          	mov    %esi,0x4(%esp)
80101eaa:	89 1c 24             	mov    %ebx,(%esp)
80101ead:	e8 de fa ff ff       	call   80101990 <readi>
80101eb2:	83 f8 10             	cmp    $0x10,%eax
80101eb5:	75 5e                	jne    80101f15 <dirlink+0xc5>
    if(de.inum == 0)
80101eb7:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ebc:	75 d2                	jne    80101e90 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
80101ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ec1:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101ec8:	00 
80101ec9:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ecd:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ed0:	89 04 24             	mov    %eax,(%esp)
80101ed3:	e8 68 26 00 00       	call   80104540 <strncpy>
  de.inum = inum;
80101ed8:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101edb:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ee2:	00 
80101ee3:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ee7:	89 74 24 04          	mov    %esi,0x4(%esp)
80101eeb:	89 1c 24             	mov    %ebx,(%esp)
  de.inum = inum;
80101eee:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ef2:	e8 99 fb ff ff       	call   80101a90 <writei>
80101ef7:	83 f8 10             	cmp    $0x10,%eax
80101efa:	75 25                	jne    80101f21 <dirlink+0xd1>
  return 0;
80101efc:	31 c0                	xor    %eax,%eax
}
80101efe:	83 c4 2c             	add    $0x2c,%esp
80101f01:	5b                   	pop    %ebx
80101f02:	5e                   	pop    %esi
80101f03:	5f                   	pop    %edi
80101f04:	5d                   	pop    %ebp
80101f05:	c3                   	ret    
    iput(ip);
80101f06:	89 04 24             	mov    %eax,(%esp)
80101f09:	e8 f2 f8 ff ff       	call   80101800 <iput>
    return -1;
80101f0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f13:	eb e9                	jmp    80101efe <dirlink+0xae>
      panic("dirlink read");
80101f15:	c7 04 24 88 6e 10 80 	movl   $0x80106e88,(%esp)
80101f1c:	e8 3f e4 ff ff       	call   80100360 <panic>
    panic("dirlink");
80101f21:	c7 04 24 c6 74 10 80 	movl   $0x801074c6,(%esp)
80101f28:	e8 33 e4 ff ff       	call   80100360 <panic>
80101f2d:	8d 76 00             	lea    0x0(%esi),%esi

80101f30 <namei>:

struct inode*
namei(char *path)
{
80101f30:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f31:	31 d2                	xor    %edx,%edx
{
80101f33:	89 e5                	mov    %esp,%ebp
80101f35:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f38:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f3e:	e8 6d fd ff ff       	call   80101cb0 <namex>
}
80101f43:	c9                   	leave  
80101f44:	c3                   	ret    
80101f45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f50 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f50:	55                   	push   %ebp
  return namex(path, 1, name);
80101f51:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f56:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f58:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f5e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f5f:	e9 4c fd ff ff       	jmp    80101cb0 <namex>
80101f64:	66 90                	xchg   %ax,%ax
80101f66:	66 90                	xchg   %ax,%ax
80101f68:	66 90                	xchg   %ax,%ax
80101f6a:	66 90                	xchg   %ax,%ax
80101f6c:	66 90                	xchg   %ax,%ax
80101f6e:	66 90                	xchg   %ax,%ax

80101f70 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	56                   	push   %esi
80101f74:	89 c6                	mov    %eax,%esi
80101f76:	53                   	push   %ebx
80101f77:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101f7a:	85 c0                	test   %eax,%eax
80101f7c:	0f 84 99 00 00 00    	je     8010201b <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f82:	8b 48 08             	mov    0x8(%eax),%ecx
80101f85:	81 f9 1f 4e 00 00    	cmp    $0x4e1f,%ecx
80101f8b:	0f 87 7e 00 00 00    	ja     8010200f <idestart+0x9f>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f91:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f96:	66 90                	xchg   %ax,%ax
80101f98:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f99:	83 e0 c0             	and    $0xffffffc0,%eax
80101f9c:	3c 40                	cmp    $0x40,%al
80101f9e:	75 f8                	jne    80101f98 <idestart+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fa0:	31 db                	xor    %ebx,%ebx
80101fa2:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101fa7:	89 d8                	mov    %ebx,%eax
80101fa9:	ee                   	out    %al,(%dx)
80101faa:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101faf:	b8 01 00 00 00       	mov    $0x1,%eax
80101fb4:	ee                   	out    %al,(%dx)
80101fb5:	0f b6 c1             	movzbl %cl,%eax
80101fb8:	b2 f3                	mov    $0xf3,%dl
80101fba:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101fbb:	89 c8                	mov    %ecx,%eax
80101fbd:	b2 f4                	mov    $0xf4,%dl
80101fbf:	c1 f8 08             	sar    $0x8,%eax
80101fc2:	ee                   	out    %al,(%dx)
80101fc3:	b2 f5                	mov    $0xf5,%dl
80101fc5:	89 d8                	mov    %ebx,%eax
80101fc7:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101fc8:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fcc:	b2 f6                	mov    $0xf6,%dl
80101fce:	83 e0 01             	and    $0x1,%eax
80101fd1:	c1 e0 04             	shl    $0x4,%eax
80101fd4:	83 c8 e0             	or     $0xffffffe0,%eax
80101fd7:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fd8:	f6 06 04             	testb  $0x4,(%esi)
80101fdb:	75 13                	jne    80101ff0 <idestart+0x80>
80101fdd:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fe2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fe7:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fe8:	83 c4 10             	add    $0x10,%esp
80101feb:	5b                   	pop    %ebx
80101fec:	5e                   	pop    %esi
80101fed:	5d                   	pop    %ebp
80101fee:	c3                   	ret    
80101fef:	90                   	nop
80101ff0:	b2 f7                	mov    $0xf7,%dl
80101ff2:	b8 30 00 00 00       	mov    $0x30,%eax
80101ff7:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101ff8:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101ffd:	83 c6 5c             	add    $0x5c,%esi
80102000:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102005:	fc                   	cld    
80102006:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102008:	83 c4 10             	add    $0x10,%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5d                   	pop    %ebp
8010200e:	c3                   	ret    
    panic("incorrect blockno");
8010200f:	c7 04 24 f4 6e 10 80 	movl   $0x80106ef4,(%esp)
80102016:	e8 45 e3 ff ff       	call   80100360 <panic>
    panic("idestart");
8010201b:	c7 04 24 eb 6e 10 80 	movl   $0x80106eeb,(%esp)
80102022:	e8 39 e3 ff ff       	call   80100360 <panic>
80102027:	89 f6                	mov    %esi,%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
80102036:	c7 44 24 04 06 6f 10 	movl   $0x80106f06,0x4(%esp)
8010203d:	80 
8010203e:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102045:	e8 36 21 00 00       	call   80104180 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010204a:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010204f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102056:	83 e8 01             	sub    $0x1,%eax
80102059:	89 44 24 04          	mov    %eax,0x4(%esp)
8010205d:	e8 7e 02 00 00       	call   801022e0 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102062:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102067:	90                   	nop
80102068:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102069:	83 e0 c0             	and    $0xffffffc0,%eax
8010206c:	3c 40                	cmp    $0x40,%al
8010206e:	75 f8                	jne    80102068 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102070:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102075:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010207a:	ee                   	out    %al,(%dx)
8010207b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102080:	b2 f7                	mov    $0xf7,%dl
80102082:	eb 09                	jmp    8010208d <ideinit+0x5d>
80102084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102088:	83 e9 01             	sub    $0x1,%ecx
8010208b:	74 0f                	je     8010209c <ideinit+0x6c>
8010208d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010208e:	84 c0                	test   %al,%al
80102090:	74 f6                	je     80102088 <ideinit+0x58>
      havedisk1 = 1;
80102092:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102099:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010209c:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020a1:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801020a6:	ee                   	out    %al,(%dx)
}
801020a7:	c9                   	leave  
801020a8:	c3                   	ret    
801020a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020b0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	57                   	push   %edi
801020b4:	56                   	push   %esi
801020b5:	53                   	push   %ebx
801020b6:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020b9:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801020c0:	e8 2b 22 00 00       	call   801042f0 <acquire>

  if((b = idequeue) == 0){
801020c5:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020cb:	85 db                	test   %ebx,%ebx
801020cd:	74 30                	je     801020ff <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020cf:	8b 43 58             	mov    0x58(%ebx),%eax
801020d2:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020d7:	8b 33                	mov    (%ebx),%esi
801020d9:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020df:	74 37                	je     80102118 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020e1:	83 e6 fb             	and    $0xfffffffb,%esi
801020e4:	83 ce 02             	or     $0x2,%esi
801020e7:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020e9:	89 1c 24             	mov    %ebx,(%esp)
801020ec:	e8 cf 1c 00 00       	call   80103dc0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020f1:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020f6:	85 c0                	test   %eax,%eax
801020f8:	74 05                	je     801020ff <ideintr+0x4f>
    idestart(idequeue);
801020fa:	e8 71 fe ff ff       	call   80101f70 <idestart>
    release(&idelock);
801020ff:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102106:	e8 55 22 00 00       	call   80104360 <release>

  release(&idelock);
}
8010210b:	83 c4 1c             	add    $0x1c,%esp
8010210e:	5b                   	pop    %ebx
8010210f:	5e                   	pop    %esi
80102110:	5f                   	pop    %edi
80102111:	5d                   	pop    %ebp
80102112:	c3                   	ret    
80102113:	90                   	nop
80102114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102118:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010211d:	8d 76 00             	lea    0x0(%esi),%esi
80102120:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102121:	89 c1                	mov    %eax,%ecx
80102123:	83 e1 c0             	and    $0xffffffc0,%ecx
80102126:	80 f9 40             	cmp    $0x40,%cl
80102129:	75 f5                	jne    80102120 <ideintr+0x70>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010212b:	a8 21                	test   $0x21,%al
8010212d:	75 b2                	jne    801020e1 <ideintr+0x31>
    insl(0x1f0, b->data, BSIZE/4);
8010212f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102132:	b9 80 00 00 00       	mov    $0x80,%ecx
80102137:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010213c:	fc                   	cld    
8010213d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010213f:	8b 33                	mov    (%ebx),%esi
80102141:	eb 9e                	jmp    801020e1 <ideintr+0x31>
80102143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102150 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	53                   	push   %ebx
80102154:	83 ec 14             	sub    $0x14,%esp
80102157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010215a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010215d:	89 04 24             	mov    %eax,(%esp)
80102160:	e8 cb 1f 00 00       	call   80104130 <holdingsleep>
80102165:	85 c0                	test   %eax,%eax
80102167:	0f 84 9e 00 00 00    	je     8010220b <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010216d:	8b 03                	mov    (%ebx),%eax
8010216f:	83 e0 06             	and    $0x6,%eax
80102172:	83 f8 02             	cmp    $0x2,%eax
80102175:	0f 84 a8 00 00 00    	je     80102223 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010217b:	8b 53 04             	mov    0x4(%ebx),%edx
8010217e:	85 d2                	test   %edx,%edx
80102180:	74 0d                	je     8010218f <iderw+0x3f>
80102182:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102187:	85 c0                	test   %eax,%eax
80102189:	0f 84 88 00 00 00    	je     80102217 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010218f:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102196:	e8 55 21 00 00       	call   801042f0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219b:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
801021a0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021a7:	85 c0                	test   %eax,%eax
801021a9:	75 07                	jne    801021b2 <iderw+0x62>
801021ab:	eb 4e                	jmp    801021fb <iderw+0xab>
801021ad:	8d 76 00             	lea    0x0(%esi),%esi
801021b0:	89 d0                	mov    %edx,%eax
801021b2:	8b 50 58             	mov    0x58(%eax),%edx
801021b5:	85 d2                	test   %edx,%edx
801021b7:	75 f7                	jne    801021b0 <iderw+0x60>
801021b9:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
801021bc:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
801021be:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801021c4:	74 3c                	je     80102202 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021c6:	8b 03                	mov    (%ebx),%eax
801021c8:	83 e0 06             	and    $0x6,%eax
801021cb:	83 f8 02             	cmp    $0x2,%eax
801021ce:	74 1a                	je     801021ea <iderw+0x9a>
    sleep(b, &idelock);
801021d0:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
801021d7:	80 
801021d8:	89 1c 24             	mov    %ebx,(%esp)
801021db:	e8 50 1a 00 00       	call   80103c30 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021e0:	8b 13                	mov    (%ebx),%edx
801021e2:	83 e2 06             	and    $0x6,%edx
801021e5:	83 fa 02             	cmp    $0x2,%edx
801021e8:	75 e6                	jne    801021d0 <iderw+0x80>
  }


  release(&idelock);
801021ea:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021f1:	83 c4 14             	add    $0x14,%esp
801021f4:	5b                   	pop    %ebx
801021f5:	5d                   	pop    %ebp
  release(&idelock);
801021f6:	e9 65 21 00 00       	jmp    80104360 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021fb:	b8 64 a5 10 80       	mov    $0x8010a564,%eax
80102200:	eb ba                	jmp    801021bc <iderw+0x6c>
    idestart(b);
80102202:	89 d8                	mov    %ebx,%eax
80102204:	e8 67 fd ff ff       	call   80101f70 <idestart>
80102209:	eb bb                	jmp    801021c6 <iderw+0x76>
    panic("iderw: buf not locked");
8010220b:	c7 04 24 0a 6f 10 80 	movl   $0x80106f0a,(%esp)
80102212:	e8 49 e1 ff ff       	call   80100360 <panic>
    panic("iderw: ide disk 1 not present");
80102217:	c7 04 24 35 6f 10 80 	movl   $0x80106f35,(%esp)
8010221e:	e8 3d e1 ff ff       	call   80100360 <panic>
    panic("iderw: nothing to do");
80102223:	c7 04 24 20 6f 10 80 	movl   $0x80106f20,(%esp)
8010222a:	e8 31 e1 ff ff       	call   80100360 <panic>
8010222f:	90                   	nop

80102230 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	56                   	push   %esi
80102234:	53                   	push   %ebx
80102235:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102238:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
8010223f:	00 c0 fe 
  ioapic->reg = reg;
80102242:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102249:	00 00 00 
  return ioapic->data;
8010224c:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102252:	8b 42 10             	mov    0x10(%edx),%eax
  ioapic->reg = reg;
80102255:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010225b:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102261:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102268:	c1 e8 10             	shr    $0x10,%eax
8010226b:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010226e:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102271:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102274:	39 c2                	cmp    %eax,%edx
80102276:	74 12                	je     8010228a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102278:	c7 04 24 54 6f 10 80 	movl   $0x80106f54,(%esp)
8010227f:	e8 cc e3 ff ff       	call   80100650 <cprintf>
80102284:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010228a:	ba 10 00 00 00       	mov    $0x10,%edx
8010228f:	31 c0                	xor    %eax,%eax
80102291:	eb 07                	jmp    8010229a <ioapicinit+0x6a>
80102293:	90                   	nop
80102294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102298:	89 cb                	mov    %ecx,%ebx
  ioapic->reg = reg;
8010229a:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010229c:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
801022a2:	8d 48 20             	lea    0x20(%eax),%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022a5:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  for(i = 0; i <= maxintr; i++){
801022ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022ae:	89 4b 10             	mov    %ecx,0x10(%ebx)
801022b1:	8d 4a 01             	lea    0x1(%edx),%ecx
801022b4:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801022b7:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801022b9:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
801022bf:	39 c6                	cmp    %eax,%esi
  ioapic->data = data;
801022c1:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022c8:	7d ce                	jge    80102298 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022ca:	83 c4 10             	add    $0x10,%esp
801022cd:	5b                   	pop    %ebx
801022ce:	5e                   	pop    %esi
801022cf:	5d                   	pop    %ebp
801022d0:	c3                   	ret    
801022d1:	eb 0d                	jmp    801022e0 <ioapicenable>
801022d3:	90                   	nop
801022d4:	90                   	nop
801022d5:	90                   	nop
801022d6:	90                   	nop
801022d7:	90                   	nop
801022d8:	90                   	nop
801022d9:	90                   	nop
801022da:	90                   	nop
801022db:	90                   	nop
801022dc:	90                   	nop
801022dd:	90                   	nop
801022de:	90                   	nop
801022df:	90                   	nop

801022e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	8b 55 08             	mov    0x8(%ebp),%edx
801022e6:	53                   	push   %ebx
801022e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ea:	8d 5a 20             	lea    0x20(%edx),%ebx
801022ed:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
  ioapic->reg = reg;
801022f1:	8b 15 34 26 11 80    	mov    0x80112634,%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022f7:	c1 e0 18             	shl    $0x18,%eax
  ioapic->reg = reg;
801022fa:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801022fc:	8b 15 34 26 11 80    	mov    0x80112634,%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102302:	83 c1 01             	add    $0x1,%ecx
  ioapic->data = data;
80102305:	89 5a 10             	mov    %ebx,0x10(%edx)
  ioapic->reg = reg;
80102308:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
8010230a:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102310:	89 42 10             	mov    %eax,0x10(%edx)
}
80102313:	5b                   	pop    %ebx
80102314:	5d                   	pop    %ebp
80102315:	c3                   	ret    
80102316:	66 90                	xchg   %ax,%ax
80102318:	66 90                	xchg   %ax,%ax
8010231a:	66 90                	xchg   %ax,%ax
8010231c:	66 90                	xchg   %ax,%ax
8010231e:	66 90                	xchg   %ax,%ax

80102320 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	53                   	push   %ebx
80102324:	83 ec 14             	sub    $0x14,%esp
80102327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010232a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102330:	75 7c                	jne    801023ae <kfree+0x8e>
80102332:	81 fb a8 55 11 80    	cmp    $0x801155a8,%ebx
80102338:	72 74                	jb     801023ae <kfree+0x8e>
8010233a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102340:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102345:	77 67                	ja     801023ae <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102347:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010234e:	00 
8010234f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102356:	00 
80102357:	89 1c 24             	mov    %ebx,(%esp)
8010235a:	e8 51 20 00 00       	call   801043b0 <memset>

  if(kmem.use_lock)
8010235f:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102365:	85 d2                	test   %edx,%edx
80102367:	75 37                	jne    801023a0 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102369:	a1 78 26 11 80       	mov    0x80112678,%eax
8010236e:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102370:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102375:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
8010237b:	85 c0                	test   %eax,%eax
8010237d:	75 09                	jne    80102388 <kfree+0x68>
    release(&kmem.lock);
}
8010237f:	83 c4 14             	add    $0x14,%esp
80102382:	5b                   	pop    %ebx
80102383:	5d                   	pop    %ebp
80102384:	c3                   	ret    
80102385:	8d 76 00             	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102388:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010238f:	83 c4 14             	add    $0x14,%esp
80102392:	5b                   	pop    %ebx
80102393:	5d                   	pop    %ebp
    release(&kmem.lock);
80102394:	e9 c7 1f 00 00       	jmp    80104360 <release>
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
801023a0:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801023a7:	e8 44 1f 00 00       	call   801042f0 <acquire>
801023ac:	eb bb                	jmp    80102369 <kfree+0x49>
    panic("kfree");
801023ae:	c7 04 24 86 6f 10 80 	movl   $0x80106f86,(%esp)
801023b5:	e8 a6 df ff ff       	call   80100360 <panic>
801023ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801023c0 <freerange>:
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
801023c5:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
801023c8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023ce:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801023d4:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023da:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801023e0:	39 de                	cmp    %ebx,%esi
801023e2:	73 08                	jae    801023ec <freerange+0x2c>
801023e4:	eb 18                	jmp    801023fe <freerange+0x3e>
801023e6:	66 90                	xchg   %ax,%ax
801023e8:	89 da                	mov    %ebx,%edx
801023ea:	89 c3                	mov    %eax,%ebx
    kfree(p);
801023ec:	89 14 24             	mov    %edx,(%esp)
801023ef:	e8 2c ff ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801023fa:	39 f0                	cmp    %esi,%eax
801023fc:	76 ea                	jbe    801023e8 <freerange+0x28>
}
801023fe:	83 c4 10             	add    $0x10,%esp
80102401:	5b                   	pop    %ebx
80102402:	5e                   	pop    %esi
80102403:	5d                   	pop    %ebp
80102404:	c3                   	ret    
80102405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102410 <kinit1>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	83 ec 10             	sub    $0x10,%esp
80102418:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010241b:	c7 44 24 04 8c 6f 10 	movl   $0x80106f8c,0x4(%esp)
80102422:	80 
80102423:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010242a:	e8 51 1d 00 00       	call   80104180 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010242f:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102432:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102439:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010243c:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102442:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102448:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
8010244e:	39 de                	cmp    %ebx,%esi
80102450:	73 0a                	jae    8010245c <kinit1+0x4c>
80102452:	eb 1a                	jmp    8010246e <kinit1+0x5e>
80102454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102458:	89 da                	mov    %ebx,%edx
8010245a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010245c:	89 14 24             	mov    %edx,(%esp)
8010245f:	e8 bc fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102464:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010246a:	39 c6                	cmp    %eax,%esi
8010246c:	73 ea                	jae    80102458 <kinit1+0x48>
}
8010246e:	83 c4 10             	add    $0x10,%esp
80102471:	5b                   	pop    %ebx
80102472:	5e                   	pop    %esi
80102473:	5d                   	pop    %ebp
80102474:	c3                   	ret    
80102475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kinit2>:
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx
80102485:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102488:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010248b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010248e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102494:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010249a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801024a0:	39 de                	cmp    %ebx,%esi
801024a2:	73 08                	jae    801024ac <kinit2+0x2c>
801024a4:	eb 18                	jmp    801024be <kinit2+0x3e>
801024a6:	66 90                	xchg   %ax,%ax
801024a8:	89 da                	mov    %ebx,%edx
801024aa:	89 c3                	mov    %eax,%ebx
    kfree(p);
801024ac:	89 14 24             	mov    %edx,(%esp)
801024af:	e8 6c fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801024ba:	39 c6                	cmp    %eax,%esi
801024bc:	73 ea                	jae    801024a8 <kinit2+0x28>
  kmem.use_lock = 1;
801024be:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801024c5:	00 00 00 
}
801024c8:	83 c4 10             	add    $0x10,%esp
801024cb:	5b                   	pop    %ebx
801024cc:	5e                   	pop    %esi
801024cd:	5d                   	pop    %ebp
801024ce:	c3                   	ret    
801024cf:	90                   	nop

801024d0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	53                   	push   %ebx
801024d4:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
801024d7:	a1 74 26 11 80       	mov    0x80112674,%eax
801024dc:	85 c0                	test   %eax,%eax
801024de:	75 30                	jne    80102510 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024e0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024e6:	85 db                	test   %ebx,%ebx
801024e8:	74 08                	je     801024f2 <kalloc+0x22>
    kmem.freelist = r->next;
801024ea:	8b 13                	mov    (%ebx),%edx
801024ec:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801024f2:	85 c0                	test   %eax,%eax
801024f4:	74 0c                	je     80102502 <kalloc+0x32>
    release(&kmem.lock);
801024f6:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801024fd:	e8 5e 1e 00 00       	call   80104360 <release>
  return (char*)r;
}
80102502:	83 c4 14             	add    $0x14,%esp
80102505:	89 d8                	mov    %ebx,%eax
80102507:	5b                   	pop    %ebx
80102508:	5d                   	pop    %ebp
80102509:	c3                   	ret    
8010250a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
80102510:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102517:	e8 d4 1d 00 00       	call   801042f0 <acquire>
8010251c:	a1 74 26 11 80       	mov    0x80112674,%eax
80102521:	eb bd                	jmp    801024e0 <kalloc+0x10>
80102523:	66 90                	xchg   %ax,%ax
80102525:	66 90                	xchg   %ax,%ax
80102527:	66 90                	xchg   %ax,%ax
80102529:	66 90                	xchg   %ax,%ax
8010252b:	66 90                	xchg   %ax,%ax
8010252d:	66 90                	xchg   %ax,%ax
8010252f:	90                   	nop

80102530 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102530:	ba 64 00 00 00       	mov    $0x64,%edx
80102535:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102536:	a8 01                	test   $0x1,%al
80102538:	0f 84 ba 00 00 00    	je     801025f8 <kbdgetc+0xc8>
8010253e:	b2 60                	mov    $0x60,%dl
80102540:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102541:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102544:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010254a:	0f 84 88 00 00 00    	je     801025d8 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102550:	84 c0                	test   %al,%al
80102552:	79 2c                	jns    80102580 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102554:	8b 15 b4 a5 10 80    	mov    0x8010a5b4,%edx
8010255a:	f6 c2 40             	test   $0x40,%dl
8010255d:	75 05                	jne    80102564 <kbdgetc+0x34>
8010255f:	89 c1                	mov    %eax,%ecx
80102561:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102564:	0f b6 81 c0 70 10 80 	movzbl -0x7fef8f40(%ecx),%eax
8010256b:	83 c8 40             	or     $0x40,%eax
8010256e:	0f b6 c0             	movzbl %al,%eax
80102571:	f7 d0                	not    %eax
80102573:	21 d0                	and    %edx,%eax
80102575:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010257a:	31 c0                	xor    %eax,%eax
8010257c:	c3                   	ret    
8010257d:	8d 76 00             	lea    0x0(%esi),%esi
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	53                   	push   %ebx
80102584:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
  } else if(shift & E0ESC){
8010258a:	f6 c3 40             	test   $0x40,%bl
8010258d:	74 09                	je     80102598 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010258f:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102592:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102595:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102598:	0f b6 91 c0 70 10 80 	movzbl -0x7fef8f40(%ecx),%edx
  shift ^= togglecode[data];
8010259f:	0f b6 81 c0 6f 10 80 	movzbl -0x7fef9040(%ecx),%eax
  shift |= shiftcode[data];
801025a6:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801025a8:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801025aa:	89 d0                	mov    %edx,%eax
801025ac:	83 e0 03             	and    $0x3,%eax
801025af:	8b 04 85 a0 6f 10 80 	mov    -0x7fef9060(,%eax,4),%eax
  shift ^= togglecode[data];
801025b6:	89 15 b4 a5 10 80    	mov    %edx,0x8010a5b4
  if(shift & CAPSLOCK){
801025bc:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801025bf:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801025c3:	74 0b                	je     801025d0 <kbdgetc+0xa0>
    if('a' <= c && c <= 'z')
801025c5:	8d 50 9f             	lea    -0x61(%eax),%edx
801025c8:	83 fa 19             	cmp    $0x19,%edx
801025cb:	77 1b                	ja     801025e8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025cd:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025d0:	5b                   	pop    %ebx
801025d1:	5d                   	pop    %ebp
801025d2:	c3                   	ret    
801025d3:	90                   	nop
801025d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025d8:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
801025df:	31 c0                	xor    %eax,%eax
801025e1:	c3                   	ret    
801025e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801025e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025eb:	8d 50 20             	lea    0x20(%eax),%edx
801025ee:	83 f9 19             	cmp    $0x19,%ecx
801025f1:	0f 46 c2             	cmovbe %edx,%eax
  return c;
801025f4:	eb da                	jmp    801025d0 <kbdgetc+0xa0>
801025f6:	66 90                	xchg   %ax,%ax
    return -1;
801025f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025fd:	c3                   	ret    
801025fe:	66 90                	xchg   %ax,%ax

80102600 <kbdintr>:

void
kbdintr(void)
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102606:	c7 04 24 30 25 10 80 	movl   $0x80102530,(%esp)
8010260d:	e8 be e1 ff ff       	call   801007d0 <consoleintr>
}
80102612:	c9                   	leave  
80102613:	c3                   	ret    
80102614:	66 90                	xchg   %ax,%ax
80102616:	66 90                	xchg   %ax,%ax
80102618:	66 90                	xchg   %ax,%ax
8010261a:	66 90                	xchg   %ax,%ax
8010261c:	66 90                	xchg   %ax,%ax
8010261e:	66 90                	xchg   %ax,%ax

80102620 <fill_rtcdate>:
  return inb(CMOS_RETURN);
}

static void
fill_rtcdate(struct rtcdate *r)
{
80102620:	55                   	push   %ebp
80102621:	89 c1                	mov    %eax,%ecx
80102623:	89 e5                	mov    %esp,%ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102625:	ba 70 00 00 00       	mov    $0x70,%edx
8010262a:	53                   	push   %ebx
8010262b:	31 c0                	xor    %eax,%eax
8010262d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010262e:	bb 71 00 00 00       	mov    $0x71,%ebx
80102633:	89 da                	mov    %ebx,%edx
80102635:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102636:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102639:	b2 70                	mov    $0x70,%dl
8010263b:	89 01                	mov    %eax,(%ecx)
8010263d:	b8 02 00 00 00       	mov    $0x2,%eax
80102642:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102643:	89 da                	mov    %ebx,%edx
80102645:	ec                   	in     (%dx),%al
80102646:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102649:	b2 70                	mov    $0x70,%dl
8010264b:	89 41 04             	mov    %eax,0x4(%ecx)
8010264e:	b8 04 00 00 00       	mov    $0x4,%eax
80102653:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102654:	89 da                	mov    %ebx,%edx
80102656:	ec                   	in     (%dx),%al
80102657:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010265a:	b2 70                	mov    $0x70,%dl
8010265c:	89 41 08             	mov    %eax,0x8(%ecx)
8010265f:	b8 07 00 00 00       	mov    $0x7,%eax
80102664:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102665:	89 da                	mov    %ebx,%edx
80102667:	ec                   	in     (%dx),%al
80102668:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010266b:	b2 70                	mov    $0x70,%dl
8010266d:	89 41 0c             	mov    %eax,0xc(%ecx)
80102670:	b8 08 00 00 00       	mov    $0x8,%eax
80102675:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102676:	89 da                	mov    %ebx,%edx
80102678:	ec                   	in     (%dx),%al
80102679:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010267c:	b2 70                	mov    $0x70,%dl
8010267e:	89 41 10             	mov    %eax,0x10(%ecx)
80102681:	b8 09 00 00 00       	mov    $0x9,%eax
80102686:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102687:	89 da                	mov    %ebx,%edx
80102689:	ec                   	in     (%dx),%al
8010268a:	0f b6 d8             	movzbl %al,%ebx
8010268d:	89 59 14             	mov    %ebx,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
80102690:	5b                   	pop    %ebx
80102691:	5d                   	pop    %ebp
80102692:	c3                   	ret    
80102693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026a0 <lapicinit>:
  if(!lapic)
801026a0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
801026a5:	55                   	push   %ebp
801026a6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801026a8:	85 c0                	test   %eax,%eax
801026aa:	0f 84 c0 00 00 00    	je     80102770 <lapicinit+0xd0>
  lapic[index] = value;
801026b0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801026b7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026bd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801026c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ca:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026d1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801026d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026de:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026eb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026f1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026fb:	8b 50 20             	mov    0x20(%eax),%edx
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026fe:	8b 50 30             	mov    0x30(%eax),%edx
80102701:	c1 ea 10             	shr    $0x10,%edx
80102704:	80 fa 03             	cmp    $0x3,%dl
80102707:	77 6f                	ja     80102778 <lapicinit+0xd8>
  lapic[index] = value;
80102709:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102710:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102713:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102716:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010271d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102720:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102723:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010272a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010272d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102730:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102737:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010273d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102744:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102747:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010274a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102751:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102754:	8b 50 20             	mov    0x20(%eax),%edx
80102757:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
80102758:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010275e:	80 e6 10             	and    $0x10,%dh
80102761:	75 f5                	jne    80102758 <lapicinit+0xb8>
  lapic[index] = value;
80102763:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010276a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010276d:	8b 40 20             	mov    0x20(%eax),%eax
}
80102770:	5d                   	pop    %ebp
80102771:	c3                   	ret    
80102772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102778:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010277f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102782:	8b 50 20             	mov    0x20(%eax),%edx
80102785:	eb 82                	jmp    80102709 <lapicinit+0x69>
80102787:	89 f6                	mov    %esi,%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <lapicid>:
  if (!lapic)
80102790:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102795:	55                   	push   %ebp
80102796:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102798:	85 c0                	test   %eax,%eax
8010279a:	74 0c                	je     801027a8 <lapicid+0x18>
  return lapic[ID] >> 24;
8010279c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010279f:	5d                   	pop    %ebp
  return lapic[ID] >> 24;
801027a0:	c1 e8 18             	shr    $0x18,%eax
}
801027a3:	c3                   	ret    
801027a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801027a8:	31 c0                	xor    %eax,%eax
}
801027aa:	5d                   	pop    %ebp
801027ab:	c3                   	ret    
801027ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027b0 <lapiceoi>:
  if(lapic)
801027b0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
801027b5:	55                   	push   %ebp
801027b6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801027b8:	85 c0                	test   %eax,%eax
801027ba:	74 0d                	je     801027c9 <lapiceoi+0x19>
  lapic[index] = value;
801027bc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027c3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c6:	8b 40 20             	mov    0x20(%eax),%eax
}
801027c9:	5d                   	pop    %ebp
801027ca:	c3                   	ret    
801027cb:	90                   	nop
801027cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027d0 <microdelay>:
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
}
801027d3:	5d                   	pop    %ebp
801027d4:	c3                   	ret    
801027d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027e0 <lapicstartap>:
{
801027e0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027e1:	ba 70 00 00 00       	mov    $0x70,%edx
801027e6:	89 e5                	mov    %esp,%ebp
801027e8:	b8 0f 00 00 00       	mov    $0xf,%eax
801027ed:	53                   	push   %ebx
801027ee:	8b 4d 08             	mov    0x8(%ebp),%ecx
801027f1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801027f4:	ee                   	out    %al,(%dx)
801027f5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027fa:	b2 71                	mov    $0x71,%dl
801027fc:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
801027fd:	31 c0                	xor    %eax,%eax
801027ff:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102805:	89 d8                	mov    %ebx,%eax
80102807:	c1 e8 04             	shr    $0x4,%eax
8010280a:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102810:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(ICRHI, apicid<<24);
80102815:	c1 e1 18             	shl    $0x18,%ecx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102818:	c1 eb 0c             	shr    $0xc,%ebx
  lapic[index] = value;
8010281b:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102821:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102824:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
8010282b:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102831:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102838:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010283b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010283e:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102844:	8b 50 20             	mov    0x20(%eax),%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102847:	89 da                	mov    %ebx,%edx
80102849:	80 ce 06             	or     $0x6,%dh
  lapic[index] = value;
8010284c:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102852:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102855:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010285b:	8b 48 20             	mov    0x20(%eax),%ecx
  lapic[index] = value;
8010285e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102864:	8b 40 20             	mov    0x20(%eax),%eax
}
80102867:	5b                   	pop    %ebx
80102868:	5d                   	pop    %ebp
80102869:	c3                   	ret    
8010286a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102870 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102870:	55                   	push   %ebp
80102871:	ba 70 00 00 00       	mov    $0x70,%edx
80102876:	89 e5                	mov    %esp,%ebp
80102878:	b8 0b 00 00 00       	mov    $0xb,%eax
8010287d:	57                   	push   %edi
8010287e:	56                   	push   %esi
8010287f:	53                   	push   %ebx
80102880:	83 ec 4c             	sub    $0x4c,%esp
80102883:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102884:	b2 71                	mov    $0x71,%dl
80102886:	ec                   	in     (%dx),%al
80102887:	88 45 b7             	mov    %al,-0x49(%ebp)
8010288a:	8d 5d b8             	lea    -0x48(%ebp),%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010288d:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
80102891:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102898:	be 70 00 00 00       	mov    $0x70,%esi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010289d:	89 d8                	mov    %ebx,%eax
8010289f:	e8 7c fd ff ff       	call   80102620 <fill_rtcdate>
801028a4:	b8 0a 00 00 00       	mov    $0xa,%eax
801028a9:	89 f2                	mov    %esi,%edx
801028ab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ac:	ba 71 00 00 00       	mov    $0x71,%edx
801028b1:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028b2:	84 c0                	test   %al,%al
801028b4:	78 e7                	js     8010289d <cmostime+0x2d>
        continue;
    fill_rtcdate(&t2);
801028b6:	89 f8                	mov    %edi,%eax
801028b8:	e8 63 fd ff ff       	call   80102620 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028bd:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
801028c4:	00 
801028c5:	89 7c 24 04          	mov    %edi,0x4(%esp)
801028c9:	89 1c 24             	mov    %ebx,(%esp)
801028cc:	e8 2f 1b 00 00       	call   80104400 <memcmp>
801028d1:	85 c0                	test   %eax,%eax
801028d3:	75 c3                	jne    80102898 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801028d5:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801028d9:	75 78                	jne    80102953 <cmostime+0xe3>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801028db:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028de:	89 c2                	mov    %eax,%edx
801028e0:	83 e0 0f             	and    $0xf,%eax
801028e3:	c1 ea 04             	shr    $0x4,%edx
801028e6:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028e9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028ec:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801028ef:	8b 45 bc             	mov    -0x44(%ebp),%eax
801028f2:	89 c2                	mov    %eax,%edx
801028f4:	83 e0 0f             	and    $0xf,%eax
801028f7:	c1 ea 04             	shr    $0x4,%edx
801028fa:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028fd:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102900:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102903:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102906:	89 c2                	mov    %eax,%edx
80102908:	83 e0 0f             	and    $0xf,%eax
8010290b:	c1 ea 04             	shr    $0x4,%edx
8010290e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102911:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102914:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102917:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010291a:	89 c2                	mov    %eax,%edx
8010291c:	83 e0 0f             	and    $0xf,%eax
8010291f:	c1 ea 04             	shr    $0x4,%edx
80102922:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102925:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102928:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010292b:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010292e:	89 c2                	mov    %eax,%edx
80102930:	83 e0 0f             	and    $0xf,%eax
80102933:	c1 ea 04             	shr    $0x4,%edx
80102936:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102939:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010293c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010293f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102942:	89 c2                	mov    %eax,%edx
80102944:	83 e0 0f             	and    $0xf,%eax
80102947:	c1 ea 04             	shr    $0x4,%edx
8010294a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010294d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102950:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102953:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102956:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102959:	89 01                	mov    %eax,(%ecx)
8010295b:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010295e:	89 41 04             	mov    %eax,0x4(%ecx)
80102961:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102964:	89 41 08             	mov    %eax,0x8(%ecx)
80102967:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010296a:	89 41 0c             	mov    %eax,0xc(%ecx)
8010296d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102970:	89 41 10             	mov    %eax,0x10(%ecx)
80102973:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102976:	89 41 14             	mov    %eax,0x14(%ecx)
  r->year += 2000;
80102979:	81 41 14 d0 07 00 00 	addl   $0x7d0,0x14(%ecx)
}
80102980:	83 c4 4c             	add    $0x4c,%esp
80102983:	5b                   	pop    %ebx
80102984:	5e                   	pop    %esi
80102985:	5f                   	pop    %edi
80102986:	5d                   	pop    %ebp
80102987:	c3                   	ret    
80102988:	66 90                	xchg   %ax,%ax
8010298a:	66 90                	xchg   %ax,%ax
8010298c:	66 90                	xchg   %ax,%ax
8010298e:	66 90                	xchg   %ax,%ax

80102990 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	57                   	push   %edi
80102994:	56                   	push   %esi
80102995:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102996:	31 db                	xor    %ebx,%ebx
{
80102998:	83 ec 1c             	sub    $0x1c,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010299b:	a1 c8 26 11 80       	mov    0x801126c8,%eax
801029a0:	85 c0                	test   %eax,%eax
801029a2:	7e 78                	jle    80102a1c <install_trans+0x8c>
801029a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029a8:	a1 b4 26 11 80       	mov    0x801126b4,%eax
801029ad:	01 d8                	add    %ebx,%eax
801029af:	83 c0 01             	add    $0x1,%eax
801029b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801029b6:	a1 c4 26 11 80       	mov    0x801126c4,%eax
801029bb:	89 04 24             	mov    %eax,(%esp)
801029be:	e8 0d d7 ff ff       	call   801000d0 <bread>
801029c3:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029c5:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
801029cc:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801029d3:	a1 c4 26 11 80       	mov    0x801126c4,%eax
801029d8:	89 04 24             	mov    %eax,(%esp)
801029db:	e8 f0 d6 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029e0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801029e7:	00 
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029e8:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029ea:	8d 47 5c             	lea    0x5c(%edi),%eax
801029ed:	89 44 24 04          	mov    %eax,0x4(%esp)
801029f1:	8d 46 5c             	lea    0x5c(%esi),%eax
801029f4:	89 04 24             	mov    %eax,(%esp)
801029f7:	e8 54 1a 00 00       	call   80104450 <memmove>
    bwrite(dbuf);  // write dst to disk
801029fc:	89 34 24             	mov    %esi,(%esp)
801029ff:	e8 9c d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a04:	89 3c 24             	mov    %edi,(%esp)
80102a07:	e8 d4 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a0c:	89 34 24             	mov    %esi,(%esp)
80102a0f:	e8 cc d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102a14:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102a1a:	7f 8c                	jg     801029a8 <install_trans+0x18>
  }
}
80102a1c:	83 c4 1c             	add    $0x1c,%esp
80102a1f:	5b                   	pop    %ebx
80102a20:	5e                   	pop    %esi
80102a21:	5f                   	pop    %edi
80102a22:	5d                   	pop    %ebp
80102a23:	c3                   	ret    
80102a24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102a30 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a30:	55                   	push   %ebp
80102a31:	89 e5                	mov    %esp,%ebp
80102a33:	57                   	push   %edi
80102a34:	56                   	push   %esi
80102a35:	53                   	push   %ebx
80102a36:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a39:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a3e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a42:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102a47:	89 04 24             	mov    %eax,(%esp)
80102a4a:	e8 81 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a4f:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102a55:	31 d2                	xor    %edx,%edx
80102a57:	85 db                	test   %ebx,%ebx
  struct buf *buf = bread(log.dev, log.start);
80102a59:	89 c7                	mov    %eax,%edi
  hb->n = log.lh.n;
80102a5b:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102a5e:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102a61:	7e 17                	jle    80102a7a <write_head+0x4a>
80102a63:	90                   	nop
80102a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102a68:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102a6f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102a73:	83 c2 01             	add    $0x1,%edx
80102a76:	39 da                	cmp    %ebx,%edx
80102a78:	75 ee                	jne    80102a68 <write_head+0x38>
  }
  bwrite(buf);
80102a7a:	89 3c 24             	mov    %edi,(%esp)
80102a7d:	e8 1e d7 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102a82:	89 3c 24             	mov    %edi,(%esp)
80102a85:	e8 56 d7 ff ff       	call   801001e0 <brelse>
}
80102a8a:	83 c4 1c             	add    $0x1c,%esp
80102a8d:	5b                   	pop    %ebx
80102a8e:	5e                   	pop    %esi
80102a8f:	5f                   	pop    %edi
80102a90:	5d                   	pop    %ebp
80102a91:	c3                   	ret    
80102a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102aa0 <initlog>:
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	56                   	push   %esi
80102aa4:	53                   	push   %ebx
80102aa5:	83 ec 30             	sub    $0x30,%esp
80102aa8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102aab:	c7 44 24 04 c0 71 10 	movl   $0x801071c0,0x4(%esp)
80102ab2:	80 
80102ab3:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102aba:	e8 c1 16 00 00       	call   80104180 <initlock>
  readsb(dev, &sb);
80102abf:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102ac2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ac6:	89 1c 24             	mov    %ebx,(%esp)
80102ac9:	e8 f2 e8 ff ff       	call   801013c0 <readsb>
  log.start = sb.logstart;
80102ace:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102ad1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  struct buf *buf = bread(log.dev, log.start);
80102ad4:	89 1c 24             	mov    %ebx,(%esp)
  log.dev = dev;
80102ad7:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  struct buf *buf = bread(log.dev, log.start);
80102add:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.size = sb.nlog;
80102ae1:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102ae7:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102aec:	e8 df d5 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102af1:	31 d2                	xor    %edx,%edx
  log.lh.n = lh->n;
80102af3:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102af6:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102af9:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102afb:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102b01:	7e 17                	jle    80102b1a <initlog+0x7a>
80102b03:	90                   	nop
80102b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102b08:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102b0c:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102b13:	83 c2 01             	add    $0x1,%edx
80102b16:	39 da                	cmp    %ebx,%edx
80102b18:	75 ee                	jne    80102b08 <initlog+0x68>
  brelse(buf);
80102b1a:	89 04 24             	mov    %eax,(%esp)
80102b1d:	e8 be d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b22:	e8 69 fe ff ff       	call   80102990 <install_trans>
  log.lh.n = 0;
80102b27:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102b2e:	00 00 00 
  write_head(); // clear the log
80102b31:	e8 fa fe ff ff       	call   80102a30 <write_head>
}
80102b36:	83 c4 30             	add    $0x30,%esp
80102b39:	5b                   	pop    %ebx
80102b3a:	5e                   	pop    %esi
80102b3b:	5d                   	pop    %ebp
80102b3c:	c3                   	ret    
80102b3d:	8d 76 00             	lea    0x0(%esi),%esi

80102b40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b40:	55                   	push   %ebp
80102b41:	89 e5                	mov    %esp,%ebp
80102b43:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102b46:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b4d:	e8 9e 17 00 00       	call   801042f0 <acquire>
80102b52:	eb 18                	jmp    80102b6c <begin_op+0x2c>
80102b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b58:	c7 44 24 04 80 26 11 	movl   $0x80112680,0x4(%esp)
80102b5f:	80 
80102b60:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b67:	e8 c4 10 00 00       	call   80103c30 <sleep>
    if(log.committing){
80102b6c:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102b71:	85 c0                	test   %eax,%eax
80102b73:	75 e3                	jne    80102b58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102b75:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102b7a:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102b80:	83 c0 01             	add    $0x1,%eax
80102b83:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b86:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b89:	83 fa 1e             	cmp    $0x1e,%edx
80102b8c:	7f ca                	jg     80102b58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102b8e:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
      log.outstanding += 1;
80102b95:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102b9a:	e8 c1 17 00 00       	call   80104360 <release>
      break;
    }
  }
}
80102b9f:	c9                   	leave  
80102ba0:	c3                   	ret    
80102ba1:	eb 0d                	jmp    80102bb0 <end_op>
80102ba3:	90                   	nop
80102ba4:	90                   	nop
80102ba5:	90                   	nop
80102ba6:	90                   	nop
80102ba7:	90                   	nop
80102ba8:	90                   	nop
80102ba9:	90                   	nop
80102baa:	90                   	nop
80102bab:	90                   	nop
80102bac:	90                   	nop
80102bad:	90                   	nop
80102bae:	90                   	nop
80102baf:	90                   	nop

80102bb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	57                   	push   %edi
80102bb4:	56                   	push   %esi
80102bb5:	53                   	push   %ebx
80102bb6:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102bb9:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102bc0:	e8 2b 17 00 00       	call   801042f0 <acquire>
  log.outstanding -= 1;
80102bc5:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102bca:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
  log.outstanding -= 1;
80102bd0:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102bd3:	85 d2                	test   %edx,%edx
  log.outstanding -= 1;
80102bd5:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102bda:	0f 85 f3 00 00 00    	jne    80102cd3 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102be0:	85 c0                	test   %eax,%eax
80102be2:	0f 85 cb 00 00 00    	jne    80102cb3 <end_op+0x103>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102be8:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
}

static void
commit()
{
  if (log.lh.n > 0) {
80102bef:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
80102bf1:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102bf8:	00 00 00 
  release(&log.lock);
80102bfb:	e8 60 17 00 00       	call   80104360 <release>
  if (log.lh.n > 0) {
80102c00:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102c05:	85 c0                	test   %eax,%eax
80102c07:	0f 8e 90 00 00 00    	jle    80102c9d <end_op+0xed>
80102c0d:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c10:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c15:	01 d8                	add    %ebx,%eax
80102c17:	83 c0 01             	add    $0x1,%eax
80102c1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c1e:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102c23:	89 04 24             	mov    %eax,(%esp)
80102c26:	e8 a5 d4 ff ff       	call   801000d0 <bread>
80102c2b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c2d:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102c34:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c37:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c3b:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102c40:	89 04 24             	mov    %eax,(%esp)
80102c43:	e8 88 d4 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102c48:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102c4f:	00 
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c50:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c52:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c55:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c59:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c5c:	89 04 24             	mov    %eax,(%esp)
80102c5f:	e8 ec 17 00 00       	call   80104450 <memmove>
    bwrite(to);  // write the log
80102c64:	89 34 24             	mov    %esi,(%esp)
80102c67:	e8 34 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c6c:	89 3c 24             	mov    %edi,(%esp)
80102c6f:	e8 6c d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102c74:	89 34 24             	mov    %esi,(%esp)
80102c77:	e8 64 d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c7c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102c82:	7c 8c                	jl     80102c10 <end_op+0x60>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102c84:	e8 a7 fd ff ff       	call   80102a30 <write_head>
    install_trans(); // Now install writes to home locations
80102c89:	e8 02 fd ff ff       	call   80102990 <install_trans>
    log.lh.n = 0;
80102c8e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c95:	00 00 00 
    write_head();    // Erase the transaction from the log
80102c98:	e8 93 fd ff ff       	call   80102a30 <write_head>
    acquire(&log.lock);
80102c9d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102ca4:	e8 47 16 00 00       	call   801042f0 <acquire>
    log.committing = 0;
80102ca9:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102cb0:	00 00 00 
    wakeup(&log);
80102cb3:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cba:	e8 01 11 00 00       	call   80103dc0 <wakeup>
    release(&log.lock);
80102cbf:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cc6:	e8 95 16 00 00       	call   80104360 <release>
}
80102ccb:	83 c4 1c             	add    $0x1c,%esp
80102cce:	5b                   	pop    %ebx
80102ccf:	5e                   	pop    %esi
80102cd0:	5f                   	pop    %edi
80102cd1:	5d                   	pop    %ebp
80102cd2:	c3                   	ret    
    panic("log.committing");
80102cd3:	c7 04 24 c4 71 10 80 	movl   $0x801071c4,(%esp)
80102cda:	e8 81 d6 ff ff       	call   80100360 <panic>
80102cdf:	90                   	nop

80102ce0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ce0:	55                   	push   %ebp
80102ce1:	89 e5                	mov    %esp,%ebp
80102ce3:	53                   	push   %ebx
80102ce4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ce7:	a1 c8 26 11 80       	mov    0x801126c8,%eax
{
80102cec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102cef:	83 f8 1d             	cmp    $0x1d,%eax
80102cf2:	0f 8f 98 00 00 00    	jg     80102d90 <log_write+0xb0>
80102cf8:	8b 0d b8 26 11 80    	mov    0x801126b8,%ecx
80102cfe:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102d01:	39 d0                	cmp    %edx,%eax
80102d03:	0f 8d 87 00 00 00    	jge    80102d90 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d09:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102d0e:	85 c0                	test   %eax,%eax
80102d10:	0f 8e 86 00 00 00    	jle    80102d9c <log_write+0xbc>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d16:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d1d:	e8 ce 15 00 00       	call   801042f0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d22:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102d28:	83 fa 00             	cmp    $0x0,%edx
80102d2b:	7e 54                	jle    80102d81 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d2d:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102d30:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d32:	39 0d cc 26 11 80    	cmp    %ecx,0x801126cc
80102d38:	75 0f                	jne    80102d49 <log_write+0x69>
80102d3a:	eb 3c                	jmp    80102d78 <log_write+0x98>
80102d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d40:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102d47:	74 2f                	je     80102d78 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102d49:	83 c0 01             	add    $0x1,%eax
80102d4c:	39 d0                	cmp    %edx,%eax
80102d4e:	75 f0                	jne    80102d40 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102d50:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102d57:	83 c2 01             	add    $0x1,%edx
80102d5a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102d60:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102d63:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102d6a:	83 c4 14             	add    $0x14,%esp
80102d6d:	5b                   	pop    %ebx
80102d6e:	5d                   	pop    %ebp
  release(&log.lock);
80102d6f:	e9 ec 15 00 00       	jmp    80104360 <release>
80102d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  log.lh.block[i] = b->blockno;
80102d78:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102d7f:	eb df                	jmp    80102d60 <log_write+0x80>
80102d81:	8b 43 08             	mov    0x8(%ebx),%eax
80102d84:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102d89:	75 d5                	jne    80102d60 <log_write+0x80>
80102d8b:	eb ca                	jmp    80102d57 <log_write+0x77>
80102d8d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("too big a transaction");
80102d90:	c7 04 24 d3 71 10 80 	movl   $0x801071d3,(%esp)
80102d97:	e8 c4 d5 ff ff       	call   80100360 <panic>
    panic("log_write outside of trans");
80102d9c:	c7 04 24 e9 71 10 80 	movl   $0x801071e9,(%esp)
80102da3:	e8 b8 d5 ff ff       	call   80100360 <panic>
80102da8:	66 90                	xchg   %ax,%ax
80102daa:	66 90                	xchg   %ax,%ax
80102dac:	66 90                	xchg   %ax,%ax
80102dae:	66 90                	xchg   %ax,%ax

80102db0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	53                   	push   %ebx
80102db4:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102db7:	e8 f4 08 00 00       	call   801036b0 <cpuid>
80102dbc:	89 c3                	mov    %eax,%ebx
80102dbe:	e8 ed 08 00 00       	call   801036b0 <cpuid>
80102dc3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102dc7:	c7 04 24 04 72 10 80 	movl   $0x80107204,(%esp)
80102dce:	89 44 24 04          	mov    %eax,0x4(%esp)
80102dd2:	e8 79 d8 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102dd7:	e8 e4 27 00 00       	call   801055c0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102ddc:	e8 4f 08 00 00       	call   80103630 <mycpu>
80102de1:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102de3:	b8 01 00 00 00       	mov    $0x1,%eax
80102de8:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102def:	e8 9c 0b 00 00       	call   80103990 <scheduler>
80102df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102e00 <mpenter>:
{
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e06:	e8 75 38 00 00       	call   80106680 <switchkvm>
  seginit();
80102e0b:	e8 b0 37 00 00       	call   801065c0 <seginit>
  lapicinit();
80102e10:	e8 8b f8 ff ff       	call   801026a0 <lapicinit>
  mpmain();
80102e15:	e8 96 ff ff ff       	call   80102db0 <mpmain>
80102e1a:	66 90                	xchg   %ax,%ax
80102e1c:	66 90                	xchg   %ax,%ax
80102e1e:	66 90                	xchg   %ax,%ax

80102e20 <main>:
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102e24:	bb 80 27 11 80       	mov    $0x80112780,%ebx
{
80102e29:	83 e4 f0             	and    $0xfffffff0,%esp
80102e2c:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e2f:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102e36:	80 
80102e37:	c7 04 24 a8 55 11 80 	movl   $0x801155a8,(%esp)
80102e3e:	e8 cd f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102e43:	e8 c8 3c 00 00       	call   80106b10 <kvmalloc>
  mpinit();        // detect other processors
80102e48:	e8 73 01 00 00       	call   80102fc0 <mpinit>
80102e4d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicinit();     // interrupt controller
80102e50:	e8 4b f8 ff ff       	call   801026a0 <lapicinit>
  seginit();       // segment descriptors
80102e55:	e8 66 37 00 00       	call   801065c0 <seginit>
  picinit();       // disable pic
80102e5a:	e8 21 03 00 00       	call   80103180 <picinit>
80102e5f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102e60:	e8 cb f3 ff ff       	call   80102230 <ioapicinit>
  consoleinit();   // console hardware
80102e65:	e8 06 db ff ff       	call   80100970 <consoleinit>
  uartinit();      // serial port
80102e6a:	e8 71 2a 00 00       	call   801058e0 <uartinit>
80102e6f:	90                   	nop
  pinit();         // process table
80102e70:	e8 9b 07 00 00       	call   80103610 <pinit>
  tvinit();        // trap vectors
80102e75:	e8 a6 26 00 00       	call   80105520 <tvinit>
  binit();         // buffer cache
80102e7a:	e8 c1 d1 ff ff       	call   80100040 <binit>
80102e7f:	90                   	nop
  fileinit();      // file table
80102e80:	e8 eb de ff ff       	call   80100d70 <fileinit>
  ideinit();       // disk 
80102e85:	e8 a6 f1 ff ff       	call   80102030 <ideinit>
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102e8a:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102e91:	00 
80102e92:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102e99:	80 
80102e9a:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102ea1:	e8 aa 15 00 00       	call   80104450 <memmove>
  for(c = cpus; c < cpus+ncpu; c++){
80102ea6:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102ead:	00 00 00 
80102eb0:	05 80 27 11 80       	add    $0x80112780,%eax
80102eb5:	39 d8                	cmp    %ebx,%eax
80102eb7:	76 6a                	jbe    80102f23 <main+0x103>
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102ec0:	e8 6b 07 00 00       	call   80103630 <mycpu>
80102ec5:	39 d8                	cmp    %ebx,%eax
80102ec7:	74 41                	je     80102f0a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102ec9:	e8 02 f6 ff ff       	call   801024d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102ece:	c7 05 f8 6f 00 80 00 	movl   $0x80102e00,0x80006ff8
80102ed5:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102ed8:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102edf:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ee2:	05 00 10 00 00       	add    $0x1000,%eax
80102ee7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102eec:	0f b6 03             	movzbl (%ebx),%eax
80102eef:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102ef6:	00 
80102ef7:	89 04 24             	mov    %eax,(%esp)
80102efa:	e8 e1 f8 ff ff       	call   801027e0 <lapicstartap>
80102eff:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f00:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f06:	85 c0                	test   %eax,%eax
80102f08:	74 f6                	je     80102f00 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102f0a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f11:	00 00 00 
80102f14:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f1a:	05 80 27 11 80       	add    $0x80112780,%eax
80102f1f:	39 c3                	cmp    %eax,%ebx
80102f21:	72 9d                	jb     80102ec0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f23:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102f2a:	8e 
80102f2b:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102f32:	e8 49 f5 ff ff       	call   80102480 <kinit2>
  userinit();      // first user process
80102f37:	e8 c4 07 00 00       	call   80103700 <userinit>
  mpmain();        // finish this processor's setup
80102f3c:	e8 6f fe ff ff       	call   80102db0 <mpmain>
80102f41:	66 90                	xchg   %ax,%ax
80102f43:	66 90                	xchg   %ax,%ax
80102f45:	66 90                	xchg   %ax,%ax
80102f47:	66 90                	xchg   %ax,%ax
80102f49:	66 90                	xchg   %ax,%ax
80102f4b:	66 90                	xchg   %ax,%ax
80102f4d:	66 90                	xchg   %ax,%ax
80102f4f:	90                   	nop

80102f50 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f50:	55                   	push   %ebp
80102f51:	89 e5                	mov    %esp,%ebp
80102f53:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102f54:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102f5a:	53                   	push   %ebx
  e = addr+len;
80102f5b:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102f5e:	83 ec 10             	sub    $0x10,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102f61:	39 de                	cmp    %ebx,%esi
80102f63:	73 3c                	jae    80102fa1 <mpsearch1+0x51>
80102f65:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f68:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102f6f:	00 
80102f70:	c7 44 24 04 18 72 10 	movl   $0x80107218,0x4(%esp)
80102f77:	80 
80102f78:	89 34 24             	mov    %esi,(%esp)
80102f7b:	e8 80 14 00 00       	call   80104400 <memcmp>
80102f80:	85 c0                	test   %eax,%eax
80102f82:	75 16                	jne    80102f9a <mpsearch1+0x4a>
80102f84:	31 c9                	xor    %ecx,%ecx
80102f86:	31 d2                	xor    %edx,%edx
    sum += addr[i];
80102f88:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
  for(i=0; i<len; i++)
80102f8c:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80102f8f:	01 c1                	add    %eax,%ecx
  for(i=0; i<len; i++)
80102f91:	83 fa 10             	cmp    $0x10,%edx
80102f94:	75 f2                	jne    80102f88 <mpsearch1+0x38>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f96:	84 c9                	test   %cl,%cl
80102f98:	74 10                	je     80102faa <mpsearch1+0x5a>
  for(p = addr; p < e; p += sizeof(struct mp))
80102f9a:	83 c6 10             	add    $0x10,%esi
80102f9d:	39 f3                	cmp    %esi,%ebx
80102f9f:	77 c7                	ja     80102f68 <mpsearch1+0x18>
      return (struct mp*)p;
  return 0;
}
80102fa1:	83 c4 10             	add    $0x10,%esp
  return 0;
80102fa4:	31 c0                	xor    %eax,%eax
}
80102fa6:	5b                   	pop    %ebx
80102fa7:	5e                   	pop    %esi
80102fa8:	5d                   	pop    %ebp
80102fa9:	c3                   	ret    
80102faa:	83 c4 10             	add    $0x10,%esp
80102fad:	89 f0                	mov    %esi,%eax
80102faf:	5b                   	pop    %ebx
80102fb0:	5e                   	pop    %esi
80102fb1:	5d                   	pop    %ebp
80102fb2:	c3                   	ret    
80102fb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102fc0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	57                   	push   %edi
80102fc4:	56                   	push   %esi
80102fc5:	53                   	push   %ebx
80102fc6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102fc9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102fd0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102fd7:	c1 e0 08             	shl    $0x8,%eax
80102fda:	09 d0                	or     %edx,%eax
80102fdc:	c1 e0 04             	shl    $0x4,%eax
80102fdf:	85 c0                	test   %eax,%eax
80102fe1:	75 1b                	jne    80102ffe <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102fe3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102fea:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102ff1:	c1 e0 08             	shl    $0x8,%eax
80102ff4:	09 d0                	or     %edx,%eax
80102ff6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102ff9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80102ffe:	ba 00 04 00 00       	mov    $0x400,%edx
80103003:	e8 48 ff ff ff       	call   80102f50 <mpsearch1>
80103008:	85 c0                	test   %eax,%eax
8010300a:	89 c7                	mov    %eax,%edi
8010300c:	0f 84 22 01 00 00    	je     80103134 <mpinit+0x174>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103012:	8b 77 04             	mov    0x4(%edi),%esi
80103015:	85 f6                	test   %esi,%esi
80103017:	0f 84 30 01 00 00    	je     8010314d <mpinit+0x18d>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010301d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103023:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010302a:	00 
8010302b:	c7 44 24 04 1d 72 10 	movl   $0x8010721d,0x4(%esp)
80103032:	80 
80103033:	89 04 24             	mov    %eax,(%esp)
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103036:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103039:	e8 c2 13 00 00       	call   80104400 <memcmp>
8010303e:	85 c0                	test   %eax,%eax
80103040:	0f 85 07 01 00 00    	jne    8010314d <mpinit+0x18d>
  if(conf->version != 1 && conf->version != 4)
80103046:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010304d:	3c 04                	cmp    $0x4,%al
8010304f:	0f 85 0b 01 00 00    	jne    80103160 <mpinit+0x1a0>
  if(sum((uchar*)conf, conf->length) != 0)
80103055:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
  for(i=0; i<len; i++)
8010305c:	85 c0                	test   %eax,%eax
8010305e:	74 21                	je     80103081 <mpinit+0xc1>
  sum = 0;
80103060:	31 c9                	xor    %ecx,%ecx
  for(i=0; i<len; i++)
80103062:	31 d2                	xor    %edx,%edx
80103064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103068:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
8010306f:	80 
  for(i=0; i<len; i++)
80103070:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103073:	01 d9                	add    %ebx,%ecx
  for(i=0; i<len; i++)
80103075:	39 d0                	cmp    %edx,%eax
80103077:	7f ef                	jg     80103068 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103079:	84 c9                	test   %cl,%cl
8010307b:	0f 85 cc 00 00 00    	jne    8010314d <mpinit+0x18d>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103081:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103084:	85 c0                	test   %eax,%eax
80103086:	0f 84 c1 00 00 00    	je     8010314d <mpinit+0x18d>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010308c:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  ismp = 1;
80103092:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
80103097:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010309c:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801030a3:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801030a9:	03 55 e4             	add    -0x1c(%ebp),%edx
801030ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030b0:	39 c2                	cmp    %eax,%edx
801030b2:	76 1b                	jbe    801030cf <mpinit+0x10f>
801030b4:	0f b6 08             	movzbl (%eax),%ecx
    switch(*p){
801030b7:	80 f9 04             	cmp    $0x4,%cl
801030ba:	77 74                	ja     80103130 <mpinit+0x170>
801030bc:	ff 24 8d 5c 72 10 80 	jmp    *-0x7fef8da4(,%ecx,4)
801030c3:	90                   	nop
801030c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801030c8:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030cb:	39 c2                	cmp    %eax,%edx
801030cd:	77 e5                	ja     801030b4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801030cf:	85 db                	test   %ebx,%ebx
801030d1:	0f 84 93 00 00 00    	je     8010316a <mpinit+0x1aa>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801030d7:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801030db:	74 12                	je     801030ef <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030dd:	ba 22 00 00 00       	mov    $0x22,%edx
801030e2:	b8 70 00 00 00       	mov    $0x70,%eax
801030e7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030e8:	b2 23                	mov    $0x23,%dl
801030ea:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801030eb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030ee:	ee                   	out    %al,(%dx)
  }
}
801030ef:	83 c4 1c             	add    $0x1c,%esp
801030f2:	5b                   	pop    %ebx
801030f3:	5e                   	pop    %esi
801030f4:	5f                   	pop    %edi
801030f5:	5d                   	pop    %ebp
801030f6:	c3                   	ret    
801030f7:	90                   	nop
      if(ncpu < NCPU) {
801030f8:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801030fe:	83 fe 07             	cmp    $0x7,%esi
80103101:	7f 17                	jg     8010311a <mpinit+0x15a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103103:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80103107:	69 f6 b0 00 00 00    	imul   $0xb0,%esi,%esi
        ncpu++;
8010310d:	83 05 00 2d 11 80 01 	addl   $0x1,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103114:	88 8e 80 27 11 80    	mov    %cl,-0x7feed880(%esi)
      p += sizeof(struct mpproc);
8010311a:	83 c0 14             	add    $0x14,%eax
      continue;
8010311d:	eb 91                	jmp    801030b0 <mpinit+0xf0>
8010311f:	90                   	nop
      ioapicid = ioapic->apicno;
80103120:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103124:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103127:	88 0d 60 27 11 80    	mov    %cl,0x80112760
      continue;
8010312d:	eb 81                	jmp    801030b0 <mpinit+0xf0>
8010312f:	90                   	nop
      ismp = 0;
80103130:	31 db                	xor    %ebx,%ebx
80103132:	eb 83                	jmp    801030b7 <mpinit+0xf7>
  return mpsearch1(0xF0000, 0x10000);
80103134:	ba 00 00 01 00       	mov    $0x10000,%edx
80103139:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010313e:	e8 0d fe ff ff       	call   80102f50 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103143:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103145:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103147:	0f 85 c5 fe ff ff    	jne    80103012 <mpinit+0x52>
    panic("Expect to run on an SMP");
8010314d:	c7 04 24 22 72 10 80 	movl   $0x80107222,(%esp)
80103154:	e8 07 d2 ff ff       	call   80100360 <panic>
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(conf->version != 1 && conf->version != 4)
80103160:	3c 01                	cmp    $0x1,%al
80103162:	0f 84 ed fe ff ff    	je     80103055 <mpinit+0x95>
80103168:	eb e3                	jmp    8010314d <mpinit+0x18d>
    panic("Didn't find a suitable machine");
8010316a:	c7 04 24 3c 72 10 80 	movl   $0x8010723c,(%esp)
80103171:	e8 ea d1 ff ff       	call   80100360 <panic>
80103176:	66 90                	xchg   %ax,%ax
80103178:	66 90                	xchg   %ax,%ax
8010317a:	66 90                	xchg   %ax,%ax
8010317c:	66 90                	xchg   %ax,%ax
8010317e:	66 90                	xchg   %ax,%ax

80103180 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103180:	55                   	push   %ebp
80103181:	ba 21 00 00 00       	mov    $0x21,%edx
80103186:	89 e5                	mov    %esp,%ebp
80103188:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010318d:	ee                   	out    %al,(%dx)
8010318e:	b2 a1                	mov    $0xa1,%dl
80103190:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103191:	5d                   	pop    %ebp
80103192:	c3                   	ret    
80103193:	66 90                	xchg   %ax,%ax
80103195:	66 90                	xchg   %ax,%ax
80103197:	66 90                	xchg   %ax,%ax
80103199:	66 90                	xchg   %ax,%ax
8010319b:	66 90                	xchg   %ax,%ax
8010319d:	66 90                	xchg   %ax,%ax
8010319f:	90                   	nop

801031a0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	57                   	push   %edi
801031a4:	56                   	push   %esi
801031a5:	53                   	push   %ebx
801031a6:	83 ec 1c             	sub    $0x1c,%esp
801031a9:	8b 75 08             	mov    0x8(%ebp),%esi
801031ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801031af:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801031b5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801031bb:	e8 d0 db ff ff       	call   80100d90 <filealloc>
801031c0:	85 c0                	test   %eax,%eax
801031c2:	89 06                	mov    %eax,(%esi)
801031c4:	0f 84 a4 00 00 00    	je     8010326e <pipealloc+0xce>
801031ca:	e8 c1 db ff ff       	call   80100d90 <filealloc>
801031cf:	85 c0                	test   %eax,%eax
801031d1:	89 03                	mov    %eax,(%ebx)
801031d3:	0f 84 87 00 00 00    	je     80103260 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801031d9:	e8 f2 f2 ff ff       	call   801024d0 <kalloc>
801031de:	85 c0                	test   %eax,%eax
801031e0:	89 c7                	mov    %eax,%edi
801031e2:	74 7c                	je     80103260 <pipealloc+0xc0>
    goto bad;
  p->readopen = 1;
801031e4:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801031eb:	00 00 00 
  p->writeopen = 1;
801031ee:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801031f5:	00 00 00 
  p->nwrite = 0;
801031f8:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801031ff:	00 00 00 
  p->nread = 0;
80103202:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103209:	00 00 00 
  initlock(&p->lock, "pipe");
8010320c:	89 04 24             	mov    %eax,(%esp)
8010320f:	c7 44 24 04 70 72 10 	movl   $0x80107270,0x4(%esp)
80103216:	80 
80103217:	e8 64 0f 00 00       	call   80104180 <initlock>
  (*f0)->type = FD_PIPE;
8010321c:	8b 06                	mov    (%esi),%eax
8010321e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103224:	8b 06                	mov    (%esi),%eax
80103226:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010322a:	8b 06                	mov    (%esi),%eax
8010322c:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103230:	8b 06                	mov    (%esi),%eax
80103232:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103235:	8b 03                	mov    (%ebx),%eax
80103237:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010323d:	8b 03                	mov    (%ebx),%eax
8010323f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103243:	8b 03                	mov    (%ebx),%eax
80103245:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103249:	8b 03                	mov    (%ebx),%eax
  return 0;
8010324b:	31 db                	xor    %ebx,%ebx
  (*f1)->pipe = p;
8010324d:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103250:	83 c4 1c             	add    $0x1c,%esp
80103253:	89 d8                	mov    %ebx,%eax
80103255:	5b                   	pop    %ebx
80103256:	5e                   	pop    %esi
80103257:	5f                   	pop    %edi
80103258:	5d                   	pop    %ebp
80103259:	c3                   	ret    
8010325a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(*f0)
80103260:	8b 06                	mov    (%esi),%eax
80103262:	85 c0                	test   %eax,%eax
80103264:	74 08                	je     8010326e <pipealloc+0xce>
    fileclose(*f0);
80103266:	89 04 24             	mov    %eax,(%esp)
80103269:	e8 e2 db ff ff       	call   80100e50 <fileclose>
  if(*f1)
8010326e:	8b 03                	mov    (%ebx),%eax
  return -1;
80103270:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if(*f1)
80103275:	85 c0                	test   %eax,%eax
80103277:	74 d7                	je     80103250 <pipealloc+0xb0>
    fileclose(*f1);
80103279:	89 04 24             	mov    %eax,(%esp)
8010327c:	e8 cf db ff ff       	call   80100e50 <fileclose>
}
80103281:	83 c4 1c             	add    $0x1c,%esp
80103284:	89 d8                	mov    %ebx,%eax
80103286:	5b                   	pop    %ebx
80103287:	5e                   	pop    %esi
80103288:	5f                   	pop    %edi
80103289:	5d                   	pop    %ebp
8010328a:	c3                   	ret    
8010328b:	90                   	nop
8010328c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103290 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	56                   	push   %esi
80103294:	53                   	push   %ebx
80103295:	83 ec 10             	sub    $0x10,%esp
80103298:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010329b:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010329e:	89 1c 24             	mov    %ebx,(%esp)
801032a1:	e8 4a 10 00 00       	call   801042f0 <acquire>
  if(writable){
801032a6:	85 f6                	test   %esi,%esi
801032a8:	74 3e                	je     801032e8 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->nread);
801032aa:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801032b0:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801032b7:	00 00 00 
    wakeup(&p->nread);
801032ba:	89 04 24             	mov    %eax,(%esp)
801032bd:	e8 fe 0a 00 00       	call   80103dc0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801032c2:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801032c8:	85 d2                	test   %edx,%edx
801032ca:	75 0a                	jne    801032d6 <pipeclose+0x46>
801032cc:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801032d2:	85 c0                	test   %eax,%eax
801032d4:	74 32                	je     80103308 <pipeclose+0x78>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801032d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801032d9:	83 c4 10             	add    $0x10,%esp
801032dc:	5b                   	pop    %ebx
801032dd:	5e                   	pop    %esi
801032de:	5d                   	pop    %ebp
    release(&p->lock);
801032df:	e9 7c 10 00 00       	jmp    80104360 <release>
801032e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801032e8:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801032ee:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801032f5:	00 00 00 
    wakeup(&p->nwrite);
801032f8:	89 04 24             	mov    %eax,(%esp)
801032fb:	e8 c0 0a 00 00       	call   80103dc0 <wakeup>
80103300:	eb c0                	jmp    801032c2 <pipeclose+0x32>
80103302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&p->lock);
80103308:	89 1c 24             	mov    %ebx,(%esp)
8010330b:	e8 50 10 00 00       	call   80104360 <release>
    kfree((char*)p);
80103310:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103313:	83 c4 10             	add    $0x10,%esp
80103316:	5b                   	pop    %ebx
80103317:	5e                   	pop    %esi
80103318:	5d                   	pop    %ebp
    kfree((char*)p);
80103319:	e9 02 f0 ff ff       	jmp    80102320 <kfree>
8010331e:	66 90                	xchg   %ax,%ax

80103320 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	57                   	push   %edi
80103324:	56                   	push   %esi
80103325:	53                   	push   %ebx
80103326:	83 ec 1c             	sub    $0x1c,%esp
80103329:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010332c:	89 1c 24             	mov    %ebx,(%esp)
8010332f:	e8 bc 0f 00 00       	call   801042f0 <acquire>
  for(i = 0; i < n; i++){
80103334:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103337:	85 c9                	test   %ecx,%ecx
80103339:	0f 8e b2 00 00 00    	jle    801033f1 <pipewrite+0xd1>
8010333f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103342:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103348:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010334e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103354:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103357:	03 4d 10             	add    0x10(%ebp),%ecx
8010335a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010335d:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103363:	81 c1 00 02 00 00    	add    $0x200,%ecx
80103369:	39 c8                	cmp    %ecx,%eax
8010336b:	74 38                	je     801033a5 <pipewrite+0x85>
8010336d:	eb 55                	jmp    801033c4 <pipewrite+0xa4>
8010336f:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80103370:	e8 5b 03 00 00       	call   801036d0 <myproc>
80103375:	8b 40 24             	mov    0x24(%eax),%eax
80103378:	85 c0                	test   %eax,%eax
8010337a:	75 33                	jne    801033af <pipewrite+0x8f>
      wakeup(&p->nread);
8010337c:	89 3c 24             	mov    %edi,(%esp)
8010337f:	e8 3c 0a 00 00       	call   80103dc0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103384:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103388:	89 34 24             	mov    %esi,(%esp)
8010338b:	e8 a0 08 00 00       	call   80103c30 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103390:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103396:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010339c:	05 00 02 00 00       	add    $0x200,%eax
801033a1:	39 c2                	cmp    %eax,%edx
801033a3:	75 23                	jne    801033c8 <pipewrite+0xa8>
      if(p->readopen == 0 || myproc()->killed){
801033a5:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033ab:	85 d2                	test   %edx,%edx
801033ad:	75 c1                	jne    80103370 <pipewrite+0x50>
        release(&p->lock);
801033af:	89 1c 24             	mov    %ebx,(%esp)
801033b2:	e8 a9 0f 00 00       	call   80104360 <release>
        return -1;
801033b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801033bc:	83 c4 1c             	add    $0x1c,%esp
801033bf:	5b                   	pop    %ebx
801033c0:	5e                   	pop    %esi
801033c1:	5f                   	pop    %edi
801033c2:	5d                   	pop    %ebp
801033c3:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033c4:	89 c2                	mov    %eax,%edx
801033c6:	66 90                	xchg   %ax,%ax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801033c8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801033cb:	8d 42 01             	lea    0x1(%edx),%eax
801033ce:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801033d4:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801033da:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801033de:	0f b6 09             	movzbl (%ecx),%ecx
801033e1:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801033e5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801033e8:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801033eb:	0f 85 6c ff ff ff    	jne    8010335d <pipewrite+0x3d>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801033f1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033f7:	89 04 24             	mov    %eax,(%esp)
801033fa:	e8 c1 09 00 00       	call   80103dc0 <wakeup>
  release(&p->lock);
801033ff:	89 1c 24             	mov    %ebx,(%esp)
80103402:	e8 59 0f 00 00       	call   80104360 <release>
  return n;
80103407:	8b 45 10             	mov    0x10(%ebp),%eax
8010340a:	eb b0                	jmp    801033bc <pipewrite+0x9c>
8010340c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103410 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	57                   	push   %edi
80103414:	56                   	push   %esi
80103415:	53                   	push   %ebx
80103416:	83 ec 1c             	sub    $0x1c,%esp
80103419:	8b 75 08             	mov    0x8(%ebp),%esi
8010341c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010341f:	89 34 24             	mov    %esi,(%esp)
80103422:	e8 c9 0e 00 00       	call   801042f0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103427:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010342d:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103433:	75 5b                	jne    80103490 <piperead+0x80>
80103435:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010343b:	85 db                	test   %ebx,%ebx
8010343d:	74 51                	je     80103490 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010343f:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103445:	eb 25                	jmp    8010346c <piperead+0x5c>
80103447:	90                   	nop
80103448:	89 74 24 04          	mov    %esi,0x4(%esp)
8010344c:	89 1c 24             	mov    %ebx,(%esp)
8010344f:	e8 dc 07 00 00       	call   80103c30 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103454:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010345a:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103460:	75 2e                	jne    80103490 <piperead+0x80>
80103462:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103468:	85 d2                	test   %edx,%edx
8010346a:	74 24                	je     80103490 <piperead+0x80>
    if(myproc()->killed){
8010346c:	e8 5f 02 00 00       	call   801036d0 <myproc>
80103471:	8b 48 24             	mov    0x24(%eax),%ecx
80103474:	85 c9                	test   %ecx,%ecx
80103476:	74 d0                	je     80103448 <piperead+0x38>
      release(&p->lock);
80103478:	89 34 24             	mov    %esi,(%esp)
8010347b:	e8 e0 0e 00 00       	call   80104360 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103480:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80103483:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103488:	5b                   	pop    %ebx
80103489:	5e                   	pop    %esi
8010348a:	5f                   	pop    %edi
8010348b:	5d                   	pop    %ebp
8010348c:	c3                   	ret    
8010348d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103490:	8b 55 10             	mov    0x10(%ebp),%edx
    if(p->nread == p->nwrite)
80103493:	31 db                	xor    %ebx,%ebx
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103495:	85 d2                	test   %edx,%edx
80103497:	7f 2b                	jg     801034c4 <piperead+0xb4>
80103499:	eb 31                	jmp    801034cc <piperead+0xbc>
8010349b:	90                   	nop
8010349c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    addr[i] = p->data[p->nread++ % PIPESIZE];
801034a0:	8d 48 01             	lea    0x1(%eax),%ecx
801034a3:	25 ff 01 00 00       	and    $0x1ff,%eax
801034a8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801034ae:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801034b3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801034b6:	83 c3 01             	add    $0x1,%ebx
801034b9:	3b 5d 10             	cmp    0x10(%ebp),%ebx
801034bc:	74 0e                	je     801034cc <piperead+0xbc>
    if(p->nread == p->nwrite)
801034be:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801034c4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801034ca:	75 d4                	jne    801034a0 <piperead+0x90>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801034cc:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801034d2:	89 04 24             	mov    %eax,(%esp)
801034d5:	e8 e6 08 00 00       	call   80103dc0 <wakeup>
  release(&p->lock);
801034da:	89 34 24             	mov    %esi,(%esp)
801034dd:	e8 7e 0e 00 00       	call   80104360 <release>
}
801034e2:	83 c4 1c             	add    $0x1c,%esp
  return i;
801034e5:	89 d8                	mov    %ebx,%eax
}
801034e7:	5b                   	pop    %ebx
801034e8:	5e                   	pop    %esi
801034e9:	5f                   	pop    %edi
801034ea:	5d                   	pop    %ebp
801034eb:	c3                   	ret    
801034ec:	66 90                	xchg   %ax,%ax
801034ee:	66 90                	xchg   %ax,%ax

801034f0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801034f4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801034f9:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
801034fc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103503:	e8 e8 0d 00 00       	call   801042f0 <acquire>
80103508:	eb 15                	jmp    8010351f <allocproc+0x2f>
8010350a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103510:	83 eb 80             	sub    $0xffffff80,%ebx
80103513:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103519:	0f 84 81 00 00 00    	je     801035a0 <allocproc+0xb0>
    if(p->state == UNUSED)
8010351f:	8b 43 0c             	mov    0xc(%ebx),%eax
80103522:	85 c0                	test   %eax,%eax
80103524:	75 ea                	jne    80103510 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103526:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
8010352b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  p->state = EMBRYO;
80103532:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103539:	8d 50 01             	lea    0x1(%eax),%edx
8010353c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
80103542:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103545:	e8 16 0e 00 00       	call   80104360 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010354a:	e8 81 ef ff ff       	call   801024d0 <kalloc>
8010354f:	85 c0                	test   %eax,%eax
80103551:	89 43 08             	mov    %eax,0x8(%ebx)
80103554:	74 5e                	je     801035b4 <allocproc+0xc4>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103556:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010355c:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103561:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103564:	c7 40 14 15 55 10 80 	movl   $0x80105515,0x14(%eax)
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010356b:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80103572:	00 
80103573:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010357a:	00 
8010357b:	89 04 24             	mov    %eax,(%esp)
  p->context = (struct context*)sp;
8010357e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103581:	e8 2a 0e 00 00       	call   801043b0 <memset>
  p->context->eip = (uint)forkret;
80103586:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103589:	c7 40 10 c0 35 10 80 	movl   $0x801035c0,0x10(%eax)

  p->sched_count = 0;

  return p;
80103590:	89 d8                	mov    %ebx,%eax
  p->sched_count = 0;
80103592:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
}
80103599:	83 c4 14             	add    $0x14,%esp
8010359c:	5b                   	pop    %ebx
8010359d:	5d                   	pop    %ebp
8010359e:	c3                   	ret    
8010359f:	90                   	nop
  release(&ptable.lock);
801035a0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801035a7:	e8 b4 0d 00 00       	call   80104360 <release>
}
801035ac:	83 c4 14             	add    $0x14,%esp
  return 0;
801035af:	31 c0                	xor    %eax,%eax
}
801035b1:	5b                   	pop    %ebx
801035b2:	5d                   	pop    %ebp
801035b3:	c3                   	ret    
    p->state = UNUSED;
801035b4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801035bb:	eb dc                	jmp    80103599 <allocproc+0xa9>
801035bd:	8d 76 00             	lea    0x0(%esi),%esi

801035c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801035c0:	55                   	push   %ebp
801035c1:	89 e5                	mov    %esp,%ebp
801035c3:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801035c6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801035cd:	e8 8e 0d 00 00       	call   80104360 <release>

  if (first) {
801035d2:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801035d7:	85 c0                	test   %eax,%eax
801035d9:	75 05                	jne    801035e0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801035db:	c9                   	leave  
801035dc:	c3                   	ret    
801035dd:	8d 76 00             	lea    0x0(%esi),%esi
    iinit(ROOTDEV);
801035e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
801035e7:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801035ee:	00 00 00 
    iinit(ROOTDEV);
801035f1:	e8 aa de ff ff       	call   801014a0 <iinit>
    initlog(ROOTDEV);
801035f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801035fd:	e8 9e f4 ff ff       	call   80102aa0 <initlog>
}
80103602:	c9                   	leave  
80103603:	c3                   	ret    
80103604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010360a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103610 <pinit>:
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103616:	c7 44 24 04 75 72 10 	movl   $0x80107275,0x4(%esp)
8010361d:	80 
8010361e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103625:	e8 56 0b 00 00       	call   80104180 <initlock>
}
8010362a:	c9                   	leave  
8010362b:	c3                   	ret    
8010362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103630 <mycpu>:
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	56                   	push   %esi
80103634:	53                   	push   %ebx
80103635:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103638:	9c                   	pushf  
80103639:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010363a:	f6 c4 02             	test   $0x2,%ah
8010363d:	75 57                	jne    80103696 <mycpu+0x66>
  apicid = lapicid();
8010363f:	e8 4c f1 ff ff       	call   80102790 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103644:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
8010364a:	85 f6                	test   %esi,%esi
8010364c:	7e 3c                	jle    8010368a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010364e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103655:	39 c2                	cmp    %eax,%edx
80103657:	74 2d                	je     80103686 <mycpu+0x56>
80103659:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
8010365e:	31 d2                	xor    %edx,%edx
80103660:	83 c2 01             	add    $0x1,%edx
80103663:	39 f2                	cmp    %esi,%edx
80103665:	74 23                	je     8010368a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103667:	0f b6 19             	movzbl (%ecx),%ebx
8010366a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103670:	39 c3                	cmp    %eax,%ebx
80103672:	75 ec                	jne    80103660 <mycpu+0x30>
      return &cpus[i];
80103674:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
}
8010367a:	83 c4 10             	add    $0x10,%esp
8010367d:	5b                   	pop    %ebx
8010367e:	5e                   	pop    %esi
8010367f:	5d                   	pop    %ebp
      return &cpus[i];
80103680:	05 80 27 11 80       	add    $0x80112780,%eax
}
80103685:	c3                   	ret    
  for (i = 0; i < ncpu; ++i) {
80103686:	31 d2                	xor    %edx,%edx
80103688:	eb ea                	jmp    80103674 <mycpu+0x44>
  panic("unknown apicid\n");
8010368a:	c7 04 24 7c 72 10 80 	movl   $0x8010727c,(%esp)
80103691:	e8 ca cc ff ff       	call   80100360 <panic>
    panic("mycpu called with interrupts enabled\n");
80103696:	c7 04 24 90 73 10 80 	movl   $0x80107390,(%esp)
8010369d:	e8 be cc ff ff       	call   80100360 <panic>
801036a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036b0 <cpuid>:
cpuid() {
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
801036b3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801036b6:	e8 75 ff ff ff       	call   80103630 <mycpu>
}
801036bb:	c9                   	leave  
  return mycpu()-cpus;
801036bc:	2d 80 27 11 80       	sub    $0x80112780,%eax
801036c1:	c1 f8 04             	sar    $0x4,%eax
801036c4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801036ca:	c3                   	ret    
801036cb:	90                   	nop
801036cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036d0 <myproc>:
myproc(void) {
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	53                   	push   %ebx
801036d4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801036d7:	e8 24 0b 00 00       	call   80104200 <pushcli>
  c = mycpu();
801036dc:	e8 4f ff ff ff       	call   80103630 <mycpu>
  p = c->proc;
801036e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801036e7:	e8 54 0b 00 00       	call   80104240 <popcli>
}
801036ec:	83 c4 04             	add    $0x4,%esp
801036ef:	89 d8                	mov    %ebx,%eax
801036f1:	5b                   	pop    %ebx
801036f2:	5d                   	pop    %ebp
801036f3:	c3                   	ret    
801036f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103700 <userinit>:
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	53                   	push   %ebx
80103704:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
80103707:	e8 e4 fd ff ff       	call   801034f0 <allocproc>
8010370c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010370e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103713:	e8 68 33 00 00       	call   80106a80 <setupkvm>
80103718:	85 c0                	test   %eax,%eax
8010371a:	89 43 04             	mov    %eax,0x4(%ebx)
8010371d:	0f 84 d4 00 00 00    	je     801037f7 <userinit+0xf7>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103723:	89 04 24             	mov    %eax,(%esp)
80103726:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
8010372d:	00 
8010372e:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80103735:	80 
80103736:	e8 75 30 00 00       	call   801067b0 <inituvm>
  p->sz = PGSIZE;
8010373b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103741:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80103748:	00 
80103749:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103750:	00 
80103751:	8b 43 18             	mov    0x18(%ebx),%eax
80103754:	89 04 24             	mov    %eax,(%esp)
80103757:	e8 54 0c 00 00       	call   801043b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010375c:	8b 43 18             	mov    0x18(%ebx),%eax
8010375f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103764:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103769:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010376d:	8b 43 18             	mov    0x18(%ebx),%eax
80103770:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103774:	8b 43 18             	mov    0x18(%ebx),%eax
80103777:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010377b:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010377f:	8b 43 18             	mov    0x18(%ebx),%eax
80103782:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103786:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010378a:	8b 43 18             	mov    0x18(%ebx),%eax
8010378d:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103794:	8b 43 18             	mov    0x18(%ebx),%eax
80103797:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010379e:	8b 43 18             	mov    0x18(%ebx),%eax
801037a1:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801037a8:	8d 43 6c             	lea    0x6c(%ebx),%eax
801037ab:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801037b2:	00 
801037b3:	c7 44 24 04 a5 72 10 	movl   $0x801072a5,0x4(%esp)
801037ba:	80 
801037bb:	89 04 24             	mov    %eax,(%esp)
801037be:	e8 cd 0d 00 00       	call   80104590 <safestrcpy>
  p->cwd = namei("/");
801037c3:	c7 04 24 ae 72 10 80 	movl   $0x801072ae,(%esp)
801037ca:	e8 61 e7 ff ff       	call   80101f30 <namei>
801037cf:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801037d2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801037d9:	e8 12 0b 00 00       	call   801042f0 <acquire>
  p->state = RUNNABLE;
801037de:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801037e5:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801037ec:	e8 6f 0b 00 00       	call   80104360 <release>
}
801037f1:	83 c4 14             	add    $0x14,%esp
801037f4:	5b                   	pop    %ebx
801037f5:	5d                   	pop    %ebp
801037f6:	c3                   	ret    
    panic("userinit: out of memory?");
801037f7:	c7 04 24 8c 72 10 80 	movl   $0x8010728c,(%esp)
801037fe:	e8 5d cb ff ff       	call   80100360 <panic>
80103803:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103810 <growproc>:
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	56                   	push   %esi
80103814:	53                   	push   %ebx
80103815:	83 ec 10             	sub    $0x10,%esp
80103818:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *curproc = myproc();
8010381b:	e8 b0 fe ff ff       	call   801036d0 <myproc>
  if(n > 0){
80103820:	83 fe 00             	cmp    $0x0,%esi
  struct proc *curproc = myproc();
80103823:	89 c3                	mov    %eax,%ebx
  sz = curproc->sz;
80103825:	8b 00                	mov    (%eax),%eax
  if(n > 0){
80103827:	7e 2f                	jle    80103858 <growproc+0x48>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103829:	01 c6                	add    %eax,%esi
8010382b:	89 74 24 08          	mov    %esi,0x8(%esp)
8010382f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103833:	8b 43 04             	mov    0x4(%ebx),%eax
80103836:	89 04 24             	mov    %eax,(%esp)
80103839:	e8 b2 30 00 00       	call   801068f0 <allocuvm>
8010383e:	85 c0                	test   %eax,%eax
80103840:	74 36                	je     80103878 <growproc+0x68>
  curproc->sz = sz;
80103842:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103844:	89 1c 24             	mov    %ebx,(%esp)
80103847:	e8 54 2e 00 00       	call   801066a0 <switchuvm>
  return 0;
8010384c:	31 c0                	xor    %eax,%eax
}
8010384e:	83 c4 10             	add    $0x10,%esp
80103851:	5b                   	pop    %ebx
80103852:	5e                   	pop    %esi
80103853:	5d                   	pop    %ebp
80103854:	c3                   	ret    
80103855:	8d 76 00             	lea    0x0(%esi),%esi
  } else if(n < 0){
80103858:	74 e8                	je     80103842 <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010385a:	01 c6                	add    %eax,%esi
8010385c:	89 74 24 08          	mov    %esi,0x8(%esp)
80103860:	89 44 24 04          	mov    %eax,0x4(%esp)
80103864:	8b 43 04             	mov    0x4(%ebx),%eax
80103867:	89 04 24             	mov    %eax,(%esp)
8010386a:	e8 71 31 00 00       	call   801069e0 <deallocuvm>
8010386f:	85 c0                	test   %eax,%eax
80103871:	75 cf                	jne    80103842 <growproc+0x32>
80103873:	90                   	nop
80103874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80103878:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010387d:	eb cf                	jmp    8010384e <growproc+0x3e>
8010387f:	90                   	nop

80103880 <fork>:
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	57                   	push   %edi
80103884:	56                   	push   %esi
80103885:	53                   	push   %ebx
80103886:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *curproc = myproc();
80103889:	e8 42 fe ff ff       	call   801036d0 <myproc>
8010388e:	89 c3                	mov    %eax,%ebx
  if((np = allocproc()) == 0){
80103890:	e8 5b fc ff ff       	call   801034f0 <allocproc>
80103895:	85 c0                	test   %eax,%eax
80103897:	89 c7                	mov    %eax,%edi
80103899:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010389c:	0f 84 bc 00 00 00    	je     8010395e <fork+0xde>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801038a2:	8b 03                	mov    (%ebx),%eax
801038a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801038a8:	8b 43 04             	mov    0x4(%ebx),%eax
801038ab:	89 04 24             	mov    %eax,(%esp)
801038ae:	e8 ad 32 00 00       	call   80106b60 <copyuvm>
801038b3:	85 c0                	test   %eax,%eax
801038b5:	89 47 04             	mov    %eax,0x4(%edi)
801038b8:	0f 84 a7 00 00 00    	je     80103965 <fork+0xe5>
  np->sz = curproc->sz;
801038be:	8b 03                	mov    (%ebx),%eax
801038c0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801038c3:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
801038c5:	8b 79 18             	mov    0x18(%ecx),%edi
801038c8:	89 c8                	mov    %ecx,%eax
  np->parent = curproc;
801038ca:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
801038cd:	8b 73 18             	mov    0x18(%ebx),%esi
801038d0:	b9 13 00 00 00       	mov    $0x13,%ecx
801038d5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801038d7:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801038d9:	8b 40 18             	mov    0x18(%eax),%eax
801038dc:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801038e3:	90                   	nop
801038e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
801038e8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801038ec:	85 c0                	test   %eax,%eax
801038ee:	74 0f                	je     801038ff <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
801038f0:	89 04 24             	mov    %eax,(%esp)
801038f3:	e8 08 d5 ff ff       	call   80100e00 <filedup>
801038f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801038fb:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801038ff:	83 c6 01             	add    $0x1,%esi
80103902:	83 fe 10             	cmp    $0x10,%esi
80103905:	75 e1                	jne    801038e8 <fork+0x68>
  np->cwd = idup(curproc->cwd);
80103907:	8b 43 68             	mov    0x68(%ebx),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010390a:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010390d:	89 04 24             	mov    %eax,(%esp)
80103910:	e8 9b dd ff ff       	call   801016b0 <idup>
80103915:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103918:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010391b:	8d 47 6c             	lea    0x6c(%edi),%eax
8010391e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103922:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103929:	00 
8010392a:	89 04 24             	mov    %eax,(%esp)
8010392d:	e8 5e 0c 00 00       	call   80104590 <safestrcpy>
  pid = np->pid;
80103932:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103935:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010393c:	e8 af 09 00 00       	call   801042f0 <acquire>
  np->state = RUNNABLE;
80103941:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103948:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010394f:	e8 0c 0a 00 00       	call   80104360 <release>
  return pid;
80103954:	89 d8                	mov    %ebx,%eax
}
80103956:	83 c4 1c             	add    $0x1c,%esp
80103959:	5b                   	pop    %ebx
8010395a:	5e                   	pop    %esi
8010395b:	5f                   	pop    %edi
8010395c:	5d                   	pop    %ebp
8010395d:	c3                   	ret    
    return -1;
8010395e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103963:	eb f1                	jmp    80103956 <fork+0xd6>
    kfree(np->kstack);
80103965:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103968:	8b 47 08             	mov    0x8(%edi),%eax
8010396b:	89 04 24             	mov    %eax,(%esp)
8010396e:	e8 ad e9 ff ff       	call   80102320 <kfree>
    return -1;
80103973:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    np->kstack = 0;
80103978:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
8010397f:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103986:	eb ce                	jmp    80103956 <fork+0xd6>
80103988:	90                   	nop
80103989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103990 <scheduler>:
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	57                   	push   %edi
80103994:	56                   	push   %esi
80103995:	53                   	push   %ebx
80103996:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103999:	e8 92 fc ff ff       	call   80103630 <mycpu>
8010399e:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801039a0:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801039a7:	00 00 00 
801039aa:	8d 78 04             	lea    0x4(%eax),%edi
801039ad:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
801039b0:	fb                   	sti    
    acquire(&ptable.lock);
801039b1:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039b8:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
801039bd:	e8 2e 09 00 00       	call   801042f0 <acquire>
801039c2:	eb 0f                	jmp    801039d3 <scheduler+0x43>
801039c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039c8:	83 eb 80             	sub    $0xffffff80,%ebx
801039cb:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
801039d1:	74 4d                	je     80103a20 <scheduler+0x90>
      if(p->state != RUNNABLE)
801039d3:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801039d7:	75 ef                	jne    801039c8 <scheduler+0x38>
      c->proc = p;
801039d9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801039df:	89 1c 24             	mov    %ebx,(%esp)
801039e2:	e8 b9 2c 00 00       	call   801066a0 <switchuvm>
      swtch(&(c->scheduler), p->context);
801039e7:	8b 43 1c             	mov    0x1c(%ebx),%eax
      p->state = RUNNING;
801039ea:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      p->sched_count++;
801039f1:	83 43 7c 01          	addl   $0x1,0x7c(%ebx)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039f5:	83 eb 80             	sub    $0xffffff80,%ebx
      swtch(&(c->scheduler), p->context);
801039f8:	89 44 24 04          	mov    %eax,0x4(%esp)
801039fc:	89 3c 24             	mov    %edi,(%esp)
801039ff:	e8 e7 0b 00 00       	call   801045eb <swtch>
      switchkvm();
80103a04:	e8 77 2c 00 00       	call   80106680 <switchkvm>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a09:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
      c->proc = 0;
80103a0f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103a16:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a19:	75 b8                	jne    801039d3 <scheduler+0x43>
80103a1b:	90                   	nop
80103a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80103a20:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a27:	e8 34 09 00 00       	call   80104360 <release>
  }
80103a2c:	eb 82                	jmp    801039b0 <scheduler+0x20>
80103a2e:	66 90                	xchg   %ax,%ax

80103a30 <sched>:
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	56                   	push   %esi
80103a34:	53                   	push   %ebx
80103a35:	83 ec 10             	sub    $0x10,%esp
  struct proc *p = myproc();
80103a38:	e8 93 fc ff ff       	call   801036d0 <myproc>
  if(!holding(&ptable.lock))
80103a3d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  struct proc *p = myproc();
80103a44:	89 c3                	mov    %eax,%ebx
  if(!holding(&ptable.lock))
80103a46:	e8 65 08 00 00       	call   801042b0 <holding>
80103a4b:	85 c0                	test   %eax,%eax
80103a4d:	74 4f                	je     80103a9e <sched+0x6e>
  if(mycpu()->ncli != 1)
80103a4f:	e8 dc fb ff ff       	call   80103630 <mycpu>
80103a54:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103a5b:	75 65                	jne    80103ac2 <sched+0x92>
  if(p->state == RUNNING)
80103a5d:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103a61:	74 53                	je     80103ab6 <sched+0x86>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a63:	9c                   	pushf  
80103a64:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a65:	f6 c4 02             	test   $0x2,%ah
80103a68:	75 40                	jne    80103aaa <sched+0x7a>
  intena = mycpu()->intena;
80103a6a:	e8 c1 fb ff ff       	call   80103630 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103a6f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103a72:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103a78:	e8 b3 fb ff ff       	call   80103630 <mycpu>
80103a7d:	8b 40 04             	mov    0x4(%eax),%eax
80103a80:	89 1c 24             	mov    %ebx,(%esp)
80103a83:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a87:	e8 5f 0b 00 00       	call   801045eb <swtch>
  mycpu()->intena = intena;
80103a8c:	e8 9f fb ff ff       	call   80103630 <mycpu>
80103a91:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103a97:	83 c4 10             	add    $0x10,%esp
80103a9a:	5b                   	pop    %ebx
80103a9b:	5e                   	pop    %esi
80103a9c:	5d                   	pop    %ebp
80103a9d:	c3                   	ret    
    panic("sched ptable.lock");
80103a9e:	c7 04 24 b0 72 10 80 	movl   $0x801072b0,(%esp)
80103aa5:	e8 b6 c8 ff ff       	call   80100360 <panic>
    panic("sched interruptible");
80103aaa:	c7 04 24 dc 72 10 80 	movl   $0x801072dc,(%esp)
80103ab1:	e8 aa c8 ff ff       	call   80100360 <panic>
    panic("sched running");
80103ab6:	c7 04 24 ce 72 10 80 	movl   $0x801072ce,(%esp)
80103abd:	e8 9e c8 ff ff       	call   80100360 <panic>
    panic("sched locks");
80103ac2:	c7 04 24 c2 72 10 80 	movl   $0x801072c2,(%esp)
80103ac9:	e8 92 c8 ff ff       	call   80100360 <panic>
80103ace:	66 90                	xchg   %ax,%ax

80103ad0 <exit>:
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	56                   	push   %esi
  if(curproc == initproc)
80103ad4:	31 f6                	xor    %esi,%esi
{
80103ad6:	53                   	push   %ebx
80103ad7:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103ada:	e8 f1 fb ff ff       	call   801036d0 <myproc>
  if(curproc == initproc)
80103adf:	3b 05 b8 a5 10 80    	cmp    0x8010a5b8,%eax
  struct proc *curproc = myproc();
80103ae5:	89 c3                	mov    %eax,%ebx
  if(curproc == initproc)
80103ae7:	0f 84 ea 00 00 00    	je     80103bd7 <exit+0x107>
80103aed:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103af0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103af4:	85 c0                	test   %eax,%eax
80103af6:	74 10                	je     80103b08 <exit+0x38>
      fileclose(curproc->ofile[fd]);
80103af8:	89 04 24             	mov    %eax,(%esp)
80103afb:	e8 50 d3 ff ff       	call   80100e50 <fileclose>
      curproc->ofile[fd] = 0;
80103b00:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103b07:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103b08:	83 c6 01             	add    $0x1,%esi
80103b0b:	83 fe 10             	cmp    $0x10,%esi
80103b0e:	75 e0                	jne    80103af0 <exit+0x20>
  begin_op();
80103b10:	e8 2b f0 ff ff       	call   80102b40 <begin_op>
  iput(curproc->cwd);
80103b15:	8b 43 68             	mov    0x68(%ebx),%eax
80103b18:	89 04 24             	mov    %eax,(%esp)
80103b1b:	e8 e0 dc ff ff       	call   80101800 <iput>
  end_op();
80103b20:	e8 8b f0 ff ff       	call   80102bb0 <end_op>
  curproc->cwd = 0;
80103b25:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103b2c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b33:	e8 b8 07 00 00       	call   801042f0 <acquire>
  wakeup1(curproc->parent);
80103b38:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b3b:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103b40:	eb 11                	jmp    80103b53 <exit+0x83>
80103b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b48:	83 ea 80             	sub    $0xffffff80,%edx
80103b4b:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80103b51:	74 1d                	je     80103b70 <exit+0xa0>
    if(p->state == SLEEPING && p->chan == chan)
80103b53:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103b57:	75 ef                	jne    80103b48 <exit+0x78>
80103b59:	3b 42 20             	cmp    0x20(%edx),%eax
80103b5c:	75 ea                	jne    80103b48 <exit+0x78>
      p->state = RUNNABLE;
80103b5e:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b65:	83 ea 80             	sub    $0xffffff80,%edx
80103b68:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80103b6e:	75 e3                	jne    80103b53 <exit+0x83>
      p->parent = initproc;
80103b70:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80103b75:	b9 54 2d 11 80       	mov    $0x80112d54,%ecx
80103b7a:	eb 0f                	jmp    80103b8b <exit+0xbb>
80103b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b80:	83 e9 80             	sub    $0xffffff80,%ecx
80103b83:	81 f9 54 4d 11 80    	cmp    $0x80114d54,%ecx
80103b89:	74 34                	je     80103bbf <exit+0xef>
    if(p->parent == curproc){
80103b8b:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103b8e:	75 f0                	jne    80103b80 <exit+0xb0>
      if(p->state == ZOMBIE)
80103b90:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
      p->parent = initproc;
80103b94:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103b97:	75 e7                	jne    80103b80 <exit+0xb0>
80103b99:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103b9e:	eb 0b                	jmp    80103bab <exit+0xdb>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ba0:	83 ea 80             	sub    $0xffffff80,%edx
80103ba3:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80103ba9:	74 d5                	je     80103b80 <exit+0xb0>
    if(p->state == SLEEPING && p->chan == chan)
80103bab:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103baf:	75 ef                	jne    80103ba0 <exit+0xd0>
80103bb1:	3b 42 20             	cmp    0x20(%edx),%eax
80103bb4:	75 ea                	jne    80103ba0 <exit+0xd0>
      p->state = RUNNABLE;
80103bb6:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103bbd:	eb e1                	jmp    80103ba0 <exit+0xd0>
  curproc->state = ZOMBIE;
80103bbf:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103bc6:	e8 65 fe ff ff       	call   80103a30 <sched>
  panic("zombie exit");
80103bcb:	c7 04 24 fd 72 10 80 	movl   $0x801072fd,(%esp)
80103bd2:	e8 89 c7 ff ff       	call   80100360 <panic>
    panic("init exiting");
80103bd7:	c7 04 24 f0 72 10 80 	movl   $0x801072f0,(%esp)
80103bde:	e8 7d c7 ff ff       	call   80100360 <panic>
80103be3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bf0 <yield>:
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103bf6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103bfd:	e8 ee 06 00 00       	call   801042f0 <acquire>
  myproc()->state = RUNNABLE;
80103c02:	e8 c9 fa ff ff       	call   801036d0 <myproc>
80103c07:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103c0e:	e8 1d fe ff ff       	call   80103a30 <sched>
  release(&ptable.lock);
80103c13:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c1a:	e8 41 07 00 00       	call   80104360 <release>
}
80103c1f:	c9                   	leave  
80103c20:	c3                   	ret    
80103c21:	eb 0d                	jmp    80103c30 <sleep>
80103c23:	90                   	nop
80103c24:	90                   	nop
80103c25:	90                   	nop
80103c26:	90                   	nop
80103c27:	90                   	nop
80103c28:	90                   	nop
80103c29:	90                   	nop
80103c2a:	90                   	nop
80103c2b:	90                   	nop
80103c2c:	90                   	nop
80103c2d:	90                   	nop
80103c2e:	90                   	nop
80103c2f:	90                   	nop

80103c30 <sleep>:
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	57                   	push   %edi
80103c34:	56                   	push   %esi
80103c35:	53                   	push   %ebx
80103c36:	83 ec 1c             	sub    $0x1c,%esp
80103c39:	8b 7d 08             	mov    0x8(%ebp),%edi
80103c3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
80103c3f:	e8 8c fa ff ff       	call   801036d0 <myproc>
  if(p == 0)
80103c44:	85 c0                	test   %eax,%eax
  struct proc *p = myproc();
80103c46:	89 c3                	mov    %eax,%ebx
  if(p == 0)
80103c48:	0f 84 7c 00 00 00    	je     80103cca <sleep+0x9a>
  if(lk == 0)
80103c4e:	85 f6                	test   %esi,%esi
80103c50:	74 6c                	je     80103cbe <sleep+0x8e>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103c52:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103c58:	74 46                	je     80103ca0 <sleep+0x70>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103c5a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c61:	e8 8a 06 00 00       	call   801042f0 <acquire>
    release(lk);
80103c66:	89 34 24             	mov    %esi,(%esp)
80103c69:	e8 f2 06 00 00       	call   80104360 <release>
  p->chan = chan;
80103c6e:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103c71:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103c78:	e8 b3 fd ff ff       	call   80103a30 <sched>
  p->chan = 0;
80103c7d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103c84:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c8b:	e8 d0 06 00 00       	call   80104360 <release>
    acquire(lk);
80103c90:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103c93:	83 c4 1c             	add    $0x1c,%esp
80103c96:	5b                   	pop    %ebx
80103c97:	5e                   	pop    %esi
80103c98:	5f                   	pop    %edi
80103c99:	5d                   	pop    %ebp
    acquire(lk);
80103c9a:	e9 51 06 00 00       	jmp    801042f0 <acquire>
80103c9f:	90                   	nop
  p->chan = chan;
80103ca0:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80103ca3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103caa:	e8 81 fd ff ff       	call   80103a30 <sched>
  p->chan = 0;
80103caf:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103cb6:	83 c4 1c             	add    $0x1c,%esp
80103cb9:	5b                   	pop    %ebx
80103cba:	5e                   	pop    %esi
80103cbb:	5f                   	pop    %edi
80103cbc:	5d                   	pop    %ebp
80103cbd:	c3                   	ret    
    panic("sleep without lk");
80103cbe:	c7 04 24 0f 73 10 80 	movl   $0x8010730f,(%esp)
80103cc5:	e8 96 c6 ff ff       	call   80100360 <panic>
    panic("sleep");
80103cca:	c7 04 24 09 73 10 80 	movl   $0x80107309,(%esp)
80103cd1:	e8 8a c6 ff ff       	call   80100360 <panic>
80103cd6:	8d 76 00             	lea    0x0(%esi),%esi
80103cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ce0 <wait>:
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	56                   	push   %esi
80103ce4:	53                   	push   %ebx
80103ce5:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103ce8:	e8 e3 f9 ff ff       	call   801036d0 <myproc>
  acquire(&ptable.lock);
80103ced:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  struct proc *curproc = myproc();
80103cf4:	89 c6                	mov    %eax,%esi
  acquire(&ptable.lock);
80103cf6:	e8 f5 05 00 00       	call   801042f0 <acquire>
    havekids = 0;
80103cfb:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cfd:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103d02:	eb 0f                	jmp    80103d13 <wait+0x33>
80103d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d08:	83 eb 80             	sub    $0xffffff80,%ebx
80103d0b:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103d11:	74 1d                	je     80103d30 <wait+0x50>
      if(p->parent != curproc)
80103d13:	39 73 14             	cmp    %esi,0x14(%ebx)
80103d16:	75 f0                	jne    80103d08 <wait+0x28>
      if(p->state == ZOMBIE){
80103d18:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103d1c:	74 2f                	je     80103d4d <wait+0x6d>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d1e:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80103d21:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d26:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103d2c:	75 e5                	jne    80103d13 <wait+0x33>
80103d2e:	66 90                	xchg   %ax,%ax
    if(!havekids || curproc->killed){
80103d30:	85 c0                	test   %eax,%eax
80103d32:	74 6e                	je     80103da2 <wait+0xc2>
80103d34:	8b 46 24             	mov    0x24(%esi),%eax
80103d37:	85 c0                	test   %eax,%eax
80103d39:	75 67                	jne    80103da2 <wait+0xc2>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103d3b:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80103d42:	80 
80103d43:	89 34 24             	mov    %esi,(%esp)
80103d46:	e8 e5 fe ff ff       	call   80103c30 <sleep>
  }
80103d4b:	eb ae                	jmp    80103cfb <wait+0x1b>
        kfree(p->kstack);
80103d4d:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80103d50:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103d53:	89 04 24             	mov    %eax,(%esp)
80103d56:	e8 c5 e5 ff ff       	call   80102320 <kfree>
        freevm(p->pgdir);
80103d5b:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80103d5e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103d65:	89 04 24             	mov    %eax,(%esp)
80103d68:	e8 93 2c 00 00       	call   80106a00 <freevm>
        release(&ptable.lock);
80103d6d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80103d74:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103d7b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103d82:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103d86:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103d8d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103d94:	e8 c7 05 00 00       	call   80104360 <release>
}
80103d99:	83 c4 10             	add    $0x10,%esp
        return pid;
80103d9c:	89 f0                	mov    %esi,%eax
}
80103d9e:	5b                   	pop    %ebx
80103d9f:	5e                   	pop    %esi
80103da0:	5d                   	pop    %ebp
80103da1:	c3                   	ret    
      release(&ptable.lock);
80103da2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103da9:	e8 b2 05 00 00       	call   80104360 <release>
}
80103dae:	83 c4 10             	add    $0x10,%esp
      return -1;
80103db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103db6:	5b                   	pop    %ebx
80103db7:	5e                   	pop    %esi
80103db8:	5d                   	pop    %ebp
80103db9:	c3                   	ret    
80103dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103dc0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	53                   	push   %ebx
80103dc4:	83 ec 14             	sub    $0x14,%esp
80103dc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103dca:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103dd1:	e8 1a 05 00 00       	call   801042f0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dd6:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103ddb:	eb 0d                	jmp    80103dea <wakeup+0x2a>
80103ddd:	8d 76 00             	lea    0x0(%esi),%esi
80103de0:	83 e8 80             	sub    $0xffffff80,%eax
80103de3:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103de8:	74 1e                	je     80103e08 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103dea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dee:	75 f0                	jne    80103de0 <wakeup+0x20>
80103df0:	3b 58 20             	cmp    0x20(%eax),%ebx
80103df3:	75 eb                	jne    80103de0 <wakeup+0x20>
      p->state = RUNNABLE;
80103df5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dfc:	83 e8 80             	sub    $0xffffff80,%eax
80103dff:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103e04:	75 e4                	jne    80103dea <wakeup+0x2a>
80103e06:	66 90                	xchg   %ax,%ax
  wakeup1(chan);
  release(&ptable.lock);
80103e08:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80103e0f:	83 c4 14             	add    $0x14,%esp
80103e12:	5b                   	pop    %ebx
80103e13:	5d                   	pop    %ebp
  release(&ptable.lock);
80103e14:	e9 47 05 00 00       	jmp    80104360 <release>
80103e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e20 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	53                   	push   %ebx
80103e24:	83 ec 14             	sub    $0x14,%esp
80103e27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103e2a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e31:	e8 ba 04 00 00       	call   801042f0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e36:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103e3b:	eb 0d                	jmp    80103e4a <kill+0x2a>
80103e3d:	8d 76 00             	lea    0x0(%esi),%esi
80103e40:	83 e8 80             	sub    $0xffffff80,%eax
80103e43:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103e48:	74 36                	je     80103e80 <kill+0x60>
    if(p->pid == pid){
80103e4a:	39 58 10             	cmp    %ebx,0x10(%eax)
80103e4d:	75 f1                	jne    80103e40 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103e4f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80103e53:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80103e5a:	74 14                	je     80103e70 <kill+0x50>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103e5c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e63:	e8 f8 04 00 00       	call   80104360 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103e68:	83 c4 14             	add    $0x14,%esp
      return 0;
80103e6b:	31 c0                	xor    %eax,%eax
}
80103e6d:	5b                   	pop    %ebx
80103e6e:	5d                   	pop    %ebp
80103e6f:	c3                   	ret    
        p->state = RUNNABLE;
80103e70:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e77:	eb e3                	jmp    80103e5c <kill+0x3c>
80103e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103e80:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e87:	e8 d4 04 00 00       	call   80104360 <release>
}
80103e8c:	83 c4 14             	add    $0x14,%esp
  return -1;
80103e8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103e94:	5b                   	pop    %ebx
80103e95:	5d                   	pop    %ebp
80103e96:	c3                   	ret    
80103e97:	89 f6                	mov    %esi,%esi
80103e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ea0 <sys_cps>:
};

#ifdef CPS
int
sys_cps(void)
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	53                   	push   %ebx
80103ea4:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
80103ea9:	83 ec 24             	sub    $0x24,%esp
    int i;
    const char *state = NULL;

    acquire(&ptable.lock);
80103eac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103eb3:	e8 38 04 00 00       	call   801042f0 <acquire>
    cprintf(
80103eb8:	c7 04 24 27 73 10 80 	movl   $0x80107327,(%esp)
80103ebf:	e8 8c c7 ff ff       	call   80100650 <cprintf>
        "pid\tppid\tname\tstate\tsize"
        );
    cprintf("\tsched");
80103ec4:	c7 04 24 40 73 10 80 	movl   $0x80107340,(%esp)
80103ecb:	e8 80 c7 ff ff       	call   80100650 <cprintf>
    cprintf("\n");
80103ed0:	c7 04 24 df 76 10 80 	movl   $0x801076df,(%esp)
80103ed7:	e8 74 c7 ff ff       	call   80100650 <cprintf>
80103edc:	eb 52                	jmp    80103f30 <sys_cps+0x90>
80103ede:	66 90                	xchg   %ax,%ax
                state = states[ptable.proc[i].state];
            }
            else {
                state = "uknown";
            }
            cprintf("%d\t%d\t%s\t%s\t%u"
80103ee0:	8b 40 10             	mov    0x10(%eax),%eax
80103ee3:	89 44 24 08          	mov    %eax,0x8(%esp)
80103ee7:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103eea:	89 4c 24 14          	mov    %ecx,0x14(%esp)
80103eee:	89 54 24 10          	mov    %edx,0x10(%esp)
80103ef2:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80103ef6:	89 44 24 04          	mov    %eax,0x4(%esp)
80103efa:	c7 04 24 47 73 10 80 	movl   $0x80107347,(%esp)
80103f01:	e8 4a c7 ff ff       	call   80100650 <cprintf>
                    , ptable.proc[i].pid
                    , ptable.proc[i].parent ? ptable.proc[i].parent->pid : 1
                    , ptable.proc[i].name, state
                    , ptable.proc[i].sz
                );
            cprintf("\t%u", ptable.proc[i].sched_count);
80103f06:	8b 43 10             	mov    0x10(%ebx),%eax
80103f09:	c7 04 24 52 73 10 80 	movl   $0x80107352,(%esp)
80103f10:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f14:	e8 37 c7 ff ff       	call   80100650 <cprintf>
            cprintf("\n");
80103f19:	c7 04 24 df 76 10 80 	movl   $0x801076df,(%esp)
80103f20:	e8 2b c7 ff ff       	call   80100650 <cprintf>
80103f25:	83 eb 80             	sub    $0xffffff80,%ebx
    for (i = 0; i < NPROC; i++) {
80103f28:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
80103f2e:	74 38                	je     80103f68 <sys_cps+0xc8>
        if (ptable.proc[i].state != UNUSED) {
80103f30:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103f33:	85 c0                	test   %eax,%eax
80103f35:	74 ee                	je     80103f25 <sys_cps+0x85>
            if (ptable.proc[i].state >= 0 && ptable.proc[i].state < NELEM(states)
80103f37:	83 f8 05             	cmp    $0x5,%eax
                state = "uknown";
80103f3a:	ba 20 73 10 80       	mov    $0x80107320,%edx
            if (ptable.proc[i].state >= 0 && ptable.proc[i].state < NELEM(states)
80103f3f:	77 11                	ja     80103f52 <sys_cps+0xb2>
                && states[ptable.proc[i].state]) {
80103f41:	8b 14 85 b8 73 10 80 	mov    -0x7fef8c48(,%eax,4),%edx
                state = "uknown";
80103f48:	b8 20 73 10 80       	mov    $0x80107320,%eax
80103f4d:	85 d2                	test   %edx,%edx
80103f4f:	0f 44 d0             	cmove  %eax,%edx
                    , ptable.proc[i].parent ? ptable.proc[i].parent->pid : 1
80103f52:	8b 43 a8             	mov    -0x58(%ebx),%eax
            cprintf("%d\t%d\t%s\t%s\t%u"
80103f55:	8b 4b 94             	mov    -0x6c(%ebx),%ecx
80103f58:	85 c0                	test   %eax,%eax
80103f5a:	75 84                	jne    80103ee0 <sys_cps+0x40>
80103f5c:	b8 01 00 00 00       	mov    $0x1,%eax
80103f61:	eb 80                	jmp    80103ee3 <sys_cps+0x43>
80103f63:	90                   	nop
80103f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
        else {
            // UNUSED process table entry is ignored
        }
    }
    release(&ptable.lock);
80103f68:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f6f:	e8 ec 03 00 00       	call   80104360 <release>

    return 0;
}
80103f74:	83 c4 24             	add    $0x24,%esp
80103f77:	31 c0                	xor    %eax,%eax
80103f79:	5b                   	pop    %ebx
80103f7a:	5d                   	pop    %ebp
80103f7b:	c3                   	ret    
80103f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f80 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	57                   	push   %edi
80103f84:	56                   	push   %esi
80103f85:	53                   	push   %ebx
80103f86:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
80103f8b:	83 ec 4c             	sub    $0x4c,%esp
80103f8e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103f91:	eb 20                	jmp    80103fb3 <procdump+0x33>
80103f93:	90                   	nop
80103f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103f98:	c7 04 24 df 76 10 80 	movl   $0x801076df,(%esp)
80103f9f:	e8 ac c6 ff ff       	call   80100650 <cprintf>
80103fa4:	83 eb 80             	sub    $0xffffff80,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fa7:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
80103fad:	0f 84 8d 00 00 00    	je     80104040 <procdump+0xc0>
    if(p->state == UNUSED)
80103fb3:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103fb6:	85 c0                	test   %eax,%eax
80103fb8:	74 ea                	je     80103fa4 <procdump+0x24>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103fba:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80103fbd:	ba 56 73 10 80       	mov    $0x80107356,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103fc2:	77 11                	ja     80103fd5 <procdump+0x55>
80103fc4:	8b 14 85 b8 73 10 80 	mov    -0x7fef8c48(,%eax,4),%edx
      state = "???";
80103fcb:	b8 56 73 10 80       	mov    $0x80107356,%eax
80103fd0:	85 d2                	test   %edx,%edx
80103fd2:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80103fd5:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103fd8:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80103fdc:	89 54 24 08          	mov    %edx,0x8(%esp)
80103fe0:	c7 04 24 5a 73 10 80 	movl   $0x8010735a,(%esp)
80103fe7:	89 44 24 04          	mov    %eax,0x4(%esp)
80103feb:	e8 60 c6 ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
80103ff0:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103ff4:	75 a2                	jne    80103f98 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103ff6:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103ff9:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ffd:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104000:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104003:	8b 40 0c             	mov    0xc(%eax),%eax
80104006:	83 c0 08             	add    $0x8,%eax
80104009:	89 04 24             	mov    %eax,(%esp)
8010400c:	e8 8f 01 00 00       	call   801041a0 <getcallerpcs>
80104011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104018:	8b 17                	mov    (%edi),%edx
8010401a:	85 d2                	test   %edx,%edx
8010401c:	0f 84 76 ff ff ff    	je     80103f98 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104022:	89 54 24 04          	mov    %edx,0x4(%esp)
80104026:	83 c7 04             	add    $0x4,%edi
80104029:	c7 04 24 61 6d 10 80 	movl   $0x80106d61,(%esp)
80104030:	e8 1b c6 ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104035:	39 f7                	cmp    %esi,%edi
80104037:	75 df                	jne    80104018 <procdump+0x98>
80104039:	e9 5a ff ff ff       	jmp    80103f98 <procdump+0x18>
8010403e:	66 90                	xchg   %ax,%ax
  }
}
80104040:	83 c4 4c             	add    $0x4c,%esp
80104043:	5b                   	pop    %ebx
80104044:	5e                   	pop    %esi
80104045:	5f                   	pop    %edi
80104046:	5d                   	pop    %ebp
80104047:	c3                   	ret    
80104048:	66 90                	xchg   %ax,%ax
8010404a:	66 90                	xchg   %ax,%ax
8010404c:	66 90                	xchg   %ax,%ax
8010404e:	66 90                	xchg   %ax,%ax

80104050 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 14             	sub    $0x14,%esp
80104057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010405a:	c7 44 24 04 d0 73 10 	movl   $0x801073d0,0x4(%esp)
80104061:	80 
80104062:	8d 43 04             	lea    0x4(%ebx),%eax
80104065:	89 04 24             	mov    %eax,(%esp)
80104068:	e8 13 01 00 00       	call   80104180 <initlock>
  lk->name = name;
8010406d:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104070:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104076:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010407d:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104080:	83 c4 14             	add    $0x14,%esp
80104083:	5b                   	pop    %ebx
80104084:	5d                   	pop    %ebp
80104085:	c3                   	ret    
80104086:	8d 76 00             	lea    0x0(%esi),%esi
80104089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104090 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	56                   	push   %esi
80104094:	53                   	push   %ebx
80104095:	83 ec 10             	sub    $0x10,%esp
80104098:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010409b:	8d 73 04             	lea    0x4(%ebx),%esi
8010409e:	89 34 24             	mov    %esi,(%esp)
801040a1:	e8 4a 02 00 00       	call   801042f0 <acquire>
  while (lk->locked) {
801040a6:	8b 13                	mov    (%ebx),%edx
801040a8:	85 d2                	test   %edx,%edx
801040aa:	74 16                	je     801040c2 <acquiresleep+0x32>
801040ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801040b0:	89 74 24 04          	mov    %esi,0x4(%esp)
801040b4:	89 1c 24             	mov    %ebx,(%esp)
801040b7:	e8 74 fb ff ff       	call   80103c30 <sleep>
  while (lk->locked) {
801040bc:	8b 03                	mov    (%ebx),%eax
801040be:	85 c0                	test   %eax,%eax
801040c0:	75 ee                	jne    801040b0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801040c2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801040c8:	e8 03 f6 ff ff       	call   801036d0 <myproc>
801040cd:	8b 40 10             	mov    0x10(%eax),%eax
801040d0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801040d3:	89 75 08             	mov    %esi,0x8(%ebp)
}
801040d6:	83 c4 10             	add    $0x10,%esp
801040d9:	5b                   	pop    %ebx
801040da:	5e                   	pop    %esi
801040db:	5d                   	pop    %ebp
  release(&lk->lk);
801040dc:	e9 7f 02 00 00       	jmp    80104360 <release>
801040e1:	eb 0d                	jmp    801040f0 <releasesleep>
801040e3:	90                   	nop
801040e4:	90                   	nop
801040e5:	90                   	nop
801040e6:	90                   	nop
801040e7:	90                   	nop
801040e8:	90                   	nop
801040e9:	90                   	nop
801040ea:	90                   	nop
801040eb:	90                   	nop
801040ec:	90                   	nop
801040ed:	90                   	nop
801040ee:	90                   	nop
801040ef:	90                   	nop

801040f0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	56                   	push   %esi
801040f4:	53                   	push   %ebx
801040f5:	83 ec 10             	sub    $0x10,%esp
801040f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801040fb:	8d 73 04             	lea    0x4(%ebx),%esi
801040fe:	89 34 24             	mov    %esi,(%esp)
80104101:	e8 ea 01 00 00       	call   801042f0 <acquire>
  lk->locked = 0;
80104106:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010410c:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104113:	89 1c 24             	mov    %ebx,(%esp)
80104116:	e8 a5 fc ff ff       	call   80103dc0 <wakeup>
  release(&lk->lk);
8010411b:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010411e:	83 c4 10             	add    $0x10,%esp
80104121:	5b                   	pop    %ebx
80104122:	5e                   	pop    %esi
80104123:	5d                   	pop    %ebp
  release(&lk->lk);
80104124:	e9 37 02 00 00       	jmp    80104360 <release>
80104129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104130 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	57                   	push   %edi
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
80104134:	31 ff                	xor    %edi,%edi
{
80104136:	56                   	push   %esi
80104137:	53                   	push   %ebx
80104138:	83 ec 1c             	sub    $0x1c,%esp
8010413b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010413e:	8d 73 04             	lea    0x4(%ebx),%esi
80104141:	89 34 24             	mov    %esi,(%esp)
80104144:	e8 a7 01 00 00       	call   801042f0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104149:	8b 03                	mov    (%ebx),%eax
8010414b:	85 c0                	test   %eax,%eax
8010414d:	74 13                	je     80104162 <holdingsleep+0x32>
8010414f:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104152:	e8 79 f5 ff ff       	call   801036d0 <myproc>
80104157:	3b 58 10             	cmp    0x10(%eax),%ebx
8010415a:	0f 94 c0             	sete   %al
8010415d:	0f b6 c0             	movzbl %al,%eax
80104160:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104162:	89 34 24             	mov    %esi,(%esp)
80104165:	e8 f6 01 00 00       	call   80104360 <release>
  return r;
}
8010416a:	83 c4 1c             	add    $0x1c,%esp
8010416d:	89 f8                	mov    %edi,%eax
8010416f:	5b                   	pop    %ebx
80104170:	5e                   	pop    %esi
80104171:	5f                   	pop    %edi
80104172:	5d                   	pop    %ebp
80104173:	c3                   	ret    
80104174:	66 90                	xchg   %ax,%ax
80104176:	66 90                	xchg   %ax,%ax
80104178:	66 90                	xchg   %ax,%ax
8010417a:	66 90                	xchg   %ax,%ax
8010417c:	66 90                	xchg   %ax,%ax
8010417e:	66 90                	xchg   %ax,%ax

80104180 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104186:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104189:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010418f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104192:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104199:	5d                   	pop    %ebp
8010419a:	c3                   	ret    
8010419b:	90                   	nop
8010419c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801041a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801041a3:	8b 45 08             	mov    0x8(%ebp),%eax
{
801041a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801041a9:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801041aa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801041ad:	31 c0                	xor    %eax,%eax
801041af:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801041b0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801041b6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801041bc:	77 1a                	ja     801041d8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801041be:	8b 5a 04             	mov    0x4(%edx),%ebx
801041c1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801041c4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801041c7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801041c9:	83 f8 0a             	cmp    $0xa,%eax
801041cc:	75 e2                	jne    801041b0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801041ce:	5b                   	pop    %ebx
801041cf:	5d                   	pop    %ebp
801041d0:	c3                   	ret    
801041d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
801041d8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801041df:	83 c0 01             	add    $0x1,%eax
801041e2:	83 f8 0a             	cmp    $0xa,%eax
801041e5:	74 e7                	je     801041ce <getcallerpcs+0x2e>
    pcs[i] = 0;
801041e7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801041ee:	83 c0 01             	add    $0x1,%eax
801041f1:	83 f8 0a             	cmp    $0xa,%eax
801041f4:	75 e2                	jne    801041d8 <getcallerpcs+0x38>
801041f6:	eb d6                	jmp    801041ce <getcallerpcs+0x2e>
801041f8:	90                   	nop
801041f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104200 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	53                   	push   %ebx
80104204:	83 ec 04             	sub    $0x4,%esp
80104207:	9c                   	pushf  
80104208:	5b                   	pop    %ebx
  asm volatile("cli");
80104209:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010420a:	e8 21 f4 ff ff       	call   80103630 <mycpu>
8010420f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104215:	85 c0                	test   %eax,%eax
80104217:	75 11                	jne    8010422a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104219:	e8 12 f4 ff ff       	call   80103630 <mycpu>
8010421e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104224:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010422a:	e8 01 f4 ff ff       	call   80103630 <mycpu>
8010422f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104236:	83 c4 04             	add    $0x4,%esp
80104239:	5b                   	pop    %ebx
8010423a:	5d                   	pop    %ebp
8010423b:	c3                   	ret    
8010423c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104240 <popcli>:

void
popcli(void)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104246:	9c                   	pushf  
80104247:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104248:	f6 c4 02             	test   $0x2,%ah
8010424b:	75 49                	jne    80104296 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010424d:	e8 de f3 ff ff       	call   80103630 <mycpu>
80104252:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104258:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010425b:	85 d2                	test   %edx,%edx
8010425d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104263:	78 25                	js     8010428a <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104265:	e8 c6 f3 ff ff       	call   80103630 <mycpu>
8010426a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104270:	85 d2                	test   %edx,%edx
80104272:	74 04                	je     80104278 <popcli+0x38>
    sti();
}
80104274:	c9                   	leave  
80104275:	c3                   	ret    
80104276:	66 90                	xchg   %ax,%ax
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104278:	e8 b3 f3 ff ff       	call   80103630 <mycpu>
8010427d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104283:	85 c0                	test   %eax,%eax
80104285:	74 ed                	je     80104274 <popcli+0x34>
  asm volatile("sti");
80104287:	fb                   	sti    
}
80104288:	c9                   	leave  
80104289:	c3                   	ret    
    panic("popcli");
8010428a:	c7 04 24 f2 73 10 80 	movl   $0x801073f2,(%esp)
80104291:	e8 ca c0 ff ff       	call   80100360 <panic>
    panic("popcli - interruptible");
80104296:	c7 04 24 db 73 10 80 	movl   $0x801073db,(%esp)
8010429d:	e8 be c0 ff ff       	call   80100360 <panic>
801042a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042b0 <holding>:
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	56                   	push   %esi
  r = lock->locked && lock->cpu == mycpu();
801042b4:	31 f6                	xor    %esi,%esi
{
801042b6:	53                   	push   %ebx
801042b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801042ba:	e8 41 ff ff ff       	call   80104200 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801042bf:	8b 03                	mov    (%ebx),%eax
801042c1:	85 c0                	test   %eax,%eax
801042c3:	74 12                	je     801042d7 <holding+0x27>
801042c5:	8b 5b 08             	mov    0x8(%ebx),%ebx
801042c8:	e8 63 f3 ff ff       	call   80103630 <mycpu>
801042cd:	39 c3                	cmp    %eax,%ebx
801042cf:	0f 94 c0             	sete   %al
801042d2:	0f b6 c0             	movzbl %al,%eax
801042d5:	89 c6                	mov    %eax,%esi
  popcli();
801042d7:	e8 64 ff ff ff       	call   80104240 <popcli>
}
801042dc:	89 f0                	mov    %esi,%eax
801042de:	5b                   	pop    %ebx
801042df:	5e                   	pop    %esi
801042e0:	5d                   	pop    %ebp
801042e1:	c3                   	ret    
801042e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042f0 <acquire>:
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801042f7:	e8 04 ff ff ff       	call   80104200 <pushcli>
  if(holding(lk))
801042fc:	8b 45 08             	mov    0x8(%ebp),%eax
801042ff:	89 04 24             	mov    %eax,(%esp)
80104302:	e8 a9 ff ff ff       	call   801042b0 <holding>
80104307:	85 c0                	test   %eax,%eax
80104309:	75 3a                	jne    80104345 <acquire+0x55>
  asm volatile("lock; xchgl %0, %1" :
8010430b:	b9 01 00 00 00       	mov    $0x1,%ecx
  while(xchg(&lk->locked, 1) != 0)
80104310:	8b 55 08             	mov    0x8(%ebp),%edx
80104313:	89 c8                	mov    %ecx,%eax
80104315:	f0 87 02             	lock xchg %eax,(%edx)
80104318:	85 c0                	test   %eax,%eax
8010431a:	75 f4                	jne    80104310 <acquire+0x20>
  __sync_synchronize();
8010431c:	0f ae f0             	mfence 
  lk->cpu = mycpu();
8010431f:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104322:	e8 09 f3 ff ff       	call   80103630 <mycpu>
80104327:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
8010432a:	8b 45 08             	mov    0x8(%ebp),%eax
8010432d:	83 c0 0c             	add    $0xc,%eax
80104330:	89 44 24 04          	mov    %eax,0x4(%esp)
80104334:	8d 45 08             	lea    0x8(%ebp),%eax
80104337:	89 04 24             	mov    %eax,(%esp)
8010433a:	e8 61 fe ff ff       	call   801041a0 <getcallerpcs>
}
8010433f:	83 c4 14             	add    $0x14,%esp
80104342:	5b                   	pop    %ebx
80104343:	5d                   	pop    %ebp
80104344:	c3                   	ret    
    panic("acquire");
80104345:	c7 04 24 f9 73 10 80 	movl   $0x801073f9,(%esp)
8010434c:	e8 0f c0 ff ff       	call   80100360 <panic>
80104351:	eb 0d                	jmp    80104360 <release>
80104353:	90                   	nop
80104354:	90                   	nop
80104355:	90                   	nop
80104356:	90                   	nop
80104357:	90                   	nop
80104358:	90                   	nop
80104359:	90                   	nop
8010435a:	90                   	nop
8010435b:	90                   	nop
8010435c:	90                   	nop
8010435d:	90                   	nop
8010435e:	90                   	nop
8010435f:	90                   	nop

80104360 <release>:
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
80104364:	83 ec 14             	sub    $0x14,%esp
80104367:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010436a:	89 1c 24             	mov    %ebx,(%esp)
8010436d:	e8 3e ff ff ff       	call   801042b0 <holding>
80104372:	85 c0                	test   %eax,%eax
80104374:	74 21                	je     80104397 <release+0x37>
  lk->pcs[0] = 0;
80104376:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010437d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104384:	0f ae f0             	mfence 
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104387:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010438d:	83 c4 14             	add    $0x14,%esp
80104390:	5b                   	pop    %ebx
80104391:	5d                   	pop    %ebp
  popcli();
80104392:	e9 a9 fe ff ff       	jmp    80104240 <popcli>
    panic("release");
80104397:	c7 04 24 01 74 10 80 	movl   $0x80107401,(%esp)
8010439e:	e8 bd bf ff ff       	call   80100360 <panic>
801043a3:	66 90                	xchg   %ax,%ax
801043a5:	66 90                	xchg   %ax,%ax
801043a7:	66 90                	xchg   %ax,%ax
801043a9:	66 90                	xchg   %ax,%ax
801043ab:	66 90                	xchg   %ax,%ax
801043ad:	66 90                	xchg   %ax,%ax
801043af:	90                   	nop

801043b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	8b 55 08             	mov    0x8(%ebp),%edx
801043b6:	57                   	push   %edi
801043b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801043ba:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
801043bb:	f6 c2 03             	test   $0x3,%dl
801043be:	75 05                	jne    801043c5 <memset+0x15>
801043c0:	f6 c1 03             	test   $0x3,%cl
801043c3:	74 13                	je     801043d8 <memset+0x28>
  asm volatile("cld; rep stosb" :
801043c5:	89 d7                	mov    %edx,%edi
801043c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801043ca:	fc                   	cld    
801043cb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801043cd:	5b                   	pop    %ebx
801043ce:	89 d0                	mov    %edx,%eax
801043d0:	5f                   	pop    %edi
801043d1:	5d                   	pop    %ebp
801043d2:	c3                   	ret    
801043d3:	90                   	nop
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801043d8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801043dc:	c1 e9 02             	shr    $0x2,%ecx
801043df:	89 f8                	mov    %edi,%eax
801043e1:	89 fb                	mov    %edi,%ebx
801043e3:	c1 e0 18             	shl    $0x18,%eax
801043e6:	c1 e3 10             	shl    $0x10,%ebx
801043e9:	09 d8                	or     %ebx,%eax
801043eb:	09 f8                	or     %edi,%eax
801043ed:	c1 e7 08             	shl    $0x8,%edi
801043f0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801043f2:	89 d7                	mov    %edx,%edi
801043f4:	fc                   	cld    
801043f5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801043f7:	5b                   	pop    %ebx
801043f8:	89 d0                	mov    %edx,%eax
801043fa:	5f                   	pop    %edi
801043fb:	5d                   	pop    %ebp
801043fc:	c3                   	ret    
801043fd:	8d 76 00             	lea    0x0(%esi),%esi

80104400 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	8b 45 10             	mov    0x10(%ebp),%eax
80104406:	57                   	push   %edi
80104407:	56                   	push   %esi
80104408:	8b 75 0c             	mov    0xc(%ebp),%esi
8010440b:	53                   	push   %ebx
8010440c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010440f:	85 c0                	test   %eax,%eax
80104411:	8d 78 ff             	lea    -0x1(%eax),%edi
80104414:	74 26                	je     8010443c <memcmp+0x3c>
    if(*s1 != *s2)
80104416:	0f b6 03             	movzbl (%ebx),%eax
80104419:	31 d2                	xor    %edx,%edx
8010441b:	0f b6 0e             	movzbl (%esi),%ecx
8010441e:	38 c8                	cmp    %cl,%al
80104420:	74 16                	je     80104438 <memcmp+0x38>
80104422:	eb 24                	jmp    80104448 <memcmp+0x48>
80104424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104428:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
8010442d:	83 c2 01             	add    $0x1,%edx
80104430:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104434:	38 c8                	cmp    %cl,%al
80104436:	75 10                	jne    80104448 <memcmp+0x48>
  while(n-- > 0){
80104438:	39 fa                	cmp    %edi,%edx
8010443a:	75 ec                	jne    80104428 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010443c:	5b                   	pop    %ebx
  return 0;
8010443d:	31 c0                	xor    %eax,%eax
}
8010443f:	5e                   	pop    %esi
80104440:	5f                   	pop    %edi
80104441:	5d                   	pop    %ebp
80104442:	c3                   	ret    
80104443:	90                   	nop
80104444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104448:	5b                   	pop    %ebx
      return *s1 - *s2;
80104449:	29 c8                	sub    %ecx,%eax
}
8010444b:	5e                   	pop    %esi
8010444c:	5f                   	pop    %edi
8010444d:	5d                   	pop    %ebp
8010444e:	c3                   	ret    
8010444f:	90                   	nop

80104450 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	57                   	push   %edi
80104454:	8b 45 08             	mov    0x8(%ebp),%eax
80104457:	56                   	push   %esi
80104458:	8b 75 0c             	mov    0xc(%ebp),%esi
8010445b:	53                   	push   %ebx
8010445c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010445f:	39 c6                	cmp    %eax,%esi
80104461:	73 35                	jae    80104498 <memmove+0x48>
80104463:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104466:	39 c8                	cmp    %ecx,%eax
80104468:	73 2e                	jae    80104498 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
8010446a:	85 db                	test   %ebx,%ebx
    d += n;
8010446c:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
    while(n-- > 0)
8010446f:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104472:	74 1b                	je     8010448f <memmove+0x3f>
80104474:	f7 db                	neg    %ebx
80104476:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
80104479:	01 fb                	add    %edi,%ebx
8010447b:	90                   	nop
8010447c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104480:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104484:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
    while(n-- > 0)
80104487:	83 ea 01             	sub    $0x1,%edx
8010448a:	83 fa ff             	cmp    $0xffffffff,%edx
8010448d:	75 f1                	jne    80104480 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010448f:	5b                   	pop    %ebx
80104490:	5e                   	pop    %esi
80104491:	5f                   	pop    %edi
80104492:	5d                   	pop    %ebp
80104493:	c3                   	ret    
80104494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104498:	31 d2                	xor    %edx,%edx
8010449a:	85 db                	test   %ebx,%ebx
8010449c:	74 f1                	je     8010448f <memmove+0x3f>
8010449e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801044a0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801044a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801044a7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801044aa:	39 da                	cmp    %ebx,%edx
801044ac:	75 f2                	jne    801044a0 <memmove+0x50>
}
801044ae:	5b                   	pop    %ebx
801044af:	5e                   	pop    %esi
801044b0:	5f                   	pop    %edi
801044b1:	5d                   	pop    %ebp
801044b2:	c3                   	ret    
801044b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801044c3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801044c4:	eb 8a                	jmp    80104450 <memmove>
801044c6:	8d 76 00             	lea    0x0(%esi),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	56                   	push   %esi
801044d4:	8b 75 10             	mov    0x10(%ebp),%esi
801044d7:	53                   	push   %ebx
801044d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
801044db:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
801044de:	85 f6                	test   %esi,%esi
801044e0:	74 30                	je     80104512 <strncmp+0x42>
801044e2:	0f b6 01             	movzbl (%ecx),%eax
801044e5:	84 c0                	test   %al,%al
801044e7:	74 2f                	je     80104518 <strncmp+0x48>
801044e9:	0f b6 13             	movzbl (%ebx),%edx
801044ec:	38 d0                	cmp    %dl,%al
801044ee:	75 46                	jne    80104536 <strncmp+0x66>
801044f0:	8d 51 01             	lea    0x1(%ecx),%edx
801044f3:	01 ce                	add    %ecx,%esi
801044f5:	eb 14                	jmp    8010450b <strncmp+0x3b>
801044f7:	90                   	nop
801044f8:	0f b6 02             	movzbl (%edx),%eax
801044fb:	84 c0                	test   %al,%al
801044fd:	74 31                	je     80104530 <strncmp+0x60>
801044ff:	0f b6 19             	movzbl (%ecx),%ebx
80104502:	83 c2 01             	add    $0x1,%edx
80104505:	38 d8                	cmp    %bl,%al
80104507:	75 17                	jne    80104520 <strncmp+0x50>
    n--, p++, q++;
80104509:	89 cb                	mov    %ecx,%ebx
  while(n > 0 && *p && *p == *q)
8010450b:	39 f2                	cmp    %esi,%edx
    n--, p++, q++;
8010450d:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(n > 0 && *p && *p == *q)
80104510:	75 e6                	jne    801044f8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104512:	5b                   	pop    %ebx
    return 0;
80104513:	31 c0                	xor    %eax,%eax
}
80104515:	5e                   	pop    %esi
80104516:	5d                   	pop    %ebp
80104517:	c3                   	ret    
80104518:	0f b6 1b             	movzbl (%ebx),%ebx
  while(n > 0 && *p && *p == *q)
8010451b:	31 c0                	xor    %eax,%eax
8010451d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
80104520:	0f b6 d3             	movzbl %bl,%edx
80104523:	29 d0                	sub    %edx,%eax
}
80104525:	5b                   	pop    %ebx
80104526:	5e                   	pop    %esi
80104527:	5d                   	pop    %ebp
80104528:	c3                   	ret    
80104529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104530:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
80104534:	eb ea                	jmp    80104520 <strncmp+0x50>
  while(n > 0 && *p && *p == *q)
80104536:	89 d3                	mov    %edx,%ebx
80104538:	eb e6                	jmp    80104520 <strncmp+0x50>
8010453a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104540 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	8b 45 08             	mov    0x8(%ebp),%eax
80104546:	56                   	push   %esi
80104547:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010454a:	53                   	push   %ebx
8010454b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010454e:	89 c2                	mov    %eax,%edx
80104550:	eb 19                	jmp    8010456b <strncpy+0x2b>
80104552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104558:	83 c3 01             	add    $0x1,%ebx
8010455b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010455f:	83 c2 01             	add    $0x1,%edx
80104562:	84 c9                	test   %cl,%cl
80104564:	88 4a ff             	mov    %cl,-0x1(%edx)
80104567:	74 09                	je     80104572 <strncpy+0x32>
80104569:	89 f1                	mov    %esi,%ecx
8010456b:	85 c9                	test   %ecx,%ecx
8010456d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104570:	7f e6                	jg     80104558 <strncpy+0x18>
    ;
  while(n-- > 0)
80104572:	31 c9                	xor    %ecx,%ecx
80104574:	85 f6                	test   %esi,%esi
80104576:	7e 0f                	jle    80104587 <strncpy+0x47>
    *s++ = 0;
80104578:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
8010457c:	89 f3                	mov    %esi,%ebx
8010457e:	83 c1 01             	add    $0x1,%ecx
80104581:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104583:	85 db                	test   %ebx,%ebx
80104585:	7f f1                	jg     80104578 <strncpy+0x38>
  return os;
}
80104587:	5b                   	pop    %ebx
80104588:	5e                   	pop    %esi
80104589:	5d                   	pop    %ebp
8010458a:	c3                   	ret    
8010458b:	90                   	nop
8010458c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104590 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104596:	56                   	push   %esi
80104597:	8b 45 08             	mov    0x8(%ebp),%eax
8010459a:	53                   	push   %ebx
8010459b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010459e:	85 c9                	test   %ecx,%ecx
801045a0:	7e 26                	jle    801045c8 <safestrcpy+0x38>
801045a2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801045a6:	89 c1                	mov    %eax,%ecx
801045a8:	eb 17                	jmp    801045c1 <safestrcpy+0x31>
801045aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801045b0:	83 c2 01             	add    $0x1,%edx
801045b3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801045b7:	83 c1 01             	add    $0x1,%ecx
801045ba:	84 db                	test   %bl,%bl
801045bc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801045bf:	74 04                	je     801045c5 <safestrcpy+0x35>
801045c1:	39 f2                	cmp    %esi,%edx
801045c3:	75 eb                	jne    801045b0 <safestrcpy+0x20>
    ;
  *s = 0;
801045c5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801045c8:	5b                   	pop    %ebx
801045c9:	5e                   	pop    %esi
801045ca:	5d                   	pop    %ebp
801045cb:	c3                   	ret    
801045cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045d0 <strlen>:

int
strlen(const char *s)
{
801045d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801045d1:	31 c0                	xor    %eax,%eax
{
801045d3:	89 e5                	mov    %esp,%ebp
801045d5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801045d8:	80 3a 00             	cmpb   $0x0,(%edx)
801045db:	74 0c                	je     801045e9 <strlen+0x19>
801045dd:	8d 76 00             	lea    0x0(%esi),%esi
801045e0:	83 c0 01             	add    $0x1,%eax
801045e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801045e7:	75 f7                	jne    801045e0 <strlen+0x10>
    ;
  return n;
}
801045e9:	5d                   	pop    %ebp
801045ea:	c3                   	ret    

801045eb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801045eb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801045ef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801045f3:	55                   	push   %ebp
  pushl %ebx
801045f4:	53                   	push   %ebx
  pushl %esi
801045f5:	56                   	push   %esi
  pushl %edi
801045f6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801045f7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801045f9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801045fb:	5f                   	pop    %edi
  popl %esi
801045fc:	5e                   	pop    %esi
  popl %ebx
801045fd:	5b                   	pop    %ebx
  popl %ebp
801045fe:	5d                   	pop    %ebp
  ret
801045ff:	c3                   	ret    

80104600 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	53                   	push   %ebx
80104604:	83 ec 04             	sub    $0x4,%esp
80104607:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010460a:	e8 c1 f0 ff ff       	call   801036d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010460f:	8b 00                	mov    (%eax),%eax
80104611:	39 d8                	cmp    %ebx,%eax
80104613:	76 1b                	jbe    80104630 <fetchint+0x30>
80104615:	8d 53 04             	lea    0x4(%ebx),%edx
80104618:	39 d0                	cmp    %edx,%eax
8010461a:	72 14                	jb     80104630 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010461c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010461f:	8b 13                	mov    (%ebx),%edx
80104621:	89 10                	mov    %edx,(%eax)
  return 0;
80104623:	31 c0                	xor    %eax,%eax
}
80104625:	83 c4 04             	add    $0x4,%esp
80104628:	5b                   	pop    %ebx
80104629:	5d                   	pop    %ebp
8010462a:	c3                   	ret    
8010462b:	90                   	nop
8010462c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104630:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104635:	eb ee                	jmp    80104625 <fetchint+0x25>
80104637:	89 f6                	mov    %esi,%esi
80104639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104640 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	53                   	push   %ebx
80104644:	83 ec 04             	sub    $0x4,%esp
80104647:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010464a:	e8 81 f0 ff ff       	call   801036d0 <myproc>

  if(addr >= curproc->sz)
8010464f:	39 18                	cmp    %ebx,(%eax)
80104651:	76 26                	jbe    80104679 <fetchstr+0x39>
    return -1;
  *pp = (char*)addr;
80104653:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104656:	89 da                	mov    %ebx,%edx
80104658:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010465a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010465c:	39 c3                	cmp    %eax,%ebx
8010465e:	73 19                	jae    80104679 <fetchstr+0x39>
    if(*s == 0)
80104660:	80 3b 00             	cmpb   $0x0,(%ebx)
80104663:	75 0d                	jne    80104672 <fetchstr+0x32>
80104665:	eb 21                	jmp    80104688 <fetchstr+0x48>
80104667:	90                   	nop
80104668:	80 3a 00             	cmpb   $0x0,(%edx)
8010466b:	90                   	nop
8010466c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104670:	74 16                	je     80104688 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80104672:	83 c2 01             	add    $0x1,%edx
80104675:	39 d0                	cmp    %edx,%eax
80104677:	77 ef                	ja     80104668 <fetchstr+0x28>
      return s - *pp;
  }
  return -1;
}
80104679:	83 c4 04             	add    $0x4,%esp
    return -1;
8010467c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104681:	5b                   	pop    %ebx
80104682:	5d                   	pop    %ebp
80104683:	c3                   	ret    
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104688:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010468b:	89 d0                	mov    %edx,%eax
8010468d:	29 d8                	sub    %ebx,%eax
}
8010468f:	5b                   	pop    %ebx
80104690:	5d                   	pop    %ebp
80104691:	c3                   	ret    
80104692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046a0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	56                   	push   %esi
801046a4:	8b 75 0c             	mov    0xc(%ebp),%esi
801046a7:	53                   	push   %ebx
801046a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801046ab:	e8 20 f0 ff ff       	call   801036d0 <myproc>
801046b0:	89 75 0c             	mov    %esi,0xc(%ebp)
801046b3:	8b 40 18             	mov    0x18(%eax),%eax
801046b6:	8b 40 44             	mov    0x44(%eax),%eax
801046b9:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
801046bd:	89 45 08             	mov    %eax,0x8(%ebp)
}
801046c0:	5b                   	pop    %ebx
801046c1:	5e                   	pop    %esi
801046c2:	5d                   	pop    %ebp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801046c3:	e9 38 ff ff ff       	jmp    80104600 <fetchint>
801046c8:	90                   	nop
801046c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046d0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	83 ec 20             	sub    $0x20,%esp
801046d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801046db:	e8 f0 ef ff ff       	call   801036d0 <myproc>
801046e0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801046e2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801046e5:	89 44 24 04          	mov    %eax,0x4(%esp)
801046e9:	8b 45 08             	mov    0x8(%ebp),%eax
801046ec:	89 04 24             	mov    %eax,(%esp)
801046ef:	e8 ac ff ff ff       	call   801046a0 <argint>
801046f4:	85 c0                	test   %eax,%eax
801046f6:	78 28                	js     80104720 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801046f8:	85 db                	test   %ebx,%ebx
801046fa:	78 24                	js     80104720 <argptr+0x50>
801046fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046ff:	8b 06                	mov    (%esi),%eax
80104701:	39 c2                	cmp    %eax,%edx
80104703:	73 1b                	jae    80104720 <argptr+0x50>
80104705:	01 d3                	add    %edx,%ebx
80104707:	39 d8                	cmp    %ebx,%eax
80104709:	72 15                	jb     80104720 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010470b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010470e:	89 10                	mov    %edx,(%eax)
  return 0;
}
80104710:	83 c4 20             	add    $0x20,%esp
  return 0;
80104713:	31 c0                	xor    %eax,%eax
}
80104715:	5b                   	pop    %ebx
80104716:	5e                   	pop    %esi
80104717:	5d                   	pop    %ebp
80104718:	c3                   	ret    
80104719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104720:	83 c4 20             	add    $0x20,%esp
    return -1;
80104723:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104728:	5b                   	pop    %ebx
80104729:	5e                   	pop    %esi
8010472a:	5d                   	pop    %ebp
8010472b:	c3                   	ret    
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104730 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104736:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104739:	89 44 24 04          	mov    %eax,0x4(%esp)
8010473d:	8b 45 08             	mov    0x8(%ebp),%eax
80104740:	89 04 24             	mov    %eax,(%esp)
80104743:	e8 58 ff ff ff       	call   801046a0 <argint>
80104748:	85 c0                	test   %eax,%eax
8010474a:	78 14                	js     80104760 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010474c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010474f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104753:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104756:	89 04 24             	mov    %eax,(%esp)
80104759:	e8 e2 fe ff ff       	call   80104640 <fetchstr>
}
8010475e:	c9                   	leave  
8010475f:	c3                   	ret    
    return -1;
80104760:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104765:	c9                   	leave  
80104766:	c3                   	ret    
80104767:	89 f6                	mov    %esi,%esi
80104769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104770 <syscall>:
#endif // CPS
};

void
syscall(void)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	56                   	push   %esi
80104774:	53                   	push   %ebx
80104775:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
80104778:	e8 53 ef ff ff       	call   801036d0 <myproc>

  num = curproc->tf->eax;
8010477d:	8b 70 18             	mov    0x18(%eax),%esi
  struct proc *curproc = myproc();
80104780:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104782:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104785:	8d 50 ff             	lea    -0x1(%eax),%edx
80104788:	83 fa 16             	cmp    $0x16,%edx
8010478b:	77 1b                	ja     801047a8 <syscall+0x38>
8010478d:	8b 14 85 40 74 10 80 	mov    -0x7fef8bc0(,%eax,4),%edx
80104794:	85 d2                	test   %edx,%edx
80104796:	74 10                	je     801047a8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104798:	ff d2                	call   *%edx
8010479a:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010479d:	83 c4 10             	add    $0x10,%esp
801047a0:	5b                   	pop    %ebx
801047a1:	5e                   	pop    %esi
801047a2:	5d                   	pop    %ebp
801047a3:	c3                   	ret    
801047a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
801047a8:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
801047ac:	8d 43 6c             	lea    0x6c(%ebx),%eax
801047af:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
801047b3:	8b 43 10             	mov    0x10(%ebx),%eax
801047b6:	c7 04 24 09 74 10 80 	movl   $0x80107409,(%esp)
801047bd:	89 44 24 04          	mov    %eax,0x4(%esp)
801047c1:	e8 8a be ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
801047c6:	8b 43 18             	mov    0x18(%ebx),%eax
801047c9:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801047d0:	83 c4 10             	add    $0x10,%esp
801047d3:	5b                   	pop    %ebx
801047d4:	5e                   	pop    %esi
801047d5:	5d                   	pop    %ebp
801047d6:	c3                   	ret    
801047d7:	66 90                	xchg   %ax,%ax
801047d9:	66 90                	xchg   %ax,%ax
801047db:	66 90                	xchg   %ax,%ax
801047dd:	66 90                	xchg   %ax,%ax
801047df:	90                   	nop

801047e0 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	53                   	push   %ebx
801047e4:	89 c3                	mov    %eax,%ebx
801047e6:	83 ec 04             	sub    $0x4,%esp
  int fd;
  struct proc *curproc = myproc();
801047e9:	e8 e2 ee ff ff       	call   801036d0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801047ee:	31 d2                	xor    %edx,%edx
    if(curproc->ofile[fd] == 0){
801047f0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801047f4:	85 c9                	test   %ecx,%ecx
801047f6:	74 18                	je     80104810 <fdalloc+0x30>
  for(fd = 0; fd < NOFILE; fd++){
801047f8:	83 c2 01             	add    $0x1,%edx
801047fb:	83 fa 10             	cmp    $0x10,%edx
801047fe:	75 f0                	jne    801047f0 <fdalloc+0x10>
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
80104800:	83 c4 04             	add    $0x4,%esp
  return -1;
80104803:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104808:	5b                   	pop    %ebx
80104809:	5d                   	pop    %ebp
8010480a:	c3                   	ret    
8010480b:	90                   	nop
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80104810:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
}
80104814:	83 c4 04             	add    $0x4,%esp
      return fd;
80104817:	89 d0                	mov    %edx,%eax
}
80104819:	5b                   	pop    %ebx
8010481a:	5d                   	pop    %ebp
8010481b:	c3                   	ret    
8010481c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104820 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	57                   	push   %edi
80104824:	56                   	push   %esi
80104825:	53                   	push   %ebx
80104826:	83 ec 4c             	sub    $0x4c,%esp
80104829:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010482c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010482f:	8d 5d da             	lea    -0x26(%ebp),%ebx
80104832:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104836:	89 04 24             	mov    %eax,(%esp)
{
80104839:	89 55 c4             	mov    %edx,-0x3c(%ebp)
8010483c:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010483f:	e8 0c d7 ff ff       	call   80101f50 <nameiparent>
80104844:	85 c0                	test   %eax,%eax
80104846:	89 c7                	mov    %eax,%edi
80104848:	0f 84 da 00 00 00    	je     80104928 <create+0x108>
    return 0;
  ilock(dp);
8010484e:	89 04 24             	mov    %eax,(%esp)
80104851:	e8 8a ce ff ff       	call   801016e0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104856:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104859:	89 44 24 08          	mov    %eax,0x8(%esp)
8010485d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104861:	89 3c 24             	mov    %edi,(%esp)
80104864:	e8 87 d3 ff ff       	call   80101bf0 <dirlookup>
80104869:	85 c0                	test   %eax,%eax
8010486b:	89 c6                	mov    %eax,%esi
8010486d:	74 41                	je     801048b0 <create+0x90>
    iunlockput(dp);
8010486f:	89 3c 24             	mov    %edi,(%esp)
80104872:	e8 c9 d0 ff ff       	call   80101940 <iunlockput>
    ilock(ip);
80104877:	89 34 24             	mov    %esi,(%esp)
8010487a:	e8 61 ce ff ff       	call   801016e0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010487f:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104884:	75 12                	jne    80104898 <create+0x78>
80104886:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010488b:	89 f0                	mov    %esi,%eax
8010488d:	75 09                	jne    80104898 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010488f:	83 c4 4c             	add    $0x4c,%esp
80104892:	5b                   	pop    %ebx
80104893:	5e                   	pop    %esi
80104894:	5f                   	pop    %edi
80104895:	5d                   	pop    %ebp
80104896:	c3                   	ret    
80104897:	90                   	nop
    iunlockput(ip);
80104898:	89 34 24             	mov    %esi,(%esp)
8010489b:	e8 a0 d0 ff ff       	call   80101940 <iunlockput>
}
801048a0:	83 c4 4c             	add    $0x4c,%esp
    return 0;
801048a3:	31 c0                	xor    %eax,%eax
}
801048a5:	5b                   	pop    %ebx
801048a6:	5e                   	pop    %esi
801048a7:	5f                   	pop    %edi
801048a8:	5d                   	pop    %ebp
801048a9:	c3                   	ret    
801048aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
801048b0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
801048b4:	89 44 24 04          	mov    %eax,0x4(%esp)
801048b8:	8b 07                	mov    (%edi),%eax
801048ba:	89 04 24             	mov    %eax,(%esp)
801048bd:	e8 8e cc ff ff       	call   80101550 <ialloc>
801048c2:	85 c0                	test   %eax,%eax
801048c4:	89 c6                	mov    %eax,%esi
801048c6:	0f 84 bf 00 00 00    	je     8010498b <create+0x16b>
  ilock(ip);
801048cc:	89 04 24             	mov    %eax,(%esp)
801048cf:	e8 0c ce ff ff       	call   801016e0 <ilock>
  ip->major = major;
801048d4:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801048d8:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801048dc:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
801048e0:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801048e4:	b8 01 00 00 00       	mov    $0x1,%eax
801048e9:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801048ed:	89 34 24             	mov    %esi,(%esp)
801048f0:	e8 2b cd ff ff       	call   80101620 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801048f5:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801048fa:	74 34                	je     80104930 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
801048fc:	8b 46 04             	mov    0x4(%esi),%eax
801048ff:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104903:	89 3c 24             	mov    %edi,(%esp)
80104906:	89 44 24 08          	mov    %eax,0x8(%esp)
8010490a:	e8 41 d5 ff ff       	call   80101e50 <dirlink>
8010490f:	85 c0                	test   %eax,%eax
80104911:	78 6c                	js     8010497f <create+0x15f>
  iunlockput(dp);
80104913:	89 3c 24             	mov    %edi,(%esp)
80104916:	e8 25 d0 ff ff       	call   80101940 <iunlockput>
}
8010491b:	83 c4 4c             	add    $0x4c,%esp
  return ip;
8010491e:	89 f0                	mov    %esi,%eax
}
80104920:	5b                   	pop    %ebx
80104921:	5e                   	pop    %esi
80104922:	5f                   	pop    %edi
80104923:	5d                   	pop    %ebp
80104924:	c3                   	ret    
80104925:	8d 76 00             	lea    0x0(%esi),%esi
    return 0;
80104928:	31 c0                	xor    %eax,%eax
8010492a:	e9 60 ff ff ff       	jmp    8010488f <create+0x6f>
8010492f:	90                   	nop
    dp->nlink++;  // for ".."
80104930:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104935:	89 3c 24             	mov    %edi,(%esp)
80104938:	e8 e3 cc ff ff       	call   80101620 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010493d:	8b 46 04             	mov    0x4(%esi),%eax
80104940:	c7 44 24 04 bc 74 10 	movl   $0x801074bc,0x4(%esp)
80104947:	80 
80104948:	89 34 24             	mov    %esi,(%esp)
8010494b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010494f:	e8 fc d4 ff ff       	call   80101e50 <dirlink>
80104954:	85 c0                	test   %eax,%eax
80104956:	78 1b                	js     80104973 <create+0x153>
80104958:	8b 47 04             	mov    0x4(%edi),%eax
8010495b:	c7 44 24 04 bb 74 10 	movl   $0x801074bb,0x4(%esp)
80104962:	80 
80104963:	89 34 24             	mov    %esi,(%esp)
80104966:	89 44 24 08          	mov    %eax,0x8(%esp)
8010496a:	e8 e1 d4 ff ff       	call   80101e50 <dirlink>
8010496f:	85 c0                	test   %eax,%eax
80104971:	79 89                	jns    801048fc <create+0xdc>
      panic("create dots");
80104973:	c7 04 24 af 74 10 80 	movl   $0x801074af,(%esp)
8010497a:	e8 e1 b9 ff ff       	call   80100360 <panic>
    panic("create: dirlink");
8010497f:	c7 04 24 be 74 10 80 	movl   $0x801074be,(%esp)
80104986:	e8 d5 b9 ff ff       	call   80100360 <panic>
    panic("create: ialloc");
8010498b:	c7 04 24 a0 74 10 80 	movl   $0x801074a0,(%esp)
80104992:	e8 c9 b9 ff ff       	call   80100360 <panic>
80104997:	89 f6                	mov    %esi,%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049a0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	56                   	push   %esi
801049a4:	89 c6                	mov    %eax,%esi
801049a6:	53                   	push   %ebx
801049a7:	89 d3                	mov    %edx,%ebx
801049a9:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801049ac:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049af:	89 44 24 04          	mov    %eax,0x4(%esp)
801049b3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801049ba:	e8 e1 fc ff ff       	call   801046a0 <argint>
801049bf:	85 c0                	test   %eax,%eax
801049c1:	78 2d                	js     801049f0 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801049c3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801049c7:	77 27                	ja     801049f0 <argfd.constprop.0+0x50>
801049c9:	e8 02 ed ff ff       	call   801036d0 <myproc>
801049ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
801049d1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801049d5:	85 c0                	test   %eax,%eax
801049d7:	74 17                	je     801049f0 <argfd.constprop.0+0x50>
  if(pfd)
801049d9:	85 f6                	test   %esi,%esi
801049db:	74 02                	je     801049df <argfd.constprop.0+0x3f>
    *pfd = fd;
801049dd:	89 16                	mov    %edx,(%esi)
  if(pf)
801049df:	85 db                	test   %ebx,%ebx
801049e1:	74 1d                	je     80104a00 <argfd.constprop.0+0x60>
    *pf = f;
801049e3:	89 03                	mov    %eax,(%ebx)
  return 0;
801049e5:	31 c0                	xor    %eax,%eax
}
801049e7:	83 c4 20             	add    $0x20,%esp
801049ea:	5b                   	pop    %ebx
801049eb:	5e                   	pop    %esi
801049ec:	5d                   	pop    %ebp
801049ed:	c3                   	ret    
801049ee:	66 90                	xchg   %ax,%ax
801049f0:	83 c4 20             	add    $0x20,%esp
    return -1;
801049f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049f8:	5b                   	pop    %ebx
801049f9:	5e                   	pop    %esi
801049fa:	5d                   	pop    %ebp
801049fb:	c3                   	ret    
801049fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
80104a00:	31 c0                	xor    %eax,%eax
80104a02:	eb e3                	jmp    801049e7 <argfd.constprop.0+0x47>
80104a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a10 <sys_dup>:
{
80104a10:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104a11:	31 c0                	xor    %eax,%eax
{
80104a13:	89 e5                	mov    %esp,%ebp
80104a15:	53                   	push   %ebx
80104a16:	83 ec 24             	sub    $0x24,%esp
  if(argfd(0, 0, &f) < 0)
80104a19:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104a1c:	e8 7f ff ff ff       	call   801049a0 <argfd.constprop.0>
80104a21:	85 c0                	test   %eax,%eax
80104a23:	78 23                	js     80104a48 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
80104a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a28:	e8 b3 fd ff ff       	call   801047e0 <fdalloc>
80104a2d:	85 c0                	test   %eax,%eax
80104a2f:	89 c3                	mov    %eax,%ebx
80104a31:	78 15                	js     80104a48 <sys_dup+0x38>
  filedup(f);
80104a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a36:	89 04 24             	mov    %eax,(%esp)
80104a39:	e8 c2 c3 ff ff       	call   80100e00 <filedup>
  return fd;
80104a3e:	89 d8                	mov    %ebx,%eax
}
80104a40:	83 c4 24             	add    $0x24,%esp
80104a43:	5b                   	pop    %ebx
80104a44:	5d                   	pop    %ebp
80104a45:	c3                   	ret    
80104a46:	66 90                	xchg   %ax,%ax
    return -1;
80104a48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a4d:	eb f1                	jmp    80104a40 <sys_dup+0x30>
80104a4f:	90                   	nop

80104a50 <sys_read>:
{
80104a50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a51:	31 c0                	xor    %eax,%eax
{
80104a53:	89 e5                	mov    %esp,%ebp
80104a55:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a5b:	e8 40 ff ff ff       	call   801049a0 <argfd.constprop.0>
80104a60:	85 c0                	test   %eax,%eax
80104a62:	78 54                	js     80104ab8 <sys_read+0x68>
80104a64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a67:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a6b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104a72:	e8 29 fc ff ff       	call   801046a0 <argint>
80104a77:	85 c0                	test   %eax,%eax
80104a79:	78 3d                	js     80104ab8 <sys_read+0x68>
80104a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104a85:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a8c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a90:	e8 3b fc ff ff       	call   801046d0 <argptr>
80104a95:	85 c0                	test   %eax,%eax
80104a97:	78 1f                	js     80104ab8 <sys_read+0x68>
  return fileread(f, p, n);
80104a99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a9c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aa3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104aa7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104aaa:	89 04 24             	mov    %eax,(%esp)
80104aad:	e8 ae c4 ff ff       	call   80100f60 <fileread>
}
80104ab2:	c9                   	leave  
80104ab3:	c3                   	ret    
80104ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ab8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104abd:	c9                   	leave  
80104abe:	c3                   	ret    
80104abf:	90                   	nop

80104ac0 <sys_write>:
{
80104ac0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ac1:	31 c0                	xor    %eax,%eax
{
80104ac3:	89 e5                	mov    %esp,%ebp
80104ac5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ac8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104acb:	e8 d0 fe ff ff       	call   801049a0 <argfd.constprop.0>
80104ad0:	85 c0                	test   %eax,%eax
80104ad2:	78 54                	js     80104b28 <sys_write+0x68>
80104ad4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ad7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104adb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104ae2:	e8 b9 fb ff ff       	call   801046a0 <argint>
80104ae7:	85 c0                	test   %eax,%eax
80104ae9:	78 3d                	js     80104b28 <sys_write+0x68>
80104aeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104aee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104af5:	89 44 24 08          	mov    %eax,0x8(%esp)
80104af9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104afc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b00:	e8 cb fb ff ff       	call   801046d0 <argptr>
80104b05:	85 c0                	test   %eax,%eax
80104b07:	78 1f                	js     80104b28 <sys_write+0x68>
  return filewrite(f, p, n);
80104b09:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b0c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b17:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b1a:	89 04 24             	mov    %eax,(%esp)
80104b1d:	e8 de c4 ff ff       	call   80101000 <filewrite>
}
80104b22:	c9                   	leave  
80104b23:	c3                   	ret    
80104b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b2d:	c9                   	leave  
80104b2e:	c3                   	ret    
80104b2f:	90                   	nop

80104b30 <sys_close>:
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80104b36:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104b39:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b3c:	e8 5f fe ff ff       	call   801049a0 <argfd.constprop.0>
80104b41:	85 c0                	test   %eax,%eax
80104b43:	78 23                	js     80104b68 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80104b45:	e8 86 eb ff ff       	call   801036d0 <myproc>
80104b4a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104b4d:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104b54:	00 
  fileclose(f);
80104b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b58:	89 04 24             	mov    %eax,(%esp)
80104b5b:	e8 f0 c2 ff ff       	call   80100e50 <fileclose>
  return 0;
80104b60:	31 c0                	xor    %eax,%eax
}
80104b62:	c9                   	leave  
80104b63:	c3                   	ret    
80104b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b6d:	c9                   	leave  
80104b6e:	c3                   	ret    
80104b6f:	90                   	nop

80104b70 <sys_fstat>:
{
80104b70:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104b71:	31 c0                	xor    %eax,%eax
{
80104b73:	89 e5                	mov    %esp,%ebp
80104b75:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104b78:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104b7b:	e8 20 fe ff ff       	call   801049a0 <argfd.constprop.0>
80104b80:	85 c0                	test   %eax,%eax
80104b82:	78 34                	js     80104bb8 <sys_fstat+0x48>
80104b84:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b87:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104b8e:	00 
80104b8f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b93:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b9a:	e8 31 fb ff ff       	call   801046d0 <argptr>
80104b9f:	85 c0                	test   %eax,%eax
80104ba1:	78 15                	js     80104bb8 <sys_fstat+0x48>
  return filestat(f, st);
80104ba3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba6:	89 44 24 04          	mov    %eax,0x4(%esp)
80104baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bad:	89 04 24             	mov    %eax,(%esp)
80104bb0:	e8 5b c3 ff ff       	call   80100f10 <filestat>
}
80104bb5:	c9                   	leave  
80104bb6:	c3                   	ret    
80104bb7:	90                   	nop
    return -1;
80104bb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104bbd:	c9                   	leave  
80104bbe:	c3                   	ret    
80104bbf:	90                   	nop

80104bc0 <sys_link>:
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	57                   	push   %edi
80104bc4:	56                   	push   %esi
80104bc5:	53                   	push   %ebx
80104bc6:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104bc9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104bd7:	e8 54 fb ff ff       	call   80104730 <argstr>
80104bdc:	85 c0                	test   %eax,%eax
80104bde:	0f 88 e6 00 00 00    	js     80104cca <sys_link+0x10a>
80104be4:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104be7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104beb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104bf2:	e8 39 fb ff ff       	call   80104730 <argstr>
80104bf7:	85 c0                	test   %eax,%eax
80104bf9:	0f 88 cb 00 00 00    	js     80104cca <sys_link+0x10a>
  begin_op();
80104bff:	e8 3c df ff ff       	call   80102b40 <begin_op>
  if((ip = namei(old)) == 0){
80104c04:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104c07:	89 04 24             	mov    %eax,(%esp)
80104c0a:	e8 21 d3 ff ff       	call   80101f30 <namei>
80104c0f:	85 c0                	test   %eax,%eax
80104c11:	89 c3                	mov    %eax,%ebx
80104c13:	0f 84 ac 00 00 00    	je     80104cc5 <sys_link+0x105>
  ilock(ip);
80104c19:	89 04 24             	mov    %eax,(%esp)
80104c1c:	e8 bf ca ff ff       	call   801016e0 <ilock>
  if(ip->type == T_DIR){
80104c21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104c26:	0f 84 91 00 00 00    	je     80104cbd <sys_link+0xfd>
  ip->nlink++;
80104c2c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104c31:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104c34:	89 1c 24             	mov    %ebx,(%esp)
80104c37:	e8 e4 c9 ff ff       	call   80101620 <iupdate>
  iunlock(ip);
80104c3c:	89 1c 24             	mov    %ebx,(%esp)
80104c3f:	e8 7c cb ff ff       	call   801017c0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104c44:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104c47:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c4b:	89 04 24             	mov    %eax,(%esp)
80104c4e:	e8 fd d2 ff ff       	call   80101f50 <nameiparent>
80104c53:	85 c0                	test   %eax,%eax
80104c55:	89 c6                	mov    %eax,%esi
80104c57:	74 4f                	je     80104ca8 <sys_link+0xe8>
  ilock(dp);
80104c59:	89 04 24             	mov    %eax,(%esp)
80104c5c:	e8 7f ca ff ff       	call   801016e0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104c61:	8b 03                	mov    (%ebx),%eax
80104c63:	39 06                	cmp    %eax,(%esi)
80104c65:	75 39                	jne    80104ca0 <sys_link+0xe0>
80104c67:	8b 43 04             	mov    0x4(%ebx),%eax
80104c6a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c6e:	89 34 24             	mov    %esi,(%esp)
80104c71:	89 44 24 08          	mov    %eax,0x8(%esp)
80104c75:	e8 d6 d1 ff ff       	call   80101e50 <dirlink>
80104c7a:	85 c0                	test   %eax,%eax
80104c7c:	78 22                	js     80104ca0 <sys_link+0xe0>
  iunlockput(dp);
80104c7e:	89 34 24             	mov    %esi,(%esp)
80104c81:	e8 ba cc ff ff       	call   80101940 <iunlockput>
  iput(ip);
80104c86:	89 1c 24             	mov    %ebx,(%esp)
80104c89:	e8 72 cb ff ff       	call   80101800 <iput>
  end_op();
80104c8e:	e8 1d df ff ff       	call   80102bb0 <end_op>
}
80104c93:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80104c96:	31 c0                	xor    %eax,%eax
}
80104c98:	5b                   	pop    %ebx
80104c99:	5e                   	pop    %esi
80104c9a:	5f                   	pop    %edi
80104c9b:	5d                   	pop    %ebp
80104c9c:	c3                   	ret    
80104c9d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80104ca0:	89 34 24             	mov    %esi,(%esp)
80104ca3:	e8 98 cc ff ff       	call   80101940 <iunlockput>
  ilock(ip);
80104ca8:	89 1c 24             	mov    %ebx,(%esp)
80104cab:	e8 30 ca ff ff       	call   801016e0 <ilock>
  ip->nlink--;
80104cb0:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104cb5:	89 1c 24             	mov    %ebx,(%esp)
80104cb8:	e8 63 c9 ff ff       	call   80101620 <iupdate>
  iunlockput(ip);
80104cbd:	89 1c 24             	mov    %ebx,(%esp)
80104cc0:	e8 7b cc ff ff       	call   80101940 <iunlockput>
  end_op();
80104cc5:	e8 e6 de ff ff       	call   80102bb0 <end_op>
}
80104cca:	83 c4 3c             	add    $0x3c,%esp
  return -1;
80104ccd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cd2:	5b                   	pop    %ebx
80104cd3:	5e                   	pop    %esi
80104cd4:	5f                   	pop    %edi
80104cd5:	5d                   	pop    %ebp
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <sys_unlink>:
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	57                   	push   %edi
80104ce4:	56                   	push   %esi
80104ce5:	53                   	push   %ebx
80104ce6:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80104ce9:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104cec:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cf0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104cf7:	e8 34 fa ff ff       	call   80104730 <argstr>
80104cfc:	85 c0                	test   %eax,%eax
80104cfe:	0f 88 76 01 00 00    	js     80104e7a <sys_unlink+0x19a>
  begin_op();
80104d04:	e8 37 de ff ff       	call   80102b40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104d09:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104d0c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104d0f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104d13:	89 04 24             	mov    %eax,(%esp)
80104d16:	e8 35 d2 ff ff       	call   80101f50 <nameiparent>
80104d1b:	85 c0                	test   %eax,%eax
80104d1d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104d20:	0f 84 4f 01 00 00    	je     80104e75 <sys_unlink+0x195>
  ilock(dp);
80104d26:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104d29:	89 34 24             	mov    %esi,(%esp)
80104d2c:	e8 af c9 ff ff       	call   801016e0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104d31:	c7 44 24 04 bc 74 10 	movl   $0x801074bc,0x4(%esp)
80104d38:	80 
80104d39:	89 1c 24             	mov    %ebx,(%esp)
80104d3c:	e8 7f ce ff ff       	call   80101bc0 <namecmp>
80104d41:	85 c0                	test   %eax,%eax
80104d43:	0f 84 21 01 00 00    	je     80104e6a <sys_unlink+0x18a>
80104d49:	c7 44 24 04 bb 74 10 	movl   $0x801074bb,0x4(%esp)
80104d50:	80 
80104d51:	89 1c 24             	mov    %ebx,(%esp)
80104d54:	e8 67 ce ff ff       	call   80101bc0 <namecmp>
80104d59:	85 c0                	test   %eax,%eax
80104d5b:	0f 84 09 01 00 00    	je     80104e6a <sys_unlink+0x18a>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104d61:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104d64:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104d68:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d6c:	89 34 24             	mov    %esi,(%esp)
80104d6f:	e8 7c ce ff ff       	call   80101bf0 <dirlookup>
80104d74:	85 c0                	test   %eax,%eax
80104d76:	89 c3                	mov    %eax,%ebx
80104d78:	0f 84 ec 00 00 00    	je     80104e6a <sys_unlink+0x18a>
  ilock(ip);
80104d7e:	89 04 24             	mov    %eax,(%esp)
80104d81:	e8 5a c9 ff ff       	call   801016e0 <ilock>
  if(ip->nlink < 1)
80104d86:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104d8b:	0f 8e 24 01 00 00    	jle    80104eb5 <sys_unlink+0x1d5>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104d91:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d96:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104d99:	74 7d                	je     80104e18 <sys_unlink+0x138>
  memset(&de, 0, sizeof(de));
80104d9b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104da2:	00 
80104da3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104daa:	00 
80104dab:	89 34 24             	mov    %esi,(%esp)
80104dae:	e8 fd f5 ff ff       	call   801043b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104db3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104db6:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104dbd:	00 
80104dbe:	89 74 24 04          	mov    %esi,0x4(%esp)
80104dc2:	89 44 24 08          	mov    %eax,0x8(%esp)
80104dc6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104dc9:	89 04 24             	mov    %eax,(%esp)
80104dcc:	e8 bf cc ff ff       	call   80101a90 <writei>
80104dd1:	83 f8 10             	cmp    $0x10,%eax
80104dd4:	0f 85 cf 00 00 00    	jne    80104ea9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80104dda:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ddf:	0f 84 a3 00 00 00    	je     80104e88 <sys_unlink+0x1a8>
  iunlockput(dp);
80104de5:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104de8:	89 04 24             	mov    %eax,(%esp)
80104deb:	e8 50 cb ff ff       	call   80101940 <iunlockput>
  ip->nlink--;
80104df0:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104df5:	89 1c 24             	mov    %ebx,(%esp)
80104df8:	e8 23 c8 ff ff       	call   80101620 <iupdate>
  iunlockput(ip);
80104dfd:	89 1c 24             	mov    %ebx,(%esp)
80104e00:	e8 3b cb ff ff       	call   80101940 <iunlockput>
  end_op();
80104e05:	e8 a6 dd ff ff       	call   80102bb0 <end_op>
}
80104e0a:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80104e0d:	31 c0                	xor    %eax,%eax
}
80104e0f:	5b                   	pop    %ebx
80104e10:	5e                   	pop    %esi
80104e11:	5f                   	pop    %edi
80104e12:	5d                   	pop    %ebp
80104e13:	c3                   	ret    
80104e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104e18:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104e1c:	0f 86 79 ff ff ff    	jbe    80104d9b <sys_unlink+0xbb>
80104e22:	bf 20 00 00 00       	mov    $0x20,%edi
80104e27:	eb 15                	jmp    80104e3e <sys_unlink+0x15e>
80104e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e30:	8d 57 10             	lea    0x10(%edi),%edx
80104e33:	3b 53 58             	cmp    0x58(%ebx),%edx
80104e36:	0f 83 5f ff ff ff    	jae    80104d9b <sys_unlink+0xbb>
80104e3c:	89 d7                	mov    %edx,%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104e3e:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104e45:	00 
80104e46:	89 7c 24 08          	mov    %edi,0x8(%esp)
80104e4a:	89 74 24 04          	mov    %esi,0x4(%esp)
80104e4e:	89 1c 24             	mov    %ebx,(%esp)
80104e51:	e8 3a cb ff ff       	call   80101990 <readi>
80104e56:	83 f8 10             	cmp    $0x10,%eax
80104e59:	75 42                	jne    80104e9d <sys_unlink+0x1bd>
    if(de.inum != 0)
80104e5b:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104e60:	74 ce                	je     80104e30 <sys_unlink+0x150>
    iunlockput(ip);
80104e62:	89 1c 24             	mov    %ebx,(%esp)
80104e65:	e8 d6 ca ff ff       	call   80101940 <iunlockput>
  iunlockput(dp);
80104e6a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e6d:	89 04 24             	mov    %eax,(%esp)
80104e70:	e8 cb ca ff ff       	call   80101940 <iunlockput>
  end_op();
80104e75:	e8 36 dd ff ff       	call   80102bb0 <end_op>
}
80104e7a:	83 c4 5c             	add    $0x5c,%esp
  return -1;
80104e7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e82:	5b                   	pop    %ebx
80104e83:	5e                   	pop    %esi
80104e84:	5f                   	pop    %edi
80104e85:	5d                   	pop    %ebp
80104e86:	c3                   	ret    
80104e87:	90                   	nop
    dp->nlink--;
80104e88:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e8b:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80104e90:	89 04 24             	mov    %eax,(%esp)
80104e93:	e8 88 c7 ff ff       	call   80101620 <iupdate>
80104e98:	e9 48 ff ff ff       	jmp    80104de5 <sys_unlink+0x105>
      panic("isdirempty: readi");
80104e9d:	c7 04 24 e0 74 10 80 	movl   $0x801074e0,(%esp)
80104ea4:	e8 b7 b4 ff ff       	call   80100360 <panic>
    panic("unlink: writei");
80104ea9:	c7 04 24 f2 74 10 80 	movl   $0x801074f2,(%esp)
80104eb0:	e8 ab b4 ff ff       	call   80100360 <panic>
    panic("unlink: nlink < 1");
80104eb5:	c7 04 24 ce 74 10 80 	movl   $0x801074ce,(%esp)
80104ebc:	e8 9f b4 ff ff       	call   80100360 <panic>
80104ec1:	eb 0d                	jmp    80104ed0 <sys_open>
80104ec3:	90                   	nop
80104ec4:	90                   	nop
80104ec5:	90                   	nop
80104ec6:	90                   	nop
80104ec7:	90                   	nop
80104ec8:	90                   	nop
80104ec9:	90                   	nop
80104eca:	90                   	nop
80104ecb:	90                   	nop
80104ecc:	90                   	nop
80104ecd:	90                   	nop
80104ece:	90                   	nop
80104ecf:	90                   	nop

80104ed0 <sys_open>:

int
sys_open(void)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	57                   	push   %edi
80104ed4:	56                   	push   %esi
80104ed5:	53                   	push   %ebx
80104ed6:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104ed9:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104edc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ee0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ee7:	e8 44 f8 ff ff       	call   80104730 <argstr>
80104eec:	85 c0                	test   %eax,%eax
80104eee:	0f 88 d1 00 00 00    	js     80104fc5 <sys_open+0xf5>
80104ef4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104ef7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104efb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104f02:	e8 99 f7 ff ff       	call   801046a0 <argint>
80104f07:	85 c0                	test   %eax,%eax
80104f09:	0f 88 b6 00 00 00    	js     80104fc5 <sys_open+0xf5>
    return -1;

  begin_op();
80104f0f:	e8 2c dc ff ff       	call   80102b40 <begin_op>

  if(omode & O_CREATE){
80104f14:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104f18:	0f 85 82 00 00 00    	jne    80104fa0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104f1e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f21:	89 04 24             	mov    %eax,(%esp)
80104f24:	e8 07 d0 ff ff       	call   80101f30 <namei>
80104f29:	85 c0                	test   %eax,%eax
80104f2b:	89 c6                	mov    %eax,%esi
80104f2d:	0f 84 8d 00 00 00    	je     80104fc0 <sys_open+0xf0>
      end_op();
      return -1;
    }
    ilock(ip);
80104f33:	89 04 24             	mov    %eax,(%esp)
80104f36:	e8 a5 c7 ff ff       	call   801016e0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104f3b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104f40:	0f 84 92 00 00 00    	je     80104fd8 <sys_open+0x108>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104f46:	e8 45 be ff ff       	call   80100d90 <filealloc>
80104f4b:	85 c0                	test   %eax,%eax
80104f4d:	89 c3                	mov    %eax,%ebx
80104f4f:	0f 84 93 00 00 00    	je     80104fe8 <sys_open+0x118>
80104f55:	e8 86 f8 ff ff       	call   801047e0 <fdalloc>
80104f5a:	85 c0                	test   %eax,%eax
80104f5c:	89 c7                	mov    %eax,%edi
80104f5e:	0f 88 94 00 00 00    	js     80104ff8 <sys_open+0x128>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104f64:	89 34 24             	mov    %esi,(%esp)
80104f67:	e8 54 c8 ff ff       	call   801017c0 <iunlock>
  end_op();
80104f6c:	e8 3f dc ff ff       	call   80102bb0 <end_op>

  f->type = FD_INODE;
80104f71:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80104f77:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->ip = ip;
80104f7a:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
80104f7d:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80104f84:	89 c2                	mov    %eax,%edx
80104f86:	83 e2 01             	and    $0x1,%edx
80104f89:	83 f2 01             	xor    $0x1,%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104f8c:	a8 03                	test   $0x3,%al
  f->readable = !(omode & O_WRONLY);
80104f8e:	88 53 08             	mov    %dl,0x8(%ebx)
  return fd;
80104f91:	89 f8                	mov    %edi,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104f93:	0f 95 43 09          	setne  0x9(%ebx)
}
80104f97:	83 c4 2c             	add    $0x2c,%esp
80104f9a:	5b                   	pop    %ebx
80104f9b:	5e                   	pop    %esi
80104f9c:	5f                   	pop    %edi
80104f9d:	5d                   	pop    %ebp
80104f9e:	c3                   	ret    
80104f9f:	90                   	nop
    ip = create(path, T_FILE, 0, 0);
80104fa0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104fa3:	31 c9                	xor    %ecx,%ecx
80104fa5:	ba 02 00 00 00       	mov    $0x2,%edx
80104faa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fb1:	e8 6a f8 ff ff       	call   80104820 <create>
    if(ip == 0){
80104fb6:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80104fb8:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80104fba:	75 8a                	jne    80104f46 <sys_open+0x76>
80104fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80104fc0:	e8 eb db ff ff       	call   80102bb0 <end_op>
}
80104fc5:	83 c4 2c             	add    $0x2c,%esp
    return -1;
80104fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fcd:	5b                   	pop    %ebx
80104fce:	5e                   	pop    %esi
80104fcf:	5f                   	pop    %edi
80104fd0:	5d                   	pop    %ebp
80104fd1:	c3                   	ret    
80104fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80104fd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104fdb:	85 c0                	test   %eax,%eax
80104fdd:	0f 84 63 ff ff ff    	je     80104f46 <sys_open+0x76>
80104fe3:	90                   	nop
80104fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80104fe8:	89 34 24             	mov    %esi,(%esp)
80104feb:	e8 50 c9 ff ff       	call   80101940 <iunlockput>
80104ff0:	eb ce                	jmp    80104fc0 <sys_open+0xf0>
80104ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      fileclose(f);
80104ff8:	89 1c 24             	mov    %ebx,(%esp)
80104ffb:	e8 50 be ff ff       	call   80100e50 <fileclose>
80105000:	eb e6                	jmp    80104fe8 <sys_open+0x118>
80105002:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105010 <sys_mkdir>:

int
sys_mkdir(void)
{
80105010:	55                   	push   %ebp
80105011:	89 e5                	mov    %esp,%ebp
80105013:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105016:	e8 25 db ff ff       	call   80102b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010501b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010501e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105022:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105029:	e8 02 f7 ff ff       	call   80104730 <argstr>
8010502e:	85 c0                	test   %eax,%eax
80105030:	78 2e                	js     80105060 <sys_mkdir+0x50>
80105032:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105035:	31 c9                	xor    %ecx,%ecx
80105037:	ba 01 00 00 00       	mov    $0x1,%edx
8010503c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105043:	e8 d8 f7 ff ff       	call   80104820 <create>
80105048:	85 c0                	test   %eax,%eax
8010504a:	74 14                	je     80105060 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010504c:	89 04 24             	mov    %eax,(%esp)
8010504f:	e8 ec c8 ff ff       	call   80101940 <iunlockput>
  end_op();
80105054:	e8 57 db ff ff       	call   80102bb0 <end_op>
  return 0;
80105059:	31 c0                	xor    %eax,%eax
}
8010505b:	c9                   	leave  
8010505c:	c3                   	ret    
8010505d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105060:	e8 4b db ff ff       	call   80102bb0 <end_op>
    return -1;
80105065:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010506a:	c9                   	leave  
8010506b:	c3                   	ret    
8010506c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105070 <sys_mknod>:

int
sys_mknod(void)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105076:	e8 c5 da ff ff       	call   80102b40 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010507b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010507e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105082:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105089:	e8 a2 f6 ff ff       	call   80104730 <argstr>
8010508e:	85 c0                	test   %eax,%eax
80105090:	78 5e                	js     801050f0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105092:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105095:	89 44 24 04          	mov    %eax,0x4(%esp)
80105099:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801050a0:	e8 fb f5 ff ff       	call   801046a0 <argint>
  if((argstr(0, &path)) < 0 ||
801050a5:	85 c0                	test   %eax,%eax
801050a7:	78 47                	js     801050f0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801050a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801050b0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801050b7:	e8 e4 f5 ff ff       	call   801046a0 <argint>
     argint(1, &major) < 0 ||
801050bc:	85 c0                	test   %eax,%eax
801050be:	78 30                	js     801050f0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801050c0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801050c4:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
801050c9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801050cd:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
801050d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801050d3:	e8 48 f7 ff ff       	call   80104820 <create>
801050d8:	85 c0                	test   %eax,%eax
801050da:	74 14                	je     801050f0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801050dc:	89 04 24             	mov    %eax,(%esp)
801050df:	e8 5c c8 ff ff       	call   80101940 <iunlockput>
  end_op();
801050e4:	e8 c7 da ff ff       	call   80102bb0 <end_op>
  return 0;
801050e9:	31 c0                	xor    %eax,%eax
}
801050eb:	c9                   	leave  
801050ec:	c3                   	ret    
801050ed:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801050f0:	e8 bb da ff ff       	call   80102bb0 <end_op>
    return -1;
801050f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050fa:	c9                   	leave  
801050fb:	c3                   	ret    
801050fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105100 <sys_chdir>:

int
sys_chdir(void)
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	56                   	push   %esi
80105104:	53                   	push   %ebx
80105105:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105108:	e8 c3 e5 ff ff       	call   801036d0 <myproc>
8010510d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010510f:	e8 2c da ff ff       	call   80102b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105114:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105117:	89 44 24 04          	mov    %eax,0x4(%esp)
8010511b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105122:	e8 09 f6 ff ff       	call   80104730 <argstr>
80105127:	85 c0                	test   %eax,%eax
80105129:	78 4a                	js     80105175 <sys_chdir+0x75>
8010512b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010512e:	89 04 24             	mov    %eax,(%esp)
80105131:	e8 fa cd ff ff       	call   80101f30 <namei>
80105136:	85 c0                	test   %eax,%eax
80105138:	89 c3                	mov    %eax,%ebx
8010513a:	74 39                	je     80105175 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010513c:	89 04 24             	mov    %eax,(%esp)
8010513f:	e8 9c c5 ff ff       	call   801016e0 <ilock>
  if(ip->type != T_DIR){
80105144:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80105149:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010514c:	75 22                	jne    80105170 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010514e:	e8 6d c6 ff ff       	call   801017c0 <iunlock>
  iput(curproc->cwd);
80105153:	8b 46 68             	mov    0x68(%esi),%eax
80105156:	89 04 24             	mov    %eax,(%esp)
80105159:	e8 a2 c6 ff ff       	call   80101800 <iput>
  end_op();
8010515e:	e8 4d da ff ff       	call   80102bb0 <end_op>
  curproc->cwd = ip;
  return 0;
80105163:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80105165:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80105168:	83 c4 20             	add    $0x20,%esp
8010516b:	5b                   	pop    %ebx
8010516c:	5e                   	pop    %esi
8010516d:	5d                   	pop    %ebp
8010516e:	c3                   	ret    
8010516f:	90                   	nop
    iunlockput(ip);
80105170:	e8 cb c7 ff ff       	call   80101940 <iunlockput>
    end_op();
80105175:	e8 36 da ff ff       	call   80102bb0 <end_op>
}
8010517a:	83 c4 20             	add    $0x20,%esp
    return -1;
8010517d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105182:	5b                   	pop    %ebx
80105183:	5e                   	pop    %esi
80105184:	5d                   	pop    %ebp
80105185:	c3                   	ret    
80105186:	8d 76 00             	lea    0x0(%esi),%esi
80105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105190 <sys_exec>:

int
sys_exec(void)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	57                   	push   %edi
80105194:	56                   	push   %esi
80105195:	53                   	push   %ebx
80105196:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010519c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801051a2:	89 44 24 04          	mov    %eax,0x4(%esp)
801051a6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051ad:	e8 7e f5 ff ff       	call   80104730 <argstr>
801051b2:	85 c0                	test   %eax,%eax
801051b4:	0f 88 84 00 00 00    	js     8010523e <sys_exec+0xae>
801051ba:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801051c0:	89 44 24 04          	mov    %eax,0x4(%esp)
801051c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801051cb:	e8 d0 f4 ff ff       	call   801046a0 <argint>
801051d0:	85 c0                	test   %eax,%eax
801051d2:	78 6a                	js     8010523e <sys_exec+0xae>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801051d4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
801051da:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801051dc:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801051e3:	00 
801051e4:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801051ea:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801051f1:	00 
801051f2:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801051f8:	89 04 24             	mov    %eax,(%esp)
801051fb:	e8 b0 f1 ff ff       	call   801043b0 <memset>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105200:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105206:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010520a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010520d:	89 04 24             	mov    %eax,(%esp)
80105210:	e8 eb f3 ff ff       	call   80104600 <fetchint>
80105215:	85 c0                	test   %eax,%eax
80105217:	78 25                	js     8010523e <sys_exec+0xae>
      return -1;
    if(uarg == 0){
80105219:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010521f:	85 c0                	test   %eax,%eax
80105221:	74 2d                	je     80105250 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105223:	89 74 24 04          	mov    %esi,0x4(%esp)
80105227:	89 04 24             	mov    %eax,(%esp)
8010522a:	e8 11 f4 ff ff       	call   80104640 <fetchstr>
8010522f:	85 c0                	test   %eax,%eax
80105231:	78 0b                	js     8010523e <sys_exec+0xae>
  for(i=0;; i++){
80105233:	83 c3 01             	add    $0x1,%ebx
80105236:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
80105239:	83 fb 20             	cmp    $0x20,%ebx
8010523c:	75 c2                	jne    80105200 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
8010523e:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80105244:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105249:	5b                   	pop    %ebx
8010524a:	5e                   	pop    %esi
8010524b:	5f                   	pop    %edi
8010524c:	5d                   	pop    %ebp
8010524d:	c3                   	ret    
8010524e:	66 90                	xchg   %ax,%ax
  return exec(path, argv);
80105250:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105256:	89 44 24 04          	mov    %eax,0x4(%esp)
8010525a:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
      argv[i] = 0;
80105260:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105267:	00 00 00 00 
  return exec(path, argv);
8010526b:	89 04 24             	mov    %eax,(%esp)
8010526e:	e8 4d b7 ff ff       	call   801009c0 <exec>
}
80105273:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105279:	5b                   	pop    %ebx
8010527a:	5e                   	pop    %esi
8010527b:	5f                   	pop    %edi
8010527c:	5d                   	pop    %ebp
8010527d:	c3                   	ret    
8010527e:	66 90                	xchg   %ax,%ax

80105280 <sys_pipe>:

int
sys_pipe(void)
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	53                   	push   %ebx
80105284:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105287:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010528a:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80105291:	00 
80105292:	89 44 24 04          	mov    %eax,0x4(%esp)
80105296:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010529d:	e8 2e f4 ff ff       	call   801046d0 <argptr>
801052a2:	85 c0                	test   %eax,%eax
801052a4:	78 6d                	js     80105313 <sys_pipe+0x93>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801052a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801052ad:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052b0:	89 04 24             	mov    %eax,(%esp)
801052b3:	e8 e8 de ff ff       	call   801031a0 <pipealloc>
801052b8:	85 c0                	test   %eax,%eax
801052ba:	78 57                	js     80105313 <sys_pipe+0x93>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801052bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052bf:	e8 1c f5 ff ff       	call   801047e0 <fdalloc>
801052c4:	85 c0                	test   %eax,%eax
801052c6:	89 c3                	mov    %eax,%ebx
801052c8:	78 33                	js     801052fd <sys_pipe+0x7d>
801052ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052cd:	e8 0e f5 ff ff       	call   801047e0 <fdalloc>
801052d2:	85 c0                	test   %eax,%eax
801052d4:	78 1a                	js     801052f0 <sys_pipe+0x70>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801052d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
801052d9:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
801052db:	8b 55 ec             	mov    -0x14(%ebp),%edx
801052de:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
}
801052e1:	83 c4 24             	add    $0x24,%esp
  return 0;
801052e4:	31 c0                	xor    %eax,%eax
}
801052e6:	5b                   	pop    %ebx
801052e7:	5d                   	pop    %ebp
801052e8:	c3                   	ret    
801052e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801052f0:	e8 db e3 ff ff       	call   801036d0 <myproc>
801052f5:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
801052fc:	00 
    fileclose(rf);
801052fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105300:	89 04 24             	mov    %eax,(%esp)
80105303:	e8 48 bb ff ff       	call   80100e50 <fileclose>
    fileclose(wf);
80105308:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010530b:	89 04 24             	mov    %eax,(%esp)
8010530e:	e8 3d bb ff ff       	call   80100e50 <fileclose>
}
80105313:	83 c4 24             	add    $0x24,%esp
    return -1;
80105316:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010531b:	5b                   	pop    %ebx
8010531c:	5d                   	pop    %ebp
8010531d:	c3                   	ret    
8010531e:	66 90                	xchg   %ax,%ax

80105320 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105323:	5d                   	pop    %ebp
  return fork();
80105324:	e9 57 e5 ff ff       	jmp    80103880 <fork>
80105329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105330 <sys_getppid>:

#ifdef GETPPID
int
sys_getppid(void)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	83 ec 08             	sub    $0x8,%esp
    int ppid = 1;

    if (myproc()->parent) {
80105336:	e8 95 e3 ff ff       	call   801036d0 <myproc>
    int ppid = 1;
8010533b:	ba 01 00 00 00       	mov    $0x1,%edx
    if (myproc()->parent) {
80105340:	8b 40 14             	mov    0x14(%eax),%eax
80105343:	85 c0                	test   %eax,%eax
80105345:	74 0b                	je     80105352 <sys_getppid+0x22>
        ppid = myproc()->parent->pid;
80105347:	e8 84 e3 ff ff       	call   801036d0 <myproc>
8010534c:	8b 40 14             	mov    0x14(%eax),%eax
8010534f:	8b 50 10             	mov    0x10(%eax),%edx
    }
    return ppid;
}
80105352:	89 d0                	mov    %edx,%eax
80105354:	c9                   	leave  
80105355:	c3                   	ret    
80105356:	8d 76 00             	lea    0x0(%esi),%esi
80105359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105360 <sys_exit>:
#endif 

int
sys_exit(void)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	83 ec 08             	sub    $0x8,%esp
  exit();
80105366:	e8 65 e7 ff ff       	call   80103ad0 <exit>
  return 0;  // not reached
}
8010536b:	31 c0                	xor    %eax,%eax
8010536d:	c9                   	leave  
8010536e:	c3                   	ret    
8010536f:	90                   	nop

80105370 <sys_wait>:

int
sys_wait(void)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105373:	5d                   	pop    %ebp
  return wait();
80105374:	e9 67 e9 ff ff       	jmp    80103ce0 <wait>
80105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_kill>:

int
sys_kill(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105386:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105389:	89 44 24 04          	mov    %eax,0x4(%esp)
8010538d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105394:	e8 07 f3 ff ff       	call   801046a0 <argint>
80105399:	85 c0                	test   %eax,%eax
8010539b:	78 13                	js     801053b0 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010539d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053a0:	89 04 24             	mov    %eax,(%esp)
801053a3:	e8 78 ea ff ff       	call   80103e20 <kill>
}
801053a8:	c9                   	leave  
801053a9:	c3                   	ret    
801053aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801053b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053b5:	c9                   	leave  
801053b6:	c3                   	ret    
801053b7:	89 f6                	mov    %esi,%esi
801053b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053c0 <sys_getpid>:

int
sys_getpid(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801053c6:	e8 05 e3 ff ff       	call   801036d0 <myproc>
801053cb:	8b 40 10             	mov    0x10(%eax),%eax
}
801053ce:	c9                   	leave  
801053cf:	c3                   	ret    

801053d0 <sys_sbrk>:

int
sys_sbrk(void)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	53                   	push   %ebx
801053d4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801053d7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053da:	89 44 24 04          	mov    %eax,0x4(%esp)
801053de:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053e5:	e8 b6 f2 ff ff       	call   801046a0 <argint>
801053ea:	85 c0                	test   %eax,%eax
801053ec:	78 22                	js     80105410 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801053ee:	e8 dd e2 ff ff       	call   801036d0 <myproc>
  if(growproc(n) < 0)
801053f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  addr = myproc()->sz;
801053f6:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801053f8:	89 14 24             	mov    %edx,(%esp)
801053fb:	e8 10 e4 ff ff       	call   80103810 <growproc>
80105400:	85 c0                	test   %eax,%eax
80105402:	78 0c                	js     80105410 <sys_sbrk+0x40>
    return -1;
  return addr;
80105404:	89 d8                	mov    %ebx,%eax
}
80105406:	83 c4 24             	add    $0x24,%esp
80105409:	5b                   	pop    %ebx
8010540a:	5d                   	pop    %ebp
8010540b:	c3                   	ret    
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105410:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105415:	eb ef                	jmp    80105406 <sys_sbrk+0x36>
80105417:	89 f6                	mov    %esi,%esi
80105419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105420 <sys_sleep>:

int
sys_sleep(void)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	53                   	push   %ebx
80105424:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105427:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010542a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010542e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105435:	e8 66 f2 ff ff       	call   801046a0 <argint>
8010543a:	85 c0                	test   %eax,%eax
8010543c:	78 7e                	js     801054bc <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
8010543e:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
80105445:	e8 a6 ee ff ff       	call   801042f0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010544a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010544d:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
  while(ticks - ticks0 < n){
80105453:	85 d2                	test   %edx,%edx
80105455:	75 29                	jne    80105480 <sys_sleep+0x60>
80105457:	eb 4f                	jmp    801054a8 <sys_sleep+0x88>
80105459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105460:	c7 44 24 04 60 4d 11 	movl   $0x80114d60,0x4(%esp)
80105467:	80 
80105468:	c7 04 24 a0 55 11 80 	movl   $0x801155a0,(%esp)
8010546f:	e8 bc e7 ff ff       	call   80103c30 <sleep>
  while(ticks - ticks0 < n){
80105474:	a1 a0 55 11 80       	mov    0x801155a0,%eax
80105479:	29 d8                	sub    %ebx,%eax
8010547b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010547e:	73 28                	jae    801054a8 <sys_sleep+0x88>
    if(myproc()->killed){
80105480:	e8 4b e2 ff ff       	call   801036d0 <myproc>
80105485:	8b 40 24             	mov    0x24(%eax),%eax
80105488:	85 c0                	test   %eax,%eax
8010548a:	74 d4                	je     80105460 <sys_sleep+0x40>
      release(&tickslock);
8010548c:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
80105493:	e8 c8 ee ff ff       	call   80104360 <release>
      return -1;
80105498:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
8010549d:	83 c4 24             	add    $0x24,%esp
801054a0:	5b                   	pop    %ebx
801054a1:	5d                   	pop    %ebp
801054a2:	c3                   	ret    
801054a3:	90                   	nop
801054a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
801054a8:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
801054af:	e8 ac ee ff ff       	call   80104360 <release>
}
801054b4:	83 c4 24             	add    $0x24,%esp
  return 0;
801054b7:	31 c0                	xor    %eax,%eax
}
801054b9:	5b                   	pop    %ebx
801054ba:	5d                   	pop    %ebp
801054bb:	c3                   	ret    
    return -1;
801054bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054c1:	eb da                	jmp    8010549d <sys_sleep+0x7d>
801054c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054d0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	53                   	push   %ebx
801054d4:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
801054d7:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
801054de:	e8 0d ee ff ff       	call   801042f0 <acquire>
  xticks = ticks;
801054e3:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
  release(&tickslock);
801054e9:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
801054f0:	e8 6b ee ff ff       	call   80104360 <release>
  return xticks;
}
801054f5:	83 c4 14             	add    $0x14,%esp
801054f8:	89 d8                	mov    %ebx,%eax
801054fa:	5b                   	pop    %ebx
801054fb:	5d                   	pop    %ebp
801054fc:	c3                   	ret    

801054fd <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801054fd:	1e                   	push   %ds
  pushl %es
801054fe:	06                   	push   %es
  pushl %fs
801054ff:	0f a0                	push   %fs
  pushl %gs
80105501:	0f a8                	push   %gs
  pushal
80105503:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105504:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105508:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010550a:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010550c:	54                   	push   %esp
  call trap
8010550d:	e8 de 00 00 00       	call   801055f0 <trap>
  addl $4, %esp
80105512:	83 c4 04             	add    $0x4,%esp

80105515 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105515:	61                   	popa   
  popl %gs
80105516:	0f a9                	pop    %gs
  popl %fs
80105518:	0f a1                	pop    %fs
  popl %es
8010551a:	07                   	pop    %es
  popl %ds
8010551b:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010551c:	83 c4 08             	add    $0x8,%esp
  iret
8010551f:	cf                   	iret   

80105520 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105520:	31 c0                	xor    %eax,%eax
80105522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105528:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010552f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105534:	66 89 0c c5 a2 4d 11 	mov    %cx,-0x7feeb25e(,%eax,8)
8010553b:	80 
8010553c:	c6 04 c5 a4 4d 11 80 	movb   $0x0,-0x7feeb25c(,%eax,8)
80105543:	00 
80105544:	c6 04 c5 a5 4d 11 80 	movb   $0x8e,-0x7feeb25b(,%eax,8)
8010554b:	8e 
8010554c:	66 89 14 c5 a0 4d 11 	mov    %dx,-0x7feeb260(,%eax,8)
80105553:	80 
80105554:	c1 ea 10             	shr    $0x10,%edx
80105557:	66 89 14 c5 a6 4d 11 	mov    %dx,-0x7feeb25a(,%eax,8)
8010555e:	80 
  for(i = 0; i < 256; i++)
8010555f:	83 c0 01             	add    $0x1,%eax
80105562:	3d 00 01 00 00       	cmp    $0x100,%eax
80105567:	75 bf                	jne    80105528 <tvinit+0x8>
{
80105569:	55                   	push   %ebp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010556a:	ba 08 00 00 00       	mov    $0x8,%edx
{
8010556f:	89 e5                	mov    %esp,%ebp
80105571:	83 ec 18             	sub    $0x18,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105574:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105579:	c7 44 24 04 01 75 10 	movl   $0x80107501,0x4(%esp)
80105580:	80 
80105581:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105588:	66 89 15 a2 4f 11 80 	mov    %dx,0x80114fa2
8010558f:	66 a3 a0 4f 11 80    	mov    %ax,0x80114fa0
80105595:	c1 e8 10             	shr    $0x10,%eax
80105598:	c6 05 a4 4f 11 80 00 	movb   $0x0,0x80114fa4
8010559f:	c6 05 a5 4f 11 80 ef 	movb   $0xef,0x80114fa5
801055a6:	66 a3 a6 4f 11 80    	mov    %ax,0x80114fa6
  initlock(&tickslock, "time");
801055ac:	e8 cf eb ff ff       	call   80104180 <initlock>
}
801055b1:	c9                   	leave  
801055b2:	c3                   	ret    
801055b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055c0 <idtinit>:

void
idtinit(void)
{
801055c0:	55                   	push   %ebp
  pd[0] = size-1;
801055c1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801055c6:	89 e5                	mov    %esp,%ebp
801055c8:	83 ec 10             	sub    $0x10,%esp
801055cb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801055cf:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
801055d4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801055d8:	c1 e8 10             	shr    $0x10,%eax
801055db:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801055df:	8d 45 fa             	lea    -0x6(%ebp),%eax
801055e2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801055e5:	c9                   	leave  
801055e6:	c3                   	ret    
801055e7:	89 f6                	mov    %esi,%esi
801055e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055f0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	57                   	push   %edi
801055f4:	56                   	push   %esi
801055f5:	53                   	push   %ebx
801055f6:	83 ec 3c             	sub    $0x3c,%esp
801055f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801055fc:	8b 43 30             	mov    0x30(%ebx),%eax
801055ff:	83 f8 40             	cmp    $0x40,%eax
80105602:	0f 84 a0 01 00 00    	je     801057a8 <trap+0x1b8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105608:	83 e8 20             	sub    $0x20,%eax
8010560b:	83 f8 1f             	cmp    $0x1f,%eax
8010560e:	77 08                	ja     80105618 <trap+0x28>
80105610:	ff 24 85 a8 75 10 80 	jmp    *-0x7fef8a58(,%eax,4)
80105617:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105618:	e8 b3 e0 ff ff       	call   801036d0 <myproc>
8010561d:	85 c0                	test   %eax,%eax
8010561f:	90                   	nop
80105620:	0f 84 fa 01 00 00    	je     80105820 <trap+0x230>
80105626:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
8010562a:	0f 84 f0 01 00 00    	je     80105820 <trap+0x230>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105630:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105633:	8b 53 38             	mov    0x38(%ebx),%edx
80105636:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105639:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010563c:	e8 6f e0 ff ff       	call   801036b0 <cpuid>
80105641:	8b 73 30             	mov    0x30(%ebx),%esi
80105644:	89 c7                	mov    %eax,%edi
80105646:	8b 43 34             	mov    0x34(%ebx),%eax
80105649:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010564c:	e8 7f e0 ff ff       	call   801036d0 <myproc>
80105651:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105654:	e8 77 e0 ff ff       	call   801036d0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105659:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010565c:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105660:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105663:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105666:	89 7c 24 14          	mov    %edi,0x14(%esp)
8010566a:	89 54 24 18          	mov    %edx,0x18(%esp)
8010566e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80105671:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105674:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105678:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010567c:	89 54 24 10          	mov    %edx,0x10(%esp)
80105680:	8b 40 10             	mov    0x10(%eax),%eax
80105683:	c7 04 24 64 75 10 80 	movl   $0x80107564,(%esp)
8010568a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010568e:	e8 bd af ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105693:	e8 38 e0 ff ff       	call   801036d0 <myproc>
80105698:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010569f:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801056a0:	e8 2b e0 ff ff       	call   801036d0 <myproc>
801056a5:	85 c0                	test   %eax,%eax
801056a7:	74 0c                	je     801056b5 <trap+0xc5>
801056a9:	e8 22 e0 ff ff       	call   801036d0 <myproc>
801056ae:	8b 50 24             	mov    0x24(%eax),%edx
801056b1:	85 d2                	test   %edx,%edx
801056b3:	75 4b                	jne    80105700 <trap+0x110>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801056b5:	e8 16 e0 ff ff       	call   801036d0 <myproc>
801056ba:	85 c0                	test   %eax,%eax
801056bc:	74 0d                	je     801056cb <trap+0xdb>
801056be:	66 90                	xchg   %ax,%ax
801056c0:	e8 0b e0 ff ff       	call   801036d0 <myproc>
801056c5:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801056c9:	74 4d                	je     80105718 <trap+0x128>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801056cb:	e8 00 e0 ff ff       	call   801036d0 <myproc>
801056d0:	85 c0                	test   %eax,%eax
801056d2:	74 1d                	je     801056f1 <trap+0x101>
801056d4:	e8 f7 df ff ff       	call   801036d0 <myproc>
801056d9:	8b 40 24             	mov    0x24(%eax),%eax
801056dc:	85 c0                	test   %eax,%eax
801056de:	74 11                	je     801056f1 <trap+0x101>
801056e0:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801056e4:	83 e0 03             	and    $0x3,%eax
801056e7:	66 83 f8 03          	cmp    $0x3,%ax
801056eb:	0f 84 e8 00 00 00    	je     801057d9 <trap+0x1e9>
    exit();
}
801056f1:	83 c4 3c             	add    $0x3c,%esp
801056f4:	5b                   	pop    %ebx
801056f5:	5e                   	pop    %esi
801056f6:	5f                   	pop    %edi
801056f7:	5d                   	pop    %ebp
801056f8:	c3                   	ret    
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105700:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105704:	83 e0 03             	and    $0x3,%eax
80105707:	66 83 f8 03          	cmp    $0x3,%ax
8010570b:	75 a8                	jne    801056b5 <trap+0xc5>
    exit();
8010570d:	e8 be e3 ff ff       	call   80103ad0 <exit>
80105712:	eb a1                	jmp    801056b5 <trap+0xc5>
80105714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105718:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010571c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105720:	75 a9                	jne    801056cb <trap+0xdb>
    yield();
80105722:	e8 c9 e4 ff ff       	call   80103bf0 <yield>
80105727:	eb a2                	jmp    801056cb <trap+0xdb>
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105730:	e8 7b df ff ff       	call   801036b0 <cpuid>
80105735:	85 c0                	test   %eax,%eax
80105737:	0f 84 b3 00 00 00    	je     801057f0 <trap+0x200>
8010573d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80105740:	e8 6b d0 ff ff       	call   801027b0 <lapiceoi>
    break;
80105745:	e9 56 ff ff ff       	jmp    801056a0 <trap+0xb0>
8010574a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kbdintr();
80105750:	e8 ab ce ff ff       	call   80102600 <kbdintr>
    lapiceoi();
80105755:	e8 56 d0 ff ff       	call   801027b0 <lapiceoi>
    break;
8010575a:	e9 41 ff ff ff       	jmp    801056a0 <trap+0xb0>
8010575f:	90                   	nop
    uartintr();
80105760:	e8 1b 02 00 00       	call   80105980 <uartintr>
    lapiceoi();
80105765:	e8 46 d0 ff ff       	call   801027b0 <lapiceoi>
    break;
8010576a:	e9 31 ff ff ff       	jmp    801056a0 <trap+0xb0>
8010576f:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105770:	8b 7b 38             	mov    0x38(%ebx),%edi
80105773:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105777:	e8 34 df ff ff       	call   801036b0 <cpuid>
8010577c:	c7 04 24 0c 75 10 80 	movl   $0x8010750c,(%esp)
80105783:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105787:	89 74 24 08          	mov    %esi,0x8(%esp)
8010578b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010578f:	e8 bc ae ff ff       	call   80100650 <cprintf>
    lapiceoi();
80105794:	e8 17 d0 ff ff       	call   801027b0 <lapiceoi>
    break;
80105799:	e9 02 ff ff ff       	jmp    801056a0 <trap+0xb0>
8010579e:	66 90                	xchg   %ax,%ax
    ideintr();
801057a0:	e8 0b c9 ff ff       	call   801020b0 <ideintr>
801057a5:	eb 96                	jmp    8010573d <trap+0x14d>
801057a7:	90                   	nop
801057a8:	90                   	nop
801057a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801057b0:	e8 1b df ff ff       	call   801036d0 <myproc>
801057b5:	8b 70 24             	mov    0x24(%eax),%esi
801057b8:	85 f6                	test   %esi,%esi
801057ba:	75 2c                	jne    801057e8 <trap+0x1f8>
    myproc()->tf = tf;
801057bc:	e8 0f df ff ff       	call   801036d0 <myproc>
801057c1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801057c4:	e8 a7 ef ff ff       	call   80104770 <syscall>
    if(myproc()->killed)
801057c9:	e8 02 df ff ff       	call   801036d0 <myproc>
801057ce:	8b 48 24             	mov    0x24(%eax),%ecx
801057d1:	85 c9                	test   %ecx,%ecx
801057d3:	0f 84 18 ff ff ff    	je     801056f1 <trap+0x101>
}
801057d9:	83 c4 3c             	add    $0x3c,%esp
801057dc:	5b                   	pop    %ebx
801057dd:	5e                   	pop    %esi
801057de:	5f                   	pop    %edi
801057df:	5d                   	pop    %ebp
      exit();
801057e0:	e9 eb e2 ff ff       	jmp    80103ad0 <exit>
801057e5:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
801057e8:	e8 e3 e2 ff ff       	call   80103ad0 <exit>
801057ed:	eb cd                	jmp    801057bc <trap+0x1cc>
801057ef:	90                   	nop
      acquire(&tickslock);
801057f0:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
801057f7:	e8 f4 ea ff ff       	call   801042f0 <acquire>
      wakeup(&ticks);
801057fc:	c7 04 24 a0 55 11 80 	movl   $0x801155a0,(%esp)
      ticks++;
80105803:	83 05 a0 55 11 80 01 	addl   $0x1,0x801155a0
      wakeup(&ticks);
8010580a:	e8 b1 e5 ff ff       	call   80103dc0 <wakeup>
      release(&tickslock);
8010580f:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
80105816:	e8 45 eb ff ff       	call   80104360 <release>
8010581b:	e9 1d ff ff ff       	jmp    8010573d <trap+0x14d>
80105820:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105823:	8b 73 38             	mov    0x38(%ebx),%esi
80105826:	e8 85 de ff ff       	call   801036b0 <cpuid>
8010582b:	89 7c 24 10          	mov    %edi,0x10(%esp)
8010582f:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105833:	89 44 24 08          	mov    %eax,0x8(%esp)
80105837:	8b 43 30             	mov    0x30(%ebx),%eax
8010583a:	c7 04 24 30 75 10 80 	movl   $0x80107530,(%esp)
80105841:	89 44 24 04          	mov    %eax,0x4(%esp)
80105845:	e8 06 ae ff ff       	call   80100650 <cprintf>
      panic("trap");
8010584a:	c7 04 24 06 75 10 80 	movl   $0x80107506,(%esp)
80105851:	e8 0a ab ff ff       	call   80100360 <panic>
80105856:	66 90                	xchg   %ax,%ax
80105858:	66 90                	xchg   %ax,%ax
8010585a:	66 90                	xchg   %ax,%ax
8010585c:	66 90                	xchg   %ax,%ax
8010585e:	66 90                	xchg   %ax,%ax

80105860 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105860:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105865:	55                   	push   %ebp
80105866:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105868:	85 c0                	test   %eax,%eax
8010586a:	74 14                	je     80105880 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010586c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105871:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105872:	a8 01                	test   $0x1,%al
80105874:	74 0a                	je     80105880 <uartgetc+0x20>
80105876:	b2 f8                	mov    $0xf8,%dl
80105878:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105879:	0f b6 c0             	movzbl %al,%eax
}
8010587c:	5d                   	pop    %ebp
8010587d:	c3                   	ret    
8010587e:	66 90                	xchg   %ax,%ax
    return -1;
80105880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105885:	5d                   	pop    %ebp
80105886:	c3                   	ret    
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <uartputc>:
  if(!uart)
80105890:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105895:	85 c0                	test   %eax,%eax
80105897:	74 3f                	je     801058d8 <uartputc+0x48>
{
80105899:	55                   	push   %ebp
8010589a:	89 e5                	mov    %esp,%ebp
8010589c:	56                   	push   %esi
8010589d:	be fd 03 00 00       	mov    $0x3fd,%esi
801058a2:	53                   	push   %ebx
  if(!uart)
801058a3:	bb 80 00 00 00       	mov    $0x80,%ebx
{
801058a8:	83 ec 10             	sub    $0x10,%esp
801058ab:	eb 14                	jmp    801058c1 <uartputc+0x31>
801058ad:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
801058b0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801058b7:	e8 14 cf ff ff       	call   801027d0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801058bc:	83 eb 01             	sub    $0x1,%ebx
801058bf:	74 07                	je     801058c8 <uartputc+0x38>
801058c1:	89 f2                	mov    %esi,%edx
801058c3:	ec                   	in     (%dx),%al
801058c4:	a8 20                	test   $0x20,%al
801058c6:	74 e8                	je     801058b0 <uartputc+0x20>
  outb(COM1+0, c);
801058c8:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801058cc:	ba f8 03 00 00       	mov    $0x3f8,%edx
801058d1:	ee                   	out    %al,(%dx)
}
801058d2:	83 c4 10             	add    $0x10,%esp
801058d5:	5b                   	pop    %ebx
801058d6:	5e                   	pop    %esi
801058d7:	5d                   	pop    %ebp
801058d8:	f3 c3                	repz ret 
801058da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058e0 <uartinit>:
{
801058e0:	55                   	push   %ebp
801058e1:	31 c9                	xor    %ecx,%ecx
801058e3:	89 e5                	mov    %esp,%ebp
801058e5:	89 c8                	mov    %ecx,%eax
801058e7:	57                   	push   %edi
801058e8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801058ed:	56                   	push   %esi
801058ee:	89 fa                	mov    %edi,%edx
801058f0:	53                   	push   %ebx
801058f1:	83 ec 1c             	sub    $0x1c,%esp
801058f4:	ee                   	out    %al,(%dx)
801058f5:	be fb 03 00 00       	mov    $0x3fb,%esi
801058fa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801058ff:	89 f2                	mov    %esi,%edx
80105901:	ee                   	out    %al,(%dx)
80105902:	b8 0c 00 00 00       	mov    $0xc,%eax
80105907:	b2 f8                	mov    $0xf8,%dl
80105909:	ee                   	out    %al,(%dx)
8010590a:	bb f9 03 00 00       	mov    $0x3f9,%ebx
8010590f:	89 c8                	mov    %ecx,%eax
80105911:	89 da                	mov    %ebx,%edx
80105913:	ee                   	out    %al,(%dx)
80105914:	b8 03 00 00 00       	mov    $0x3,%eax
80105919:	89 f2                	mov    %esi,%edx
8010591b:	ee                   	out    %al,(%dx)
8010591c:	b2 fc                	mov    $0xfc,%dl
8010591e:	89 c8                	mov    %ecx,%eax
80105920:	ee                   	out    %al,(%dx)
80105921:	b8 01 00 00 00       	mov    $0x1,%eax
80105926:	89 da                	mov    %ebx,%edx
80105928:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105929:	b2 fd                	mov    $0xfd,%dl
8010592b:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
8010592c:	3c ff                	cmp    $0xff,%al
8010592e:	74 42                	je     80105972 <uartinit+0x92>
  uart = 1;
80105930:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105937:	00 00 00 
8010593a:	89 fa                	mov    %edi,%edx
8010593c:	ec                   	in     (%dx),%al
8010593d:	b2 f8                	mov    $0xf8,%dl
8010593f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105940:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105947:	00 
  for(p="xv6...\n"; *p; p++)
80105948:	bb 28 76 10 80       	mov    $0x80107628,%ebx
  ioapicenable(IRQ_COM1, 0);
8010594d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105954:	e8 87 c9 ff ff       	call   801022e0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80105959:	b8 78 00 00 00       	mov    $0x78,%eax
8010595e:	66 90                	xchg   %ax,%ax
    uartputc(*p);
80105960:	89 04 24             	mov    %eax,(%esp)
  for(p="xv6...\n"; *p; p++)
80105963:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
80105966:	e8 25 ff ff ff       	call   80105890 <uartputc>
  for(p="xv6...\n"; *p; p++)
8010596b:	0f be 03             	movsbl (%ebx),%eax
8010596e:	84 c0                	test   %al,%al
80105970:	75 ee                	jne    80105960 <uartinit+0x80>
}
80105972:	83 c4 1c             	add    $0x1c,%esp
80105975:	5b                   	pop    %ebx
80105976:	5e                   	pop    %esi
80105977:	5f                   	pop    %edi
80105978:	5d                   	pop    %ebp
80105979:	c3                   	ret    
8010597a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105980 <uartintr>:

void
uartintr(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105986:	c7 04 24 60 58 10 80 	movl   $0x80105860,(%esp)
8010598d:	e8 3e ae ff ff       	call   801007d0 <consoleintr>
}
80105992:	c9                   	leave  
80105993:	c3                   	ret    

80105994 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105994:	6a 00                	push   $0x0
  pushl $0
80105996:	6a 00                	push   $0x0
  jmp alltraps
80105998:	e9 60 fb ff ff       	jmp    801054fd <alltraps>

8010599d <vector1>:
.globl vector1
vector1:
  pushl $0
8010599d:	6a 00                	push   $0x0
  pushl $1
8010599f:	6a 01                	push   $0x1
  jmp alltraps
801059a1:	e9 57 fb ff ff       	jmp    801054fd <alltraps>

801059a6 <vector2>:
.globl vector2
vector2:
  pushl $0
801059a6:	6a 00                	push   $0x0
  pushl $2
801059a8:	6a 02                	push   $0x2
  jmp alltraps
801059aa:	e9 4e fb ff ff       	jmp    801054fd <alltraps>

801059af <vector3>:
.globl vector3
vector3:
  pushl $0
801059af:	6a 00                	push   $0x0
  pushl $3
801059b1:	6a 03                	push   $0x3
  jmp alltraps
801059b3:	e9 45 fb ff ff       	jmp    801054fd <alltraps>

801059b8 <vector4>:
.globl vector4
vector4:
  pushl $0
801059b8:	6a 00                	push   $0x0
  pushl $4
801059ba:	6a 04                	push   $0x4
  jmp alltraps
801059bc:	e9 3c fb ff ff       	jmp    801054fd <alltraps>

801059c1 <vector5>:
.globl vector5
vector5:
  pushl $0
801059c1:	6a 00                	push   $0x0
  pushl $5
801059c3:	6a 05                	push   $0x5
  jmp alltraps
801059c5:	e9 33 fb ff ff       	jmp    801054fd <alltraps>

801059ca <vector6>:
.globl vector6
vector6:
  pushl $0
801059ca:	6a 00                	push   $0x0
  pushl $6
801059cc:	6a 06                	push   $0x6
  jmp alltraps
801059ce:	e9 2a fb ff ff       	jmp    801054fd <alltraps>

801059d3 <vector7>:
.globl vector7
vector7:
  pushl $0
801059d3:	6a 00                	push   $0x0
  pushl $7
801059d5:	6a 07                	push   $0x7
  jmp alltraps
801059d7:	e9 21 fb ff ff       	jmp    801054fd <alltraps>

801059dc <vector8>:
.globl vector8
vector8:
  pushl $8
801059dc:	6a 08                	push   $0x8
  jmp alltraps
801059de:	e9 1a fb ff ff       	jmp    801054fd <alltraps>

801059e3 <vector9>:
.globl vector9
vector9:
  pushl $0
801059e3:	6a 00                	push   $0x0
  pushl $9
801059e5:	6a 09                	push   $0x9
  jmp alltraps
801059e7:	e9 11 fb ff ff       	jmp    801054fd <alltraps>

801059ec <vector10>:
.globl vector10
vector10:
  pushl $10
801059ec:	6a 0a                	push   $0xa
  jmp alltraps
801059ee:	e9 0a fb ff ff       	jmp    801054fd <alltraps>

801059f3 <vector11>:
.globl vector11
vector11:
  pushl $11
801059f3:	6a 0b                	push   $0xb
  jmp alltraps
801059f5:	e9 03 fb ff ff       	jmp    801054fd <alltraps>

801059fa <vector12>:
.globl vector12
vector12:
  pushl $12
801059fa:	6a 0c                	push   $0xc
  jmp alltraps
801059fc:	e9 fc fa ff ff       	jmp    801054fd <alltraps>

80105a01 <vector13>:
.globl vector13
vector13:
  pushl $13
80105a01:	6a 0d                	push   $0xd
  jmp alltraps
80105a03:	e9 f5 fa ff ff       	jmp    801054fd <alltraps>

80105a08 <vector14>:
.globl vector14
vector14:
  pushl $14
80105a08:	6a 0e                	push   $0xe
  jmp alltraps
80105a0a:	e9 ee fa ff ff       	jmp    801054fd <alltraps>

80105a0f <vector15>:
.globl vector15
vector15:
  pushl $0
80105a0f:	6a 00                	push   $0x0
  pushl $15
80105a11:	6a 0f                	push   $0xf
  jmp alltraps
80105a13:	e9 e5 fa ff ff       	jmp    801054fd <alltraps>

80105a18 <vector16>:
.globl vector16
vector16:
  pushl $0
80105a18:	6a 00                	push   $0x0
  pushl $16
80105a1a:	6a 10                	push   $0x10
  jmp alltraps
80105a1c:	e9 dc fa ff ff       	jmp    801054fd <alltraps>

80105a21 <vector17>:
.globl vector17
vector17:
  pushl $17
80105a21:	6a 11                	push   $0x11
  jmp alltraps
80105a23:	e9 d5 fa ff ff       	jmp    801054fd <alltraps>

80105a28 <vector18>:
.globl vector18
vector18:
  pushl $0
80105a28:	6a 00                	push   $0x0
  pushl $18
80105a2a:	6a 12                	push   $0x12
  jmp alltraps
80105a2c:	e9 cc fa ff ff       	jmp    801054fd <alltraps>

80105a31 <vector19>:
.globl vector19
vector19:
  pushl $0
80105a31:	6a 00                	push   $0x0
  pushl $19
80105a33:	6a 13                	push   $0x13
  jmp alltraps
80105a35:	e9 c3 fa ff ff       	jmp    801054fd <alltraps>

80105a3a <vector20>:
.globl vector20
vector20:
  pushl $0
80105a3a:	6a 00                	push   $0x0
  pushl $20
80105a3c:	6a 14                	push   $0x14
  jmp alltraps
80105a3e:	e9 ba fa ff ff       	jmp    801054fd <alltraps>

80105a43 <vector21>:
.globl vector21
vector21:
  pushl $0
80105a43:	6a 00                	push   $0x0
  pushl $21
80105a45:	6a 15                	push   $0x15
  jmp alltraps
80105a47:	e9 b1 fa ff ff       	jmp    801054fd <alltraps>

80105a4c <vector22>:
.globl vector22
vector22:
  pushl $0
80105a4c:	6a 00                	push   $0x0
  pushl $22
80105a4e:	6a 16                	push   $0x16
  jmp alltraps
80105a50:	e9 a8 fa ff ff       	jmp    801054fd <alltraps>

80105a55 <vector23>:
.globl vector23
vector23:
  pushl $0
80105a55:	6a 00                	push   $0x0
  pushl $23
80105a57:	6a 17                	push   $0x17
  jmp alltraps
80105a59:	e9 9f fa ff ff       	jmp    801054fd <alltraps>

80105a5e <vector24>:
.globl vector24
vector24:
  pushl $0
80105a5e:	6a 00                	push   $0x0
  pushl $24
80105a60:	6a 18                	push   $0x18
  jmp alltraps
80105a62:	e9 96 fa ff ff       	jmp    801054fd <alltraps>

80105a67 <vector25>:
.globl vector25
vector25:
  pushl $0
80105a67:	6a 00                	push   $0x0
  pushl $25
80105a69:	6a 19                	push   $0x19
  jmp alltraps
80105a6b:	e9 8d fa ff ff       	jmp    801054fd <alltraps>

80105a70 <vector26>:
.globl vector26
vector26:
  pushl $0
80105a70:	6a 00                	push   $0x0
  pushl $26
80105a72:	6a 1a                	push   $0x1a
  jmp alltraps
80105a74:	e9 84 fa ff ff       	jmp    801054fd <alltraps>

80105a79 <vector27>:
.globl vector27
vector27:
  pushl $0
80105a79:	6a 00                	push   $0x0
  pushl $27
80105a7b:	6a 1b                	push   $0x1b
  jmp alltraps
80105a7d:	e9 7b fa ff ff       	jmp    801054fd <alltraps>

80105a82 <vector28>:
.globl vector28
vector28:
  pushl $0
80105a82:	6a 00                	push   $0x0
  pushl $28
80105a84:	6a 1c                	push   $0x1c
  jmp alltraps
80105a86:	e9 72 fa ff ff       	jmp    801054fd <alltraps>

80105a8b <vector29>:
.globl vector29
vector29:
  pushl $0
80105a8b:	6a 00                	push   $0x0
  pushl $29
80105a8d:	6a 1d                	push   $0x1d
  jmp alltraps
80105a8f:	e9 69 fa ff ff       	jmp    801054fd <alltraps>

80105a94 <vector30>:
.globl vector30
vector30:
  pushl $0
80105a94:	6a 00                	push   $0x0
  pushl $30
80105a96:	6a 1e                	push   $0x1e
  jmp alltraps
80105a98:	e9 60 fa ff ff       	jmp    801054fd <alltraps>

80105a9d <vector31>:
.globl vector31
vector31:
  pushl $0
80105a9d:	6a 00                	push   $0x0
  pushl $31
80105a9f:	6a 1f                	push   $0x1f
  jmp alltraps
80105aa1:	e9 57 fa ff ff       	jmp    801054fd <alltraps>

80105aa6 <vector32>:
.globl vector32
vector32:
  pushl $0
80105aa6:	6a 00                	push   $0x0
  pushl $32
80105aa8:	6a 20                	push   $0x20
  jmp alltraps
80105aaa:	e9 4e fa ff ff       	jmp    801054fd <alltraps>

80105aaf <vector33>:
.globl vector33
vector33:
  pushl $0
80105aaf:	6a 00                	push   $0x0
  pushl $33
80105ab1:	6a 21                	push   $0x21
  jmp alltraps
80105ab3:	e9 45 fa ff ff       	jmp    801054fd <alltraps>

80105ab8 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ab8:	6a 00                	push   $0x0
  pushl $34
80105aba:	6a 22                	push   $0x22
  jmp alltraps
80105abc:	e9 3c fa ff ff       	jmp    801054fd <alltraps>

80105ac1 <vector35>:
.globl vector35
vector35:
  pushl $0
80105ac1:	6a 00                	push   $0x0
  pushl $35
80105ac3:	6a 23                	push   $0x23
  jmp alltraps
80105ac5:	e9 33 fa ff ff       	jmp    801054fd <alltraps>

80105aca <vector36>:
.globl vector36
vector36:
  pushl $0
80105aca:	6a 00                	push   $0x0
  pushl $36
80105acc:	6a 24                	push   $0x24
  jmp alltraps
80105ace:	e9 2a fa ff ff       	jmp    801054fd <alltraps>

80105ad3 <vector37>:
.globl vector37
vector37:
  pushl $0
80105ad3:	6a 00                	push   $0x0
  pushl $37
80105ad5:	6a 25                	push   $0x25
  jmp alltraps
80105ad7:	e9 21 fa ff ff       	jmp    801054fd <alltraps>

80105adc <vector38>:
.globl vector38
vector38:
  pushl $0
80105adc:	6a 00                	push   $0x0
  pushl $38
80105ade:	6a 26                	push   $0x26
  jmp alltraps
80105ae0:	e9 18 fa ff ff       	jmp    801054fd <alltraps>

80105ae5 <vector39>:
.globl vector39
vector39:
  pushl $0
80105ae5:	6a 00                	push   $0x0
  pushl $39
80105ae7:	6a 27                	push   $0x27
  jmp alltraps
80105ae9:	e9 0f fa ff ff       	jmp    801054fd <alltraps>

80105aee <vector40>:
.globl vector40
vector40:
  pushl $0
80105aee:	6a 00                	push   $0x0
  pushl $40
80105af0:	6a 28                	push   $0x28
  jmp alltraps
80105af2:	e9 06 fa ff ff       	jmp    801054fd <alltraps>

80105af7 <vector41>:
.globl vector41
vector41:
  pushl $0
80105af7:	6a 00                	push   $0x0
  pushl $41
80105af9:	6a 29                	push   $0x29
  jmp alltraps
80105afb:	e9 fd f9 ff ff       	jmp    801054fd <alltraps>

80105b00 <vector42>:
.globl vector42
vector42:
  pushl $0
80105b00:	6a 00                	push   $0x0
  pushl $42
80105b02:	6a 2a                	push   $0x2a
  jmp alltraps
80105b04:	e9 f4 f9 ff ff       	jmp    801054fd <alltraps>

80105b09 <vector43>:
.globl vector43
vector43:
  pushl $0
80105b09:	6a 00                	push   $0x0
  pushl $43
80105b0b:	6a 2b                	push   $0x2b
  jmp alltraps
80105b0d:	e9 eb f9 ff ff       	jmp    801054fd <alltraps>

80105b12 <vector44>:
.globl vector44
vector44:
  pushl $0
80105b12:	6a 00                	push   $0x0
  pushl $44
80105b14:	6a 2c                	push   $0x2c
  jmp alltraps
80105b16:	e9 e2 f9 ff ff       	jmp    801054fd <alltraps>

80105b1b <vector45>:
.globl vector45
vector45:
  pushl $0
80105b1b:	6a 00                	push   $0x0
  pushl $45
80105b1d:	6a 2d                	push   $0x2d
  jmp alltraps
80105b1f:	e9 d9 f9 ff ff       	jmp    801054fd <alltraps>

80105b24 <vector46>:
.globl vector46
vector46:
  pushl $0
80105b24:	6a 00                	push   $0x0
  pushl $46
80105b26:	6a 2e                	push   $0x2e
  jmp alltraps
80105b28:	e9 d0 f9 ff ff       	jmp    801054fd <alltraps>

80105b2d <vector47>:
.globl vector47
vector47:
  pushl $0
80105b2d:	6a 00                	push   $0x0
  pushl $47
80105b2f:	6a 2f                	push   $0x2f
  jmp alltraps
80105b31:	e9 c7 f9 ff ff       	jmp    801054fd <alltraps>

80105b36 <vector48>:
.globl vector48
vector48:
  pushl $0
80105b36:	6a 00                	push   $0x0
  pushl $48
80105b38:	6a 30                	push   $0x30
  jmp alltraps
80105b3a:	e9 be f9 ff ff       	jmp    801054fd <alltraps>

80105b3f <vector49>:
.globl vector49
vector49:
  pushl $0
80105b3f:	6a 00                	push   $0x0
  pushl $49
80105b41:	6a 31                	push   $0x31
  jmp alltraps
80105b43:	e9 b5 f9 ff ff       	jmp    801054fd <alltraps>

80105b48 <vector50>:
.globl vector50
vector50:
  pushl $0
80105b48:	6a 00                	push   $0x0
  pushl $50
80105b4a:	6a 32                	push   $0x32
  jmp alltraps
80105b4c:	e9 ac f9 ff ff       	jmp    801054fd <alltraps>

80105b51 <vector51>:
.globl vector51
vector51:
  pushl $0
80105b51:	6a 00                	push   $0x0
  pushl $51
80105b53:	6a 33                	push   $0x33
  jmp alltraps
80105b55:	e9 a3 f9 ff ff       	jmp    801054fd <alltraps>

80105b5a <vector52>:
.globl vector52
vector52:
  pushl $0
80105b5a:	6a 00                	push   $0x0
  pushl $52
80105b5c:	6a 34                	push   $0x34
  jmp alltraps
80105b5e:	e9 9a f9 ff ff       	jmp    801054fd <alltraps>

80105b63 <vector53>:
.globl vector53
vector53:
  pushl $0
80105b63:	6a 00                	push   $0x0
  pushl $53
80105b65:	6a 35                	push   $0x35
  jmp alltraps
80105b67:	e9 91 f9 ff ff       	jmp    801054fd <alltraps>

80105b6c <vector54>:
.globl vector54
vector54:
  pushl $0
80105b6c:	6a 00                	push   $0x0
  pushl $54
80105b6e:	6a 36                	push   $0x36
  jmp alltraps
80105b70:	e9 88 f9 ff ff       	jmp    801054fd <alltraps>

80105b75 <vector55>:
.globl vector55
vector55:
  pushl $0
80105b75:	6a 00                	push   $0x0
  pushl $55
80105b77:	6a 37                	push   $0x37
  jmp alltraps
80105b79:	e9 7f f9 ff ff       	jmp    801054fd <alltraps>

80105b7e <vector56>:
.globl vector56
vector56:
  pushl $0
80105b7e:	6a 00                	push   $0x0
  pushl $56
80105b80:	6a 38                	push   $0x38
  jmp alltraps
80105b82:	e9 76 f9 ff ff       	jmp    801054fd <alltraps>

80105b87 <vector57>:
.globl vector57
vector57:
  pushl $0
80105b87:	6a 00                	push   $0x0
  pushl $57
80105b89:	6a 39                	push   $0x39
  jmp alltraps
80105b8b:	e9 6d f9 ff ff       	jmp    801054fd <alltraps>

80105b90 <vector58>:
.globl vector58
vector58:
  pushl $0
80105b90:	6a 00                	push   $0x0
  pushl $58
80105b92:	6a 3a                	push   $0x3a
  jmp alltraps
80105b94:	e9 64 f9 ff ff       	jmp    801054fd <alltraps>

80105b99 <vector59>:
.globl vector59
vector59:
  pushl $0
80105b99:	6a 00                	push   $0x0
  pushl $59
80105b9b:	6a 3b                	push   $0x3b
  jmp alltraps
80105b9d:	e9 5b f9 ff ff       	jmp    801054fd <alltraps>

80105ba2 <vector60>:
.globl vector60
vector60:
  pushl $0
80105ba2:	6a 00                	push   $0x0
  pushl $60
80105ba4:	6a 3c                	push   $0x3c
  jmp alltraps
80105ba6:	e9 52 f9 ff ff       	jmp    801054fd <alltraps>

80105bab <vector61>:
.globl vector61
vector61:
  pushl $0
80105bab:	6a 00                	push   $0x0
  pushl $61
80105bad:	6a 3d                	push   $0x3d
  jmp alltraps
80105baf:	e9 49 f9 ff ff       	jmp    801054fd <alltraps>

80105bb4 <vector62>:
.globl vector62
vector62:
  pushl $0
80105bb4:	6a 00                	push   $0x0
  pushl $62
80105bb6:	6a 3e                	push   $0x3e
  jmp alltraps
80105bb8:	e9 40 f9 ff ff       	jmp    801054fd <alltraps>

80105bbd <vector63>:
.globl vector63
vector63:
  pushl $0
80105bbd:	6a 00                	push   $0x0
  pushl $63
80105bbf:	6a 3f                	push   $0x3f
  jmp alltraps
80105bc1:	e9 37 f9 ff ff       	jmp    801054fd <alltraps>

80105bc6 <vector64>:
.globl vector64
vector64:
  pushl $0
80105bc6:	6a 00                	push   $0x0
  pushl $64
80105bc8:	6a 40                	push   $0x40
  jmp alltraps
80105bca:	e9 2e f9 ff ff       	jmp    801054fd <alltraps>

80105bcf <vector65>:
.globl vector65
vector65:
  pushl $0
80105bcf:	6a 00                	push   $0x0
  pushl $65
80105bd1:	6a 41                	push   $0x41
  jmp alltraps
80105bd3:	e9 25 f9 ff ff       	jmp    801054fd <alltraps>

80105bd8 <vector66>:
.globl vector66
vector66:
  pushl $0
80105bd8:	6a 00                	push   $0x0
  pushl $66
80105bda:	6a 42                	push   $0x42
  jmp alltraps
80105bdc:	e9 1c f9 ff ff       	jmp    801054fd <alltraps>

80105be1 <vector67>:
.globl vector67
vector67:
  pushl $0
80105be1:	6a 00                	push   $0x0
  pushl $67
80105be3:	6a 43                	push   $0x43
  jmp alltraps
80105be5:	e9 13 f9 ff ff       	jmp    801054fd <alltraps>

80105bea <vector68>:
.globl vector68
vector68:
  pushl $0
80105bea:	6a 00                	push   $0x0
  pushl $68
80105bec:	6a 44                	push   $0x44
  jmp alltraps
80105bee:	e9 0a f9 ff ff       	jmp    801054fd <alltraps>

80105bf3 <vector69>:
.globl vector69
vector69:
  pushl $0
80105bf3:	6a 00                	push   $0x0
  pushl $69
80105bf5:	6a 45                	push   $0x45
  jmp alltraps
80105bf7:	e9 01 f9 ff ff       	jmp    801054fd <alltraps>

80105bfc <vector70>:
.globl vector70
vector70:
  pushl $0
80105bfc:	6a 00                	push   $0x0
  pushl $70
80105bfe:	6a 46                	push   $0x46
  jmp alltraps
80105c00:	e9 f8 f8 ff ff       	jmp    801054fd <alltraps>

80105c05 <vector71>:
.globl vector71
vector71:
  pushl $0
80105c05:	6a 00                	push   $0x0
  pushl $71
80105c07:	6a 47                	push   $0x47
  jmp alltraps
80105c09:	e9 ef f8 ff ff       	jmp    801054fd <alltraps>

80105c0e <vector72>:
.globl vector72
vector72:
  pushl $0
80105c0e:	6a 00                	push   $0x0
  pushl $72
80105c10:	6a 48                	push   $0x48
  jmp alltraps
80105c12:	e9 e6 f8 ff ff       	jmp    801054fd <alltraps>

80105c17 <vector73>:
.globl vector73
vector73:
  pushl $0
80105c17:	6a 00                	push   $0x0
  pushl $73
80105c19:	6a 49                	push   $0x49
  jmp alltraps
80105c1b:	e9 dd f8 ff ff       	jmp    801054fd <alltraps>

80105c20 <vector74>:
.globl vector74
vector74:
  pushl $0
80105c20:	6a 00                	push   $0x0
  pushl $74
80105c22:	6a 4a                	push   $0x4a
  jmp alltraps
80105c24:	e9 d4 f8 ff ff       	jmp    801054fd <alltraps>

80105c29 <vector75>:
.globl vector75
vector75:
  pushl $0
80105c29:	6a 00                	push   $0x0
  pushl $75
80105c2b:	6a 4b                	push   $0x4b
  jmp alltraps
80105c2d:	e9 cb f8 ff ff       	jmp    801054fd <alltraps>

80105c32 <vector76>:
.globl vector76
vector76:
  pushl $0
80105c32:	6a 00                	push   $0x0
  pushl $76
80105c34:	6a 4c                	push   $0x4c
  jmp alltraps
80105c36:	e9 c2 f8 ff ff       	jmp    801054fd <alltraps>

80105c3b <vector77>:
.globl vector77
vector77:
  pushl $0
80105c3b:	6a 00                	push   $0x0
  pushl $77
80105c3d:	6a 4d                	push   $0x4d
  jmp alltraps
80105c3f:	e9 b9 f8 ff ff       	jmp    801054fd <alltraps>

80105c44 <vector78>:
.globl vector78
vector78:
  pushl $0
80105c44:	6a 00                	push   $0x0
  pushl $78
80105c46:	6a 4e                	push   $0x4e
  jmp alltraps
80105c48:	e9 b0 f8 ff ff       	jmp    801054fd <alltraps>

80105c4d <vector79>:
.globl vector79
vector79:
  pushl $0
80105c4d:	6a 00                	push   $0x0
  pushl $79
80105c4f:	6a 4f                	push   $0x4f
  jmp alltraps
80105c51:	e9 a7 f8 ff ff       	jmp    801054fd <alltraps>

80105c56 <vector80>:
.globl vector80
vector80:
  pushl $0
80105c56:	6a 00                	push   $0x0
  pushl $80
80105c58:	6a 50                	push   $0x50
  jmp alltraps
80105c5a:	e9 9e f8 ff ff       	jmp    801054fd <alltraps>

80105c5f <vector81>:
.globl vector81
vector81:
  pushl $0
80105c5f:	6a 00                	push   $0x0
  pushl $81
80105c61:	6a 51                	push   $0x51
  jmp alltraps
80105c63:	e9 95 f8 ff ff       	jmp    801054fd <alltraps>

80105c68 <vector82>:
.globl vector82
vector82:
  pushl $0
80105c68:	6a 00                	push   $0x0
  pushl $82
80105c6a:	6a 52                	push   $0x52
  jmp alltraps
80105c6c:	e9 8c f8 ff ff       	jmp    801054fd <alltraps>

80105c71 <vector83>:
.globl vector83
vector83:
  pushl $0
80105c71:	6a 00                	push   $0x0
  pushl $83
80105c73:	6a 53                	push   $0x53
  jmp alltraps
80105c75:	e9 83 f8 ff ff       	jmp    801054fd <alltraps>

80105c7a <vector84>:
.globl vector84
vector84:
  pushl $0
80105c7a:	6a 00                	push   $0x0
  pushl $84
80105c7c:	6a 54                	push   $0x54
  jmp alltraps
80105c7e:	e9 7a f8 ff ff       	jmp    801054fd <alltraps>

80105c83 <vector85>:
.globl vector85
vector85:
  pushl $0
80105c83:	6a 00                	push   $0x0
  pushl $85
80105c85:	6a 55                	push   $0x55
  jmp alltraps
80105c87:	e9 71 f8 ff ff       	jmp    801054fd <alltraps>

80105c8c <vector86>:
.globl vector86
vector86:
  pushl $0
80105c8c:	6a 00                	push   $0x0
  pushl $86
80105c8e:	6a 56                	push   $0x56
  jmp alltraps
80105c90:	e9 68 f8 ff ff       	jmp    801054fd <alltraps>

80105c95 <vector87>:
.globl vector87
vector87:
  pushl $0
80105c95:	6a 00                	push   $0x0
  pushl $87
80105c97:	6a 57                	push   $0x57
  jmp alltraps
80105c99:	e9 5f f8 ff ff       	jmp    801054fd <alltraps>

80105c9e <vector88>:
.globl vector88
vector88:
  pushl $0
80105c9e:	6a 00                	push   $0x0
  pushl $88
80105ca0:	6a 58                	push   $0x58
  jmp alltraps
80105ca2:	e9 56 f8 ff ff       	jmp    801054fd <alltraps>

80105ca7 <vector89>:
.globl vector89
vector89:
  pushl $0
80105ca7:	6a 00                	push   $0x0
  pushl $89
80105ca9:	6a 59                	push   $0x59
  jmp alltraps
80105cab:	e9 4d f8 ff ff       	jmp    801054fd <alltraps>

80105cb0 <vector90>:
.globl vector90
vector90:
  pushl $0
80105cb0:	6a 00                	push   $0x0
  pushl $90
80105cb2:	6a 5a                	push   $0x5a
  jmp alltraps
80105cb4:	e9 44 f8 ff ff       	jmp    801054fd <alltraps>

80105cb9 <vector91>:
.globl vector91
vector91:
  pushl $0
80105cb9:	6a 00                	push   $0x0
  pushl $91
80105cbb:	6a 5b                	push   $0x5b
  jmp alltraps
80105cbd:	e9 3b f8 ff ff       	jmp    801054fd <alltraps>

80105cc2 <vector92>:
.globl vector92
vector92:
  pushl $0
80105cc2:	6a 00                	push   $0x0
  pushl $92
80105cc4:	6a 5c                	push   $0x5c
  jmp alltraps
80105cc6:	e9 32 f8 ff ff       	jmp    801054fd <alltraps>

80105ccb <vector93>:
.globl vector93
vector93:
  pushl $0
80105ccb:	6a 00                	push   $0x0
  pushl $93
80105ccd:	6a 5d                	push   $0x5d
  jmp alltraps
80105ccf:	e9 29 f8 ff ff       	jmp    801054fd <alltraps>

80105cd4 <vector94>:
.globl vector94
vector94:
  pushl $0
80105cd4:	6a 00                	push   $0x0
  pushl $94
80105cd6:	6a 5e                	push   $0x5e
  jmp alltraps
80105cd8:	e9 20 f8 ff ff       	jmp    801054fd <alltraps>

80105cdd <vector95>:
.globl vector95
vector95:
  pushl $0
80105cdd:	6a 00                	push   $0x0
  pushl $95
80105cdf:	6a 5f                	push   $0x5f
  jmp alltraps
80105ce1:	e9 17 f8 ff ff       	jmp    801054fd <alltraps>

80105ce6 <vector96>:
.globl vector96
vector96:
  pushl $0
80105ce6:	6a 00                	push   $0x0
  pushl $96
80105ce8:	6a 60                	push   $0x60
  jmp alltraps
80105cea:	e9 0e f8 ff ff       	jmp    801054fd <alltraps>

80105cef <vector97>:
.globl vector97
vector97:
  pushl $0
80105cef:	6a 00                	push   $0x0
  pushl $97
80105cf1:	6a 61                	push   $0x61
  jmp alltraps
80105cf3:	e9 05 f8 ff ff       	jmp    801054fd <alltraps>

80105cf8 <vector98>:
.globl vector98
vector98:
  pushl $0
80105cf8:	6a 00                	push   $0x0
  pushl $98
80105cfa:	6a 62                	push   $0x62
  jmp alltraps
80105cfc:	e9 fc f7 ff ff       	jmp    801054fd <alltraps>

80105d01 <vector99>:
.globl vector99
vector99:
  pushl $0
80105d01:	6a 00                	push   $0x0
  pushl $99
80105d03:	6a 63                	push   $0x63
  jmp alltraps
80105d05:	e9 f3 f7 ff ff       	jmp    801054fd <alltraps>

80105d0a <vector100>:
.globl vector100
vector100:
  pushl $0
80105d0a:	6a 00                	push   $0x0
  pushl $100
80105d0c:	6a 64                	push   $0x64
  jmp alltraps
80105d0e:	e9 ea f7 ff ff       	jmp    801054fd <alltraps>

80105d13 <vector101>:
.globl vector101
vector101:
  pushl $0
80105d13:	6a 00                	push   $0x0
  pushl $101
80105d15:	6a 65                	push   $0x65
  jmp alltraps
80105d17:	e9 e1 f7 ff ff       	jmp    801054fd <alltraps>

80105d1c <vector102>:
.globl vector102
vector102:
  pushl $0
80105d1c:	6a 00                	push   $0x0
  pushl $102
80105d1e:	6a 66                	push   $0x66
  jmp alltraps
80105d20:	e9 d8 f7 ff ff       	jmp    801054fd <alltraps>

80105d25 <vector103>:
.globl vector103
vector103:
  pushl $0
80105d25:	6a 00                	push   $0x0
  pushl $103
80105d27:	6a 67                	push   $0x67
  jmp alltraps
80105d29:	e9 cf f7 ff ff       	jmp    801054fd <alltraps>

80105d2e <vector104>:
.globl vector104
vector104:
  pushl $0
80105d2e:	6a 00                	push   $0x0
  pushl $104
80105d30:	6a 68                	push   $0x68
  jmp alltraps
80105d32:	e9 c6 f7 ff ff       	jmp    801054fd <alltraps>

80105d37 <vector105>:
.globl vector105
vector105:
  pushl $0
80105d37:	6a 00                	push   $0x0
  pushl $105
80105d39:	6a 69                	push   $0x69
  jmp alltraps
80105d3b:	e9 bd f7 ff ff       	jmp    801054fd <alltraps>

80105d40 <vector106>:
.globl vector106
vector106:
  pushl $0
80105d40:	6a 00                	push   $0x0
  pushl $106
80105d42:	6a 6a                	push   $0x6a
  jmp alltraps
80105d44:	e9 b4 f7 ff ff       	jmp    801054fd <alltraps>

80105d49 <vector107>:
.globl vector107
vector107:
  pushl $0
80105d49:	6a 00                	push   $0x0
  pushl $107
80105d4b:	6a 6b                	push   $0x6b
  jmp alltraps
80105d4d:	e9 ab f7 ff ff       	jmp    801054fd <alltraps>

80105d52 <vector108>:
.globl vector108
vector108:
  pushl $0
80105d52:	6a 00                	push   $0x0
  pushl $108
80105d54:	6a 6c                	push   $0x6c
  jmp alltraps
80105d56:	e9 a2 f7 ff ff       	jmp    801054fd <alltraps>

80105d5b <vector109>:
.globl vector109
vector109:
  pushl $0
80105d5b:	6a 00                	push   $0x0
  pushl $109
80105d5d:	6a 6d                	push   $0x6d
  jmp alltraps
80105d5f:	e9 99 f7 ff ff       	jmp    801054fd <alltraps>

80105d64 <vector110>:
.globl vector110
vector110:
  pushl $0
80105d64:	6a 00                	push   $0x0
  pushl $110
80105d66:	6a 6e                	push   $0x6e
  jmp alltraps
80105d68:	e9 90 f7 ff ff       	jmp    801054fd <alltraps>

80105d6d <vector111>:
.globl vector111
vector111:
  pushl $0
80105d6d:	6a 00                	push   $0x0
  pushl $111
80105d6f:	6a 6f                	push   $0x6f
  jmp alltraps
80105d71:	e9 87 f7 ff ff       	jmp    801054fd <alltraps>

80105d76 <vector112>:
.globl vector112
vector112:
  pushl $0
80105d76:	6a 00                	push   $0x0
  pushl $112
80105d78:	6a 70                	push   $0x70
  jmp alltraps
80105d7a:	e9 7e f7 ff ff       	jmp    801054fd <alltraps>

80105d7f <vector113>:
.globl vector113
vector113:
  pushl $0
80105d7f:	6a 00                	push   $0x0
  pushl $113
80105d81:	6a 71                	push   $0x71
  jmp alltraps
80105d83:	e9 75 f7 ff ff       	jmp    801054fd <alltraps>

80105d88 <vector114>:
.globl vector114
vector114:
  pushl $0
80105d88:	6a 00                	push   $0x0
  pushl $114
80105d8a:	6a 72                	push   $0x72
  jmp alltraps
80105d8c:	e9 6c f7 ff ff       	jmp    801054fd <alltraps>

80105d91 <vector115>:
.globl vector115
vector115:
  pushl $0
80105d91:	6a 00                	push   $0x0
  pushl $115
80105d93:	6a 73                	push   $0x73
  jmp alltraps
80105d95:	e9 63 f7 ff ff       	jmp    801054fd <alltraps>

80105d9a <vector116>:
.globl vector116
vector116:
  pushl $0
80105d9a:	6a 00                	push   $0x0
  pushl $116
80105d9c:	6a 74                	push   $0x74
  jmp alltraps
80105d9e:	e9 5a f7 ff ff       	jmp    801054fd <alltraps>

80105da3 <vector117>:
.globl vector117
vector117:
  pushl $0
80105da3:	6a 00                	push   $0x0
  pushl $117
80105da5:	6a 75                	push   $0x75
  jmp alltraps
80105da7:	e9 51 f7 ff ff       	jmp    801054fd <alltraps>

80105dac <vector118>:
.globl vector118
vector118:
  pushl $0
80105dac:	6a 00                	push   $0x0
  pushl $118
80105dae:	6a 76                	push   $0x76
  jmp alltraps
80105db0:	e9 48 f7 ff ff       	jmp    801054fd <alltraps>

80105db5 <vector119>:
.globl vector119
vector119:
  pushl $0
80105db5:	6a 00                	push   $0x0
  pushl $119
80105db7:	6a 77                	push   $0x77
  jmp alltraps
80105db9:	e9 3f f7 ff ff       	jmp    801054fd <alltraps>

80105dbe <vector120>:
.globl vector120
vector120:
  pushl $0
80105dbe:	6a 00                	push   $0x0
  pushl $120
80105dc0:	6a 78                	push   $0x78
  jmp alltraps
80105dc2:	e9 36 f7 ff ff       	jmp    801054fd <alltraps>

80105dc7 <vector121>:
.globl vector121
vector121:
  pushl $0
80105dc7:	6a 00                	push   $0x0
  pushl $121
80105dc9:	6a 79                	push   $0x79
  jmp alltraps
80105dcb:	e9 2d f7 ff ff       	jmp    801054fd <alltraps>

80105dd0 <vector122>:
.globl vector122
vector122:
  pushl $0
80105dd0:	6a 00                	push   $0x0
  pushl $122
80105dd2:	6a 7a                	push   $0x7a
  jmp alltraps
80105dd4:	e9 24 f7 ff ff       	jmp    801054fd <alltraps>

80105dd9 <vector123>:
.globl vector123
vector123:
  pushl $0
80105dd9:	6a 00                	push   $0x0
  pushl $123
80105ddb:	6a 7b                	push   $0x7b
  jmp alltraps
80105ddd:	e9 1b f7 ff ff       	jmp    801054fd <alltraps>

80105de2 <vector124>:
.globl vector124
vector124:
  pushl $0
80105de2:	6a 00                	push   $0x0
  pushl $124
80105de4:	6a 7c                	push   $0x7c
  jmp alltraps
80105de6:	e9 12 f7 ff ff       	jmp    801054fd <alltraps>

80105deb <vector125>:
.globl vector125
vector125:
  pushl $0
80105deb:	6a 00                	push   $0x0
  pushl $125
80105ded:	6a 7d                	push   $0x7d
  jmp alltraps
80105def:	e9 09 f7 ff ff       	jmp    801054fd <alltraps>

80105df4 <vector126>:
.globl vector126
vector126:
  pushl $0
80105df4:	6a 00                	push   $0x0
  pushl $126
80105df6:	6a 7e                	push   $0x7e
  jmp alltraps
80105df8:	e9 00 f7 ff ff       	jmp    801054fd <alltraps>

80105dfd <vector127>:
.globl vector127
vector127:
  pushl $0
80105dfd:	6a 00                	push   $0x0
  pushl $127
80105dff:	6a 7f                	push   $0x7f
  jmp alltraps
80105e01:	e9 f7 f6 ff ff       	jmp    801054fd <alltraps>

80105e06 <vector128>:
.globl vector128
vector128:
  pushl $0
80105e06:	6a 00                	push   $0x0
  pushl $128
80105e08:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105e0d:	e9 eb f6 ff ff       	jmp    801054fd <alltraps>

80105e12 <vector129>:
.globl vector129
vector129:
  pushl $0
80105e12:	6a 00                	push   $0x0
  pushl $129
80105e14:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105e19:	e9 df f6 ff ff       	jmp    801054fd <alltraps>

80105e1e <vector130>:
.globl vector130
vector130:
  pushl $0
80105e1e:	6a 00                	push   $0x0
  pushl $130
80105e20:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80105e25:	e9 d3 f6 ff ff       	jmp    801054fd <alltraps>

80105e2a <vector131>:
.globl vector131
vector131:
  pushl $0
80105e2a:	6a 00                	push   $0x0
  pushl $131
80105e2c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105e31:	e9 c7 f6 ff ff       	jmp    801054fd <alltraps>

80105e36 <vector132>:
.globl vector132
vector132:
  pushl $0
80105e36:	6a 00                	push   $0x0
  pushl $132
80105e38:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105e3d:	e9 bb f6 ff ff       	jmp    801054fd <alltraps>

80105e42 <vector133>:
.globl vector133
vector133:
  pushl $0
80105e42:	6a 00                	push   $0x0
  pushl $133
80105e44:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80105e49:	e9 af f6 ff ff       	jmp    801054fd <alltraps>

80105e4e <vector134>:
.globl vector134
vector134:
  pushl $0
80105e4e:	6a 00                	push   $0x0
  pushl $134
80105e50:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80105e55:	e9 a3 f6 ff ff       	jmp    801054fd <alltraps>

80105e5a <vector135>:
.globl vector135
vector135:
  pushl $0
80105e5a:	6a 00                	push   $0x0
  pushl $135
80105e5c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105e61:	e9 97 f6 ff ff       	jmp    801054fd <alltraps>

80105e66 <vector136>:
.globl vector136
vector136:
  pushl $0
80105e66:	6a 00                	push   $0x0
  pushl $136
80105e68:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105e6d:	e9 8b f6 ff ff       	jmp    801054fd <alltraps>

80105e72 <vector137>:
.globl vector137
vector137:
  pushl $0
80105e72:	6a 00                	push   $0x0
  pushl $137
80105e74:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105e79:	e9 7f f6 ff ff       	jmp    801054fd <alltraps>

80105e7e <vector138>:
.globl vector138
vector138:
  pushl $0
80105e7e:	6a 00                	push   $0x0
  pushl $138
80105e80:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105e85:	e9 73 f6 ff ff       	jmp    801054fd <alltraps>

80105e8a <vector139>:
.globl vector139
vector139:
  pushl $0
80105e8a:	6a 00                	push   $0x0
  pushl $139
80105e8c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105e91:	e9 67 f6 ff ff       	jmp    801054fd <alltraps>

80105e96 <vector140>:
.globl vector140
vector140:
  pushl $0
80105e96:	6a 00                	push   $0x0
  pushl $140
80105e98:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80105e9d:	e9 5b f6 ff ff       	jmp    801054fd <alltraps>

80105ea2 <vector141>:
.globl vector141
vector141:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $141
80105ea4:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105ea9:	e9 4f f6 ff ff       	jmp    801054fd <alltraps>

80105eae <vector142>:
.globl vector142
vector142:
  pushl $0
80105eae:	6a 00                	push   $0x0
  pushl $142
80105eb0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80105eb5:	e9 43 f6 ff ff       	jmp    801054fd <alltraps>

80105eba <vector143>:
.globl vector143
vector143:
  pushl $0
80105eba:	6a 00                	push   $0x0
  pushl $143
80105ebc:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105ec1:	e9 37 f6 ff ff       	jmp    801054fd <alltraps>

80105ec6 <vector144>:
.globl vector144
vector144:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $144
80105ec8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80105ecd:	e9 2b f6 ff ff       	jmp    801054fd <alltraps>

80105ed2 <vector145>:
.globl vector145
vector145:
  pushl $0
80105ed2:	6a 00                	push   $0x0
  pushl $145
80105ed4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105ed9:	e9 1f f6 ff ff       	jmp    801054fd <alltraps>

80105ede <vector146>:
.globl vector146
vector146:
  pushl $0
80105ede:	6a 00                	push   $0x0
  pushl $146
80105ee0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80105ee5:	e9 13 f6 ff ff       	jmp    801054fd <alltraps>

80105eea <vector147>:
.globl vector147
vector147:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $147
80105eec:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105ef1:	e9 07 f6 ff ff       	jmp    801054fd <alltraps>

80105ef6 <vector148>:
.globl vector148
vector148:
  pushl $0
80105ef6:	6a 00                	push   $0x0
  pushl $148
80105ef8:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80105efd:	e9 fb f5 ff ff       	jmp    801054fd <alltraps>

80105f02 <vector149>:
.globl vector149
vector149:
  pushl $0
80105f02:	6a 00                	push   $0x0
  pushl $149
80105f04:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80105f09:	e9 ef f5 ff ff       	jmp    801054fd <alltraps>

80105f0e <vector150>:
.globl vector150
vector150:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $150
80105f10:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80105f15:	e9 e3 f5 ff ff       	jmp    801054fd <alltraps>

80105f1a <vector151>:
.globl vector151
vector151:
  pushl $0
80105f1a:	6a 00                	push   $0x0
  pushl $151
80105f1c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80105f21:	e9 d7 f5 ff ff       	jmp    801054fd <alltraps>

80105f26 <vector152>:
.globl vector152
vector152:
  pushl $0
80105f26:	6a 00                	push   $0x0
  pushl $152
80105f28:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105f2d:	e9 cb f5 ff ff       	jmp    801054fd <alltraps>

80105f32 <vector153>:
.globl vector153
vector153:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $153
80105f34:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105f39:	e9 bf f5 ff ff       	jmp    801054fd <alltraps>

80105f3e <vector154>:
.globl vector154
vector154:
  pushl $0
80105f3e:	6a 00                	push   $0x0
  pushl $154
80105f40:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80105f45:	e9 b3 f5 ff ff       	jmp    801054fd <alltraps>

80105f4a <vector155>:
.globl vector155
vector155:
  pushl $0
80105f4a:	6a 00                	push   $0x0
  pushl $155
80105f4c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80105f51:	e9 a7 f5 ff ff       	jmp    801054fd <alltraps>

80105f56 <vector156>:
.globl vector156
vector156:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $156
80105f58:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80105f5d:	e9 9b f5 ff ff       	jmp    801054fd <alltraps>

80105f62 <vector157>:
.globl vector157
vector157:
  pushl $0
80105f62:	6a 00                	push   $0x0
  pushl $157
80105f64:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80105f69:	e9 8f f5 ff ff       	jmp    801054fd <alltraps>

80105f6e <vector158>:
.globl vector158
vector158:
  pushl $0
80105f6e:	6a 00                	push   $0x0
  pushl $158
80105f70:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80105f75:	e9 83 f5 ff ff       	jmp    801054fd <alltraps>

80105f7a <vector159>:
.globl vector159
vector159:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $159
80105f7c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80105f81:	e9 77 f5 ff ff       	jmp    801054fd <alltraps>

80105f86 <vector160>:
.globl vector160
vector160:
  pushl $0
80105f86:	6a 00                	push   $0x0
  pushl $160
80105f88:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80105f8d:	e9 6b f5 ff ff       	jmp    801054fd <alltraps>

80105f92 <vector161>:
.globl vector161
vector161:
  pushl $0
80105f92:	6a 00                	push   $0x0
  pushl $161
80105f94:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80105f99:	e9 5f f5 ff ff       	jmp    801054fd <alltraps>

80105f9e <vector162>:
.globl vector162
vector162:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $162
80105fa0:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80105fa5:	e9 53 f5 ff ff       	jmp    801054fd <alltraps>

80105faa <vector163>:
.globl vector163
vector163:
  pushl $0
80105faa:	6a 00                	push   $0x0
  pushl $163
80105fac:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80105fb1:	e9 47 f5 ff ff       	jmp    801054fd <alltraps>

80105fb6 <vector164>:
.globl vector164
vector164:
  pushl $0
80105fb6:	6a 00                	push   $0x0
  pushl $164
80105fb8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80105fbd:	e9 3b f5 ff ff       	jmp    801054fd <alltraps>

80105fc2 <vector165>:
.globl vector165
vector165:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $165
80105fc4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80105fc9:	e9 2f f5 ff ff       	jmp    801054fd <alltraps>

80105fce <vector166>:
.globl vector166
vector166:
  pushl $0
80105fce:	6a 00                	push   $0x0
  pushl $166
80105fd0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80105fd5:	e9 23 f5 ff ff       	jmp    801054fd <alltraps>

80105fda <vector167>:
.globl vector167
vector167:
  pushl $0
80105fda:	6a 00                	push   $0x0
  pushl $167
80105fdc:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80105fe1:	e9 17 f5 ff ff       	jmp    801054fd <alltraps>

80105fe6 <vector168>:
.globl vector168
vector168:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $168
80105fe8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80105fed:	e9 0b f5 ff ff       	jmp    801054fd <alltraps>

80105ff2 <vector169>:
.globl vector169
vector169:
  pushl $0
80105ff2:	6a 00                	push   $0x0
  pushl $169
80105ff4:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80105ff9:	e9 ff f4 ff ff       	jmp    801054fd <alltraps>

80105ffe <vector170>:
.globl vector170
vector170:
  pushl $0
80105ffe:	6a 00                	push   $0x0
  pushl $170
80106000:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106005:	e9 f3 f4 ff ff       	jmp    801054fd <alltraps>

8010600a <vector171>:
.globl vector171
vector171:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $171
8010600c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106011:	e9 e7 f4 ff ff       	jmp    801054fd <alltraps>

80106016 <vector172>:
.globl vector172
vector172:
  pushl $0
80106016:	6a 00                	push   $0x0
  pushl $172
80106018:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010601d:	e9 db f4 ff ff       	jmp    801054fd <alltraps>

80106022 <vector173>:
.globl vector173
vector173:
  pushl $0
80106022:	6a 00                	push   $0x0
  pushl $173
80106024:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106029:	e9 cf f4 ff ff       	jmp    801054fd <alltraps>

8010602e <vector174>:
.globl vector174
vector174:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $174
80106030:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106035:	e9 c3 f4 ff ff       	jmp    801054fd <alltraps>

8010603a <vector175>:
.globl vector175
vector175:
  pushl $0
8010603a:	6a 00                	push   $0x0
  pushl $175
8010603c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106041:	e9 b7 f4 ff ff       	jmp    801054fd <alltraps>

80106046 <vector176>:
.globl vector176
vector176:
  pushl $0
80106046:	6a 00                	push   $0x0
  pushl $176
80106048:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010604d:	e9 ab f4 ff ff       	jmp    801054fd <alltraps>

80106052 <vector177>:
.globl vector177
vector177:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $177
80106054:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106059:	e9 9f f4 ff ff       	jmp    801054fd <alltraps>

8010605e <vector178>:
.globl vector178
vector178:
  pushl $0
8010605e:	6a 00                	push   $0x0
  pushl $178
80106060:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106065:	e9 93 f4 ff ff       	jmp    801054fd <alltraps>

8010606a <vector179>:
.globl vector179
vector179:
  pushl $0
8010606a:	6a 00                	push   $0x0
  pushl $179
8010606c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106071:	e9 87 f4 ff ff       	jmp    801054fd <alltraps>

80106076 <vector180>:
.globl vector180
vector180:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $180
80106078:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010607d:	e9 7b f4 ff ff       	jmp    801054fd <alltraps>

80106082 <vector181>:
.globl vector181
vector181:
  pushl $0
80106082:	6a 00                	push   $0x0
  pushl $181
80106084:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106089:	e9 6f f4 ff ff       	jmp    801054fd <alltraps>

8010608e <vector182>:
.globl vector182
vector182:
  pushl $0
8010608e:	6a 00                	push   $0x0
  pushl $182
80106090:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106095:	e9 63 f4 ff ff       	jmp    801054fd <alltraps>

8010609a <vector183>:
.globl vector183
vector183:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $183
8010609c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801060a1:	e9 57 f4 ff ff       	jmp    801054fd <alltraps>

801060a6 <vector184>:
.globl vector184
vector184:
  pushl $0
801060a6:	6a 00                	push   $0x0
  pushl $184
801060a8:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801060ad:	e9 4b f4 ff ff       	jmp    801054fd <alltraps>

801060b2 <vector185>:
.globl vector185
vector185:
  pushl $0
801060b2:	6a 00                	push   $0x0
  pushl $185
801060b4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801060b9:	e9 3f f4 ff ff       	jmp    801054fd <alltraps>

801060be <vector186>:
.globl vector186
vector186:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $186
801060c0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801060c5:	e9 33 f4 ff ff       	jmp    801054fd <alltraps>

801060ca <vector187>:
.globl vector187
vector187:
  pushl $0
801060ca:	6a 00                	push   $0x0
  pushl $187
801060cc:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801060d1:	e9 27 f4 ff ff       	jmp    801054fd <alltraps>

801060d6 <vector188>:
.globl vector188
vector188:
  pushl $0
801060d6:	6a 00                	push   $0x0
  pushl $188
801060d8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801060dd:	e9 1b f4 ff ff       	jmp    801054fd <alltraps>

801060e2 <vector189>:
.globl vector189
vector189:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $189
801060e4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801060e9:	e9 0f f4 ff ff       	jmp    801054fd <alltraps>

801060ee <vector190>:
.globl vector190
vector190:
  pushl $0
801060ee:	6a 00                	push   $0x0
  pushl $190
801060f0:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801060f5:	e9 03 f4 ff ff       	jmp    801054fd <alltraps>

801060fa <vector191>:
.globl vector191
vector191:
  pushl $0
801060fa:	6a 00                	push   $0x0
  pushl $191
801060fc:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106101:	e9 f7 f3 ff ff       	jmp    801054fd <alltraps>

80106106 <vector192>:
.globl vector192
vector192:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $192
80106108:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010610d:	e9 eb f3 ff ff       	jmp    801054fd <alltraps>

80106112 <vector193>:
.globl vector193
vector193:
  pushl $0
80106112:	6a 00                	push   $0x0
  pushl $193
80106114:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106119:	e9 df f3 ff ff       	jmp    801054fd <alltraps>

8010611e <vector194>:
.globl vector194
vector194:
  pushl $0
8010611e:	6a 00                	push   $0x0
  pushl $194
80106120:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106125:	e9 d3 f3 ff ff       	jmp    801054fd <alltraps>

8010612a <vector195>:
.globl vector195
vector195:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $195
8010612c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106131:	e9 c7 f3 ff ff       	jmp    801054fd <alltraps>

80106136 <vector196>:
.globl vector196
vector196:
  pushl $0
80106136:	6a 00                	push   $0x0
  pushl $196
80106138:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010613d:	e9 bb f3 ff ff       	jmp    801054fd <alltraps>

80106142 <vector197>:
.globl vector197
vector197:
  pushl $0
80106142:	6a 00                	push   $0x0
  pushl $197
80106144:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106149:	e9 af f3 ff ff       	jmp    801054fd <alltraps>

8010614e <vector198>:
.globl vector198
vector198:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $198
80106150:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106155:	e9 a3 f3 ff ff       	jmp    801054fd <alltraps>

8010615a <vector199>:
.globl vector199
vector199:
  pushl $0
8010615a:	6a 00                	push   $0x0
  pushl $199
8010615c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106161:	e9 97 f3 ff ff       	jmp    801054fd <alltraps>

80106166 <vector200>:
.globl vector200
vector200:
  pushl $0
80106166:	6a 00                	push   $0x0
  pushl $200
80106168:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010616d:	e9 8b f3 ff ff       	jmp    801054fd <alltraps>

80106172 <vector201>:
.globl vector201
vector201:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $201
80106174:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106179:	e9 7f f3 ff ff       	jmp    801054fd <alltraps>

8010617e <vector202>:
.globl vector202
vector202:
  pushl $0
8010617e:	6a 00                	push   $0x0
  pushl $202
80106180:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106185:	e9 73 f3 ff ff       	jmp    801054fd <alltraps>

8010618a <vector203>:
.globl vector203
vector203:
  pushl $0
8010618a:	6a 00                	push   $0x0
  pushl $203
8010618c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106191:	e9 67 f3 ff ff       	jmp    801054fd <alltraps>

80106196 <vector204>:
.globl vector204
vector204:
  pushl $0
80106196:	6a 00                	push   $0x0
  pushl $204
80106198:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010619d:	e9 5b f3 ff ff       	jmp    801054fd <alltraps>

801061a2 <vector205>:
.globl vector205
vector205:
  pushl $0
801061a2:	6a 00                	push   $0x0
  pushl $205
801061a4:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801061a9:	e9 4f f3 ff ff       	jmp    801054fd <alltraps>

801061ae <vector206>:
.globl vector206
vector206:
  pushl $0
801061ae:	6a 00                	push   $0x0
  pushl $206
801061b0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801061b5:	e9 43 f3 ff ff       	jmp    801054fd <alltraps>

801061ba <vector207>:
.globl vector207
vector207:
  pushl $0
801061ba:	6a 00                	push   $0x0
  pushl $207
801061bc:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801061c1:	e9 37 f3 ff ff       	jmp    801054fd <alltraps>

801061c6 <vector208>:
.globl vector208
vector208:
  pushl $0
801061c6:	6a 00                	push   $0x0
  pushl $208
801061c8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801061cd:	e9 2b f3 ff ff       	jmp    801054fd <alltraps>

801061d2 <vector209>:
.globl vector209
vector209:
  pushl $0
801061d2:	6a 00                	push   $0x0
  pushl $209
801061d4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801061d9:	e9 1f f3 ff ff       	jmp    801054fd <alltraps>

801061de <vector210>:
.globl vector210
vector210:
  pushl $0
801061de:	6a 00                	push   $0x0
  pushl $210
801061e0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801061e5:	e9 13 f3 ff ff       	jmp    801054fd <alltraps>

801061ea <vector211>:
.globl vector211
vector211:
  pushl $0
801061ea:	6a 00                	push   $0x0
  pushl $211
801061ec:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801061f1:	e9 07 f3 ff ff       	jmp    801054fd <alltraps>

801061f6 <vector212>:
.globl vector212
vector212:
  pushl $0
801061f6:	6a 00                	push   $0x0
  pushl $212
801061f8:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801061fd:	e9 fb f2 ff ff       	jmp    801054fd <alltraps>

80106202 <vector213>:
.globl vector213
vector213:
  pushl $0
80106202:	6a 00                	push   $0x0
  pushl $213
80106204:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106209:	e9 ef f2 ff ff       	jmp    801054fd <alltraps>

8010620e <vector214>:
.globl vector214
vector214:
  pushl $0
8010620e:	6a 00                	push   $0x0
  pushl $214
80106210:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106215:	e9 e3 f2 ff ff       	jmp    801054fd <alltraps>

8010621a <vector215>:
.globl vector215
vector215:
  pushl $0
8010621a:	6a 00                	push   $0x0
  pushl $215
8010621c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106221:	e9 d7 f2 ff ff       	jmp    801054fd <alltraps>

80106226 <vector216>:
.globl vector216
vector216:
  pushl $0
80106226:	6a 00                	push   $0x0
  pushl $216
80106228:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010622d:	e9 cb f2 ff ff       	jmp    801054fd <alltraps>

80106232 <vector217>:
.globl vector217
vector217:
  pushl $0
80106232:	6a 00                	push   $0x0
  pushl $217
80106234:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106239:	e9 bf f2 ff ff       	jmp    801054fd <alltraps>

8010623e <vector218>:
.globl vector218
vector218:
  pushl $0
8010623e:	6a 00                	push   $0x0
  pushl $218
80106240:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106245:	e9 b3 f2 ff ff       	jmp    801054fd <alltraps>

8010624a <vector219>:
.globl vector219
vector219:
  pushl $0
8010624a:	6a 00                	push   $0x0
  pushl $219
8010624c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106251:	e9 a7 f2 ff ff       	jmp    801054fd <alltraps>

80106256 <vector220>:
.globl vector220
vector220:
  pushl $0
80106256:	6a 00                	push   $0x0
  pushl $220
80106258:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010625d:	e9 9b f2 ff ff       	jmp    801054fd <alltraps>

80106262 <vector221>:
.globl vector221
vector221:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $221
80106264:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106269:	e9 8f f2 ff ff       	jmp    801054fd <alltraps>

8010626e <vector222>:
.globl vector222
vector222:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $222
80106270:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106275:	e9 83 f2 ff ff       	jmp    801054fd <alltraps>

8010627a <vector223>:
.globl vector223
vector223:
  pushl $0
8010627a:	6a 00                	push   $0x0
  pushl $223
8010627c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106281:	e9 77 f2 ff ff       	jmp    801054fd <alltraps>

80106286 <vector224>:
.globl vector224
vector224:
  pushl $0
80106286:	6a 00                	push   $0x0
  pushl $224
80106288:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010628d:	e9 6b f2 ff ff       	jmp    801054fd <alltraps>

80106292 <vector225>:
.globl vector225
vector225:
  pushl $0
80106292:	6a 00                	push   $0x0
  pushl $225
80106294:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106299:	e9 5f f2 ff ff       	jmp    801054fd <alltraps>

8010629e <vector226>:
.globl vector226
vector226:
  pushl $0
8010629e:	6a 00                	push   $0x0
  pushl $226
801062a0:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801062a5:	e9 53 f2 ff ff       	jmp    801054fd <alltraps>

801062aa <vector227>:
.globl vector227
vector227:
  pushl $0
801062aa:	6a 00                	push   $0x0
  pushl $227
801062ac:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801062b1:	e9 47 f2 ff ff       	jmp    801054fd <alltraps>

801062b6 <vector228>:
.globl vector228
vector228:
  pushl $0
801062b6:	6a 00                	push   $0x0
  pushl $228
801062b8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801062bd:	e9 3b f2 ff ff       	jmp    801054fd <alltraps>

801062c2 <vector229>:
.globl vector229
vector229:
  pushl $0
801062c2:	6a 00                	push   $0x0
  pushl $229
801062c4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801062c9:	e9 2f f2 ff ff       	jmp    801054fd <alltraps>

801062ce <vector230>:
.globl vector230
vector230:
  pushl $0
801062ce:	6a 00                	push   $0x0
  pushl $230
801062d0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801062d5:	e9 23 f2 ff ff       	jmp    801054fd <alltraps>

801062da <vector231>:
.globl vector231
vector231:
  pushl $0
801062da:	6a 00                	push   $0x0
  pushl $231
801062dc:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801062e1:	e9 17 f2 ff ff       	jmp    801054fd <alltraps>

801062e6 <vector232>:
.globl vector232
vector232:
  pushl $0
801062e6:	6a 00                	push   $0x0
  pushl $232
801062e8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801062ed:	e9 0b f2 ff ff       	jmp    801054fd <alltraps>

801062f2 <vector233>:
.globl vector233
vector233:
  pushl $0
801062f2:	6a 00                	push   $0x0
  pushl $233
801062f4:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801062f9:	e9 ff f1 ff ff       	jmp    801054fd <alltraps>

801062fe <vector234>:
.globl vector234
vector234:
  pushl $0
801062fe:	6a 00                	push   $0x0
  pushl $234
80106300:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106305:	e9 f3 f1 ff ff       	jmp    801054fd <alltraps>

8010630a <vector235>:
.globl vector235
vector235:
  pushl $0
8010630a:	6a 00                	push   $0x0
  pushl $235
8010630c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106311:	e9 e7 f1 ff ff       	jmp    801054fd <alltraps>

80106316 <vector236>:
.globl vector236
vector236:
  pushl $0
80106316:	6a 00                	push   $0x0
  pushl $236
80106318:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010631d:	e9 db f1 ff ff       	jmp    801054fd <alltraps>

80106322 <vector237>:
.globl vector237
vector237:
  pushl $0
80106322:	6a 00                	push   $0x0
  pushl $237
80106324:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106329:	e9 cf f1 ff ff       	jmp    801054fd <alltraps>

8010632e <vector238>:
.globl vector238
vector238:
  pushl $0
8010632e:	6a 00                	push   $0x0
  pushl $238
80106330:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106335:	e9 c3 f1 ff ff       	jmp    801054fd <alltraps>

8010633a <vector239>:
.globl vector239
vector239:
  pushl $0
8010633a:	6a 00                	push   $0x0
  pushl $239
8010633c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106341:	e9 b7 f1 ff ff       	jmp    801054fd <alltraps>

80106346 <vector240>:
.globl vector240
vector240:
  pushl $0
80106346:	6a 00                	push   $0x0
  pushl $240
80106348:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010634d:	e9 ab f1 ff ff       	jmp    801054fd <alltraps>

80106352 <vector241>:
.globl vector241
vector241:
  pushl $0
80106352:	6a 00                	push   $0x0
  pushl $241
80106354:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106359:	e9 9f f1 ff ff       	jmp    801054fd <alltraps>

8010635e <vector242>:
.globl vector242
vector242:
  pushl $0
8010635e:	6a 00                	push   $0x0
  pushl $242
80106360:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106365:	e9 93 f1 ff ff       	jmp    801054fd <alltraps>

8010636a <vector243>:
.globl vector243
vector243:
  pushl $0
8010636a:	6a 00                	push   $0x0
  pushl $243
8010636c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106371:	e9 87 f1 ff ff       	jmp    801054fd <alltraps>

80106376 <vector244>:
.globl vector244
vector244:
  pushl $0
80106376:	6a 00                	push   $0x0
  pushl $244
80106378:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010637d:	e9 7b f1 ff ff       	jmp    801054fd <alltraps>

80106382 <vector245>:
.globl vector245
vector245:
  pushl $0
80106382:	6a 00                	push   $0x0
  pushl $245
80106384:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106389:	e9 6f f1 ff ff       	jmp    801054fd <alltraps>

8010638e <vector246>:
.globl vector246
vector246:
  pushl $0
8010638e:	6a 00                	push   $0x0
  pushl $246
80106390:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106395:	e9 63 f1 ff ff       	jmp    801054fd <alltraps>

8010639a <vector247>:
.globl vector247
vector247:
  pushl $0
8010639a:	6a 00                	push   $0x0
  pushl $247
8010639c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801063a1:	e9 57 f1 ff ff       	jmp    801054fd <alltraps>

801063a6 <vector248>:
.globl vector248
vector248:
  pushl $0
801063a6:	6a 00                	push   $0x0
  pushl $248
801063a8:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801063ad:	e9 4b f1 ff ff       	jmp    801054fd <alltraps>

801063b2 <vector249>:
.globl vector249
vector249:
  pushl $0
801063b2:	6a 00                	push   $0x0
  pushl $249
801063b4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801063b9:	e9 3f f1 ff ff       	jmp    801054fd <alltraps>

801063be <vector250>:
.globl vector250
vector250:
  pushl $0
801063be:	6a 00                	push   $0x0
  pushl $250
801063c0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801063c5:	e9 33 f1 ff ff       	jmp    801054fd <alltraps>

801063ca <vector251>:
.globl vector251
vector251:
  pushl $0
801063ca:	6a 00                	push   $0x0
  pushl $251
801063cc:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801063d1:	e9 27 f1 ff ff       	jmp    801054fd <alltraps>

801063d6 <vector252>:
.globl vector252
vector252:
  pushl $0
801063d6:	6a 00                	push   $0x0
  pushl $252
801063d8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801063dd:	e9 1b f1 ff ff       	jmp    801054fd <alltraps>

801063e2 <vector253>:
.globl vector253
vector253:
  pushl $0
801063e2:	6a 00                	push   $0x0
  pushl $253
801063e4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801063e9:	e9 0f f1 ff ff       	jmp    801054fd <alltraps>

801063ee <vector254>:
.globl vector254
vector254:
  pushl $0
801063ee:	6a 00                	push   $0x0
  pushl $254
801063f0:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801063f5:	e9 03 f1 ff ff       	jmp    801054fd <alltraps>

801063fa <vector255>:
.globl vector255
vector255:
  pushl $0
801063fa:	6a 00                	push   $0x0
  pushl $255
801063fc:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106401:	e9 f7 f0 ff ff       	jmp    801054fd <alltraps>
80106406:	66 90                	xchg   %ax,%ax
80106408:	66 90                	xchg   %ax,%ax
8010640a:	66 90                	xchg   %ax,%ax
8010640c:	66 90                	xchg   %ax,%ax
8010640e:	66 90                	xchg   %ax,%ax

80106410 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106410:	55                   	push   %ebp
80106411:	89 e5                	mov    %esp,%ebp
80106413:	57                   	push   %edi
80106414:	56                   	push   %esi
80106415:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106417:	c1 ea 16             	shr    $0x16,%edx
{
8010641a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010641b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010641e:	83 ec 1c             	sub    $0x1c,%esp
  if(*pde & PTE_P){
80106421:	8b 1f                	mov    (%edi),%ebx
80106423:	f6 c3 01             	test   $0x1,%bl
80106426:	74 28                	je     80106450 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106428:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010642e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106434:	c1 ee 0a             	shr    $0xa,%esi
}
80106437:	83 c4 1c             	add    $0x1c,%esp
  return &pgtab[PTX(va)];
8010643a:	89 f2                	mov    %esi,%edx
8010643c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106442:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106445:	5b                   	pop    %ebx
80106446:	5e                   	pop    %esi
80106447:	5f                   	pop    %edi
80106448:	5d                   	pop    %ebp
80106449:	c3                   	ret    
8010644a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106450:	85 c9                	test   %ecx,%ecx
80106452:	74 34                	je     80106488 <walkpgdir+0x78>
80106454:	e8 77 c0 ff ff       	call   801024d0 <kalloc>
80106459:	85 c0                	test   %eax,%eax
8010645b:	89 c3                	mov    %eax,%ebx
8010645d:	74 29                	je     80106488 <walkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
8010645f:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106466:	00 
80106467:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010646e:	00 
8010646f:	89 04 24             	mov    %eax,(%esp)
80106472:	e8 39 df ff ff       	call   801043b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106477:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010647d:	83 c8 07             	or     $0x7,%eax
80106480:	89 07                	mov    %eax,(%edi)
80106482:	eb b0                	jmp    80106434 <walkpgdir+0x24>
80106484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80106488:	83 c4 1c             	add    $0x1c,%esp
      return 0;
8010648b:	31 c0                	xor    %eax,%eax
}
8010648d:	5b                   	pop    %ebx
8010648e:	5e                   	pop    %esi
8010648f:	5f                   	pop    %edi
80106490:	5d                   	pop    %ebp
80106491:	c3                   	ret    
80106492:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064a0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	57                   	push   %edi
801064a4:	56                   	push   %esi
801064a5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801064a6:	89 d3                	mov    %edx,%ebx
{
801064a8:	83 ec 1c             	sub    $0x1c,%esp
801064ab:	8b 7d 08             	mov    0x8(%ebp),%edi
  a = (char*)PGROUNDDOWN((uint)va);
801064ae:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801064b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801064b7:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801064bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801064be:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801064c2:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
801064c9:	29 df                	sub    %ebx,%edi
801064cb:	eb 18                	jmp    801064e5 <mappages+0x45>
801064cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(*pte & PTE_P)
801064d0:	f6 00 01             	testb  $0x1,(%eax)
801064d3:	75 3d                	jne    80106512 <mappages+0x72>
    *pte = pa | perm | PTE_P;
801064d5:	0b 75 0c             	or     0xc(%ebp),%esi
    if(a == last)
801064d8:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801064db:	89 30                	mov    %esi,(%eax)
    if(a == last)
801064dd:	74 29                	je     80106508 <mappages+0x68>
      break;
    a += PGSIZE;
801064df:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801064e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801064e8:	b9 01 00 00 00       	mov    $0x1,%ecx
801064ed:	89 da                	mov    %ebx,%edx
801064ef:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801064f2:	e8 19 ff ff ff       	call   80106410 <walkpgdir>
801064f7:	85 c0                	test   %eax,%eax
801064f9:	75 d5                	jne    801064d0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801064fb:	83 c4 1c             	add    $0x1c,%esp
      return -1;
801064fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106503:	5b                   	pop    %ebx
80106504:	5e                   	pop    %esi
80106505:	5f                   	pop    %edi
80106506:	5d                   	pop    %ebp
80106507:	c3                   	ret    
80106508:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010650b:	31 c0                	xor    %eax,%eax
}
8010650d:	5b                   	pop    %ebx
8010650e:	5e                   	pop    %esi
8010650f:	5f                   	pop    %edi
80106510:	5d                   	pop    %ebp
80106511:	c3                   	ret    
      panic("remap");
80106512:	c7 04 24 30 76 10 80 	movl   $0x80107630,(%esp)
80106519:	e8 42 9e ff ff       	call   80100360 <panic>
8010651e:	66 90                	xchg   %ax,%ax

80106520 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106520:	55                   	push   %ebp
80106521:	89 e5                	mov    %esp,%ebp
80106523:	57                   	push   %edi
80106524:	89 c7                	mov    %eax,%edi
80106526:	56                   	push   %esi
80106527:	89 d6                	mov    %edx,%esi
80106529:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010652a:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106530:	83 ec 1c             	sub    $0x1c,%esp
  a = PGROUNDUP(newsz);
80106533:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106539:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010653b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010653e:	72 3b                	jb     8010657b <deallocuvm.part.0+0x5b>
80106540:	eb 5e                	jmp    801065a0 <deallocuvm.part.0+0x80>
80106542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106548:	8b 10                	mov    (%eax),%edx
8010654a:	f6 c2 01             	test   $0x1,%dl
8010654d:	74 22                	je     80106571 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010654f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106555:	74 54                	je     801065ab <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80106557:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
8010655d:	89 14 24             	mov    %edx,(%esp)
80106560:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106563:	e8 b8 bd ff ff       	call   80102320 <kfree>
      *pte = 0;
80106568:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010656b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106571:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106577:	39 f3                	cmp    %esi,%ebx
80106579:	73 25                	jae    801065a0 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010657b:	31 c9                	xor    %ecx,%ecx
8010657d:	89 da                	mov    %ebx,%edx
8010657f:	89 f8                	mov    %edi,%eax
80106581:	e8 8a fe ff ff       	call   80106410 <walkpgdir>
    if(!pte)
80106586:	85 c0                	test   %eax,%eax
80106588:	75 be                	jne    80106548 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010658a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106590:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106596:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010659c:	39 f3                	cmp    %esi,%ebx
8010659e:	72 db                	jb     8010657b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
801065a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801065a3:	83 c4 1c             	add    $0x1c,%esp
801065a6:	5b                   	pop    %ebx
801065a7:	5e                   	pop    %esi
801065a8:	5f                   	pop    %edi
801065a9:	5d                   	pop    %ebp
801065aa:	c3                   	ret    
        panic("kfree");
801065ab:	c7 04 24 86 6f 10 80 	movl   $0x80106f86,(%esp)
801065b2:	e8 a9 9d ff ff       	call   80100360 <panic>
801065b7:	89 f6                	mov    %esi,%esi
801065b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065c0 <seginit>:
{
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801065c6:	e8 e5 d0 ff ff       	call   801036b0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065cb:	31 c9                	xor    %ecx,%ecx
801065cd:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c = &cpus[cpuid()];
801065d2:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801065d8:	05 80 27 11 80       	add    $0x80112780,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065dd:	66 89 50 78          	mov    %dx,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065e1:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  lgdt(c->gdt, sizeof(c->gdt));
801065e6:	83 c0 70             	add    $0x70,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065e9:	66 89 48 0a          	mov    %cx,0xa(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065ed:	31 c9                	xor    %ecx,%ecx
801065ef:	66 89 50 10          	mov    %dx,0x10(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801065f3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065f8:	66 89 48 12          	mov    %cx,0x12(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801065fc:	31 c9                	xor    %ecx,%ecx
801065fe:	66 89 50 18          	mov    %dx,0x18(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106602:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106607:	66 89 48 1a          	mov    %cx,0x1a(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010660b:	31 c9                	xor    %ecx,%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010660d:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
80106611:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106615:	c6 40 15 92          	movb   $0x92,0x15(%eax)
80106619:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010661d:	c6 40 1d fa          	movb   $0xfa,0x1d(%eax)
80106621:	c6 40 1e cf          	movb   $0xcf,0x1e(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106625:	c6 40 25 f2          	movb   $0xf2,0x25(%eax)
80106629:	c6 40 26 cf          	movb   $0xcf,0x26(%eax)
8010662d:	66 89 50 20          	mov    %dx,0x20(%eax)
  pd[0] = size-1;
80106631:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106636:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
8010663a:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010663e:	c6 40 14 00          	movb   $0x0,0x14(%eax)
80106642:	c6 40 17 00          	movb   $0x0,0x17(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106646:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
8010664a:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010664e:	66 89 48 22          	mov    %cx,0x22(%eax)
80106652:	c6 40 24 00          	movb   $0x0,0x24(%eax)
80106656:	c6 40 27 00          	movb   $0x0,0x27(%eax)
8010665a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
8010665e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106662:	c1 e8 10             	shr    $0x10,%eax
80106665:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106669:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010666c:	0f 01 10             	lgdtl  (%eax)
}
8010666f:	c9                   	leave  
80106670:	c3                   	ret    
80106671:	eb 0d                	jmp    80106680 <switchkvm>
80106673:	90                   	nop
80106674:	90                   	nop
80106675:	90                   	nop
80106676:	90                   	nop
80106677:	90                   	nop
80106678:	90                   	nop
80106679:	90                   	nop
8010667a:	90                   	nop
8010667b:	90                   	nop
8010667c:	90                   	nop
8010667d:	90                   	nop
8010667e:	90                   	nop
8010667f:	90                   	nop

80106680 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106680:	a1 a4 55 11 80       	mov    0x801155a4,%eax
{
80106685:	55                   	push   %ebp
80106686:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106688:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010668d:	0f 22 d8             	mov    %eax,%cr3
}
80106690:	5d                   	pop    %ebp
80106691:	c3                   	ret    
80106692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066a0 <switchuvm>:
{
801066a0:	55                   	push   %ebp
801066a1:	89 e5                	mov    %esp,%ebp
801066a3:	57                   	push   %edi
801066a4:	56                   	push   %esi
801066a5:	53                   	push   %ebx
801066a6:	83 ec 1c             	sub    $0x1c,%esp
801066a9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801066ac:	85 f6                	test   %esi,%esi
801066ae:	0f 84 cd 00 00 00    	je     80106781 <switchuvm+0xe1>
  if(p->kstack == 0)
801066b4:	8b 46 08             	mov    0x8(%esi),%eax
801066b7:	85 c0                	test   %eax,%eax
801066b9:	0f 84 da 00 00 00    	je     80106799 <switchuvm+0xf9>
  if(p->pgdir == 0)
801066bf:	8b 7e 04             	mov    0x4(%esi),%edi
801066c2:	85 ff                	test   %edi,%edi
801066c4:	0f 84 c3 00 00 00    	je     8010678d <switchuvm+0xed>
  pushcli();
801066ca:	e8 31 db ff ff       	call   80104200 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801066cf:	e8 5c cf ff ff       	call   80103630 <mycpu>
801066d4:	89 c3                	mov    %eax,%ebx
801066d6:	e8 55 cf ff ff       	call   80103630 <mycpu>
801066db:	89 c7                	mov    %eax,%edi
801066dd:	e8 4e cf ff ff       	call   80103630 <mycpu>
801066e2:	83 c7 08             	add    $0x8,%edi
801066e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801066e8:	e8 43 cf ff ff       	call   80103630 <mycpu>
801066ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801066f0:	ba 67 00 00 00       	mov    $0x67,%edx
801066f5:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
801066fc:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106703:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
8010670a:	83 c1 08             	add    $0x8,%ecx
8010670d:	c1 e9 10             	shr    $0x10,%ecx
80106710:	83 c0 08             	add    $0x8,%eax
80106713:	c1 e8 18             	shr    $0x18,%eax
80106716:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
8010671c:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106723:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106729:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
8010672e:	e8 fd ce ff ff       	call   80103630 <mycpu>
80106733:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010673a:	e8 f1 ce ff ff       	call   80103630 <mycpu>
8010673f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106744:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106748:	e8 e3 ce ff ff       	call   80103630 <mycpu>
8010674d:	8b 56 08             	mov    0x8(%esi),%edx
80106750:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106756:	89 48 0c             	mov    %ecx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106759:	e8 d2 ce ff ff       	call   80103630 <mycpu>
8010675e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106762:	b8 28 00 00 00       	mov    $0x28,%eax
80106767:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010676a:	8b 46 04             	mov    0x4(%esi),%eax
8010676d:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106772:	0f 22 d8             	mov    %eax,%cr3
}
80106775:	83 c4 1c             	add    $0x1c,%esp
80106778:	5b                   	pop    %ebx
80106779:	5e                   	pop    %esi
8010677a:	5f                   	pop    %edi
8010677b:	5d                   	pop    %ebp
  popcli();
8010677c:	e9 bf da ff ff       	jmp    80104240 <popcli>
    panic("switchuvm: no process");
80106781:	c7 04 24 36 76 10 80 	movl   $0x80107636,(%esp)
80106788:	e8 d3 9b ff ff       	call   80100360 <panic>
    panic("switchuvm: no pgdir");
8010678d:	c7 04 24 61 76 10 80 	movl   $0x80107661,(%esp)
80106794:	e8 c7 9b ff ff       	call   80100360 <panic>
    panic("switchuvm: no kstack");
80106799:	c7 04 24 4c 76 10 80 	movl   $0x8010764c,(%esp)
801067a0:	e8 bb 9b ff ff       	call   80100360 <panic>
801067a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801067b0 <inituvm>:
{
801067b0:	55                   	push   %ebp
801067b1:	89 e5                	mov    %esp,%ebp
801067b3:	57                   	push   %edi
801067b4:	56                   	push   %esi
801067b5:	53                   	push   %ebx
801067b6:	83 ec 1c             	sub    $0x1c,%esp
801067b9:	8b 75 10             	mov    0x10(%ebp),%esi
801067bc:	8b 45 08             	mov    0x8(%ebp),%eax
801067bf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
801067c2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801067c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801067cb:	77 54                	ja     80106821 <inituvm+0x71>
  mem = kalloc();
801067cd:	e8 fe bc ff ff       	call   801024d0 <kalloc>
  memset(mem, 0, PGSIZE);
801067d2:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801067d9:	00 
801067da:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801067e1:	00 
  mem = kalloc();
801067e2:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801067e4:	89 04 24             	mov    %eax,(%esp)
801067e7:	e8 c4 db ff ff       	call   801043b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801067ec:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801067f2:	b9 00 10 00 00       	mov    $0x1000,%ecx
801067f7:	89 04 24             	mov    %eax,(%esp)
801067fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801067fd:	31 d2                	xor    %edx,%edx
801067ff:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106806:	00 
80106807:	e8 94 fc ff ff       	call   801064a0 <mappages>
  memmove(mem, init, sz);
8010680c:	89 75 10             	mov    %esi,0x10(%ebp)
8010680f:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106812:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106815:	83 c4 1c             	add    $0x1c,%esp
80106818:	5b                   	pop    %ebx
80106819:	5e                   	pop    %esi
8010681a:	5f                   	pop    %edi
8010681b:	5d                   	pop    %ebp
  memmove(mem, init, sz);
8010681c:	e9 2f dc ff ff       	jmp    80104450 <memmove>
    panic("inituvm: more than a page");
80106821:	c7 04 24 75 76 10 80 	movl   $0x80107675,(%esp)
80106828:	e8 33 9b ff ff       	call   80100360 <panic>
8010682d:	8d 76 00             	lea    0x0(%esi),%esi

80106830 <loaduvm>:
{
80106830:	55                   	push   %ebp
80106831:	89 e5                	mov    %esp,%ebp
80106833:	57                   	push   %edi
80106834:	56                   	push   %esi
80106835:	53                   	push   %ebx
80106836:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80106839:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106840:	0f 85 98 00 00 00    	jne    801068de <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
80106846:	8b 75 18             	mov    0x18(%ebp),%esi
80106849:	31 db                	xor    %ebx,%ebx
8010684b:	85 f6                	test   %esi,%esi
8010684d:	75 1a                	jne    80106869 <loaduvm+0x39>
8010684f:	eb 77                	jmp    801068c8 <loaduvm+0x98>
80106851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106858:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010685e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106864:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106867:	76 5f                	jbe    801068c8 <loaduvm+0x98>
80106869:	8b 55 0c             	mov    0xc(%ebp),%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010686c:	31 c9                	xor    %ecx,%ecx
8010686e:	8b 45 08             	mov    0x8(%ebp),%eax
80106871:	01 da                	add    %ebx,%edx
80106873:	e8 98 fb ff ff       	call   80106410 <walkpgdir>
80106878:	85 c0                	test   %eax,%eax
8010687a:	74 56                	je     801068d2 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
8010687c:	8b 00                	mov    (%eax),%eax
      n = PGSIZE;
8010687e:	bf 00 10 00 00       	mov    $0x1000,%edi
80106883:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80106886:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      n = PGSIZE;
8010688b:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106891:	0f 42 fe             	cmovb  %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106894:	05 00 00 00 80       	add    $0x80000000,%eax
80106899:	89 44 24 04          	mov    %eax,0x4(%esp)
8010689d:	8b 45 10             	mov    0x10(%ebp),%eax
801068a0:	01 d9                	add    %ebx,%ecx
801068a2:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801068a6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801068aa:	89 04 24             	mov    %eax,(%esp)
801068ad:	e8 de b0 ff ff       	call   80101990 <readi>
801068b2:	39 f8                	cmp    %edi,%eax
801068b4:	74 a2                	je     80106858 <loaduvm+0x28>
}
801068b6:	83 c4 1c             	add    $0x1c,%esp
      return -1;
801068b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068be:	5b                   	pop    %ebx
801068bf:	5e                   	pop    %esi
801068c0:	5f                   	pop    %edi
801068c1:	5d                   	pop    %ebp
801068c2:	c3                   	ret    
801068c3:	90                   	nop
801068c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801068c8:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801068cb:	31 c0                	xor    %eax,%eax
}
801068cd:	5b                   	pop    %ebx
801068ce:	5e                   	pop    %esi
801068cf:	5f                   	pop    %edi
801068d0:	5d                   	pop    %ebp
801068d1:	c3                   	ret    
      panic("loaduvm: address should exist");
801068d2:	c7 04 24 8f 76 10 80 	movl   $0x8010768f,(%esp)
801068d9:	e8 82 9a ff ff       	call   80100360 <panic>
    panic("loaduvm: addr must be page aligned");
801068de:	c7 04 24 30 77 10 80 	movl   $0x80107730,(%esp)
801068e5:	e8 76 9a ff ff       	call   80100360 <panic>
801068ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801068f0 <allocuvm>:
{
801068f0:	55                   	push   %ebp
801068f1:	89 e5                	mov    %esp,%ebp
801068f3:	57                   	push   %edi
801068f4:	56                   	push   %esi
801068f5:	53                   	push   %ebx
801068f6:	83 ec 1c             	sub    $0x1c,%esp
801068f9:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
801068fc:	85 ff                	test   %edi,%edi
801068fe:	0f 88 7e 00 00 00    	js     80106982 <allocuvm+0x92>
  if(newsz < oldsz)
80106904:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106907:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
8010690a:	72 78                	jb     80106984 <allocuvm+0x94>
  a = PGROUNDUP(oldsz);
8010690c:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106912:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106918:	39 df                	cmp    %ebx,%edi
8010691a:	77 4a                	ja     80106966 <allocuvm+0x76>
8010691c:	eb 72                	jmp    80106990 <allocuvm+0xa0>
8010691e:	66 90                	xchg   %ax,%ax
    memset(mem, 0, PGSIZE);
80106920:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106927:	00 
80106928:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010692f:	00 
80106930:	89 04 24             	mov    %eax,(%esp)
80106933:	e8 78 da ff ff       	call   801043b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106938:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010693e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106943:	89 04 24             	mov    %eax,(%esp)
80106946:	8b 45 08             	mov    0x8(%ebp),%eax
80106949:	89 da                	mov    %ebx,%edx
8010694b:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106952:	00 
80106953:	e8 48 fb ff ff       	call   801064a0 <mappages>
80106958:	85 c0                	test   %eax,%eax
8010695a:	78 44                	js     801069a0 <allocuvm+0xb0>
  for(; a < newsz; a += PGSIZE){
8010695c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106962:	39 df                	cmp    %ebx,%edi
80106964:	76 2a                	jbe    80106990 <allocuvm+0xa0>
    mem = kalloc();
80106966:	e8 65 bb ff ff       	call   801024d0 <kalloc>
    if(mem == 0){
8010696b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010696d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010696f:	75 af                	jne    80106920 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
80106971:	c7 04 24 ad 76 10 80 	movl   $0x801076ad,(%esp)
80106978:	e8 d3 9c ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010697d:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106980:	77 48                	ja     801069ca <allocuvm+0xda>
      return 0;
80106982:	31 c0                	xor    %eax,%eax
}
80106984:	83 c4 1c             	add    $0x1c,%esp
80106987:	5b                   	pop    %ebx
80106988:	5e                   	pop    %esi
80106989:	5f                   	pop    %edi
8010698a:	5d                   	pop    %ebp
8010698b:	c3                   	ret    
8010698c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106990:	83 c4 1c             	add    $0x1c,%esp
80106993:	89 f8                	mov    %edi,%eax
80106995:	5b                   	pop    %ebx
80106996:	5e                   	pop    %esi
80106997:	5f                   	pop    %edi
80106998:	5d                   	pop    %ebp
80106999:	c3                   	ret    
8010699a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801069a0:	c7 04 24 c5 76 10 80 	movl   $0x801076c5,(%esp)
801069a7:	e8 a4 9c ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
801069ac:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801069af:	76 0d                	jbe    801069be <allocuvm+0xce>
801069b1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801069b4:	89 fa                	mov    %edi,%edx
801069b6:	8b 45 08             	mov    0x8(%ebp),%eax
801069b9:	e8 62 fb ff ff       	call   80106520 <deallocuvm.part.0>
      kfree(mem);
801069be:	89 34 24             	mov    %esi,(%esp)
801069c1:	e8 5a b9 ff ff       	call   80102320 <kfree>
      return 0;
801069c6:	31 c0                	xor    %eax,%eax
801069c8:	eb ba                	jmp    80106984 <allocuvm+0x94>
801069ca:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801069cd:	89 fa                	mov    %edi,%edx
801069cf:	8b 45 08             	mov    0x8(%ebp),%eax
801069d2:	e8 49 fb ff ff       	call   80106520 <deallocuvm.part.0>
      return 0;
801069d7:	31 c0                	xor    %eax,%eax
801069d9:	eb a9                	jmp    80106984 <allocuvm+0x94>
801069db:	90                   	nop
801069dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069e0 <deallocuvm>:
{
801069e0:	55                   	push   %ebp
801069e1:	89 e5                	mov    %esp,%ebp
801069e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801069e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801069e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801069ec:	39 d1                	cmp    %edx,%ecx
801069ee:	73 08                	jae    801069f8 <deallocuvm+0x18>
}
801069f0:	5d                   	pop    %ebp
801069f1:	e9 2a fb ff ff       	jmp    80106520 <deallocuvm.part.0>
801069f6:	66 90                	xchg   %ax,%ax
801069f8:	89 d0                	mov    %edx,%eax
801069fa:	5d                   	pop    %ebp
801069fb:	c3                   	ret    
801069fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a00 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106a00:	55                   	push   %ebp
80106a01:	89 e5                	mov    %esp,%ebp
80106a03:	56                   	push   %esi
80106a04:	53                   	push   %ebx
80106a05:	83 ec 10             	sub    $0x10,%esp
80106a08:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106a0b:	85 f6                	test   %esi,%esi
80106a0d:	74 59                	je     80106a68 <freevm+0x68>
80106a0f:	31 c9                	xor    %ecx,%ecx
80106a11:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106a16:	89 f0                	mov    %esi,%eax
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106a18:	31 db                	xor    %ebx,%ebx
80106a1a:	e8 01 fb ff ff       	call   80106520 <deallocuvm.part.0>
80106a1f:	eb 12                	jmp    80106a33 <freevm+0x33>
80106a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a28:	83 c3 01             	add    $0x1,%ebx
80106a2b:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106a31:	74 27                	je     80106a5a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106a33:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
80106a36:	f6 c2 01             	test   $0x1,%dl
80106a39:	74 ed                	je     80106a28 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106a3b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(i = 0; i < NPDENTRIES; i++){
80106a41:	83 c3 01             	add    $0x1,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106a44:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106a4a:	89 14 24             	mov    %edx,(%esp)
80106a4d:	e8 ce b8 ff ff       	call   80102320 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80106a52:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106a58:	75 d9                	jne    80106a33 <freevm+0x33>
    }
  }
  kfree((char*)pgdir);
80106a5a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106a5d:	83 c4 10             	add    $0x10,%esp
80106a60:	5b                   	pop    %ebx
80106a61:	5e                   	pop    %esi
80106a62:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106a63:	e9 b8 b8 ff ff       	jmp    80102320 <kfree>
    panic("freevm: no pgdir");
80106a68:	c7 04 24 e1 76 10 80 	movl   $0x801076e1,(%esp)
80106a6f:	e8 ec 98 ff ff       	call   80100360 <panic>
80106a74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106a80 <setupkvm>:
{
80106a80:	55                   	push   %ebp
80106a81:	89 e5                	mov    %esp,%ebp
80106a83:	56                   	push   %esi
80106a84:	53                   	push   %ebx
80106a85:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80106a88:	e8 43 ba ff ff       	call   801024d0 <kalloc>
80106a8d:	85 c0                	test   %eax,%eax
80106a8f:	89 c6                	mov    %eax,%esi
80106a91:	74 6d                	je     80106b00 <setupkvm+0x80>
  memset(pgdir, 0, PGSIZE);
80106a93:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106a9a:	00 
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106a9b:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106aa0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106aa7:	00 
80106aa8:	89 04 24             	mov    %eax,(%esp)
80106aab:	e8 00 d9 ff ff       	call   801043b0 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ab0:	8b 53 0c             	mov    0xc(%ebx),%edx
80106ab3:	8b 43 04             	mov    0x4(%ebx),%eax
80106ab6:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ab9:	89 54 24 04          	mov    %edx,0x4(%esp)
80106abd:	8b 13                	mov    (%ebx),%edx
80106abf:	89 04 24             	mov    %eax,(%esp)
80106ac2:	29 c1                	sub    %eax,%ecx
80106ac4:	89 f0                	mov    %esi,%eax
80106ac6:	e8 d5 f9 ff ff       	call   801064a0 <mappages>
80106acb:	85 c0                	test   %eax,%eax
80106acd:	78 19                	js     80106ae8 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106acf:	83 c3 10             	add    $0x10,%ebx
80106ad2:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106ad8:	72 d6                	jb     80106ab0 <setupkvm+0x30>
80106ada:	89 f0                	mov    %esi,%eax
}
80106adc:	83 c4 10             	add    $0x10,%esp
80106adf:	5b                   	pop    %ebx
80106ae0:	5e                   	pop    %esi
80106ae1:	5d                   	pop    %ebp
80106ae2:	c3                   	ret    
80106ae3:	90                   	nop
80106ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106ae8:	89 34 24             	mov    %esi,(%esp)
80106aeb:	e8 10 ff ff ff       	call   80106a00 <freevm>
}
80106af0:	83 c4 10             	add    $0x10,%esp
      return 0;
80106af3:	31 c0                	xor    %eax,%eax
}
80106af5:	5b                   	pop    %ebx
80106af6:	5e                   	pop    %esi
80106af7:	5d                   	pop    %ebp
80106af8:	c3                   	ret    
80106af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106b00:	31 c0                	xor    %eax,%eax
80106b02:	eb d8                	jmp    80106adc <setupkvm+0x5c>
80106b04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106b10 <kvmalloc>:
{
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106b16:	e8 65 ff ff ff       	call   80106a80 <setupkvm>
80106b1b:	a3 a4 55 11 80       	mov    %eax,0x801155a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b20:	05 00 00 00 80       	add    $0x80000000,%eax
80106b25:	0f 22 d8             	mov    %eax,%cr3
}
80106b28:	c9                   	leave  
80106b29:	c3                   	ret    
80106b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b30 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b30:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b31:	31 c9                	xor    %ecx,%ecx
{
80106b33:	89 e5                	mov    %esp,%ebp
80106b35:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106b38:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b3b:	8b 45 08             	mov    0x8(%ebp),%eax
80106b3e:	e8 cd f8 ff ff       	call   80106410 <walkpgdir>
  if(pte == 0)
80106b43:	85 c0                	test   %eax,%eax
80106b45:	74 05                	je     80106b4c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106b47:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106b4a:	c9                   	leave  
80106b4b:	c3                   	ret    
    panic("clearpteu");
80106b4c:	c7 04 24 f2 76 10 80 	movl   $0x801076f2,(%esp)
80106b53:	e8 08 98 ff ff       	call   80100360 <panic>
80106b58:	90                   	nop
80106b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b60 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	57                   	push   %edi
80106b64:	56                   	push   %esi
80106b65:	53                   	push   %ebx
80106b66:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106b69:	e8 12 ff ff ff       	call   80106a80 <setupkvm>
80106b6e:	85 c0                	test   %eax,%eax
80106b70:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106b73:	0f 84 b9 00 00 00    	je     80106c32 <copyuvm+0xd2>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106b79:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b7c:	85 c0                	test   %eax,%eax
80106b7e:	0f 84 94 00 00 00    	je     80106c18 <copyuvm+0xb8>
80106b84:	31 ff                	xor    %edi,%edi
80106b86:	eb 48                	jmp    80106bd0 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106b88:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106b8e:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106b95:	00 
80106b96:	89 74 24 04          	mov    %esi,0x4(%esp)
80106b9a:	89 04 24             	mov    %eax,(%esp)
80106b9d:	e8 ae d8 ff ff       	call   80104450 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106ba2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ba5:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106baa:	89 fa                	mov    %edi,%edx
80106bac:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bb0:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106bb6:	89 04 24             	mov    %eax,(%esp)
80106bb9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106bbc:	e8 df f8 ff ff       	call   801064a0 <mappages>
80106bc1:	85 c0                	test   %eax,%eax
80106bc3:	78 63                	js     80106c28 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106bc5:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106bcb:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106bce:	76 48                	jbe    80106c18 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106bd0:	8b 45 08             	mov    0x8(%ebp),%eax
80106bd3:	31 c9                	xor    %ecx,%ecx
80106bd5:	89 fa                	mov    %edi,%edx
80106bd7:	e8 34 f8 ff ff       	call   80106410 <walkpgdir>
80106bdc:	85 c0                	test   %eax,%eax
80106bde:	74 62                	je     80106c42 <copyuvm+0xe2>
    if(!(*pte & PTE_P))
80106be0:	8b 00                	mov    (%eax),%eax
80106be2:	a8 01                	test   $0x1,%al
80106be4:	74 50                	je     80106c36 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106be6:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
80106be8:	25 ff 0f 00 00       	and    $0xfff,%eax
80106bed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80106bf0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    if((mem = kalloc()) == 0)
80106bf6:	e8 d5 b8 ff ff       	call   801024d0 <kalloc>
80106bfb:	85 c0                	test   %eax,%eax
80106bfd:	89 c3                	mov    %eax,%ebx
80106bff:	75 87                	jne    80106b88 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
80106c01:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c04:	89 04 24             	mov    %eax,(%esp)
80106c07:	e8 f4 fd ff ff       	call   80106a00 <freevm>
  return 0;
80106c0c:	31 c0                	xor    %eax,%eax
}
80106c0e:	83 c4 2c             	add    $0x2c,%esp
80106c11:	5b                   	pop    %ebx
80106c12:	5e                   	pop    %esi
80106c13:	5f                   	pop    %edi
80106c14:	5d                   	pop    %ebp
80106c15:	c3                   	ret    
80106c16:	66 90                	xchg   %ax,%ax
80106c18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c1b:	83 c4 2c             	add    $0x2c,%esp
80106c1e:	5b                   	pop    %ebx
80106c1f:	5e                   	pop    %esi
80106c20:	5f                   	pop    %edi
80106c21:	5d                   	pop    %ebp
80106c22:	c3                   	ret    
80106c23:	90                   	nop
80106c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106c28:	89 1c 24             	mov    %ebx,(%esp)
80106c2b:	e8 f0 b6 ff ff       	call   80102320 <kfree>
      goto bad;
80106c30:	eb cf                	jmp    80106c01 <copyuvm+0xa1>
    return 0;
80106c32:	31 c0                	xor    %eax,%eax
80106c34:	eb d8                	jmp    80106c0e <copyuvm+0xae>
      panic("copyuvm: page not present");
80106c36:	c7 04 24 16 77 10 80 	movl   $0x80107716,(%esp)
80106c3d:	e8 1e 97 ff ff       	call   80100360 <panic>
      panic("copyuvm: pte should exist");
80106c42:	c7 04 24 fc 76 10 80 	movl   $0x801076fc,(%esp)
80106c49:	e8 12 97 ff ff       	call   80100360 <panic>
80106c4e:	66 90                	xchg   %ax,%ax

80106c50 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106c50:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106c51:	31 c9                	xor    %ecx,%ecx
{
80106c53:	89 e5                	mov    %esp,%ebp
80106c55:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106c58:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c5b:	8b 45 08             	mov    0x8(%ebp),%eax
80106c5e:	e8 ad f7 ff ff       	call   80106410 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106c63:	8b 00                	mov    (%eax),%eax
80106c65:	89 c2                	mov    %eax,%edx
80106c67:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
80106c6a:	83 fa 05             	cmp    $0x5,%edx
80106c6d:	75 11                	jne    80106c80 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106c6f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c74:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106c79:	c9                   	leave  
80106c7a:	c3                   	ret    
80106c7b:	90                   	nop
80106c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106c80:	31 c0                	xor    %eax,%eax
}
80106c82:	c9                   	leave  
80106c83:	c3                   	ret    
80106c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c90 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106c90:	55                   	push   %ebp
80106c91:	89 e5                	mov    %esp,%ebp
80106c93:	57                   	push   %edi
80106c94:	56                   	push   %esi
80106c95:	53                   	push   %ebx
80106c96:	83 ec 1c             	sub    $0x1c,%esp
80106c99:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106c9c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c9f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ca2:	85 db                	test   %ebx,%ebx
80106ca4:	75 3a                	jne    80106ce0 <copyout+0x50>
80106ca6:	eb 68                	jmp    80106d10 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106ca8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106cab:	89 f2                	mov    %esi,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106cad:	89 7c 24 04          	mov    %edi,0x4(%esp)
    n = PGSIZE - (va - va0);
80106cb1:	29 ca                	sub    %ecx,%edx
80106cb3:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106cb9:	39 da                	cmp    %ebx,%edx
80106cbb:	0f 47 d3             	cmova  %ebx,%edx
    memmove(pa0 + (va - va0), buf, n);
80106cbe:	29 f1                	sub    %esi,%ecx
80106cc0:	01 c8                	add    %ecx,%eax
80106cc2:	89 54 24 08          	mov    %edx,0x8(%esp)
80106cc6:	89 04 24             	mov    %eax,(%esp)
80106cc9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106ccc:	e8 7f d7 ff ff       	call   80104450 <memmove>
    len -= n;
    buf += n;
80106cd1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    va = va0 + PGSIZE;
80106cd4:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
    buf += n;
80106cda:	01 d7                	add    %edx,%edi
  while(len > 0){
80106cdc:	29 d3                	sub    %edx,%ebx
80106cde:	74 30                	je     80106d10 <copyout+0x80>
    pa0 = uva2ka(pgdir, (char*)va0);
80106ce0:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80106ce3:	89 ce                	mov    %ecx,%esi
80106ce5:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106ceb:	89 74 24 04          	mov    %esi,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
80106cef:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80106cf2:	89 04 24             	mov    %eax,(%esp)
80106cf5:	e8 56 ff ff ff       	call   80106c50 <uva2ka>
    if(pa0 == 0)
80106cfa:	85 c0                	test   %eax,%eax
80106cfc:	75 aa                	jne    80106ca8 <copyout+0x18>
  }
  return 0;
}
80106cfe:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80106d01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d06:	5b                   	pop    %ebx
80106d07:	5e                   	pop    %esi
80106d08:	5f                   	pop    %edi
80106d09:	5d                   	pop    %ebp
80106d0a:	c3                   	ret    
80106d0b:	90                   	nop
80106d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d10:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80106d13:	31 c0                	xor    %eax,%eax
}
80106d15:	5b                   	pop    %ebx
80106d16:	5e                   	pop    %esi
80106d17:	5f                   	pop    %edi
80106d18:	5d                   	pop    %ebp
80106d19:	c3                   	ret    
