//
//  PixelTrace.h
//  ImageCropUI
//
//  Created by James Mitchell on 13/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PixelTrace : NSObject


- (void) tracePixelsOfImage:(NSImage*)image;

- (void) modifiedMooreNeighbor:(NSImage*)image;

@end
