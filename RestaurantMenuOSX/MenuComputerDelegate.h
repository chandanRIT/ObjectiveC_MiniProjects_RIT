//
//  MenuComputerDelegate.h
//  RestaurantMenuOSX
//
//

#import <Foundation/Foundation.h>

@protocol MenuComputerDelegate <NSObject>

@required
-(void) showBill:(NSArray *) displayStringArray total:(NSDecimalNumber *)totalCost;
@required
-(void) menuItemAdded:(NSDictionary *) currentMenu;
@end
