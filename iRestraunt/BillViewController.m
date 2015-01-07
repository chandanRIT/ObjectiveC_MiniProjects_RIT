//
//  DetailViewController.m
//  iRestraunt
//
//  Created by Kumar Chandan on 5/8/13.
//  Copyright (c) 2013 Kumar Chandan. All rights reserved.
//

#import "BillViewController.h"

@implementation BillViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Bill", @"Bill");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[_menuModel calculateBill];
}

//////////////////

//=========================================
//today's date

//quantity item @$unit-cost: $cost
//quantity item @$unit-cost: $cost
//:
//:
//quantity item @$unit-cost: $cost

//Total bill is $total
//=========================================

/// definition of the MenuModelDelegate method
/// updates the view based on the present state of the model
////
-(void) displayBill:(NSDecimalNumber *)totalBill {
    if(_menuModel.menuData == nil || totalBill.doubleValue == 0.0){
        [_billArea setText:@"No Food ordered"];
        return;
    }
    
    [_billArea setText: @"=====================================\n"];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* strDate = [formatter stringFromDate:[NSDate date]];
    [_billArea setText: [(NSString *)_billArea.text stringByAppendingFormat: @"%@\n\n", strDate]];
    
    for(int i = 0; i < _menuModel.menuData.count; i++){
        int quantity = [(NSNumber *)_menuModel.quantityArr[i] intValue];
        if(quantity > 0){
            NSString *item = [[_menuModel.menuData allKeys] objectAtIndex: i];
            double cost = [[_menuModel.menuData objectForKey: item] doubleValue];
            
            //if((NSNumber *)_menuModel.quantityArr[i] > 0){
            [_billArea setText: [(NSString *)_billArea.text stringByAppendingFormat: @"%i %@ @$%.2f: $%.2f \n",quantity, item, cost, quantity*cost] ];
            //}
        }
    }
    
    [_billArea setText: [(NSString *)_billArea.text stringByAppendingFormat: @"\nTotal bill is $%.2f\n", [totalBill doubleValue]]];
    
    [_billArea setText: [(NSString *)_billArea.text stringByAppendingFormat: @"%@", @"=====================================\n"]];
}

							
@end
