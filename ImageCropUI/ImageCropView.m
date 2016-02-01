//
//  ImageCropView.m
//  ImageCropUI
//
//  Created by James Mitchell on 26/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "ImageCropView.h"

@implementation ImageCropView

@synthesize croppedImage = _croppedImage;

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
    NSPoint windowLocation = [theEvent locationInWindow];
    NSPoint viewLocation = [self convertPoint:windowLocation fromView:nil];
    start = viewLocation;
    
    [self setNeedsDisplay:YES];
}

- (void) mouseDragged:(NSEvent *)theEvent
{
    NSPoint windowLocation = [theEvent locationInWindow];
    NSPoint viewLocation = [self convertPoint:windowLocation fromView:nil];
    current = viewLocation;
    
    cropHasStarted = YES;
    [self setNeedsDisplay:YES];
}

- (void) mouseUp:(NSEvent *)theEvent
{
    if ( !cropHasStarted ) return;
    
    NSSize cropSize;
    cropSize.width = (int)(current.x - start.x);
    cropSize.height = (int)(start.y - current.y);

    int temp;
    
    // normalise crop position points.
     if ( start.x > current.x )
     {
         temp = start.x;
         start.x = current.x;
         current.x = temp;
     }
    
    if ( start.y < current.y )
    {
        temp = start.y;
        start.y = current.y;
        current.y = temp;
    }

    _croppedImage = [[NSImage alloc] initWithSize:cropSize];
    [_croppedImage addRepresentation:[self croppedRepresentationOfImage:[self image]
                                                         fromPoint:start
                                                           toPoint:current]];

    [self setImage:_croppedImage];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageCropComplete" object:nil];
    
    NSLog(@"After posted notification");

    cropHasStarted = NO;
    [self setNeedsDisplay:YES];
}

- (NSBitmapImageRep *) croppedRepresentationOfImage:(NSImage *)image
                                          fromPoint:(NSPoint)from
                                            toPoint:(NSPoint)to
{
    int width = (int)(to.x - from.x);
    int height = (int)(from.y - to.y);
    
    NSRect newRect = NSMakeRect(from.x , to.y, width, height);
    
    NSLog(@"width:%d, height:%d", width, height);
    NSLog(@"x: %f, y:%f", from.x, from.y);
    NSLog(@"x: %f, y:%f", to.x, to.y);
    
    NSBitmapImageRep *representation = [[NSBitmapImageRep alloc]
                                        initWithBitmapDataPlanes: NULL
                                        pixelsWide: width
                                        pixelsHigh: height
                                        bitsPerSample: 8
                                        samplesPerPixel: 4
                                        hasAlpha: YES
                                        isPlanar: NO
                                        colorSpaceName: NSCalibratedRGBColorSpace
                                        bytesPerRow: width * 4
                                        bitsPerPixel: 32];

    [image lockFocus];
    NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithBitmapImageRep:representation];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:context];
    
    [image drawInRect:NSMakeRect(0, 0, width, height)
             fromRect:newRect
            operation:NSCompositeCopy
             fraction:1.0];
    
    [context flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    [image unlockFocus];

    return representation;
}

- (NSBitmapImageRep *) grayScaleRepresentationOfImage:(NSImage *)image
{
    NSSize size = [image size];
    
    NSBitmapImageRep *representation = [[NSBitmapImageRep alloc]
                                        initWithBitmapDataPlanes: NULL
                                        pixelsWide: size.width
                                        pixelsHigh: size.height
                                        bitsPerSample: 8
                                        samplesPerPixel: 1
                                        hasAlpha: NO
                                        isPlanar: NO
                                        colorSpaceName: NSCalibratedWhiteColorSpace
                                        bytesPerRow: size.width //* 4
                                        bitsPerPixel: 8];
    
    NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithBitmapImageRep:representation];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:context];
    [image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
    [context flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    return representation;
}





@end
