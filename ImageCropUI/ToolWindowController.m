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
    
    NSLog(@"ave: %d", filterSize);

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
    
    NSLog(@"med: %d", filterSize);
    
    if ( filterSize != 1 )
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
    int filterSize = [sender intValue];
    
    NSLog(@"max: %d", filterSize);
    
    if ( filterSize != 1 )
    {
        if ( !imageProcessing )
        {
            imageProcessing =[[ImageProcessing alloc] init];
        }
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        [representation.subject removeRepresentation:rep];
        [representation.subject addRepresentation:[imageProcessing maxFilterOfSize:filterSize onImage:representation.original]];
    } else {
        [self resetToOriginal];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}

- (IBAction) applyMinFilter:(id)sender
{
    int filterSize = [sender intValue];
    
    NSLog(@"min: %d", filterSize);
    
    if ( filterSize != 1 )
    {
        if ( !imageProcessing )
        {
            imageProcessing =[[ImageProcessing alloc] init];
        }
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        [representation.subject removeRepresentation:rep];
        [representation.subject addRepresentation:[imageProcessing minFilterOfSize:filterSize onImage:representation.original]];
    } else {
        [self resetToOriginal];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
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
    [aveFilterSlider setIntValue:0];
    [medianFilterSlider setIntValue:0];
    [maxFilterSlider setIntValue:0];
    [minFilterSlider setIntValue:0];
    
    [thresholdSlider setIntValue:128];
    
    [erodeFilterSlider setIntValue:0];
    [dilateFilterSlider setIntValue:0];
    [openFilterSlider setIntValue:0];
    [closeFilterSlider setIntValue:0];
    
    // cropped bit.
    
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
