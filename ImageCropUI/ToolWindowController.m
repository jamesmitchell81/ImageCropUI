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

@implementation ToolWindowController

@synthesize representation;

- (IBAction) applyAveragingFilter:(id)sender
{
    int val = [sender intValue];

    ImageProcessing* imageProcessing = [[ImageProcessing alloc] init];
    representation.bitmaprep = [imageProcessing simpleAveragingFilterOfSize:val
                                                                    onImage:representation.original];
    
    representation.subject = [ImageRepresentation cacheImageFromRepresentation:representation.bitmaprep];
    
    
    NSLog(@"tvc: %@", representation.subject);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdateReciever" object:self];
}

- (IBAction) applyMedianFilter:(id)sender
{
    
}

- (IBAction) applyMaxFilter:(id)sender
{
    
}

- (IBAction) applyMinFilter:(id)sender
{
    
}

- (IBAction) threshold:(id)sender
{
    
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

@end
