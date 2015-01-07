#include "shell.h"
#import "CommandHistory.h"

//
// 4005-714-02 - Lab 2 - Memory Management
// Main shell script
//
// Note: you will need to fill in missing memory management code in this file!
//
// 31 March 2013
// Author: Adam Oest (amo9149)
// Author Kumar Chandan
//

///
/// main entry point
/// 
/// @author Adam Oest
/// @author Kumar Chandan
////
int main()
{
    // Initialize the program
    main_loop();

    return 0;

} // main

// YOU DO NOT NEED TO MAKE ANY EDITS ABOVE THIS LINE

///
/// main_loop -- This is the main function that calls get_line() 
/// to process user input
////
void main_loop()
{
    hist = [[CommandHistory alloc] init];
    
    // Print the program header
    printf(PROG_NAME, [hist numCommands] + 1);
    fflush(NULL);
    
    while(true)
    {
        // Fetch and print user input
        char* string = get_line(BUFFER_SIZE);

        // Handle control-D
        if (string == NULL)
        {
            printf("\nExiting because Control+D was pressed.\n");
            break;
        }
        
        // Proceed only if input found
        if (strlen(string));
         {
            // Print the output
            print_line(string);
        }

        free(string);
        printf(PROG_NAME, [hist numCommands] + 1);
        fflush(NULL);
    }

	// Hint: something is missing here!
	[hist release]; //mycode

} // main_loop

///
/// print_line -- Executes the command that was entered 
/// and prints the result, tokenizes string
///
/// @param char* string -- the command to be executed
////
void print_line(char* string)
{
    // Tokenize input
    char* params[BUFFER_SIZE];
    char* token;
    int i = 0;
    
    // Copy the string before it gets torn apart!
    char* newstring = (char *) calloc(strlen(string) + 1, sizeof(char));            
    strcpy(newstring, string);
    
    // If this is an empty string, get out of here
    token = strtok(string, " \n\t\r");
    if (token == NULL)
    {
        fflush(NULL);
        return;
    }

    // Add command to history
    Node* newNode = [[Node alloc] initWithValue:newstring];
    
    [hist add:newNode];
    [newNode release]; //mycode
    
    free(newstring);
    
    // Continue tokenizing
    while (token != NULL)
    {
        params[i++] = token;
        token = strtok(NULL, " \n\t\r");
       }
    params[i] = '\0';

    // Resize the history
    if (strcmp(params[0], HIST_CMD) == 0 && params[1])
    {
        int new_size = atoi(params[1]);

        // Process resize
        if (new_size > 0)
        {
            [hist resize:new_size];
            printf("History buffer resized to %i\n", new_size);
        }    
        else
        {
            printf("Error: positive value required.\n");
        }
    }
    // Display history
    else if (strcmp(params[0], GET_HIST_CMD) == 0)
    {
        [hist printHistory];
    }
    // Display saved commands
    else if (strcmp(params[0], GETALL_CMD) == 0)
    {
        int i;
        for (i = 0; i < SAVED_SIZE; i++)
        {
            if (saved[i] != nil)
            {
                printf("At position %i: %s\n", i, [saved[i] value]);
            }
        }
    }
    // Save a command
    else if (strcmp(params[0], SAVE_CMD) == 0 && params[1] && params[2])
    {
        int idx = atoi(params[1]);
        int idx2 = atoi(params[2]);
        
        Node* history = [hist getWithIndex:idx];

        // put history into saved[idx2]
	if (history != nil && idx2 < SAVED_SIZE) //mycode from here
            saved [idx2] = history;
        else
            printf("Error: invalid index.\n"); //mycode end
    }
    // Execute a saved command
    else if (strcmp(params[0], EXEC_CMD) == 0 && params[1])
    {
        int idx = atoi(params[1]);
    
        if (idx < SAVED_SIZE)
        {
            Node* newNode = saved[idx];
            
            if (newNode != nil)
            {
                char* tmp = (char *) calloc(strlen([newNode value]) + 1, sizeof(char));
                strcpy(tmp, [newNode value]);    

                printf(PROG_NAME2, [hist numCommands] + 1, tmp);
                fflush(NULL);

                print_line(tmp);
		free(tmp); //my code
            }
            else
            {
                printf("No command stored at this index.\n");
            }
        }
        else
        {
            printf("Error: invalid index.\n");
        }
    }

    // YOU DO NOT NEED TO MAKE ANY EDITS BELOW THIS LINE

    // Exec commands
    else 
    {
        pid_t pid = fork();
        
        if (pid < 0)
        {
            fprintf(stderr, "Shell: fork failed.\n");
            errno = 0;
        } 
        else if (pid == 0)
        {
            if(-1 == execvp(params[0],params))
            {
                fprintf(stderr, "Shell: Encountered error code %i\n", errno);
                perror("Shell");
                errno = 0;
                exit(0);
            }
        }
        else
        {
            wait(NULL);
        }
    }
    fflush(NULL);
} // print_line

///
/// get_line -- This function captures user input using a read()
/// system call.
///
/// @param buffer_size - int with the desired buffer length
///
/// @return - string buffer of data read | NULL if there is nothing to read
////
char* get_line(int buffer_size)
{
    // Allocate a character array of the prefedined size
    char* buffer = (char*) calloc(buffer_size, sizeof(char));

    // Perform the read
    int chars_read = read(0, buffer, buffer_size);

    // Prevent silly memory leak
    if (chars_read == 0)
    {
        free(buffer);
    }

    return ((chars_read != 0) ? buffer : NULL);
} // get_line
