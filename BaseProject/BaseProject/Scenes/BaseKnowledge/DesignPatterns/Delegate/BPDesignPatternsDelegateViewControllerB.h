//
//  BPDesignPatternsDelegateViewControllerB.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"

//1.声明协议
@protocol BPDesignPatternsDelegateViewControllerDelegate<NSObject>
//2.声明协议方法
- (NSString *)configDelegate;

@end
@interface BPDesignPatternsDelegateViewControllerB : BPBaseViewController
//3.声明协议代理
@property(nonatomic,assign)id<BPDesignPatternsDelegateViewControllerDelegate>delegate;
@end
