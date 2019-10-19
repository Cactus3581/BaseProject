//
//  BPHitTestInterceptParentView.m
//  BaseProject
//
//  Created by Ryan on 2019/4/23.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHitTestInterceptParentView.h"
#import "BPHitTestInterceptSubView.h"

@implementation BPHitTestInterceptParentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    BPHitTestInterceptSubView *view = [[BPHitTestInterceptSubView alloc] init];
    view.backgroundColor = kGreenColor;
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(self).width.multipliedBy(0.5);
    }];
}


//事件拦截第一种方法：重写拦截事件的 view 的 hitTest 方法 ，比如要让 superView 处理事件 就重写 superView 的 hitTest 方法，实现后 所有 subview 将不再能够接受任何事件

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 如果交互未打开，或者透明度小于0.05 或者 视图被隐藏
    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES) {
        return nil;
    }
    // 如果在当前 view 中 直接返回 self 这样自身就成为了第一响应者 subViews 不再能够接受到响应事件
    if ([self pointInside:point withEvent:event]) {
        return self;
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"Super");
}

@end
