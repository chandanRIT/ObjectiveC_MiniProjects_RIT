#ifndef SHELL_H
#define SHELL_H

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<sys/types.h>
#include<unistd.h>
#include<stdbool.h>
#include<sys/wait.h>
#include<errno.h>
#import<Foundation/NSObject.h>
#import "CommandHistory.h"

//
// 4005-714-02 - Lab 2 - Memory Management
// Main shell script
//
// 31 March 2013
// Author: Adam Oest (amo9149)
//

// Input buffer size
#define BUFFER_SIZE 1024

// Size of saved command "clipboard"
#define SAVED_SIZE 3

// Name of this program for printing
#define PROG_NAME	"ObjcShell[%i] -> "
#define PROG_NAME2	"ObjcShell[%i] -> %s"

// Built-in command names
#define HIST_CMD "setHistorySize"
#define GET_HIST_CMD "getHistory"
#define GETALL_CMD "getSaved"

// save [index of node] [index in clipboard]
#define SAVE_CMD "save"

// exec [index in clipboard]
#define EXEC_CMD "exec"

// Saved command clipboard
Node* saved[SAVED_SIZE];

// Circular linked list with history
CommandHistory* hist;

///
/// main_loop -- This is the main function that calls get_line() 
/// to process user input
//// 
void main_loop();

///
/// get_line -- This function captures user input using a read()
/// system call.
///
/// @param buffer_size the size of the string buffer to be allocated and read
///
/// @return - string buffer of data read | NULL if there is nothing to read
////
char* get_line(int buffer_size);

///
/// print_line -- Calls a command and prints the result
///
/// @param char* string -- a string to be printed
/// @param CommandHistory* hist -- history list
////
void print_line(char* string);

#endif // SHELL_H
