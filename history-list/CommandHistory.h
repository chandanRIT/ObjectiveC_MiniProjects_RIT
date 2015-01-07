#ifndef COMMAND_HISTORY_H
#define COMMAND_HISTORY_H

#import <objc/Object.h>
#import <Foundation/NSObject.h>
#include <stdio.h>
#include <string.h>
#import "Node.h"

#define HIST_DEF_SIZE 8

//
// 4005-714-02 - Lab 2 - CommandHistory
//
// 31 March 2013
// Author: Adam Oest (amo9149)
//

@interface CommandHistory: NSObject
{
    // Number of commands that have been executed
    unsigned num_commands;
    
    // Maximum number of commands retained
    unsigned max_commands;
    
    // First node in the list
    Node* head;
}

// Methods

///
/// init - initializedsthe list with a default maximum size and no nodes
///
/// @return self
////
-(CommandHistory*) init;

///
/// resize - sets a new maximum list size
/// and trims the current list if needed
///
/// @param newsize -- the new maximum size of the list
////
-(void) resize : (unsigned) size;

///
/// add - adds a node to the list
///
/// @param contents -- the contents of the new node
/// this is a pointer to a string; it will be freed
/// once the node is deleted
///
////
-(void) add : (Node*) newNode;

///
/// printHistory - print the contents of the linked list
////
-(void) printHistory;

///
/// numCommands gets the last node index in the list
///
/// @return the index of the last node
////
-(unsigned) numCommands;

///
/// Gets the node with a given index
/// returns nil if index doesn't exist
///
/// @return the node whose index == targetIndex, else nil
/// NOTE: we don't care about the index within the linked list.
/// you need to look at the index property of Node
////
-(Node*) getWithIndex: (unsigned) targetIndex;

///
/// Dealloc frees up allocated memory associated with this list
////
-(void) dealloc;

@end

#endif // COMMAND_HISTORY_H
