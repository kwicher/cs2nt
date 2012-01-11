//
//  AppDelegate.m
//  cs2nt
//
//  Created by Krzysztof Wicher on 06/01/2012.
//  Copyright (c) 2012 MiK. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize info_window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(IBAction)flip2help:(id)sender
{
    flipp=[[AnimationFlipWindow alloc] init];

    [flipp flip:_window toBack:info_window];
    [flipp release];
   }
-(IBAction)flip2main:(id)sender
{
    flipp=[[AnimationFlipWindow alloc] init];
    
    [flipp flip:info_window toBack:_window];
    [flipp release];
}
@end
