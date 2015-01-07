#import "CommandHistory.h"

//
// 4005-714-02 - Lab 2 - CommandHistory
//
// 31 March 2013
// Author: Adam Oest (amo9149)
// Author Kumar Chandan
//

@implementation CommandHistory

// Methods: refer to CommandHistory.h for comments

-(CommandHistory*) init
{
    // This method does not need to be edited
    [super init];
    num_commands = 0;
    max_commands = HIST_DEF_SIZE;
    head = nil;
    
    return self;
} // init

-(void) add: (Node*) newNode
{
    // Add code to handle adding new nodes to the list
	[newNode setIndex: ++num_commands];
	if(head == nil){     // What if head is nil?
		head = newNode;
		[head setNext: head];
		[head setPrev: head];
		
	} else {
		[newNode setNext: head];
		[newNode setPrev: [head prev]];
		[[head prev] setNext: newNode];
		[head setPrev: newNode];
	}
	
	if( (num_commands - [head index] + 1) > max_commands){ // remove oldest element if limit exceeded
		Node *prevHead = head;
		head = [head next];
		
		[[prevHead prev] setNext: head];
		[head setPrev: [prevHead prev]];
		
		[prevHead release];
	}
	
	[newNode retain];
} 

-(void) resize: (unsigned) newsize
{    
    // Implement code to resize the list here
    // Update the value of max_commands
    // Delete excessive nodes if needed
	if(newsize < 1)  // Note: newsize >= 1.  Reject 0
		return;
	
	if(newsize >= max_commands){
		max_commands = newsize;
		return;
	}
	
	int i, currSize = num_commands - [head index] + 1;
	Node *currNode, *tempNode = nil, *prevToHead = [head prev];
	for(i=0, currNode = head; i < (currSize - newsize); i++, currNode = [currNode next]){
		if(tempNode != nil)
			[tempNode release];
		tempNode = currNode;
	}
	[tempNode release];

	head = currNode;
	[currNode setPrev: prevToHead];
	[prevToHead setNext: currNode];

	max_commands = newsize;
} 

-(Node*) getWithIndex : (unsigned) targetIndex
{
    // Get the node that has an index of targetIndex
    // Careful not to end up with an infinite loop
	if(targetIndex < 0 || targetIndex >= num_commands)
		return nil;
	
	Node *currNode = head;
	do 
	{
		if ([currNode index] == targetIndex)
		{
			return currNode;
		}
		currNode = [currNode next];
	} while (currNode != head);
    
	return nil;     // Return nil if not found
} 

-(void) dealloc
{	
	// Free all memory associated with this object
	int i, size =  num_commands - [head index] + 1 ; Node *currNode, *tempNode = nil;
	for(i=0, currNode = head; i < size; i++, currNode = [currNode next]){
		if(tempNode != nil)
			[tempNode release];
		tempNode = currNode;
	}
	[tempNode release];

	[super dealloc];
} 

-(unsigned) numCommands
{
    // This method does not need to be edited
    return num_commands;
} // numCommands

-(void) printHistory
{
    // This method does not need to be edited
    if (num_commands > 0)
    {
        printf("\nCommand History:\n[pid %i] %i: %s",
                                getpid(), [head index], [head value]);        
        Node* current = [head next];

        while ([current index] != [head index])
        {
            printf("[pid %i] %i: %s",
                                getpid(), [current index], [current value]);
            current = [current next];
        }
    }
    else
    {
        printf("\nCommand History:\nNo commands typed yet\n");
    }

    fflush(NULL);
} // printHistory
@end
