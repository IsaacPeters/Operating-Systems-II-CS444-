// Isaac Peters

#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <dirent.h>
#include <unistd.h>
#include <string.h>
#include <libgen.h>
#include <pwd.h>
#include <grp.h>

void print_rwx_string(struct stat* fileStat);

int
main(int argc, char *argv[])
{
    struct stat sb;
    struct stat sb2;
    char buffer[50];
    char *linkname;
    ssize_t r;
    struct passwd* user_info;
    struct group* group_info;
    int result;
    int i = 1;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s <pathname>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    while (i < argc) { 
        result = lstat(argv[i], &sb);
        if (result == -1) {
            perror("lstat");
            exit(EXIT_FAILURE);
        }

        printf("File: %s\n", argv[i]);

        printf("  File type:                ");

        switch (sb.st_mode & S_IFMT) {
            case S_IFBLK:  printf("block device\n");            break;
            case S_IFCHR:  printf("character device\n");        break;
            case S_IFDIR:  printf("directory\n");               break;
            case S_IFIFO:  printf("FIFO/pipe\n");               break;
            case S_IFLNK:  


                linkname = malloc(sb.st_size + 1);
                if (linkname == NULL) {
                    fprintf(stderr, "insufficient memory\n");
                    exit(EXIT_FAILURE);
                }

                r = readlink(argv[i], linkname, sb.st_size + 1);

                if (r < 0) {
                    perror("lstat");
                    exit(EXIT_FAILURE);
                }

                if (r > sb.st_size) {
                    fprintf(stderr, "symlink increased in size "
                                    "between lstat() and readlink()\n");
                    exit(EXIT_FAILURE);
                }

                linkname[sb.st_size] = '\0';

                // Symbolic link is a special case
                if (r == -1) {
                    printf("Symbolic link - error reading link\n");
                } else {
                    if ((char)linkname[0] == '/') {
                        // Absolute path, stat it to see if it exists
                        if( stat(linkname, &sb2) == 0 ) {
                            // file exists
                            printf("Symbolic link -> %s\n", linkname);   
                        } else {
                            // file doesn't exist
                            printf("Symbolic link - with dangling destination\n");
                        }
                    } else {
                        // Relative path, stat it but relative to the file entered
                        
                        if( stat(strcat(strcat(dirname(argv[i]), "/"), linkname), &sb2) == 0 ) {
                            // file exists
                            printf("Symbolic link -> %s\n", linkname);   
                        } else {
                            // file doesn't exist
                            printf("Symbolic link - with dangling destination\n");
                        }
                    }
                }
                
                //  if( stat(linkname, &sb2) == 0 ) {
                //     printf("File %s exists ", linkname);
                //     // file exists
                //     printf("Symbolic link -> %s\n", linkname);   
                // } else {
                //     printf("File %s DNE ", linkname);
                //     // file doesn't exist
                //     printf("Symbolic link - with dangling destination\n");
                // }

                free(linkname);          
            
            break;
            case S_IFREG:  printf("regular file\n");            break;
            case S_IFSOCK: printf("socket\n");                  break;
            default:       printf("unknown?\n");                break;
        }

        printf("  Device ID number:         %ld\n", (long) sb.st_dev);
        printf("  I-node number:            %ld\n", (long) sb.st_ino);

        printf("  Mode:                     "); print_rwx_string(&sb); printf("        (%lo in octal)\n",
                    (unsigned long) sb.st_mode % 512);

        // Get user and group information
        user_info = getpwuid(sb.st_uid);
        group_info = getgrgid(sb.st_gid);

        printf("  Link count:               %ld\n", (long) sb.st_nlink);
        printf("  Owner Id:                 %-18s(UID = %ld)\n",
                user_info->pw_name, (long) sb.st_uid);
        printf("  Group Id:                 %-18s(GID = %ld)\n",
                group_info->gr_name, (long) sb.st_gid);

        printf("  Preferred I/O block size: %ld bytes\n",
                    (long) sb.st_blksize);
        printf("  File size:                %lld bytes\n",
                (long long) sb.st_size);
        printf("  Blocks allocated:         %lld\n",
                (long long) sb.st_blocks);

        strftime(buffer, 50, "%Y-%m-%d %H:%M:%S %z (%Z) %a (local)", localtime(&sb.st_atime));
        printf("  Last file access:         %s\n", buffer);
        strftime(buffer, 50, "%Y-%m-%d %H:%M:%S %z (%Z) %a (local)", localtime(&sb.st_mtime));
        printf("  Last file modification:   %s\n", buffer);
        strftime(buffer, 50, "%Y-%m-%d %H:%M:%S %z (%Z) %a (local)", localtime(&sb.st_ctime));
        printf("  Last status change:       %s\n", buffer);

        i++; // increment argument counter
    }

    exit(EXIT_SUCCESS);
}

void
print_rwx_string(struct stat* fileStat) {
    // first char is tricker, depends on file type. switch statement just for that
    switch (fileStat->st_mode & S_IFMT) {
            case S_IFBLK:  printf("b");                     break;
            case S_IFCHR:  printf("c");                     break;
            case S_IFDIR:  printf("d");                     break;
            case S_IFIFO:  printf("p");                     break;
            case S_IFLNK:  printf("l");                     break;
            case S_IFREG:  printf("-");                     break;
            case S_IFSOCK: printf("s");                     break;
            default:       printf("-");                     break;
    }
    printf( (fileStat->st_mode & S_IRUSR) ? "r" : "-");
    printf( (fileStat->st_mode & S_IWUSR) ? "w" : "-");
    printf( (fileStat->st_mode & S_IXUSR) ? "x" : "-");
    printf( (fileStat->st_mode & S_IRGRP) ? "r" : "-");
    printf( (fileStat->st_mode & S_IWGRP) ? "w" : "-");
    printf( (fileStat->st_mode & S_IXGRP) ? "x" : "-");
    printf( (fileStat->st_mode & S_IROTH) ? "r" : "-");
    printf( (fileStat->st_mode & S_IWOTH) ? "w" : "-");
    printf( (fileStat->st_mode & S_IXOTH) ? "x" : "-");
}
