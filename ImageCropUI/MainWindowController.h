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
@class ImageManipulationView;
@class ToolViewController;
@class ImageRepresentation;

@interface MainWindowController : NSWindowController
{
    NSImage* image;
    ImageRepresentation* representation;
    
    IBOutlet NSView* containerView;
    IBOutlet NSView* toolView;
    ToolViewController* toolViewController;
    
    // collection of the view controllers.
    NSMutableDictionary* viewControllerNames;
    NSMutableDictionary* viewControllerNibs;
}

@property (nonatomic) ImageRepresentation* representation;

// CurrentViewController
@property (nonatomic) NSViewController* currentViewController;

// Views/ViewControllers.
@property (nonatomic) DropZoneView* dropZoneView;
@property (nonatomic) ImageManipulationView* imgManipView;
@property (nonatomic) ImageCropView* imageCropView;
@property (nonatomic) NSScrollView* scrollView;

- (void) changeViewController:(NSString*)viewControllerName;
- (NSRect) determineViewBounds;
- (void) handleDroppedImage;
- (void) imageFromDropZone;
- (void) addToolView;
- (void) setImageManipulationView;
- (void) setCropView;

@end


// DropZoneView
// ImageCropView
// ImageRepresentation