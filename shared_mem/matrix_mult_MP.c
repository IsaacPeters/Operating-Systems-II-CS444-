/*
 * R Jesse Chaney
 */

#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <libgen.h>
#include <pthread.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <semaphore.h>

#ifndef TRUE
# define TRUE 1
#endif // TRUE
#ifndef FALSE
# define FALSE 0
#endif // FALSE

// Strangly, I've found that the 32bit calculations are faster!
// The 64bit integers are slower and require a lot more space.
//#define GO_64
#ifdef GO_64
# define MATRIX_TYPE int64_t
#else
# define MATRIX_TYPE int32_t
#endif // GO_64

typedef struct matrix_s {
    char *file_name;
    int32_t rows;
    int32_t cols;
    MATRIX_TYPE *data;
} matrix_t;

#ifdef DYNAMIC
// these are used with semaphores
#define SHARE_WITHIN_PROCESS    0  // Share for threads within a single process
#define SHARE_BETWEEN_PROCESSES 1  // Share between multiple processes

#define AVAILABLE_RESOURCES 1
#define SEM_NAME "semMemMatrixMult"

struct next_row_sem_s {
    sem_t sem_lock;
    unsigned next_row;
} ;
#endif // DYNAMIC

#define SHM_NAME "shmMemMatrixMult"
#define DEFAULT_PROC_COUNT 1
#define MICROSECONDS_PER_SECOND 1000000.0D
#define COMMAND_ARGS "vhl:r:o:p:sS"
#define BUFFER_LEN 265

static short isVerbose = 0;

static void read_file(matrix_t *matrix);
static void free_matrix(matrix_t *matrix);
static void calc_row(matrix_t *lmatrix, matrix_t *rmatrix, matrix_t *omatrix, int32_t row);
static void output_matrix(matrix_t *matrix, char *file_name);

