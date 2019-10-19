//
//  UIResponder+BPMsgSend.h
//  BaseProject
//
//  Created by Ryan on 2019/7/6.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (BPMsgSend)

// 多层级传递消息，替代其他几种设计模式
- (void)bp_routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo;

//找到当前View对应的控制器
- (UIViewController *)bp_parentController;

@end

NS_ASSUME_NONNULL_END
