#import "CommandHistory.h"
#import "Node.h"

int main()
{
    CommandHistory* hist = [[CommandHistory alloc] init];

    char str[] = "abc\n";
    Node* newNode = [[Node alloc] initWithValue:(char*) str];
    [hist add:newNode];
    [newNode release];

    [hist printHistory];


    char str2[] = "def\n";
    newNode = [[Node alloc] initWithValue:(char*) str2];
    [hist add:newNode];
    [newNode release];

    [hist printHistory];

    char str3[] = "ghi\n";
    newNode = [[Node alloc] initWithValue:(char*) str3];
    [hist add:newNode];
    [newNode release];


    [hist printHistory];

    [hist resize:2];

    [hist printHistory];

    char str4[] = "hij\n";
    newNode = [[Node alloc] initWithValue:(char*) str4];
    [hist add:newNode];
    [newNode release];


    [hist printHistory];
    [hist release];
   
     printf("\n");
    [NSObject report];
        
}
