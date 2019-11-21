/*
 * R Jesse Chaney
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <libgen.h>

#ifndef TRUE
# define TRUE 1
#endif // TRUE
#ifndef FALSE
# define FALSE 0
#endif // FALSE

#define DEFAULT_UPPER_BOUND 64
#define DEFAULT_ROWS 100
#define DEFAULT_COLS 100

int main(
     int argc
     , char *argv[]
)
{
  char *file_name = NULL;
  FILE *ofile = stdout;
  int ofd = STDOUT_FILENO;
  int32_t num_rows = DEFAULT_ROWS;
  int32_t num_cols = DEFAULT_COLS;
  int32_t upper_bound = DEFAULT_UPPER_BOUND;
  short identityMatrix = FALSE;
  short binaryOutput = FALSE;

  {
    char c;

    while ((c = getopt(argc, argv, "hr:c:o:u:IB")) != -1) {
      switch (c) {
      case 'h':
	printf("%s [-r #] [-c #] [-o name] [-u #] [-h] [-I]\n", basename(argv[0]));
	printf("\t-h show some help and exit\n");
	printf("\t-r <num rows> the default is %d\n", DEFAULT_ROWS);
	printf("\t-c <num cols> the default is %d\n", DEFAULT_COLS);
	printf("\t-o <output file name> the default is stdout\n");
	printf("\t-u <upper bound> the maximum value when generating random values, default is %d\n", DEFAULT_UPPER_BOUND);
	printf("\t-I create an identity matrix of rows by rows size\n");
	printf("\t-B create binary output\n");
	exit(EXIT_SUCCESS);
	break;
      case 'r':
        num_rows = atoi(optarg);
        break;
      case 'c':
	num_cols = atoi(optarg);
        break;
      case 'o':
	file_name = strdup(optarg);
	break;
      case 'u':
	upper_bound = atoi(optarg);
	break;
      case 'I':
	// Produce an identity matrix.
	identityMatrix = TRUE;
	break;
      case 'B':
	// Produce binary output
	binaryOutput = TRUE;
	break;
      default:
        // oops
        break;
      }
    }
  }

  if (file_name != NULL) {
    if (binaryOutput) {
      ofd = open(file_name, O_CREAT | O_TRUNC | O_WRONLY);
      if (ofd < 0) {
	perror("count open output file");
	fprintf(stderr, "*** failed to open output file '%s' ***\n", file_name);
	exit(EXIT_FAILURE);
      }
    }
    else {
      ofile = fopen(file_name, "w");
      if (NULL == ofile) {
	perror("count open output file");
	fprintf(stderr, "*** failed to open output file '%s' ***\n", file_name);
	exit(EXIT_FAILURE);
      }
    }
  }

  srand((unsigned int) time(NULL));

  if (identityMatrix) {
    num_cols = num_rows;
  }

  if (binaryOutput) {
    write(ofd, &num_rows, sizeof(num_rows));
    write(ofd, &num_cols, sizeof(num_cols));
  }
  else {
    fprintf(ofile, "%d %d\n", num_rows, num_cols);
  }

  {
    int32_t row = 0;
    int32_t col = 0;
    int32_t val = -1;
    short neg = -1;

    for (row = 0; row < num_rows; row++) {
      for (col = 0; col < num_cols; col++) {
	if (identityMatrix) {
	  if (row == col) {
	    val = 1;
	  }
	  else {
	    val = 0;
	  }
	}
	else {
	  val = rand() % upper_bound;
	  neg = rand() % 2;

	  if (neg) {
	    val = -val;
	  }
	}
	if (binaryOutput) {
	  write(ofd, &val, sizeof(val));
	}
	else {
	  fprintf(ofile, "%d ", val);
	}
      }
      if (binaryOutput) {
	// nothing to do, newline not necessary
      }
      else {
	fprintf(ofile, "\n");
      }
    }
  }

  if (file_name != NULL) {
    free(file_name);
    fclose(ofile);
  }

  return EXIT_SUCCESS;
}
