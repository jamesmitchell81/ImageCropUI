//
//  DropZoneView.h
//  ImageCropUI
//
//  Created by James Mitchell on 26/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowController.h"

//@protocol JMImageReceiverDelegate <NSObject>
//- (NSImage*) provideImage;
//@end


@interface DropZoneView : NSView <NSDraggingDestination>
{
    NSString* _name;
    NSImage* _image;
}

@property (nonatomic, strong) NSImage* image;
@property (nonatomic, strong) NSString* name;
//@property (nonatomic, strong) IBOutlet id delegate;

@property (assign) BOOL successDisplay;
@property (assign) BOOL defaultDisplay;
@property (assign) BOOL errorDisplay;

//- (NSString*) name;

@end
