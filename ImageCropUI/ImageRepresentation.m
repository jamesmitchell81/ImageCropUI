//
//  ImageRepresentation.m
//  ImageCropUI
//
//  Created by James Mitchell on 28/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "ImageRepresentation.h"

@implementation ImageRepresentation

@synthesize image;

- (id) initWithImage:(NSImage*)newImage
{
    self = [super init];
    if ( self )
    {
        [self setImage:newImage];
    }
    return self;
}


@end
