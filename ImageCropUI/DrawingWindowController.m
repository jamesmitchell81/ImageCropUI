//
//  TracedWindowController.m
//  ImageCropUI
//
//  Created by James Mitchell on 14/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "DrawingWindowController.h"

@implementation DrawingWindowController

@synthesize drawingData;
@synthesize drawingView;

- (void)windowDidLoad {
    [super windowDidLoad];

    NSLog(@"windowDidload");
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    // add the drawing view.
    NSLog(@"%f, %f", self.window.frame.size.width, self.window.frame.size.height);
    
    drawingView = [[NSView alloc] initWithFrame:[self.window frame]];
    [[self.window contentView] addSubview:drawingView];
}

- (void)awakeFromNib
{
    // REFERENCE: stackoverflow.com/questions/25250762/xcode-swift-window-without-title-bar-but-with-close-minimize-and-resize-but
//    self.window.titleVisibility = NSWindowTitleHidden;
//    self.window.titlebarAppearsTransparent = YES;
//    self.window.styleMask |= NSFullSizeContentViewWindowMask;

    
}

- (void) draw
{
    NSColor* fillColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
    NSBezierPath* hPath = [NSBezierPath bezierPath];
    [hPath moveToPoint: NSMakePoint(0.06, 0)];
    [hPath lineToPoint: NSMakePoint(1.59, 0)];
    [hPath lineToPoint: NSMakePoint(1.59, 20.16)];
    [hPath curveToPoint: NSMakePoint(13.41, 32.69) controlPoint1: NSMakePoint(1.59, 27.53) controlPoint2: NSMakePoint(6.5, 32.69)];
    [hPath curveToPoint: NSMakePoint(24.47, 21.66) controlPoint1: NSMakePoint(19.97, 32.69) controlPoint2: NSMakePoint(24.47, 28.5)];
    [hPath lineToPoint: NSMakePoint(24.47, 0)];
    [hPath lineToPoint: NSMakePoint(26, 0)];
    [hPath lineToPoint: NSMakePoint(26, 21.72)];
    [hPath curveToPoint: NSMakePoint(13.59, 34.12) controlPoint1: NSMakePoint(26, 29.25) controlPoint2: NSMakePoint(20.97, 34.12)];
    [hPath curveToPoint: NSMakePoint(1.66, 25.69) controlPoint1: NSMakePoint(7.75, 34.12) controlPoint2: NSMakePoint(3.09, 30.66)];
    [hPath lineToPoint: NSMakePoint(1.59, 25.69)];
    [hPath lineToPoint: NSMakePoint(1.59, 47.06)];
    [hPath lineToPoint: NSMakePoint(0.06, 47.06)];
    [hPath lineToPoint: NSMakePoint(0.06, 0)];
    [hPath closePath];
    [hPath setMiterLimit: 4];
    [hPath setWindingRule: NSEvenOddWindingRule];
    [fillColor setFill];
    [hPath fill];

}

@end
