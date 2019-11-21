/*
 * R Jesse Chaney
 */

#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <libgen.h>
#include <pthread.h>

#ifndef TRUE
# define TRUE 1
#endif // TRUE
#ifndef FALSE
# define FALSE 0
#endif // FALSE

#ifndef MATRIX_TYPE
# define MATRIX_TYPE int32_t
#endif // MATRIX_TYPE

typedef struct matrix_s {
    char *file_name;
    int32_t rows;
    int32_t cols;
    MATRIX_TYPE **data;
} matrix_t;

#define DEFAULT_THREAD_COUNT 1
#define MICROSECONDS_PER_SECOND (1000000.0D)
#define COMMAND_ARGS "vhl:r:o:t:Ss"

static short serialOnly = FALSE;
static short isVerbose = FALSE;
static long numThreads = DEFAULT_THREAD_COUNT;
static short itsShowTime = 0;
static matrix_t *omatrix = NULL;    // the output matrix - defaults to stdout
static matrix_t *lmatrix = NULL;    // the lefthand matrix
static matrix_t *rmatrix = NULL;    // the righthand matrix

static void read_file(matrix_t *matrix);
static void free_matrix(matrix_t *matrix);
static void calc_row(matrix_t *lmatrix, matrix_t *rmatrix, matrix_t *omatrix, int32_t row);
static void output_matrix(matrix_t *matrix, char *file_name);

// new functions we added
int getNextRow(void);
void* cal_rowThreadMutex(void*);

