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
    IBOutlet NSSlider *aveFilterSlider;
    IBOutlet NSSlider *medianFilterSlider;
    IBOutlet NSSlider *maxFilterSlider;
    IBOutlet NSSlider *minFilterSlider;
    
    IBOutlet NSSlider *thresholdSlider;
    IBOutlet NSSlider *erodeFilterSlider;
    IBOutlet NSSlider *dilateFilterSlider;
    IBOutlet NSSlider *openFilterSlider;
    IBOutlet NSSlider *closeFilterSlider;
    
    IBOutlet NSButton *switchPolarity;
    IBOutlet NSButton *thin;
    IBOutlet NSButton *crop;
}

- (IBAction) applyAveragingFilter:(id)sender;


@end
