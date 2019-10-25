#ifdef RANDOM
#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    printf(1, "Random number is: %d\n", random());

    exit();
}
#endif //RANDOM