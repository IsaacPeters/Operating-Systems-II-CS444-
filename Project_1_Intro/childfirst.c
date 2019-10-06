// This is an introductory program for the os2 class at OSU
// Created By: Isaac Peters
// The goal of this program is to refresh on using fork() and exec() in C

#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>
#include <dirent.h>
#include <sys/types.h>
#include <unistd.h>
#include <pthread.h>
#include <stdbool.h>
#include <sys/wait.h>
#include <signal.h>

void print_string_to_file(const char* thing_to_print);

// MAIN *********************************************************************************************


int main() {
    pid_t pid;
	
    printf("before fork\n");

	pid = fork();

    char* writeString = malloc(32 * sizeof(char));
    memset(writeString, '\0', 32 * sizeof(char));

    // Processes will set writeString to different values, then send it all to the file to be written

	if (pid == 0) {
		// Child process
        sprintf(writeString, "hello");
	} else if (pid < 0) {
		// We forked it up
		perror("error on forking");
		exit(1);
	} else {
        sprintf(writeString, "goodbye");
        int exitStatus;
        waitpid(pid, &exitStatus, 0);
	}	
    
    printf("%s\n", writeString);

    exit(1);
}