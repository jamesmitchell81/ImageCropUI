//
//  ViewsMenuController.h
//  ImageCropUI
//
//  Created by James Mitchell on 13/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MenuController : NSMenu
{
    
}

- (IBAction) newDropZone:(id)sender;
- (IBAction) closeApplication:(id)sender;
- (IBAction) showToolWindow:(id)sender;

@end
