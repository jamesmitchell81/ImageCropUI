//
//  PixelTrace.m
//  ImageCropUI
//
//  Created by James Mitchell on 13/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "PixelTrace.h"
#import "ImageRepresentation.h"

@implementation PixelTrace

struct PointNode {
    NSPoint point;
    struct PointNode *left;
    struct PointNode *right;
};


- (void) tracePixelsOfImage:(NSImage*)image
{
    NSBitmapImageRep *representation = [ImageRepresentation grayScaleRepresentationOfImage:image];
    unsigned char *data = [representation bitmapData];
    
    int width = image.size.width;
    int height = image.size.height;
    int index = 0;
    int searchPixel = 0;
    BOOL match = NO;
    
    NSMutableArray* points = [[NSMutableArray alloc] init];
   
    // find the first black pixel.
    // or collect all the balck points.
    for ( int y = 0; y < height; y++ )
    {
        for ( int x = 0; x < width; x++ )
        {
            index = x + y * width;
            
            if ( data[index] == searchPixel )
            {
                match = YES;
                NSPoint point = NSMakePoint(x, y);
                NSValue *p = [NSValue valueWithPoint:point];
                [points addObject:p];
//                break;
            }
        }
//        if ( match ) break;
    }
    
//    struct PointNode *head = nil;
    
    [points sortUsingComparator: ^NSComparisonResult(id p1, id p2) {
        NSPoint point1;
        [p1 getValue:&point1];
        
        NSPoint point2;
        [p2 getValue:&point2];
        
        return point1.x > point2.x;
    }];

    for ( NSValue *val in points)
    {
        NSPoint current;
        [val getValue:&current];
        
        NSLog(@"%f, %f", current.x, current.y);
    }
    
}


@end
