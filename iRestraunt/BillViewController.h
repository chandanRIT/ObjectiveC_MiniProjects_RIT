//
//  DetailViewController.h
//  iRestraunt
//
//  Created by Kumar Chandan on 5/8/13.
//  Copyright (c) 2013 Kumar Chandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
#import "MenuModelDelegate.h"

@interface BillViewController : UIViewController <MenuModelDelegate>

@property (strong) MenuModel *menuModel;
@property (strong, nonatomic) IBOutlet UITextView *billArea;

@end
