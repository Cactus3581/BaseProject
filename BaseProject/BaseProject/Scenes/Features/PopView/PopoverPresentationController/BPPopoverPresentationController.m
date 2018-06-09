//
//  BPPopoverPresentationController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPopoverPresentationController.h"

@interface BPPopoverPresentationController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation BPPopoverPresentationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureButton];
}

- (void)configureButton {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kThemeColor;
    [rightButton setTitle:@"Show" forState:UIControlStateNormal];
    [rightButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    [[rightButton layer] setCornerRadius:25.0f];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.trailing.equalTo(self.view).offset(-30);
        make.centerY.equalTo(self.view);
    }];
}

- (void)buttonAct:(UIButton *)bt {
    [self system:bt];
}


#pragma mark - 系统方法
- (void)system:(UIView *)sender {
    UIPopoverController;//废弃
    //UIPopoverPresentationController
    UIViewController * testVC = [UIViewController new];
    testVC.view.backgroundColor = kExplicitColor;
    // 设置大小
    testVC.preferredContentSize = CGSizeMake(300, 400);
    // 设置 Sytle
    testVC.modalPresentationStyle = UIModalPresentationPopover;
    testVC.popoverPresentationController.backgroundColor = kExplicitColor;
    
    
    // 需要通过 sourceView 来判断位置的
    testVC.popoverPresentationController.sourceView = sender;//确定位置，确定参照视图
    // 指定箭头所指区域的矩形框范围（位置和尺寸）,以sourceView的左上角为坐标原点
    // 这个可以 通过 Point 或  Size 调试位置
    testVC.popoverPresentationController.sourceRect = sender.bounds;//弹框大小
    // 箭头方向
    testVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    // 设置代理
    testVC.popoverPresentationController.delegate = self;
    [self presentViewController:testVC animated:YES completion:nil];
}


#pragma mark --  实现代理方法
//默认返回的是覆盖整个屏幕，需设置成UIModalPresentationNone。
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

//点击蒙版是否消失，默认为yes；
-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

//弹框消失时调用的方法
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    BPLog(@"弹框已经消失");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
