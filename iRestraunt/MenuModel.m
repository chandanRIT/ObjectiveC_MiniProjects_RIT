//
//  MenuModel.m
//  CocoaRestaurantMenu
//
//  Created by Kumar Chandan on 5/8/13.
//  Copyright (c) 2013 Kumar Chandan. All rights reserved.
//
//  Authors: Kumar Chandan 

#import "MenuModel.h"

@implementation MenuModel

// init method
-(MenuModel *) init{
    self = [super init];
    //if(self){
    
    //}
    return self;
}

/// override of getter of the property menuData
/// property quantity also initialized and updated
////
-(void) setMenuData:(NSMutableDictionary *)menuData{
    if(menuData == nil){
        _menuData = nil;
        _quantityArr = nil;
        [_delegate displayBill:[NSDecimalNumber decimalNumberWithString:@"0.0"]];
        return;
    }
    
    _menuData = menuData;
    _quantityArr = [[NSMutableArray alloc] initWithCapacity:_menuData.count];
    for(int i=0; i<_menuData.count; i++){
        [_quantityArr addObject:[NSNumber numberWithInt:0]];
    }
}

/// resets the quantity array to zero
/// notifies the associated delegate (the controller)
////
-(void) resetBill{
    for(int i=0; i<_quantityArr.count; i++){
        _quantityArr[i] = [NSNumber numberWithInt: 0];
    }
    [_delegate displayBill:[NSDecimalNumber decimalNumberWithString:@"0.0"]];
}

/// calculates the total bill and notifies the controller of the update
////
-(NSDecimalNumber *) calculateBill{
    NSDecimalNumber *totalBill = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    
    for(int i=0; i<_quantityArr.count; i++){
        int quantity = [(NSNumber *)_quantityArr[i] intValue];
        if(quantity > 0){
            NSString *key = [[_menuData allKeys] objectAtIndex: i];
            double cost = [[_menuData objectForKey: key] doubleValue];
            
            totalBill = [totalBill decimalNumberByAdding:(NSDecimalNumber *)[NSDecimalNumber numberWithDouble: quantity*cost]];
        }
        
    }
    [_delegate displayBill:totalBill];
    return totalBill;
}


@end
