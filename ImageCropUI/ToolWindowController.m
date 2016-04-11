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
    
    if ( filterSize != 0 )
    {
        if ( !imageProcessing )
        {
            imageProcessing = [[ImageProcessing alloc] init];
        }
        
        // set other filters to 1
        [medianFilterSlider setIntValue:1];
        [maxFilterSlider setIntValue:1];
        [minFilterSlider setIntValue:1];
        
        // reset the filter.
        representation.filtered = nil;
        
        // apply the filter to the origianal image.
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        [representation.subject removeRepresentation:rep];
        [representation.subject addRepresentation:[imageProcessing simpleAveragingFilterOfSize:filterSize onImage:representation.current]];
    } else {
        representation.subject = [[NSImage alloc] init];
        [representation.subject addRepresentation:[ImageRepresentation grayScaleRepresentationOfImage:representation.current]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}

- (IBAction) applyMedianFilter:(id)sender
{
    int filterSize = [sender intValue];
    
    if ( filterSize != 1 )
    {
        if ( !imageProcessing )
        {
            imageProcessing = [[ImageProcessing alloc] init];
        }
        
        // set other filters to 1
        [aveFilterSlider setIntValue:1];
        [maxFilterSlider setIntValue:1];
        [minFilterSlider setIntValue:1];
        
        // reset the filter.
        representation.filtered = nil;
        
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        [representation.subject removeRepresentation:rep];
        [representation.subject addRepresentation:[imageProcessing medianFilterOfSize:filterSize onImage:representation.current]];
    } else {
        representation.subject = [[NSImage alloc] init];
        [representation.subject addRepresentation:[ImageRepresentation grayScaleRepresentationOfImage:representation.current]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}

- (IBAction) applyMaxFilter:(id)sender
{
    int filterSize = [sender intValue];
    
    if ( filterSize != 1 )
    {
        if ( !imageProcessing )
        {
            imageProcessing = [[ImageProcessing alloc] init];
        }
        
        // set other filters to 1
        [aveFilterSlider setIntValue:1];
        [medianFilterSlider setIntValue:1];
        [minFilterSlider setIntValue:1];
        
        // reset the filter.
        representation.filtered = nil;
        
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        [representation.subject removeRepresentation:rep];
        [representation.subject addRepresentation:[imageProcessing maxFilterOfSize:filterSize onImage:representation.current]];
    } else {
        representation.subject = [[NSImage alloc] init];
        [representation.subject addRepresentation:[ImageRepresentation grayScaleRepresentationOfImage:representation.current]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}

- (IBAction) applyMinFilter:(id)sender
{
    int filterSize = [sender intValue];
    
    if ( filterSize != 1 )
    {
        if ( !imageProcessing )
        {
            imageProcessing = [[ImageProcessing alloc] init];
        }
        
        // set other filters to 1
        [aveFilterSlider setIntValue:1];
        [medianFilterSlider setIntValue:1];
        [maxFilterSlider setIntValue:1];
        
        // reset the filter.
        representation.filtered = nil;
        
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        [representation.subject removeRepresentation:rep];
        [representation.subject addRepresentation:[imageProcessing minFilterOfSize:filterSize onImage:representation.current]];
    } else {
        representation.subject = [[NSImage alloc] init];
        [representation.subject addRepresentation:[ImageRepresentation grayScaleRepresentationOfImage:representation.current]];
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
    
    if ( !representation.filtered )
    {
        NSImageRep* rep = [representation.subject.representations objectAtIndex:0];
        representation.filtered = [ImageRepresentation cacheImageFromRepresentation:(NSBitmapImageRep*)rep];
    }
    
    NSBitmapImageRep* newRep = [imageProcessing threshold:representation.filtered atValue:thresholdValue];
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
    representation.filtered = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CropImageToolSelection" object:self];
}

- (IBAction) resetImage:(id)sender
{
    [aveFilterSlider setIntValue:1];
    [medianFilterSlider setIntValue:1];
    [maxFilterSlider setIntValue:1];
    [minFilterSlider setIntValue:1];
    
    [thresholdSlider setIntValue:128];
    
    [erodeFilterSlider setIntValue:1];
    [dilateFilterSlider setIntValue:1];
    [openFilterSlider setIntValue:1];
    [closeFilterSlider setIntValue:1];
    
    // cropped bit.
    
    [self resetToOriginal];
}

- (void) resetToOriginal
{
    [representation resetSubject];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetOriginalImage" object:self];
}

@end
