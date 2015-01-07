//
//  MenuModel.h
//  CocoaRestaurantMenu
//
//  Created by Kumar Chandan on 5/8/13.
//  Copyright (c) 2013 Kumar Chandan. All rights reserved.
//
//  Authors: Kumar Chandan.

#import <Foundation/Foundation.h>
#import "MenuModelDelegate.h"

@interface MenuModel : NSObject

@property (nonatomic,weak) id <MenuModelDelegate> delegate;
@property (nonatomic, strong, setter = setMenuData:) NSMutableDictionary *menuData;
@property (strong) NSMutableArray *quantityArr;

-(void) resetBill;
-(NSDecimalNumber *) calculateBill;

@end
