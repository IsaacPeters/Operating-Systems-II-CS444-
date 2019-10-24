// Pseudo-random number generator
#include "rand.h"
static unsigned long next = 1;

int rand(void) {
    next = next * 1103515245 + 12345;
    return((unsigned)(next/65536) % MAX_RAND);
}

void srand(unsigned seed) {
    next = seed;
}