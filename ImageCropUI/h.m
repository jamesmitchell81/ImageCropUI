//
//  h.m
//  ImageCropUI
//
//  Created by James Mitchell on 13/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "h.h"

@implementation h

@synthesize path;

- (void) makeBasePath
{
    NSColor* fillColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
    
    path = [NSBezierPath bezierPath];
    [path moveToPoint: NSMakePoint(0.06, 0)];
    [path lineToPoint: NSMakePoint(1.59, 0)];
    [path lineToPoint: NSMakePoint(1.59, 20.16)];
    [path curveToPoint: NSMakePoint(13.41, 32.69) controlPoint1: NSMakePoint(1.59, 27.53) controlPoint2: NSMakePoint(6.5, 32.69)];
    [path curveToPoint: NSMakePoint(24.47, 21.66) controlPoint1: NSMakePoint(19.97, 32.69) controlPoint2: NSMakePoint(24.47, 28.5)];
    [path lineToPoint: NSMakePoint(24.47, 0)];
    [path lineToPoint: NSMakePoint(26, 0)];
    [path lineToPoint: NSMakePoint(26, 21.72)];
    [path curveToPoint: NSMakePoint(13.59, 34.12) controlPoint1: NSMakePoint(26, 29.25) controlPoint2: NSMakePoint(20.97, 34.12)];
    [path curveToPoint: NSMakePoint(1.66, 25.69) controlPoint1: NSMakePoint(7.75, 34.12) controlPoint2: NSMakePoint(3.09, 30.66)];
    [path lineToPoint: NSMakePoint(1.59, 25.69)];
    [path lineToPoint: NSMakePoint(1.59, 47.06)];
    [path lineToPoint: NSMakePoint(0.06, 47.06)];
    [path lineToPoint: NSMakePoint(0.06, 0)];
    [path closePath];
    [path setMiterLimit: 4];
    [path setWindingRule: NSEvenOddWindingRule];
    [fillColor setFill];
    [path fill];
}

@end
