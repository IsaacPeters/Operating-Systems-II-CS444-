CC = gcc -Wall -g
PROG = forkintro
PROG2 = forkingfiles
PROG3 = childfirst
PROG4 = execdemo

all: $(PROG) $(PROG2) $(PROG3) $(PROG4)

$(PROG): $(PROG).o
	$(CC) -o $@ $^
    
$(PROG).o: $(PROG).c
	$(CC) -c $<

$(PROG2): $(PROG2).o
	$(CC) -o $@ $^
    
$(PROG2).o: $(PROG2).c
	$(CC) -c $<

$(PROG3): $(PROG3).o
	$(CC) -o $@ $^
    
$(PROG3).o: $(PROG3).c
	$(CC) -c $<

$(PROG4): $(PROG4).o
	$(CC) -o $@ $^
    
$(PROG4).o: $(PROG4).c
	$(CC) -c $<

clean:
	rm -f *.o $(PROG) *~ \#*
	rm -f *.o $(PROG2) *~ \#*
	rm -f *.o $(PROG3) *~ \#*
	rm -f *.o $(PROG4) *~ \#*
