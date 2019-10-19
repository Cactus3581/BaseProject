//
//  BPOutSideSuperView.m
//  BaseProject
//
//  Created by Ryan on 2019/5/5.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPOutSideSuperView.h"
#import "BPOutSideSubView.h"

@implementation BPOutSideSuperView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    BPOutSideSubView *view = [[BPOutSideSubView alloc] init];
    view.backgroundColor = kGreenColor;
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.height.equalTo(self).width.multipliedBy(0.5);
        make.bottom.equalTo(self.mas_top).offset(50);
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    // 如果交互未打开，或者透明度小于0.05 或者 视图被隐藏
    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES) {
        return nil;
    }
    
    // 触摸点在视图范围内 则交由父类处理
    if ([self pointInside:point withEvent:event]) {
        return [super hitTest:point withEvent:event];
    }
    
    // 如果触摸点不在范围内 而在子视图范围内依旧返回子视图
    NSArray<UIView *> * superViews = self.subviews;
    // 倒序 从最上面的一个视图开始查找
    for (NSUInteger i = superViews.count; i > 0; i--) {
        
        UIView * subview = superViews[i - 1];
        // 转换坐标系 使坐标基于子视图
        CGPoint newPoint = [self convertPoint:point toView:subview];
        BPLog(@"newPoint = %@",NSStringFromCGPoint(newPoint));
        // 得到子视图 hitTest 方法返回的值
        UIView * view = [subview hitTest:newPoint withEvent:event];
        // 如果子视图返回一个view 就直接返回 不在继续遍历
        if (view) {
            return view;
        }
    }
    
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BPLog(@"Super");
}

@end
