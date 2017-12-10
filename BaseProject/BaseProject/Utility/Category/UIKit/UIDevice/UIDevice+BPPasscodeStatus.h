//
//  UIDevice+PasscodeStatus.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BPPasscodeStatus){
    /* The passcode status was unknown */
    BPPasscodeStatusUnknown   = 0,
    /* The passcode is enabled */
    BPPasscodeStatusEnabled   = 1,
    /* The passcode is disabled */
    BPPasscodeStatusDisabled  = 2
};

@interface UIDevice (BPPasscodeStatus)

/**
 *  Determines if the device supports the `passcodeStatus` check. Passcode check is only supported on iOS 8.
 */
@property (readonly) BOOL bp_passcodeStatusSupported;

/**
 *  Checks and returns the devices current passcode status.
 *  If `passcodeStatusSupported` returns NO then `LNPasscodeStatusUnknown` will be returned.
 */
@property (readonly) BPPasscodeStatus bp_passcodeStatus;

@end
