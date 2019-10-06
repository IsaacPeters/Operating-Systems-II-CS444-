// This is an introductory program for the os2 class at OSU
// Created By: Isaac Peters
// The goal of this program is to refresh on using fork() and process ordering in C

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

    char* writeString = malloc(32 * sizeof(char));
    memset(writeString, '\0', 32 * sizeof(char));

	pid = fork();

    // Processes will set writeString to different values, then send it all to the file to be written

	if (pid == 0) {
		// Child process
        int status = 0;

        // Fork for each exec call we need to make. Need four children, so fork 3 times 
        pid = fork();
        if (pid == 0){
            pid = fork();
            if (pid == 0){
                // Child, Child
                // execl operates on a list of commands
                
                status = execl("/usr/bin/ls", "ls", "-l", "-F", "-h", (char *) NULL);
                perror("Error: ");

            } else if (pid > 0) {
                // Child, Parent
                // execlp operates on a list of commands and searches the PATH
                
                status = execlp("ls", "ls", "-l", "-F", "-h", (char *) NULL);
                perror("Error: ");

            }

        } else if (pid > 0) {
            pid = fork();
            if (pid == 0){
                // Parent, Child
                // execv operates on a vector of commands (argv)
                
                char* ls_argv[] = {"ls", "-l", "-F", "-h", (char *) NULL};
                status = execv("/usr/bin/ls", ls_argv);
                perror("Error: ");

            } else if (pid > 0) {
                // Parent, Parent
                // execvp operates on a vector of commands (argv) and searches the PATH
                
                char* ls_argv[] = {"ls", "-l", "-F", "-h", (char *) NULL};
                status = execvp(ls_argv[0], ls_argv);
                perror("Error: ");

            }
            
        }

	} else if (pid < 0) {
		// We forked it up
		perror("error on forking");
		exit(1);
	} else {
        // Parent process
        int exitStatus;
        waitpid(pid, &exitStatus, 0);
	}	

    exit(1);
}