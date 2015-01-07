//
//  MasterViewController.m
//  iRestraunt
//
//  Created by Kumar Chandan on 5/8/13.
//  Copyright (c) 2013 Kumar Chandan. All rights reserved.
//

#import "MenuViewController.h"
#import "BillViewController.h"

@interface MenuViewController () {
    int selectedRow;
}
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"iMenu", @"iMenu");
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear Bill" style:UIBarButtonItemStyleBordered  target:self action:@selector(clearBill:)];
        self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Get Bill" style:UIBarButtonItemStyleBordered  target:self action:@selector(generateBill:)];

        _menuModel = [[MenuModel alloc] init];
        _menuModel.menuData = [self loadMenuData];        
    }    
    return self;
}
							
/// generates bill when 'Get Bill' button is hit
////
- (void)generateBill:(id)sender
{
     if (!self.billViewController) {
         self.billViewController = [[BillViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
         self.billViewController.menuModel = _menuModel;
         _menuModel.delegate = self.billViewController;
     }
    [self.navigationController pushViewController:self.billViewController animated:YES];
    [_menuModel calculateBill];
}

/// clears Bill when 'Clear Bill' button is hit
////
- (void)clearBill:(id)sender {
    [_menuModel resetBill];
    [self.tableView reloadData];
}

/// overridden method of UITableViewDataSource
////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_menuModel == nil || _menuModel.menuData.count == 0)
        return 1;
    
    return _menuModel.menuData.count;
}

/// overridden method of UITableViewDataSource, data is populated in rows here
////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItem"];
    if (!cell) {;
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MenuItem"];
    }
    
    if(_menuModel == nil || _menuModel.menuData.count == 0)
    {
        cell.textLabel.text = @"Please check the Menu file";
        return cell;
    }
    
    NSString *key = [[_menuModel.menuData allKeys] objectAtIndex: indexPath.row];
    cell.textLabel.text = [key stringByAppendingFormat:@" @ $%@", [_menuModel.menuData objectForKey:key]];
    cell.detailTextLabel.text = [_menuModel.quantityArr[indexPath.row] stringValue];
    return cell;
}

/// overridden method of UITableViewDataSource
////
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/// overridden method of UITableViewDelegate, defines what to do when a row is selected
////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle: [ NSString stringWithFormat:@"Enter Quantity for '%@'", [[_menuModel.menuData allKeys] objectAtIndex: indexPath.row ]] message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

/// overridden method of the UIAlertViewDelegate, called when alert's buttons are clicked
////
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (1 == buttonIndex) {
        UITextField *quantityField = [alertView textFieldAtIndex:0];
        if (quantityField.text && [quantityField.text intValue] >= 0 ) {
            _menuModel.quantityArr[selectedRow] = [NSNumber numberWithInt:[quantityField.text intValue]];
            [self.tableView reloadData];
            
        }
    }
}

/// reads from the specified path and returns a dictionary version of menu file
/// The file has to be in comma seperated format
////
-(NSMutableDictionary*) loadMenuData {
    @try{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"txt"];
        NSString *contents = [NSString stringWithContentsOfFile:filePath usedEncoding:nil error:nil];
        
        NSArray *subStrArr = [contents componentsSeparatedByString:@"\n"];
        NSMutableDictionary *menuData = [NSMutableDictionary dictionary];
        for (int i = 0; i < [subStrArr count]; i++) {
            NSArray *tokens = [subStrArr[i] componentsSeparatedByString:@","];
            [menuData setObject:tokens[1] forKey:tokens[0]];
        }
        return menuData;
    }
    @catch (NSException *e){ // handling incorrect menu files
        [self.tableView setUserInteractionEnabled:false];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        return nil;
    }
}

@end
