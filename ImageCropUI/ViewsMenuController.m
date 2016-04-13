//
//  ViewsMenuController.m
//  ImageCropUI
//
//  Created by James Mitchell on 13/04/2016.
//  Copyright © 2016 James Mitchell. All rights reserved.
//

#import "ViewsMenuController.h"

@implementation ViewsMenuController


- (IBAction) displayDropZoneView:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ViewChangeDropZoneReciever" object:self];
}


- (IBAction) displayTemplateView:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ViewChangeTemplateViewReciever" object:self];
}



@end
