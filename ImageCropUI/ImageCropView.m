//
//  ImageCropView.m
//  ImageCropUI
//
//  Created by James Mitchell on 26/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "ImageCropView.h"

@implementation ImageCropView

- (id) initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    if (self)
    {
        cropHasStarted = NO;
    }
    
    return self;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    if ( cropHasStarted )
    {
        CGFloat width = current.x - start.x ;
        CGFloat height = current.y - start.y;
        
        NSRect rect = NSMakeRect(start.x, start.y, width, height);
        NSBezierPath* path = [NSBezierPath bezierPathWithRect:rect];

        [path stroke];
    }
}


- (void) mouseDown:(NSEvent *)theEvent
{
    start = theEvent.locationInWindow;
//    NSLog(@"x: %f  y:%f", start.x, start.y);
    
    [self setNeedsDisplay:YES];
}

- (void) mouseDragged:(NSEvent *)theEvent
{
    current = theEvent.locationInWindow;
    cropHasStarted = YES;
//    NSLog(@"x: %f  y:%f", current.x, current.y);

    [self setNeedsDisplay:YES];
}






@end
