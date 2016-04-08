//
//  AppDelegate.h
//  ImageCropUI
//
//  Created by James Mitchell on 21/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MainWindowController;
@class ToolViewController;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    MainWindowController* mainWindowController;
    ToolViewController* toolViewController;
}

//@property (nonatomic, readonly) JMWindowController* mainWindowController;

@end

