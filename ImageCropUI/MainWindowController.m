//
//  JMWindowController.m
//  ImageCropUI
//
//  Created by James Mitchell on 22/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "MainWindowController.h"
#import "DropZoneView.h"
#import "ImageCropView.h"
#import "ImageManipulationView.h"
#import "ToolWindowController.h"

#import "ImageRepresentation.h"

@implementation MainWindowController

@synthesize representation;
@synthesize currentViewController;
@synthesize dropZoneView;
@synthesize imgManipView;
@synthesize imageCropView;
@synthesize scrollView;

- (void)awakeFromNib
{
    // REFERENCE: stackoverflow.com/questions/25250762/xcode-swift-window-without-title-bar-but-with-close-minimize-and-resize-but
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.titlebarAppearsTransparent = YES;
    self.window.styleMask |= NSFullSizeContentViewWindowMask;
    
    [self changeToDropZoneController];
//    [self addToolView];
}

- (void) changeToDropZoneController
{
    if ([self.currentViewController view] != nil )
    {
        // remove the old view.
        [[self.currentViewController view] removeFromSuperview];
    }
    
    dropZoneView = [[DropZoneView alloc] initWithFrame:[containerView bounds]];

    [containerView addSubview:dropZoneView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDroppedImage)
                                                 name:@"ImageUploadReciever"
                                               object:nil];

}

/*
 * Where the image is larger then the container window
 * set the destination view to be the size of the image.
 */
- (NSRect) determineViewBounds
{
    NSRect viewBounds;
    int viewWidth;
    int viewHeight;
    
    int maxWidth = 1000;
    int maxHeight = 1000;
    
    if ( maxHeight < representation.subject.size.height )
    {
        viewHeight = maxHeight;
    } else {
        viewHeight = representation.subject.size.height;
    }
    
    if ( maxWidth < representation.subject.size.width )
    {
        viewWidth = maxWidth;
    } else {
        viewWidth = representation.subject.size.width;
    }
    
    viewBounds = NSMakeRect(0, 0, viewWidth, viewHeight);

    return viewBounds;
}

- (void) handleDroppedImage
{
    [self imageFromDropZone];
    [self setImageManipulationView];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ImageUploadReciever" object:nil];
}


- (void) imageFromDropZone
{
    representation = [[ImageRepresentation alloc] init];
    representation.subject = [dropZoneView image];
    [dropZoneView removeFromSuperview];
}

- (void) displayToolWindow
{
    if ( !toolViewController )
    {
        toolViewController = [[ToolWindowController alloc] initWithWindowNibName:@"ToolView"];
        [toolViewController showWindow:nil];
    }
    
    [toolViewController setRepresentation:representation];
}

- (void) setImageManipulationView
{
    NSRect viewBounds = [self determineViewBounds];
    imgManipView = [[ImageManipulationView alloc] initWithFrame:viewBounds];
    [imgManipView setImage:representation.subject];
    
    // add the new view.
    scrollView = [[NSScrollView alloc] initWithFrame:viewBounds];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    [scrollView setDocumentView:imgManipView];
    
    [containerView setBounds:viewBounds];
    [containerView addSubview:scrollView];
    [self.window setContentView:scrollView];
    
    NSRect frame = [self.window frame];
    frame.size = viewBounds.size;
    [self.window setFrame:frame display:YES animate:NO];
    
    [self displayToolWindow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setCropView)
                                                 name:@"CropImageToolSelection"
                                               object:nil];
}

- (void) setCropView
{
    NSRect viewBounds = [self determineViewBounds];
    
    [imgManipView removeFromSuperview];

    imageCropView = [[ImageCropView alloc] initWithFrame:viewBounds];
    [imageCropView setImage:representation.subject];

    scrollView = [[NSScrollView alloc] initWithFrame:viewBounds];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    
    [scrollView setDocumentView:imageCropView];
    [containerView addSubview:scrollView];
    [self.window setContentView:scrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imageFromCrop)
                                                 name:@"ImageCropComplete"
                                               object:nil];
    
    [[NSApp mainWindow] makeKeyWindow];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CropImageToolSelection" object:nil];
}

- (void) imageFromCrop
{
    representation.subject = [imageCropView croppedImage];
    [imageCropView removeFromSuperview];
    
    [self setImageManipulationView];
}

- (void) changeViewController:(NSString*)viewControllerKey
{
    NSViewController* controller;
    
    if ([self.currentViewController view] != nil )
    {
        // remove the old view.
        [[self.currentViewController view] removeFromSuperview];
    }
    
    // create the new view Controller
//    [viewControllers]
    NSString* controllerName = [viewControllerNames objectForKey:viewControllerKey];
    NSString* nibName        = [viewControllerNibs  objectForKey:viewControllerKey];
    
    id newViewControllerClass = NSClassFromString(controllerName);
    
    if ( [newViewControllerClass isKindOfClass:[NSViewController class]] )
    {
        controller = [[newViewControllerClass alloc] initWithNibName:nibName bundle:nil];
    }

    // update the containerView sub
    currentViewController = controller;
    [containerView addSubview:[currentViewController view]];

}


@end
