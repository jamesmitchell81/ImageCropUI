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

#import "ImageRepresentation.h"

@implementation MainWindowController

@synthesize currentViewController;
@synthesize dropZoneView;
@synthesize imageCropView;
@synthesize scrollView;

- (void)awakeFromNib
{
    [self changeToDropZoneController];
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
                                             selector:@selector(imageFromDropZoneController)
                                                 name:@"ImageUploadReciever"
                                               object:nil];
    
    // resize to fit.
//    [[self.currentViewController view] setFrame:[containerView bounds]];
}

- (void) imageFromDropZoneController
{
    image = [dropZoneView image];
    
    // remove containerView subview.
    [dropZoneView removeFromSuperview];
    
    // the imageCropView needs to fit the image in for the best results when cropping.
    // need to adjust the x, y to centre the image. not important now.
    NSRect imageBounds = NSMakeRect(0, 0, image.size.width, image.size.height);
    
    // create the new view.
    imageCropView = [[ImageCropView alloc] initWithFrame:imageBounds];
    [imageCropView setImage:image];
    
    // add the new view.
    scrollView = [[NSScrollView alloc] initWithFrame:imageBounds];
    
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    
    [scrollView setDocumentView:imageCropView];
    [containerView addSubview:scrollView];
    [self.window setContentView:scrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imageFromCrop)
                                                 name:@"ImageCropComplete"
                                               object:nil];
    
    // remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ImageUploadReciever" object:nil];
}

- (void) imageFromCrop
{
    image = [imageCropView croppedImage];
    
    // update image crop view. scrollview etc.
    NSRect imageBounds = NSMakeRect(0, 0, image.size.width, image.size.height);
    
    // create the new view.
    imageCropView = [[ImageCropView alloc] initWithFrame:imageBounds];
    [imageCropView setImage:image];
    
    // add the new view.
    scrollView = [[NSScrollView alloc] initWithFrame:imageBounds];
    
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    
    [scrollView setDocumentView:imageCropView];
    [containerView addSubview:scrollView];
    [self.window setContentView:scrollView];
    
    NSBitmapImageRep* rep = [ImageRepresentation grayScaleRepresentationOfImage:image];
    [ImageRepresentation saveImageFileFromRepresentation:rep fileName:@"Cropped"];
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
