//
//  DropZoneView.m
//  ImageCropUI
//
//  Created by James Mitchell on 26/01/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "DropZoneView.h"
#import "ImageRepresentation.h"

@class ImageRepresentation;

@implementation DropZoneView

@synthesize image = _image;
@synthesize name = _name;


- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    if (self)
    {
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
    }
    
    return self;
}


- (NSDragOperation) draggingEntered:(id<NSDraggingInfo>)sender
{
    // the pastboard and drag operation.
    NSPasteboard* pasteboard;
    NSDragOperation sourceDragInformation;
    
    NSLog(@"draggingEntered");
    
    // get the drag information from the sender.
    sourceDragInformation = [sender draggingSourceOperationMask];
    // get the pastebaord information from the sender.
    pasteboard = [sender draggingPasteboard];
    
    if ( [[pasteboard types] containsObject:NSFilenamesPboardType] )
    {
        if ( sourceDragInformation & NSDragOperationCopy )
        {
            
            self.successDisplay = YES;
            [self setNeedsDisplay:YES];
            
            _name = @"James";
            
            return NSDragOperationCopy;
        }
    }
    
    return NSDragOperationNone;
}

- (void) draggingExited:(id<NSDraggingInfo>)sender
{
    self.defaultDisplay = YES;
    [self setNeedsDisplay:YES];
}

- (BOOL) prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    // Apple Docs[https://developer.apple.com/library/mac/samplecode/CocoaDragAndDrop/Listings/CocoaDragAndDrop_DragDropImageView_m.html]
    // Only interested in a sender that can create an image
    BOOL correct = [NSImage canInitWithPasteboard: [sender draggingPasteboard]];
    
    NSLog(correct ? @"YES" : @"NO");
    
    return correct;
}

// Handles drop data.
- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender
{
    
    NSImage* droppedImage = [[NSImage alloc] initWithPasteboard:[sender draggingPasteboard]];
    _image = droppedImage;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUploadReciever" object:self];
    
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // this is temporay and will need to change to CoreAnimation.
        [[NSColor greenColor] setFill];
        NSRectFill(dirtyRect);
        [super drawRect:dirtyRect];
}

@end
