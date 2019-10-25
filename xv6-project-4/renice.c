#include "types.h"
#include "stat.h"
#include "user.h"

int 
main(int argc, char *argv[]) {
#ifdef LOTTERY_SCHED
    int i;
    int r;

    if (argc < 3) {
        printf(1,"Not enough arguments; renice nicev pid1 ...\n");
    }

    for ( i = 2; i < argc; i++ ) {
        r = renice(atoi(argv[1]), atoi(argv[i]));
        if (r < 0) {
            printf(1,"ERROR: arguments invalid, pid %s not changed to %s\n", argv[i], argv[1]);
        } else if (r == 1) {
            printf(1,"ERROR: nice value out of bounds\n");
        } else if (r == 2) {
            printf(1,"ERROR: pid %s not found\n", argv[i]);
        }
    }
#endif
    exit();
}