int 
main(int argc, char *argv[])
{
    struct timeval tv0;
    struct timeval tv3;
    struct timeval tv4;
    struct timeval tv6;

    matrix_t *omatrix = NULL;
    matrix_t *lmatrix = NULL;
    matrix_t *rmatrix = NULL;

    long numProcs = DEFAULT_PROC_COUNT;
    short serialOnly = FALSE;
    short itsShowTime = 0;

    gettimeofday (&tv0, NULL);
    lmatrix = calloc(1, sizeof(matrix_t));
    rmatrix = calloc(1, sizeof(matrix_t));
    omatrix = calloc(1, sizeof(matrix_t));

    {
        char c;

        // v - verbose
        // h - help
        // l - left matrix - no default
        // r - right matrix - no default
        // o - output file - stdout is default
        // p - process count - default 1
        // S - serial only, no multi-process stuff at all
        // s - collect and show timing results
        while ((c = getopt(argc, argv, COMMAND_ARGS)) != -1) {
            switch (c) {
            case 'v':
                isVerbose = TRUE;
                break;
            case 'h':
                fprintf(stderr, "%s %s\n", basename(argv[0]), COMMAND_ARGS);
                fprintf(stderr, "\tv - verbose\n"
                       "\th - help\n"
                       "\tl - left matrix - no default\n"
                       "\tr - right matrix - no default\n"
                       "\to - output file - stdout is default\n"
                       "\tp - process count - default 0\n"
                       "\tS - serial only, no multi-process stuff at all\n"
                       "\ts - collect and show timing results\n"
                    );
                exit(EXIT_SUCCESS);
                break;
            case 's':
                itsShowTime++;
                break;
            case 'l':
                lmatrix->file_name = optarg;
                break;
            case 'r':
                rmatrix->file_name = optarg;
                //rfile_name = strdup(optarg);
                break;
            case 'o':
                omatrix->file_name = optarg;
                //ofile_name = strdup(optarg);
                break;
            case 'p':
                numProcs = atoi(optarg);
                if (numProcs < 1) {
                    numProcs = DEFAULT_PROC_COUNT;
                }
                break;
            case 'S':
                serialOnly = TRUE;
                break;
            default:
                // oops
                break;
            }
        }
    }

    if (NULL == lmatrix->file_name || NULL == rmatrix->file_name) {
        fprintf(stderr, "*** You must provide file names for both the "
                "left and right matrix files ***\n");
        exit(EXIT_FAILURE);
    }

    if (serialOnly) {
        int32_t row = 0;

        numProcs = 0;
        read_file(lmatrix);
        read_file(rmatrix);

        if (lmatrix->cols == rmatrix->rows) {
            // If A is an n × m matrix and B is an m × p matrix, their matrix 
            // product AB is an n × p matrix.
            //    https://en.wikipedia.org/wiki/Matrix_multiplication
            //    https://www.mathsisfun.com/algebra/matrix-multiplying.html
            omatrix->rows = lmatrix->rows;
            omatrix->cols = rmatrix->cols;
            omatrix->data = calloc(omatrix->rows * omatrix->cols, sizeof(MATRIX_TYPE));
      
            gettimeofday (&tv3, NULL);
            for (row = 0; row < omatrix->rows; row++) {
                calc_row(lmatrix, rmatrix, omatrix, row);
            }

            gettimeofday (&tv4, NULL);
            output_matrix(omatrix, omatrix->file_name);
        }
        else {
            fprintf(stderr, "*** the left matrix must have the same "
                    "number of colums as the right matrix has rows ***\n");
            exit(EXIT_FAILURE);
        }
    }
    else if (numProcs > 0) {
#ifdef DYNAMIC
        char semName[BUFFER_LEN] = {0};
        int semfd = -1;
        struct next_row_sem_s* next_row_sem = NULL;
#endif // DYNAMIC
        char shmName[BUFFER_LEN] = {0};
        int shmfd = -1;
        size_t shared_seg_size = -1;

        read_file(lmatrix);
        read_file(rmatrix);
        omatrix->rows = lmatrix->rows;
        omatrix->cols = rmatrix->cols;

        {

#ifdef DYNAMIC
            sprintf(semName, "/%s.%s", SEM_NAME, getenv("LOGNAME"));
            if (shm_unlink(semName) != 0) {
                // more pithy messages
            }
            semfd = shm_open(semName, (O_CREAT | O_RDWR | O_EXCL)
                            , (S_IRUSR | S_IWUSR));
            ftruncate(semfd, sizeof(struct next_row_sem_s));
            next_row_sem = mmap(NULL, sizeof(struct next_row_sem_s)
                                , PROT_READ | PROT_WRITE
                                , MAP_SHARED
                                , semfd
                                , 0);
            sem_init(&(next_row_sem->sem_lock), SHARE_BETWEEN_PROCESSES, 1);
            next_row_sem->next_row = 0;
#endif // DYNAMIC
            sprintf(shmName, "/%s.%s", SHM_NAME, getenv("LOGNAME"));
            if (shm_unlink(shmName)) {
                // printf pithy message
            }
            shmfd = shm_open(shmName, (O_CREAT | O_RDWR | O_EXCL)
                            , (S_IRUSR | S_IWUSR));
            
            if (shmfd < 0) {
                exit(EXIT_FAILURE);
            }
            shared_seg_size = lmatrix->cols * rmatrix->rows * sizeof(MATRIX_TYPE);
            ftruncate(shmfd, shared_seg_size);  
            omatrix->data = mmap(NULL, shared_seg_size, PROT_READ | PROT_WRITE
                                , MAP_SHARED, shmfd, 0);
            fflush(stdout);
            fflush(stderr);
            {
                int proc = 0;
                pid_t cpid = -1;

                gettimeofday(&tv3, NULL);
                for (proc = 0; proc < numProcs; proc++) {
                    cpid = fork();
                    if (cpid == 0) {
                        // Child Process
                        int row = -1;
#ifdef DYNAMIC
                        // map the shared memory space into the child processes
                        // bad me

                        while (row < omatrix->rows) {
                            // CRITICAL SECTION, acquires semaphor (and other stuff)
                            sem_wait(&(next_row_sem->sem_lock));
                            row = (next_row_sem->next_row)++;
                            sem_post(&(next_row_sem->sem_lock));

                            calc_row(lmatrix, rmatrix, omatrix, row);
                        }
                        munmap(next_row_sem, sizeof(struct next_row_sem_s));
                        close(semfd);
#else // DYNAMIC
                        for (row = proc; row < omatrix->rows; row += numProcs) {
                            calc_row(lmatrix, rmatrix, omatrix, row);
                        }
#endif // DYNAMIC
                        munmap(omatrix->data, shared_seg_size);
                        close(shmfd);
                        _exit(EXIT_FAILURE); // doesn't flush stdout, stderr; use for child processes
                    } else {
                        // Parent Process

                    }   
                }
                proc = 0;
                while((cpid = wait(NULL)) > 0) {
                    printf("child %d %d is done\n", proc++, cpid);
                }
                output_matrix(omatrix, omatrix->file_name);

#ifdef DYNAMIC
                sem_destroy(&(next_row_sem->sem_lock));
                munmap(next_row_sem, sizeof(struct next_row_sem_s));
                close(semfd);
                shm_unlink(semName);
#endif // DYNAMIC

                munmap(omatrix->data, shared_seg_size);
                close(shmfd);
                shm_unlink(shmName);
                omatrix->data = NULL;
            }          
        }
    }
    else {
        fprintf(stderr, "must have a positive number of procsses: %ld\n", numProcs);
        exit(EXIT_FAILURE);
    }

    free_matrix(lmatrix);
    free_matrix(rmatrix);
    free_matrix(omatrix);

    gettimeofday (&tv6, NULL);

    if (itsShowTime > 0)
    {
        double mult_time = 
            (((double) (tv4.tv_usec - tv3.tv_usec)) / MICROSECONDS_PER_SECOND)
            + ((double) (tv4.tv_sec - tv3.tv_sec));
        double total_time = 
            (((double) (tv6.tv_usec - tv0.tv_usec)) / MICROSECONDS_PER_SECOND)
            + ((double) (tv6.tv_sec - tv0.tv_sec));

        fprintf(stderr, "%ld %.4lf %.4lf\n"
                , numProcs, total_time, mult_time);
    }

    return EXIT_SUCCESS;
}

