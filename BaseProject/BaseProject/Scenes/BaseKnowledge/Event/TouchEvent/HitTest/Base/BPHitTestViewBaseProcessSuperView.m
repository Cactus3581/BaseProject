//
//  BPHitTestView.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHitTestViewBaseProcessSuperView.h"
#import "BPHitTestViewBaseProcessView.h"

@interface BPHitTestViewBaseProcessSuperView()

@property (nonatomic,weak) UIButton *button;

@end

@implementation BPHitTestViewBaseProcessSuperView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    BPHitTestViewBaseProcessView *view = [[BPHitTestViewBaseProcessView alloc] init];
    view.backgroundColor = kGreenColor;
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(self).width.multipliedBy(0.5);
    }];
}

#pragma mark - 事件传递：查找第一响应者

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    // 1.判断下窗口能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01) {
        return nil;
    }
    
    // 2.判断下点在不在窗口上
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }

    NSArray<UIView *> * subviews = self.subviews;
    // 倒序 从最上面的一个视图开始查找
    for (NSUInteger i = subviews.count; i > 0; i--) {
        UIView * subview = subviews[i - 1];
        // 转换坐标系 使坐标基于子视图
        CGPoint newPoint = [self convertPoint:point toView:subview];
        // 得到子视图 hitTest 方法返回的值
        UIView * view = [subview hitTest:newPoint withEvent:event];
        // 如果子视图返回一个view 就直接返回 不在继续遍历
        if (view) {
            return view;
        }
    }
    // 所有子视图都没有返回 则返回自身
    return self;
}

//通过 point 参数确定触碰点是否在当前 View 的响应范围内 是则返回YES 否则返回 NO 实现方法大概是这个样子的
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(self.bounds, point);
}

#pragma mark - 事件响应

/*
 UIView是UIResponder的子类，可以覆盖下列4个方法处理不同的触摸事件.提示：touches中存放的都是UITouch对象
 */

// 一根或者多根手指开始触摸view，系统会自动调用view的下面方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"SuperView Began");
}

//一根或者多根手指在view上移动，系统会自动调用view的下面方法（随着手指的移动，会持续调用该方法）
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"SuperView Moved");
}

//一根或者多根手指离开view，系统会自动调用view的下面方法
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"SuperView Ended");
}

//触摸结束前，某个系统事件(例如电话呼入)会打断触摸过程，系统会自动调用view的下面方法
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"SuperView Cancelled");
}

@end
