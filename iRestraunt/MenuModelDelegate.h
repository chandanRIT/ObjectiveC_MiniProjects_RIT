//
//  MenuModelDelegate.h
//  CocoaRestaurantMenu
//
//  Created by Kumar Chandan on 5/8/13.
//  Copyright (c) 2013 Kumar Chandan. All rights reserved.
//
//  Authors: Kumar Chandan

#import <Foundation/Foundation.h>

@protocol MenuModelDelegate <NSObject>

@required
-(void) displayBill: (NSDecimalNumber *)totalBill;


@end
