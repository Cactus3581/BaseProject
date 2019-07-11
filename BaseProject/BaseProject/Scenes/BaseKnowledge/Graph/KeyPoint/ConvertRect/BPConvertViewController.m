//
//  BPConvertViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/23.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPConvertViewController.h"

@interface BPConvertViewController ()

@end

@implementation BPConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)initialize {
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = kLightGrayColor;
    [self.view addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = kThemeColor;
    [view1 addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view1);
        make.width.height.equalTo(view1).width.multipliedBy(0.5);
        make.centerY.equalTo(view1).offset(50);
    }];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];

    // 计算view1上的view2 在window中的位置 即CGRect

    CGRect rect = [view1 convertRect:view2.frame toView:kKeyWindow];
    
    // 计算view1上的view2 在window中的位置 即CGRect
    CGRect rect1 = [kKeyWindow convertRect:view2.frame fromView:view1];
    
    // 计算view1上的view2在window中的位置 即CGPoint

    CGPoint point = [view1 convertPoint:view2.center toView:kKeyWindow];
    
    // 计算view1上的view2在window中的位置 即CGPoint

    CGPoint point1 = [kKeyWindow convertPoint:view2.center fromView:view1];
    
    BPLog(@"rect = %@,rect1 = %@,point = %@,,point1 = %@",NSStringFromCGRect(rect),NSStringFromCGRect(rect1),NSStringFromCGPoint(point),NSStringFromCGPoint(point1));
}

@end
