//
//  BPGesSlidePopupView.h
//  BaseProject
//
//  Created by Ryan on 2021/5/31.
//  Copyright © 2021 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPGesSlidePopupView : UIView

+ (instancetype)showInView:(UIView *)parentView contentView:(UIView *)contentView delegate: (id)delegate;

- (void)dismiss;
- (void)reload;

@end


@protocol BPGesSlidePopupViewDelegate <NSObject>

@optional
- (void)popupViewShowFinished:(BPGesSlidePopupView *)popupView;
- (CGFloat)popupView:(BPGesSlidePopupView *)popupView heightForContentViewWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
