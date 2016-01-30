//
//  ImageRepresentation.h
//  ImageCropUI
//
//  Created by James Mitchell on 28/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageRepresentation : NSObject

@property (nonatomic, assign) NSImage* image;

- (id) initWithImage:(NSImage*)image;

@end
