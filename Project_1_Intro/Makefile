CC = gcc -Wall -g
PROG = forkintro
PROG2 = forkingfiles

all: $(PROG) $(PROG2)

$(PROG): $(PROG).o
	$(CC) -o $@ $^
    
$(PROG).o: $(PROG).c
	$(CC) -c $<

$(PROG2): $(PROG2).o
	$(CC) -o $@ $^
    
$(PROG2).o: $(PROG2).c
	$(CC) -c $<

clean:
	rm -f *.o $(PROG) *~ \#*
	rm -f *.o $(PROG2) *~ \#*
