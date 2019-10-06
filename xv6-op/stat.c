#include "types.h"
#include "stat.h"
#include "user.h"

char* filetype(int sttype) {
    static char filetype[20];

    memset(filetype, 0, sizeof(filetype));
    switch(sttype) {
        case T_DIR:
            strcpy(filetype, "directory");
            break;
        case T_FILE:
            strcpy(filetype, "regular file");
            break;
        case T_DEV:
            strcpy(filetype, "device");
            break;
        default:
            strcpy(filetype, "wtf");
            break;
    }

    return filetype;
}

int main (int argc, char *argv[]) {
    int i; 
    int res;
    struct stat st;

    for (i = 0; i < argc; i++) {
        res = stat(argv[i], &st);

        if (res < 0) {
            printf(2, "barf on file %s\n", argv[i]);
        } else {
            printf(1, "name: %s\n tupe: %s\n links: %d\n inode: %d\n size: %d\n",
                argv[i], filetype(st.type), st.nlink, st.ino, st.size);
        }
    }

    exit();
}