// This is an introductory program for the os2 class at OSU
// Created By: Isaac Peters
// The goal of this program is to refresh on using fork() and fileIO in C

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
    printf("TEST");
    pid_t pid, wpid;
	
    printf("before fork");

	pid = fork();

    // Both processes use the same xx variable (points to the same location), so xx holds the value of whoever modified it last

	if (pid == 0) {
		// Child process
        char child[50] = "child";
        printf("child");
        print_string_to_file(child);

		exit(1);
	} else if (pid < 0) {
		// We forked it up
		perror("error on forking");
		exit(1);
	} else {
		// Parent process
        char parent[50] = "parent";
        printf("parent");
        print_string_to_file(parent);
        
        exit(1);
	}	
}

void print_string_to_file(const char* thing_to_print) {
    FILE* fp = fopen ("JUNK.txt", "r");
    fprintf(fp, thing_to_print);
    fclose(fp);
}