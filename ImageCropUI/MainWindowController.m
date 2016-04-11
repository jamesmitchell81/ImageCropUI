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
#import "ToolViewController.h"

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
    
    // resize to fit.
//    [[self.currentViewController view] setFrame:[containerView bounds]];
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
    
    NSLog(@"%@, %f, %f", @"container bounds", containerView.bounds.size.height, containerView.bounds.size.width);
    NSLog(@"%@, %f, %f", @"Image Bounds", representation.subject.size.height, representation.subject.size.width);
    
    int containerHeight = containerView.bounds.size.height;
    int containerWidth = containerView.bounds.size.width;
    
    if ( containerHeight > representation.subject.size.height )
    {
        viewHeight = containerHeight;
    } else {
        viewHeight = representation.subject.size.height;
    }
    
    if ( containerWidth > representation.subject.size.width )
    {
        viewWidth = containerWidth;
    } else {
        viewWidth = representation.subject.size.width;
    }
    
    viewBounds = NSMakeRect(0, 0, viewWidth, viewHeight);
    
    // temp
    viewBounds = NSMakeRect(0, 0, containerWidth, containerHeight);
    
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

- (void) addToolView
{
    NSArray* views = [toolView subviews];
    
    if ( [views count] == 0 )
    {
        toolViewController = [[ToolViewController alloc] initWithNibName:@"ToolView" bundle:nil];
        [toolView addSubview:[toolViewController view]];
    }
}

- (void) setImageManipulationView
{
    NSLog(@"asfasfas");
    NSRect viewBounds = [self determineViewBounds];
    imgManipView = [[ImageManipulationView alloc] initWithFrame:viewBounds];
    [imgManipView setImage:representation.subject];
    
    // add the new view.
    scrollView = [[NSScrollView alloc] initWithFrame:viewBounds];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    [scrollView setDocumentView:imgManipView];
    [containerView addSubview:scrollView];

    [self addToolView];

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imageFromCrop)
                                                 name:@"ImageCropComplete"
                                               object:nil];
    
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
