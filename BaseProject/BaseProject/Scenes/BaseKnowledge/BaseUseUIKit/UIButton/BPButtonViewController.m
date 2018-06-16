//
//  BPButtonViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPButtonViewController.h"

@interface BPButtonViewController ()

@end

@implementation BPButtonViewController
//https://www.cnblogs.com/OIMM/p/5576853.html
//addTarget uibutton 参数
- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

- (void)configureButton {
    self.view.backgroundColor = kGreenColor;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kRedColor;
    
    // 只有在title时设置对其方式。无用：rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //但是问题又出来，此时文字会紧贴到做边框，我们可以设置    使文字距离做边框保持10个像素的距离。
    //rightButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    
    
    /*
     setBackgroundImage:跟button一样大
     setImage:也会被拉伸
     */
    //    [rightButton setBackgroundImage:[UIImage imageNamed:@"transitionWithType01"] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"transitionWithType01"] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"transitionWithType02"] forState:UIControlStateSelected];
    //    [rightButton setImage:[UIImage imageNamed:@"transitionWithType03"] forState:UIControlStateHighlighted];
    
    //rightButton.imageView.layer.masksToBounds = YES;//无用
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [rightButton setTitle:@"push" forState:UIControlStateNormal];
    
    /*
     设置UIButton上字体的颜色设置UIButton上字体的颜色，不是用：
     [btn.titleLabel setTextColor:kBlackColor];
     btn.titleLabel.textColor=kRedColor;
     而是用：
     */
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    
    [rightButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    //[rightButton.titleLabel sizeToFit];//无用
    
    //    rightButton.backgroundColor = kGreenColor;
    [self.view addSubview:rightButton];
    [[rightButton layer] setCornerRadius:25.0f];
    
    rightButton.showsTouchWhenHighlighted = YES;
    
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [rightButton addGestureRecognizer:longPress];
    
    
    if (@available(iOS 11,*)) {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.trailing.equalTo(self.view.mas_trailing).offset(-30);
            make.bottom.equalTo(self.view).offset(-200);
        }];
    }else {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.trailing.equalTo(self.view).offset(-30);
            make.bottom.equalTo(self.view).offset(-200);
        }];
    }
}

- (void)btnLong:(UILongPressGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        BPLog(@"长按事件");
    }
}

- (void)test {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //属性
    button.frame = CGRectMake(100, 300, 150, 100);
    button.backgroundColor = kBrownColor;
    
    //    (1)设置文字-title     :两种不同状态下，可以同时设置不同的
    
    //   正常状态下  title的设置
    //    [button setTitle:@"登陆" forState:UIControlStateNormal];
    //
    ////    高亮状态下 title的设置
    //    [button setTitle:@"登陆中..." forState:UIControlStateHighlighted];
    
    
    //    核心功能：点击事件
    //    (2)添加点击事件：title.UIControlEventTouchUpInside：触发
    
    //    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [button addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchDown];
    //
    ////    (3)移除点击事件
    //    [button removeTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchDown];
    
    //    (4)设置title的颜色
    //    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    //    [button setTitleColor:kBlueColor forState:UIControlStateHighlighted];
    
    //    (5)设置tite阴影颜色
    //    [button setTitleShadowColor:kBlackColor forState:UIControlStateNormal];
    //    //设置阴影大小。
    ////    button.titleShadowOffset = CGSizeMake(5, 5);
    //    [button setTitleShadowColor:kBlackColor forState:UIControlStateHighlighted];
    //
    
    //    (6)设置背景图片
    [button setBackgroundImage:[UIImage imageNamed:@"navi_scale"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateHighlighted];
    //    设置前景图片
    //    [button setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
    //    [button setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateHighlighted];
    
    [button setShowsTouchWhenHighlighted:YES];//网易云音乐的播放按钮的白色光晕
        [button setAdjustsImageWhenHighlighted:NO];//去除高亮
    [self.view addSubview:button];
}

//点击事件
- (void)btAction:(UIButton *)bt{
    BPLog(@"upInside");
    //    获取正常状态下的title
    BPLog(@"title = %@",[bt titleForState:UIControlStateNormal]);
    //    获取高亮状态下的title
    BPLog(@"title = %@",[bt titleForState:UIControlStateHighlighted]);
}

- (void)btAction2:(UIButton *)bt{
    BPLog(@"down");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