void 
read_file(matrix_t *matrix)
{
    FILE *file = NULL;
    char *dot = strrchr(matrix->file_name, '.');
    short inputFilesZipped = FALSE;
    
    inputFilesZipped = strcmp(dot, ".gz") == 0;
    if (inputFilesZipped) {
        char cmd[BUFFER_LEN] = {0};

        sprintf(cmd, "gunzip -c %s", matrix->file_name);
        file = popen(cmd, "r");
    }
    else {
        file = fopen(matrix->file_name, "r");
    }
    if (NULL == file) {
        perror("count open input file");
        fprintf(stderr, "*** failed to open input file '%s' ***\n", matrix->file_name);
        exit(EXIT_FAILURE);
    }

    // Read the size of the matrix, rows columns.
    fscanf(file, "%d %d", &matrix->rows, &matrix->cols);
    {
        int32_t loc = 0;

        // Allocate a big gulp of memory.
        matrix->data = calloc(matrix->rows * matrix->cols, sizeof(MATRIX_TYPE));
        for (loc = 0; loc < matrix->rows * matrix->cols; loc++) {
            fscanf(file, "%d ", &(matrix->data[loc]));
        }
    }
    if (inputFilesZipped) {
        pclose(file);
    }
    else {
        fclose(file);
    }
}

void 
free_matrix(matrix_t *matrix)
{
    if (matrix != NULL) {
        if (matrix->data != NULL) {
            free(matrix->data);
        }
        //free(matrix->file_name);
        free(matrix);
    }
}

void 
calc_row(matrix_t *lmat, matrix_t *rmat, matrix_t *omat, int32_t calc_row)
{
    int32_t lcol = 0;
    int32_t rcol = 0;
    int32_t loc = 0;
    MATRIX_TYPE sum = 0;

    for (rcol = 0; rcol < rmat->cols; rcol++) {
        sum = 0;
        loc = calc_row * omat->cols + rcol;
        for (lcol = 0; lcol < lmat->cols; lcol++) {
            // This is a bit messy.
            sum += lmat->data[calc_row * lmat->cols + lcol] 
                * rmat->data[lcol * rmat->cols + rcol];
        }
        omat->data[loc] = sum;
    }
}

void 
output_matrix(matrix_t *matrix, char *file_name)
{
    FILE *file = stdout;
    int32_t loc = 0;

    if (NULL != matrix) {
        if (file_name != NULL) {
            file = fopen(file_name, "w");
        }
        // If the file_name is NULL, then output to stdout.

        fprintf(file,  "%d %d\n", matrix->rows, matrix->cols);
        for (loc = 0; loc < matrix->rows * matrix->cols; loc++) {
            fprintf(file, "%d ", matrix->data[loc]);
            if ((loc + 1) % matrix->cols == 0 && loc != 0) {
                fprintf(file, "\n");
            }
        }

        if (file_name != NULL) {
            fclose(file);
        }
    }
}
