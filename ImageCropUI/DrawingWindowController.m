//
//  TracedWindowController.m
//  ImageCropUI
//
//  Created by James Mitchell on 14/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "DrawingWindowController.h"
#import "DrawingView.h"

@implementation DrawingWindowController

@synthesize drawingData;
@synthesize drawingView;

- (void)windowDidLoad {
    [super windowDidLoad];

    NSLog(@"windowDidload");
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    // add the drawing view.
    NSLog(@"%f, %f", self.window.frame.size.width, self.window.frame.size.height);
    
    drawingView = [[DrawingView alloc] initWithFrame:[self.window frame]];
    [[self.window contentView] addSubview:drawingView];
    [drawingView setNeedsDisplay:YES];
}

- (void)awakeFromNib
{
//     REFERENCE: stackoverflow.com/questions/25250762/xcode-swift-window-without-title-bar-but-with-close-minimize-and-resize-but
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.titlebarAppearsTransparent = YES;
    self.window.styleMask |= NSFullSizeContentViewWindowMask;

    
}

@end
