//
//  BPAnchorPopView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPAnchorPopView : UIView

+ (instancetype)arrowPopViewWithHeight:(CGFloat)height targetView:(UIView *)targetView superView:(UIView *)superView;

- (void)showPopView;
- (void)removePopView;

@property (nonatomic,strong) UIView *targetView;
@property (nonatomic,strong) UIView *superView;
@property (nonatomic,assign) CGFloat limitH;
@property (nonatomic,assign) CGFloat offset;

@end

