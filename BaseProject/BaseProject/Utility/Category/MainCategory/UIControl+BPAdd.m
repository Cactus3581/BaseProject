//
//  UIControl+BPAdd.m
//  TryCenter
//
//  Created by wazrx on 16/6/5.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIControl+BPAdd.h"
#import "NSObject+BPAdd.h"

@interface _BPControlTargetObject : NSObject

@property (nonatomic, weak) UIControl *control;
@property (nonatomic, copy) void(^config)(UIControl *control);
@end

@implementation _BPControlTargetObject

- (void)_bp_controlEvent{
    if (!_config || !_control) {
        return;
    }
    _config(_control);
}

@end

@implementation UIControl (BPAdd)


- (void)bp_addConfig:(void(^)(UIControl *control))config forControlEvents:(UIControlEvents)controlEvents {
    _BPControlTargetObject *target = [_BPControlTargetObject new];
    [self addTarget:target action:@selector(_bp_controlEvent) forControlEvents:controlEvents];
    target.control = self;
    target.config = config;
    [self bp_setAssociateValue:target withKey:_cmd];
	
}
@end
