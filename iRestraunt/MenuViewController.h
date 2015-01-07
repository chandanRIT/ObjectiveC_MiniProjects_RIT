//
//  MasterViewController.h
//  iRestraunt
//
//  Created by Kumar Chandan on 5/8/13.
//  Copyright (c) 2013 Kumar Chandan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuModel.h"

@class BillViewController;

@interface MenuViewController : UITableViewController <UIAlertViewDelegate>

    @property (strong, nonatomic) BillViewController *billViewController;
    @property (strong) MenuModel *menuModel;

    -(NSMutableDictionary*) loadMenuData;

@end
