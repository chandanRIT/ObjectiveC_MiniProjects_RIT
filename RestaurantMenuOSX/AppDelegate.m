//
//  AppDelegate.m
//  RestaurantMenuOSX
//
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSStringEncoding code;
//    NSString *contents= [NSString stringWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/menu.txt"] usedEncoding:&code error:nil];
     NSString *contents= [NSString stringWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/home/stu14/s1/kxc9234/Desktop/menu.txt"] usedEncoding:&code error:nil];
   
    NSArray *stringArray=[contents componentsSeparatedByString:@"\n"];
    NSMutableDictionary *menu=[NSMutableDictionary dictionary];
    for (int i=0; i<stringArray.count; i++) {
        NSArray *tokens=[[stringArray objectAtIndex:i] componentsSeparatedByString:@","];
        [menu setObject:[tokens objectAtIndex:1] forKey:[tokens objectAtIndex:0]];
    }
    self.menuController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self.menuController setMenuDictionary:menu];
    [self.window setFrame:NSRectFromString(@"{200,200,700,500}") display:YES];
    [self.menuController.view setFrame:[self.window.contentView bounds]];
    [self.window.contentView addSubview:self.menuController.view];
}

@end
