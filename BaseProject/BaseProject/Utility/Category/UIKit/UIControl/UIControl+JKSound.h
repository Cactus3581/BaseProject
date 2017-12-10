//
//  UIControl+Sound.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIControl (JKSound)

/// Set the sound for a particular control event (or events).
/// @param name The name of the file. The method looks for an image with the specified name in the application’s main bundle.
/// @param controlEvent A bitmask specifying the control events for which the action message is sent. See “Control Events” for bitmask constants.
//不同事件增加不同声音
- (void)bp_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;

@end
