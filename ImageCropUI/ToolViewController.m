//
//  ToolViewController.m
//  ImageCropUI
//
//  Created by James Mitchell on 08/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "ToolViewController.h"
#import "ImageProcessing.h"

@implementation ToolViewController

@synthesize image;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
}

- (IBAction) applyAveragingFilter:(id)sender
{
    int val = [sender intValue];

    ImageProcessing* imageProcessing = [[ImageProcessing alloc] init];
    
    NSBitmapImageRep* representation = [imageProcessing simpleAveragingFilterOfSize:val onImage:image];
    
    // send to 
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
    
}

@end
