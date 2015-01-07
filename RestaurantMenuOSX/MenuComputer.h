//
//  MenuComputer.h
//  RestaurantMenuOSX
//
//

#import <Foundation/Foundation.h>
#import "MenuComputerDelegate.h"
@interface MenuComputer : NSObject

@property (nonatomic,weak) id <MenuComputerDelegate> delegate;
@property (strong) NSMutableDictionary *menuDictionary;
@property (strong) NSMutableDictionary *currentMenuItemsWithQuantity;

-(MenuComputer *) init;
-(void) addMenuItem:(NSString *)itemName withQuantity:(int)quantity;
-(void) clearItems;
-(void) computeDisplayBill;
@end
