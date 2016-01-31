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

@implementation MainWindowController

@synthesize currentViewController;
@synthesize dropZoneView;
@synthesize imageCropView;

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
    
    // resize the image to fit the view?
    // or resize the window to fit the view.
    
    // remove containerView subview.
    [dropZoneView removeFromSuperview];
    
    imageCropView = [[ImageCropView alloc] initWithFrame:[containerView bounds]];
    [imageCropView setImage:image];
    [containerView addSubview:imageCropView];
    
    // remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ImageUploadReciever" object:nil];
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
