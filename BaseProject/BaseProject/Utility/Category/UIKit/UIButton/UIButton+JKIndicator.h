 //
 //UIButton+BPIndicator.h
 //  BaseProject
 //
 //  Created by xiaruzhen on 2017/12/10.
 //  Copyright © 2017年 cactus. All rights reserved.
 //

#import <UIKit/UIKit.h>

/**
 Simple category that lets you replace the text of a button with an activity indicator.
 */

@interface UIButton (JKIndicator)

/**
 This method will show the activity indicator in place of the button text.
 */
- (void)bp_showIndicator;

/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void)bp_hideIndicator;

@end
