//
//  MenuViewController.m
//  RestaurantMenuOSX
//
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.menuComputer = [[MenuComputer alloc]init];
        self.menuComputer.delegate=self;
    }
    return self;
}
-(void) loadView{
    [super loadView];
    self.placeHolderLabel=[[NSTextField alloc] initWithFrame:NSMakeRect(100, 150, 190, 50)];
    [[self.placeHolderLabel cell] setPlaceholderString:@"Your bill goes here \nHit generate to display your bill"];
    [self.placeHolderLabel setBezeled:NO];
    [self.placeHolderLabel setDrawsBackground:NO];
    [self.placeHolderLabel setEditable:NO];
    [self.placeHolderLabel setSelectable:NO];
    [self.billTextView addSubview:self.placeHolderLabel];
    self.menuComputer.menuDictionary=self.menuDictionary;
}

- (IBAction)addToBill:(NSButton *)sender {
    
    // Atleast 1 item has been selected
    if([self.menuDropDown indexOfSelectedItem] >= 0)
    {
        NSString *itemName=[[self.menuDictionary allKeys] objectAtIndex:[self.menuDropDown indexOfSelectedItem]];
        int quantity = [[self.quantityTextField stringValue] intValue];
        
        // Quantity chosen is atleast 1
        if(quantity > 0)
        {
            [self.menuComputer addMenuItem:itemName withQuantity:quantity];
            [self.quantityTextField setStringValue:@""];
            [self.menuDropDown setStringValue:@""];
        }
    }
}

- (IBAction)clearItems:(NSButton *)sender {
    [self.menuComputer clearItems];
    [self.currentMenu removeAllObjects];
    [self.menuListView reloadData];
    [self.billTextView setString:@""];
    [[self.placeHolderLabel cell] setPlaceholderString:@"Your order is empty!"];
    [self.billTextView addSubview:self.placeHolderLabel];

}

- (IBAction)generateBill:(NSButton *)sender {
    [self.menuComputer computeDisplayBill];
}

-(void) showBill:(NSArray *)displayStringArray total:(NSDecimalNumber *)totalCost{
    [self.placeHolderLabel removeFromSuperview];
    if ([displayStringArray count]!=0) {
        
        NSString *dashes = @"=========================================";
        NSString *t = self.billTextView.string;
        [self.billTextView setString: [t stringByAppendingFormat:@"%@", dashes]];

        NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterShortStyle];
        NSString *dateString = [dateFormat stringFromDate:today];
        self.billTextView.string=[NSString stringWithFormat:@"Date: %@ \n \n",dateString];
        for(NSString *string in displayStringArray){
            NSString *temp=self.billTextView.string;
            [self.billTextView setString:[temp stringByAppendingFormat:@"%@ \n",string]];
        }
        NSString *temp=self.billTextView.string;
        [self.billTextView setString:[temp stringByAppendingFormat:@"\nTotal bill is: $%@",totalCost]];
    }
    else{
        [self.billTextView setString:@""];
        [[self.placeHolderLabel cell] setPlaceholderString:@"Your order is empty!"];
        [self.billTextView addSubview:self.placeHolderLabel];
    }
    
    
}
-(void) menuItemAdded:(NSMutableDictionary *) currentMenu{
    self.currentMenu=currentMenu;
    [self.menuListView reloadData];
}
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox{
    return [[self.menuDictionary allKeys] count];
}
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index{
    return [[self.menuDictionary allKeys] objectAtIndex:index];
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return self.currentMenu.count;
}
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    NSArray *keys = [self.currentMenu allKeys];
    NSString *keyAtRow = [keys objectAtIndex:rowIndex];
    NSString *columnIdentifer = [aTableColumn identifier];
    if ([columnIdentifer isEqualToString:@"name"])
    {
        return keyAtRow;
    }
    else if ([columnIdentifer isEqualToString:@"quantity"])
    {
        int quantity = [[self.currentMenu objectForKey:keyAtRow] intValue];
        return [NSString stringWithFormat:@"%i", quantity];
    }
    return nil;
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    NSArray *keys = [self.currentMenu allKeys];
    NSString *keyAtRow = [keys objectAtIndex:rowIndex];
    NSString *columnIdentifer = [aTableColumn identifier];
    if (([columnIdentifer isEqualToString:@"quantity"]) && (rowIndex != -1))
    {
        int quantity = [anObject intValue];
        if (quantity > 0)
        {
            [self.currentMenu setObject:anObject forKey:keyAtRow];
        }
    }
    
    [aTableView reloadData];
}

@end
