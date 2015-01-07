#import "Node.h"

//
// 4005-714-02 - Lab 2 - Node
// A node class that can store strings
//
// 31 March 2013
// Author: Adam Oest (amo9149)
// Author Kumar Chandan
//

@implementation Node

// Methods: Refer to Node.h for comments

-(Node*) initWithValue : (char*) str
{
    // next and prev are initially empty

	self = [super init];
	next = nil;
	prev = nil;
	value = (char *) calloc(strlen(str) + 1, sizeof(char));
	strcpy(value, str);
	return self;

    // Carefully put str into value
}

-(void) dealloc
{
	next = nil;
	prev = nil;
	free([self value]);    
	[super dealloc];

    // Free all memory associated with this node, including the string value!
} // dealloc

@synthesize next;
@synthesize prev;
@synthesize value;
@synthesize index;

@end
