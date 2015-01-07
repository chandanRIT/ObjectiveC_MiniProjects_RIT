//
//  MenuComputer.m
//  RestaurantMenuOSX
//
//

#import "MenuComputer.h"
#import "MenuComputerDelegate.h"
@implementation MenuComputer

-(MenuComputer *) init{
    self=[super init];
    if(self){
        self.currentMenuItemsWithQuantity=[[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void) addMenuItem:(NSString *)itemName withQuantity:(int)quantity{
    
    if (quantity > 0){
        if([[self.currentMenuItemsWithQuantity allKeys] containsObject:itemName]){
            int previousQuantity = [[self.currentMenuItemsWithQuantity objectForKey:itemName] intValue];
            [self.currentMenuItemsWithQuantity setObject:[NSNumber numberWithInt:previousQuantity+quantity] forKey:itemName];
        }
        else{
            [self.currentMenuItemsWithQuantity setObject:[NSNumber numberWithInt:quantity] forKey:itemName];
        }
        if([[self delegate] respondsToSelector:@selector(menuItemAdded:)]){
            [[self delegate] menuItemAdded:self.currentMenuItemsWithQuantity];
        }
    }
}

-(void) clearItems{
    [self.currentMenuItemsWithQuantity removeAllObjects];
}

-(void)computeDisplayBill{
    NSMutableArray *displayArray = [[NSMutableArray alloc]init];
    NSDecimalNumber *totalCost=[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:0.0 ] decimalValue]];
    for (NSString *key in self.currentMenuItemsWithQuantity) {
        int quantity = [[self.currentMenuItemsWithQuantity objectForKey:key] intValue];
        int unitCost = [[self.menuDictionary objectForKey:key] intValue];
        [displayArray addObject:[NSString stringWithFormat:@"%i %@  @$%i:   $%i",quantity,key,unitCost,quantity*unitCost]];
        totalCost=[totalCost decimalNumberByAdding:[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:quantity*unitCost] decimalValue]]];
    }
    if([[self delegate] respondsToSelector:@selector(showBill:total:)]){
        [[self delegate] showBill:displayArray total:totalCost];
    }
}
@end
