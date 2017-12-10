
 //UIView+Toast.h
 //  BaseProject
 //
 //  Created by xiaruzhen on 2017/12/10.
 //  Copyright © 2017年 cactus. All rights reserved.
 //

#import <UIKit/UIKit.h>

extern NSString * const BPToastPositionTop;
extern NSString * const BPToastPositionCenter;
extern NSString * const BPToastPositionBottom;

@interface UIView (BPToast)

// each makeToast method creates a view and displays it as toast
- (void)bp_makeToast:(NSString *)message;
- (void)bp_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position;
- (void)bp_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position image:(UIImage *)image;
- (void)bp_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title;
- (void)bp_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title image:(UIImage *)image;

// displays toast with an activity spinner
- (void)bp_makeToastActivity;
- (void)bp_makeToastActivity:(id)position;
- (void)bp_hideToastActivity;

// the showToast methods display any view as toast
- (void)bp_showToast:(UIView *)toast;
- (void)bp_showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point;
- (void)bp_showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point
      tapCallback:(void(^)(void))tapCallback;

@end
