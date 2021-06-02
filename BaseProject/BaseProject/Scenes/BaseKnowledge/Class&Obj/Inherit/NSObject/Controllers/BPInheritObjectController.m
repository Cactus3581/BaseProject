//
//  BPInheritObjectController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/8.
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
    [_obj methond_C]; // C，c
    [_obj methond_D]; // d
    [_obj methond_X]; // X，Y，z
    _obj.offset += 1;
}

#pragma mark - 系统主动调用:创建的时候使用
- (void)test {
    BPInheritSubObject *obj = [[BPInheritSubObject alloc] init]; //A,a,b
    _obj = obj;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
