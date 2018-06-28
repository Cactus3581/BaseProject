//
//  BPInheritObjectController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPInheritObjectController.h"
#import "BPInheritSubObject.h"

@interface BPInheritObjectController ()
@property (nonatomic,strong) BPInheritSubObject *obj;
@end

@implementation BPInheritObjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"send";
    [self test];
}

#pragma mark - 自己主动调用
- (void)rightBarButtonItemClickAction:(id)sender {
    [_obj methond_C];
    [_obj methond_D];
}

#pragma mark - 系统主动调用:创建的时候使用
- (void)test {
    BPInheritSubObject *obj = [[BPInheritSubObject alloc] init];
    _obj = obj;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
