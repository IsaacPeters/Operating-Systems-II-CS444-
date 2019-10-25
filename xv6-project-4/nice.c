#include "types.h"
#include "user.h"

int 
main(int argc, char *argv[]) {
#ifdef LOTTERY_SCHED
    if (argc < 3) {
        printf(1,"Not enough arguments; renice nicev command\n");
    }
    renice(atoi(argv[1]), getpid());
    exec(argv[2], &argv[2]);

#endif

    // Shouldn't get here
    exit();
}