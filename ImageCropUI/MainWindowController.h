//
//  JMWindowController.h
//  ImageCropUI
//
//  Created by James Mitchell on 22/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DropZoneView.h"

@class DropZoneView;
@class ImageCropView;
@class ToolViewController;

@interface MainWindowController : NSWindowController
{
    // the container view.
    // Where the other view are displayed.
    
    
    IBOutlet NSView* containerView;
    IBOutlet NSView* toolView;
    
    ToolViewController* toolViewController;
       
    NSImage* image;
    
    // collection of the view controllers.
    NSMutableDictionary* viewControllerNames;
    NSMutableDictionary* viewControllerNibs;
}

// CurrentViewController
@property (nonatomic, assign) NSViewController* currentViewController;

// Views/ViewControllers.
@property (nonatomic, strong) DropZoneView* dropZoneView;
@property (nonatomic, strong) ImageCropView* imageCropView;
@property (nonatomic, strong) NSScrollView* scrollView;

- (void) changeViewController:(NSString*)viewControllerName;

@end


// DropZoneView
// ImageCropView
// ImageRepresentation