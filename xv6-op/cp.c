#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define DIRSTR 128
#define BUFSIZE 512

void
cp(char *src, char *dest)
{
    int n;
    int dfd = -1;
    int sfd = -1;
    int res = -1;
    struct stat st;
    int flags = 0;
    
    if ((sfd = open(src, O_RDONLY)) >= 0) {
        res = stat(dest, &st);
        if(res >= 0) {
            unlink(dest); // Should check for errors
        } 
        flags = O_CREATE | O_WRONLY;
        if ((dfd = open(dest, falgs)) >= 0) {
            for(/*init*/;
                ((nread(sfd, buf, BUFSIZE)) > 0) && ((res = write(dfd, buf, n)));
                /*increment*/);
            close(dfd);
        } else {
            printf(2, "gack3\n");
            exit();
        }
    } else {
        printf(2, "gack1\n");
        exit();
    }
}

int main(int argc, char **argv)
{
    int i = 0;
    int res = -1;
    char *dest = NULL;
    struct stat st;
    char dirstr[DIRSTR] = {0};

    if (argc < 3) {
        printf(2, "barf %d %s %s\n", __LINE__, __FILE__, __FUNCTION__);
        exit();
    }
    dest = argv[argc - 1];
    res = stat(dest, &st);
    if (res < 0) {
        // dest does not exist
        cp(argv[1], dest);
    }
    else {
        // looks like code from mv
        switch(st.type) {
            case T_DIR:
                // loop through files creating dirstr
                // cp(src, dirstr)
                break;
            case T_FILE:
                // single file
                
                break;
            default:
                break;
        }
    }

    exit();
}
