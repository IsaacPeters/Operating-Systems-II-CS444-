// This is an introductory program for the os2 class at OSU
// Created By: Isaac Peters
// The goal of this program is to refresh on using fork() in C

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

// MAIN *********************************************************************************************

int main() {
    pid_t pid, wpid;
	
    int xx = 100;
    printf("Prior to forking, xx is %d\n", xx);

	pid = fork();

	if (pid == 0) {
		// Child process
        printf("Child starts, xx is %d\n", xx);
        xx = 777;
        printf("Child sets xx to 777, xx is %d\n", xx);

		exit(1);
	} else if (pid < 0) {
		// We forked it up
		perror("error on forking");
		exit(1);
	} else {
		// Parent process
        printf("Parent starts, xx is %d\n", xx);
        xx = 999;
        printf("Parent sets xx to 999, xx is %d\n", xx);
        
        exit(1);
	}	
}