#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define DIRSTR 128

void cp(char* src, char* dest) {
    int n;
    int dfd = -1;
    int sfd = -1;
    int res = -1;
    struct stat st;
    int flags = 0;

    if ()
}

int main(int argc, char** argv) {
    int i = 0;
    int res = -1;
    char* dest = NULL;
    struct stat st;
    char dirstr[DIRSTR] = {0};

    if (argc < 3) {
        printf(2, "barf %d %s %s\n", __LINE__, __FILE__, __FUNCTION__)
        exit();
    }
    dest = argv[argc - 1];
    res = stat(dest, &st);
    if (res < 0) {
        // dest does not exist
        cp(argv[1], dest);
    } else {
        // Looks like code from mv
		// switch(st.type) {
		// 	case T_DIR:
		// 		for (i = 1; i < (argc - 1); i++) {
		// 			memset(dirstr, 0, DIRSTR);
		// 			strcpy(dirstr, dest);
		// 			dirstr[strlen(dirstr)] = '/';
		// 			strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
		// 			mv(argv[i], dirstr);
		// 		}
		// 		break;
		// 	case T_FILE:
		// 		unlink(dest);
		// 		mv(argv[1], dest);
		// 		break;
		// 	default:
		// 		printf(2, "extra barf\n");
		// 		break;

		// }
    }


    exit()
}