//
//  BPDesignPatternsTargetActionViewControllerB.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"

@interface BPDesignPatternsTargetActionViewControllerB : BPBaseViewController
//1.声明：获取方法，以及执行者
- (void)addTarget:(id)target action:(SEL)action;
@end