int
main(int argc, char *argv[])
{
    struct timeval tv0;
    struct timeval tv2;
    struct timeval tv4;
    struct timeval tv5;
    struct timeval tv6;

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
        // t - thread count - default 1
        // S - serial, no thread stuff at all
        // s - collect and show timing results
        while ((c = getopt(argc, argv, COMMAND_ARGS)) != -1) {
            switch (c) {
            case 'v':
                isVerbose = TRUE;
                break;
            case 'h':
                printf("%s %s\n", basename(argv[0]), COMMAND_ARGS);

                printf("\tv - verbose\n");
                printf("\th - help\n");
                printf("\tl - left matrix - no default\n");
                printf("\tr - right matrix - no default\n");
                printf("\to - output file - stdout is default\n");
                printf("\tt - thread count - default 1\n");
                printf("\tS - serial, no thread stuff at all\n");
                printf("\ts - collect and show timing results\n");


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
                break;
            case 'o':
                omatrix->file_name = optarg;
                break;
            case 't':
                numThreads = atoi(optarg);
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
        fprintf(stderr, "*** You must provide file names for both the left "
                "and right matrix files ***\n");
        exit(EXIT_FAILURE);
    }

    if (serialOnly) {
        int32_t row = 0;

        numThreads = 0;
        read_file(lmatrix);
        read_file(rmatrix);

        // this is so i can tell how much time was spent reading input
        gettimeofday (&tv2, NULL);

        if (lmatrix->cols == rmatrix->rows) {
            // If A is an n × m matrix and B is an m × p matrix, their matrix 
            // product AB is an n × p matrix.
            //    https://en.wikipedia.org/wiki/Matrix_multiplication
            //    https://www.mathsisfun.com/algebra/matrix-multiplying.html
            omatrix->rows = lmatrix->rows;
            omatrix->cols = rmatrix->cols;
            omatrix->data = calloc(omatrix->rows, sizeof(MATRIX_TYPE *));
      
            for (row = 0; row < omatrix->rows; row++) {
                calc_row(lmatrix, rmatrix, omatrix, row);
            }
        }
        else {
            fprintf(stderr, "*** the left matrix must have the same number "
                    "of colums as the right matrix has rows ***\n");
        }
    } else {
        // Multi-threaded approach!
        long tcount = 0;
        pthread_t* wthreads = NULL;

        read_file(lmatrix);
        read_file(rmatrix);
        gettimeofday(&tv2, NULL);

        omatrix->rows = lmatrix->rows;
        omatrix->cols = rmatrix->cols;
        omatrix->data = calloc(omatrix->rows, sizeof(MATRIX_TYPE *));

        wthreads = calloc(numThreads, sizeof(pthread_t));
        for (tcount = 0; tcount < numThreads; tcount++) {
            pthread_create(&(wthreads[tcount])
                                , NULL
                                , cal_rowThreadMutex
                                , (void *) tcount); /* C magic. Casts long as void*, because they're the same size and this requires a void* */
        }
        for (tcount = 0; tcount < numThreads; tcount++) {
            pthread_join(wthreads[tcount], NULL);
        }


    }

    // this allows me to see how much time was spent on just the calc
    gettimeofday (&tv4, NULL);
    output_matrix(omatrix, omatrix->file_name);

    // how much time was just the o/p
    gettimeofday (&tv5, NULL);
    free_matrix(lmatrix);
    free_matrix(rmatrix);
    free_matrix(omatrix);

    // total time
    gettimeofday (&tv6, NULL);

    if (itsShowTime > 0)
    {
        double read_time = 
            (((double) (tv2.tv_usec - tv0.tv_usec)) / MICROSECONDS_PER_SECOND)
            + ((double) (tv2.tv_sec - tv0.tv_sec));
        double mult_time = 
            (((double) (tv4.tv_usec - tv2.tv_usec)) / MICROSECONDS_PER_SECOND)
            + ((double) (tv4.tv_sec - tv2.tv_sec));
        double output_time = 
            (((double) (tv5.tv_usec - tv4.tv_usec)) / MICROSECONDS_PER_SECOND)
            + ((double) (tv5.tv_sec - tv4.tv_sec));
        double total_time = 
            (((double) (tv6.tv_usec - tv0.tv_usec)) / MICROSECONDS_PER_SECOND)
            + ((double) (tv6.tv_sec - tv0.tv_sec));

        fprintf(stderr, "%ld %lf %lf %lf %lf\n"
                , numThreads, total_time, mult_time, output_time, read_time);
    }

    return EXIT_SUCCESS;
}

void*
cal_rowThreadMutex(void* arg) {
    long tid = (long) arg;
    int row = tid;

    for (row = getNextRow(); row < omatrix->rows; row = getNextRow()) {
        calc_row(lmatrix, rmatrix, omatrix, row);
    }

    pthread_exit(EXIT_SUCCESS);
}

int
getNextRow(void) {
    static pthread_mutex_t count_mutex = PTHREAD_MUTEX_INITIALIZER;
    static int nextRow = 0;
    int val = 0;

    pthread_mutex_lock(&count_mutex);
    val = nextRow++;
    pthread_mutex_unlock(&count_mutex);

    return val;
}

void
read_file(matrix_t *matrix)
{
    FILE *file = NULL;

    file = fopen(matrix->file_name, "r");
    if (NULL == file) {
        perror("count open input file");
        fprintf(stderr, "*** failed to open input file '%s' ***\n", matrix->file_name);
        exit(EXIT_FAILURE);
    }

    fscanf(file, "%d %d", &matrix->rows, &matrix->cols);
    {
        int32_t row = 0;
        int32_t col = 0;

        matrix->data = calloc(matrix->rows, sizeof(MATRIX_TYPE *));
        for (row = 0; row < matrix->rows; row++) {
            matrix->data[row] = calloc(matrix->cols, sizeof(MATRIX_TYPE));
            for (col = 0; col < matrix->cols; col++) {
                fscanf(file, "%d ", &(matrix->data[row][col]));
            }
        }
    }
    if (isVerbose) {    
        int32_t row = 0;
        int32_t col = 0;

        fprintf(stderr,  "rows: %d cols: %d\n", matrix->rows, matrix->cols);
        for (row = 0; row < matrix->rows; row++) {
            for (col = 0; col < matrix->cols; col++) {
                fprintf(stderr, "%d ", matrix->data[row][col]);
            }
            fprintf(stderr, "\n");
        }
    }
    fclose(file);
}

void
free_matrix(matrix_t *matrix)
{
    int32_t row = 0;

    if (isVerbose) {
        fprintf(stderr, "%s %s %d: %s\n", __FILE__, __FUNCTION__, __LINE__, matrix->file_name);
    }
    if (matrix != NULL) {
        for (row = 0; row < matrix->rows; row++) {
            free(matrix->data[row]);
        }
        free(matrix->data);
        //free(matrix->file_name);
        free(matrix);
    }
}

void
output_matrix(matrix_t *matrix, char *file_name)
{
    FILE *file = stdout;
    int32_t row = 0;
    int32_t col = 0;

    if (NULL != matrix) {
        if (file_name != NULL) {
            file = fopen(file_name, "w");
        }

        fprintf(file,  "%d %d\n", matrix->rows, matrix->cols);
        for (row = 0; row < matrix->rows; row++) {
            for (col = 0; col < matrix->cols; col++) {
                fprintf(file, "%d ", matrix->data[row][col]);
            }
            fprintf(file, "\n");
        }

        if (file_name != NULL) {
            fclose(file);
        }
    }
}

void
calc_row(matrix_t *lmat, matrix_t *rmat, matrix_t *omat, int32_t calc_row)
{
    int32_t lcol = 0;
    int32_t rcol = 0;
    MATRIX_TYPE sum = 0;

    omat->data[calc_row] = calloc(omat->cols, sizeof(MATRIX_TYPE));
    for(rcol = 0; rcol < rmat->cols; rcol++) {
        sum = 0;
        for (lcol = 0; lcol < lmat->cols; lcol++) {
            sum += lmat->data[calc_row][lcol] * rmat->data[lcol][rcol];
        }
        omat->data[calc_row][rcol] = sum;
    }
}
