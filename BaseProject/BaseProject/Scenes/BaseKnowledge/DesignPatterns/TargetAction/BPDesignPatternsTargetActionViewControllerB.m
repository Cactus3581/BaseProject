//
//  BPDesignPatternsTargetActionViewControllerB.m
//  BaseProject
//
//  Created by Ryan on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsTargetActionViewControllerB.h"

@interface BPDesignPatternsTargetActionViewControllerB () {
    //1. 声明两个私有实例变量 分别记录执行者（target），方法（action）

    id _target; //方法执行者
    SEL _action;//方法
}
@end

@implementation BPDesignPatternsTargetActionViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];

}

//3.记录传入的执行者 和执行方法
- (void)addTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
}

//4.
// 注意这点：withObject:self.TfSecond.text
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //让执行者执行方法
    [_target performSelector:_action withObject:@"TargetAction"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
