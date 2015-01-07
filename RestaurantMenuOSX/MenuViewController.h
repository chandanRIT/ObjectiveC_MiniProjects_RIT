//
//  MenuViewController.h
//  RestaurantMenuOSX
//
//

#import <Cocoa/Cocoa.h>
#import "MenuComputerDelegate.h"
#import "MenuComputer.h"
@interface MenuViewController : NSViewController <MenuComputerDelegate,NSComboBoxDataSource,NSTableViewDataSource>

@property (weak) IBOutlet NSComboBox *menuDropDown;
@property (weak) IBOutlet NSTextField *quantityTextField;
@property (weak) IBOutlet NSTableView *menuListView;
@property (unsafe_unretained) IBOutlet NSTextView *billTextView;


@property (strong) NSTextField *placeHolderLabel;
@property (strong) MenuComputer *menuComputer;
@property (strong) NSMutableDictionary *menuDictionary;
@property (strong) NSMutableDictionary *currentMenu;

- (IBAction)addToBill:(NSButton *)sender;
- (IBAction)clearItems:(NSButton *)sender;
- (IBAction)generateBill:(NSButton *)sender;



@end
