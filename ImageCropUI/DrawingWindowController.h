//
//  TracedWindowController.h
//  ImageCropUI
//
//  Created by James Mitchell on 14/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DrawingView;

@interface DrawingWindowController : NSWindowController
{
    IBOutlet DrawingView* drawingView;
    NSArray* drawingData;
}

@property (nonatomic) NSArray* drawingData;
@property (nonatomic) NSView* drawingView;

@end
