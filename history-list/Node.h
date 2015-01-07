#ifndef NODE_H
#define NODE_H

#import <objc/Object.h>
#import <Foundation/NSObject.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//
// 4005-714-02 - Lab 2 - Node
// A node class that can store strings
//
// 31 March 2013
// Author: Adam Oest (amo9149)
//

@interface Node: NSObject
{
    // Pointer to the next node
    Node* next;

    // Pointer to the previous node
    Node* prev;
    
    // Value of the current node
    char* value;

    // Index of the current node
    unsigned index;
}

// Methods

///
/// Destructor that frees all memory associated with this Node
////
-(void) dealloc;

///
/// Initialize the node with nil for next and prev
///
/// NOTE: you need to allocate space to store str 
/// as the pointer may be deleted elsewhere
/// @param str, the string value of the node
///
/// @return self
////
-(Node*) initWithValue: (char*) str;

@property (assign, nonatomic) Node* next;
@property (assign, nonatomic) Node* prev;
@property (readonly, nonatomic) char* value;
@property (assign, nonatomic) unsigned index;

@end

#endif // NODE_H
