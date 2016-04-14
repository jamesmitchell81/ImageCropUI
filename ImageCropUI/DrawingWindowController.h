//
//  TracedWindowController.h
//  ImageCropUI
//
//  Created by James Mitchell on 14/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DrawingWindowController : NSWindowController
{
    NSArray* drawingData;
    NSView* drawingView;
}

@property (nonatomic) NSArray* drawingData;
@property (nonatomic) NSView* drawingView;

@end
