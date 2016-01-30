//
//  AppDelegate.h
//  ImageCropUI
//
//  Created by James Mitchell on 21/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MainWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    MainWindowController* mainWindowController;
}

//@property (nonatomic, readonly) JMWindowController* mainWindowController;

@end

