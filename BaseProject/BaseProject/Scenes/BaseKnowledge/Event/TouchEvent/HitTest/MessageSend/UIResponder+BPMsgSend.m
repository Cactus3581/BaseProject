//
//  UIResponder+BPMsgSend.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/6.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "UIResponder+BPMsgSend.h"

@implementation UIResponder (BPMsgSend)

- (void)bp_routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo {
    [[self nextResponder] bp_routerEventWithName:eventName userInfo:userInfo];
}

- (UIViewController *)bp_parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

@end
