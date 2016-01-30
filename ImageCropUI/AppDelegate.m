//
//  AppDelegate.m
//  ImageCropUI
//
//  Created by James Mitchell on 21/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//@synthesize mainWindowController;  = _mainWindowController;

- (void) applicationWillFinishLaunching:(NSNotification *)notification
{
    // instanciate controller with nib
    // if nil
    mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
    //
    [mainWindowController showWindow:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [mainWindowController.window makeFirstResponder:nil]; // why
}

@end
