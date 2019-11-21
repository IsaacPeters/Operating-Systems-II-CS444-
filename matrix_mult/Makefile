# R Jesse Chaney
# 

CC = gcc
DEBUG = -g -ggdb
DEFINES = -DDEBUG -pthread

CFLAGS = $(DEBUG) -Wall -Wshadow -Wunreachable-code -Wredundant-decls \
        -Wmissing-declarations -Wold-style-definition -Wmissing-prototypes \
        -Wdeclaration-after-statement -Wno-return-local-addr -Wuninitialized \
	$(DEFINES)
PROG1 = gen_data
SRCS1 = \
	$(PROG1).c \
	$(EMPTY)
OBJS1 = $(SRCS1:.c=.o)

PROG2 = matrix_mult_MT
SRCS2 = \
	$(PROG2).c \
	$(EMPTY)
OBJS2 = $(SRCS2:.c=.o)

PROGS = $(PROG1) $(PROG2) $(PROG3) $(PROG4) $(PROG5)

all: $(PROGS)

$(PROG1): $(OBJS1)
	$(CC) $(CFLAGS) -o $@ $^

gen_data.o: gen_data.c
	$(CC) $(CFLAGS) -c $<

$(PROG2): $(OBJS2)
	$(CC) $(CFLAGS) -o $@ $^

$(PROG2).o: $(PROG2).c
	$(CC) $(CFLAGS) -c $<

opt:
	make clean all DEBUG="-Ofast -ffinite-math-only -fno-math-errno"

# clean up the compiled files and editor chaff
clean:
	rm -f $(PROGS) *.o *~ \#* 


ci:
	ci -l -m"lazy checkin" *.[ch] [mM]akefile
