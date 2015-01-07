//
//  AppDelegate.h
//  RestaurantMenuOSX
//
//

#import <Cocoa/Cocoa.h>
#import "MenuViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) MenuViewController *menuController;
@end
