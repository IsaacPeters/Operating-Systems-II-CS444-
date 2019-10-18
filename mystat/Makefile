CC = gcc
DEBUG = -g
DEFINES =
DEFINES += -DCHECK

CFLAGS = $(DEBUG) -Wall -Wshadow -Wunreachable-code -Wredundant-decls \
        -Wmissing-declarations -Wold-style-definition -Wmissing-prototypes \
        -Wdeclaration-after-statement $(DEFINES)
PROG = mystat

all: $(PROG)

$(PROG): $(PROG).o
	$(CC) $(CFLAGS) -o $@ $^
    
$(PROG).o: $(PROG).c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o $(PROG) *~ \#*
