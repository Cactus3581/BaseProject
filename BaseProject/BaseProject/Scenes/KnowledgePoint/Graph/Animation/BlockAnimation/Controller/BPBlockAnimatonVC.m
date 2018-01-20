//
//  BPBlockAnimatonVC.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPBlockAnimatonVC.h"

@interface BPBlockAnimatonVC ()
@property (nonatomic,strong) UIView *testView;
@property (nonatomic,strong) UIImageView *imageview;

@end

@implementation BPBlockAnimatonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.testView];
    [self.view addSubview:self.imageview];

    
//    [self baseViewAnimation];//一般形式的UIView动画
//    [self blockAnimation_1]; //block形式的UIView动画
//    [self blockAnimation_2]; // 弹性动画
//    [self blockAnimation_3]; // 关键帧动画
    [self transitionWithView_4]; //转场动画
//    [self setMaskInView_1];
//    [self setMaskInView_2];
}

#pragma mark - 一般形式的UIView动画
- (void)baseViewAnimation {
    [UIView beginAnimations:@"centerAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationWillStart)];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    self.testView.center = CGPointMake(kScreenWidth/2, 64);//这个也作为动画的一部分
    [UIView commitAnimations];
}

- (void)animationWillStart {
    BPLog(@"%@",@(self.testView.frame));
    self.testView.transform = CGAffineTransformMakeScale(0.2, 0.2);
}

- (void)animationDidStop {
//    self.testView.transform = CGAffineTransformIdentity;
    BPLog(@"%@",@(self.testView.frame));
}

#pragma mark - block形式的UIView动画
- (void)blockAnimation_1 {
    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.testView.center = CGPointMake(kScreenWidth/2, kScreenHeight-self.testView.bounds.size.height/2);
    } completion:^(BOOL finished) {
        [self.testView removeFromSuperview];
    }];
}

- (void)blockAnimation_2 {// 弹性动画
    /*
     usingSpringWithDamping: 取值范围在0.0~1.0， 取值越小，震荡幅度越大
     initialSpringVelocity:确定了在动画结束之前运动的速度。一般情况下都是设置为0。设值举个例子来说，如果想要移动的距离为200pt，移动速度为100pt/s，就需要设置为0.5。
     */
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.testView.center = CGPointMake(kScreenWidth/2, kScreenHeight-self.testView.bounds.size.height/2-10);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)blockAnimation_3 { // 关键帧动画
    [UIView animateKeyframesWithDuration:5 delay:0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionCurveLinear animations:^{
        //第一个关键帧:从0秒开始持续50%的时间，也就是5.0*0.5=2.5秒
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            self.testView.center = CGPointMake(kScreenWidth/2, kScreenHeight-self.testView.bounds.size.height/2-10);
        }];
        
        //第二个关键帧:从50%时间开始持续25%的时间，也就是5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            self.testView.center = CGPointMake(0, 0);
        }];
        //第三个关键帧:从75%时间开始持续25%的时间，也就是5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            self.testView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        }];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)transitionWithView_4 {// 转场动画
    /*
     以上方式可以在改变视图的属性时产生动画，如果视图添加或者移除的时候想要添加动画，就要用到下面的方式了
     transition动画：指定一个view，单独为它设置transition的动画
     option设置动画类型，这里使用翻页动画以及淡出淡入
     */

    UIViewAnimationOptions option = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionTransitionFlipFromLeft;
    
    [UIView transitionWithView:self.imageview duration:10.0 options:option animations:^{
        UIImage *image = [UIImage imageNamed:@"maskImage"];
        self.imageview.image = image;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)transitionWithView_5 {// 转场动画
    /*
     这是一个便捷的视图过渡 API，在动画过程中，首先将 fromView 从父视图中删除，然后将 toView 添加，就是做了一个替换操作。
     在需要视图更改时，这个将变得特别有用。
     */
    UIViewAnimationOptions option = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionFromView:self.testView toView:self.imageview duration:5 options:option completion:^(BOOL finished) {
        
    }];
}

- (void)setMaskInView_1 {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(10,kScreenHeight-100, 50, 50);
    [bt addTarget:self action:@selector(transitionWithViewBt_1) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"转场动画_1" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)transitionWithViewBt_1 {
    [self transitionWithView_4];
}

- (void)setMaskInView_2 {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(100,kScreenHeight-100, 50, 50);
    [bt addTarget:self action:@selector(transitionWithViewBt_2) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"转场动画_2" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)transitionWithViewBt_2 {
    [self transitionWithView_5];
}

- (UIView *)testView {
    if (!_testView) {
        _testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        _testView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        _testView.backgroundColor = kGreenColor;
        UIImage *image = [UIImage imageNamed:@"layerTest"];
        _testView.layer.contents = (__bridge id)image.CGImage;
    }
    return _testView;
}

- (UIImageView *)imageview {
    if (!_imageview) {
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        _imageview.center = CGPointMake(kScreenWidth/2, kScreenHeight/2-200);
        _imageview.backgroundColor = kGreenColor;
        UIImage *image = [UIImage imageNamed:@"layerTest"];
        _imageview.image = image;
    }
    return _imageview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
