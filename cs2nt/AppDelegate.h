//
//  AppDelegate.h
//  cs2nt
//
//  Created by Krzysztof Wicher on 06/01/2012.
//  Copyright (c) 2012 MiK. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AnimationWindows.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>{
    AnimationFlipWindow *flipp;
}
-(IBAction)flip2help:(id)sender;
-(IBAction)flip2main:(id)sender;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *info_window;
@end
