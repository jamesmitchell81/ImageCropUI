//
//  ToolViewController.h
//  ImageCropUI
//
//  Created by James Mitchell on 08/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ToolViewController : NSViewController
{
    NSImage* image;
    
    IBOutlet NSSlider *aveFilterSlider;
    IBOutlet NSSlider *medianFilterSlider;
    IBOutlet NSSlider *maxFilterSlider;
    IBOutlet NSSlider *minFilterSlider;
    
    IBOutlet NSSlider *thresholdSlider;

    IBOutlet NSSlider *erodeFilterSlider;
    IBOutlet NSSlider *dilateFilterSlider;
    IBOutlet NSSlider *openFilterSlider;
    IBOutlet NSSlider *closeFilterSlider;
    
    IBOutlet NSButton *polaritySwitch;
    IBOutlet NSButton *thin;
    IBOutlet NSButton *crop;
}

@property NSImage* image;

- (IBAction) applyAveragingFilter:(id)sender;
- (IBAction) applyMedianFilter:(id)sender;
- (IBAction) applyMaxFilter:(id)sender;
- (IBAction) applyMinFilter:(id)sender;
- (IBAction) threshold:(id)sender;
- (IBAction) erode:(id)sender;
- (IBAction) dilate:(id)sender;
- (IBAction) open:(id)sender;
- (IBAction) close:(id)sender;
- (IBAction) switchPolarity:(id)sender;
- (IBAction) thin:(id)sender;
- (IBAction) crop:(id)sender;

@end
