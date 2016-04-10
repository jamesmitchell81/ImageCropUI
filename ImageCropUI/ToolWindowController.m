//
//  ToolViewController.m
//  ImageCropUI
//
//  Created by James Mitchell on 08/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "ToolWindowController.h"
#import "ImageProcessing.h"
#import "ImageRepresentation.h"
#import "Morphology.h"

@implementation ToolWindowController

@synthesize representation;

- (IBAction) applyAveragingFilter:(id)sender
{
    int filterSize = [sender intValue];
    
    NSLog(@"sender: %@", sender);

    if ( filterSize != 0 )
    {
        if ( !imageProcessing )
        {
            imageProcessing = [[ImageProcessing alloc] init];
        }
        
        // apply the filter to the origianal image.
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        [representation.subject removeRepresentation:rep];
        [representation.subject addRepresentation:[imageProcessing simpleAveragingFilterOfSize:filterSize onImage:representation.original]];
    } else {
        // reset to the origianl. i.e. remove the filter.
        [self resetToOriginal];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}

- (IBAction) applyMedianFilter:(id)sender
{
    int filterSize = [sender intValue];
    
    if ( filterSize != 0 )
    {
        if ( !imageProcessing )
        {
            imageProcessing = [[ImageProcessing alloc] init];
        }
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        [representation.subject removeRepresentation:rep];
        [representation.subject addRepresentation:[imageProcessing medianFilterOfSize:filterSize onImage:representation.original]];
    } else {
        [self resetToOriginal];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}

- (IBAction) applyMaxFilter:(id)sender
{
    
}

- (IBAction) applyMinFilter:(id)sender
{
    
}

- (IBAction) threshold:(id)sender
{
    int thresholdValue = [sender intValue];
    
    if ( !imageProcessing)
    {
        imageProcessing = [[ImageProcessing alloc] init];
    }
    
    NSBitmapImageRep* newRep = [imageProcessing threshold:representation.original atValue:thresholdValue];
    
    NSImageRep* oldRep = [representation.subject.representations objectAtIndex:0];
    [representation.subject removeRepresentation:oldRep];
    [representation.subject addRepresentation:newRep];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}


- (IBAction) erode:(id)sender
{
    
}

- (IBAction) dilate:(id)sender
{
    
}

- (IBAction) open:(id)sender
{
    
}


- (IBAction) close:(id)sender
{
    
}

- (IBAction) switchPolarity:(id)sender
{
    
}

- (IBAction) thin:(id)sender
{
    
}

- (IBAction) crop:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CropImageToolSelection" object:self];
}

- (IBAction) resetImage:(id)sender
{
    // set sliders to default.
    [self resetToOriginal];
}

- (void) resetToOriginal
{
    NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
    [representation.subject removeRepresentation:rep];
    [representation.subject addRepresentation:[ImageRepresentation grayScaleRepresentationOfImage:representation.original]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}

@end
