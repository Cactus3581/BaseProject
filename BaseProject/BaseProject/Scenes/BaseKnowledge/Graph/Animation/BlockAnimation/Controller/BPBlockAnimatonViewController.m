//
//  BPBlockAnimatonViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/1/23.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPBlockAnimatonViewController.h"

@interface BPBlockAnimatonViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *animationView;
@property (weak, nonatomic) IBOutlet UIImageView *animationView1;

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIImageView *subView1;
@property (nonatomic,strong) UIView *subView2;

@end


@implementation BPBlockAnimatonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.subView1];
//    [self.contentView addSubview:self.subView2];

//    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self transaction];
            }
                break;
                
            case 1:{
                [self beginAnimation];
            }
                break;
                
            case 2:{
                [self spring];
            }
                break;
                
            case 3:{
                [self keyframes];
            }
                break;
                
            case 4:{
                [self transition];
            }
                break;
                
            case 5:{
                [self transition1];
            }
                break;
                
            case 6:{
                [self withoutAnimation];
            }
                break;
                
            case 7:{
                [self removeView];
            }
                break;
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self handleDynamicJumpData];
}

#pragma mark - 显式使用事务开启UIView的属性动画
// 事务用于批量提交多个对layer-tree的操作
- (void)transaction {

    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setDisableActions:YES];
    _animationView.layer.transform = CATransform3DMakeScale(3, 3, 3);
    [CATransaction setCompletionBlock:^{
        //complete block
    }];
    [CATransaction commit];
}

#pragma mark - 一般形式的UIView动画
- (void)beginAnimation {

    //第一个参数给动画起一个名字，第二个参数 为哪一个视图做的动画
    [UIView beginAnimations:@"centerAnimation" context:(__bridge void *)(_animationView)];//
    
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];

    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:100];
    [UIView setAnimationDelay:0];
    
    //设置代理(不需要再写遵守协议)
    [UIView setAnimationDelegate:self];
    //代理方法
    [UIView setAnimationWillStartSelector:@selector(animationWillStart:context:)];//动画开始时做什么
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];//动画结束时做什么
    
    _animationView.center = CGPointMake(kScreenWidth/2, 64);//这个也作为动画的一部分
    [UIView commitAnimations];//提交动画
}

//动画开始
- (void)animationWillStart:(NSString *)animationID context:(void *)context {
    _animationView.transform = CGAffineTransformMakeScale(0.2, 0.2);
}

//动画结束
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)contexts {
    _animationView.transform = CGAffineTransformIdentity;
}

#pragma mark - UIView 的弹簧动画
- (void)spring {
    /*
     usingSpringWithDamping: 取值范围在0.0~1.0， 取值越小，震荡幅度越大
     initialSpringVelocity:表示初始的速度，数值越大一开始移动越快。一般情况下都是设置为0
     */
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _animationView.center = CGPointMake(kScreenWidth/2, kScreenHeight-_animationView.bounds.size.height/2-10);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UIView 的关键帧动画
- (void)keyframes {
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionCurveLinear animations:^{
        
        //第一个关键帧:从0秒开始持续50%的时间，也就是5.0*0.5=2.5秒
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            _animationView.center = CGPointMake(kScreenWidth/2, kScreenHeight-_animationView.bounds.size.height/2-10);
        }];
        
        //第二个关键帧:从50%时间开始持续25%的时间，也就是5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            _animationView.center = CGPointMake(0, 0);
        }];
        
        //第三个关键帧:从75%时间开始持续25%的时间，也就是5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            _animationView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UIView 的转场动画：transitionWithView
- (void)transition {
    
    //上面的动画可以在改变视图的属性时产生动画，如果视图添加或者移除的时候想要添加动画，就要用到转场动画
    
    UIViewAnimationOptions option = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionTransitionFlipFromLeft;
    
    // 在块里添加/移除视图
    [UIView transitionWithView:self.contentView duration:2 options:option animations:^{

        [_subView1 removeFromSuperview];
        [self.contentView addSubview:self.subView2];
        
        _subView1.image = [UIImage imageNamed:@"module_landscape6"];
        _subView2.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}


#pragma mark - UIView 的转场动画：transitionFromView
- (void)transition1 {
    // 首先将 fromView 从父视图中删除，然后将 toView 添加
    
    UIViewAnimationOptions option = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionTransitionFlipFromLeft;
    
    [UIView transitionFromView:self.subView1 toView:self.subView2 duration:0.5 options:option completion:^(BOOL finished) {

        
    }];
}

#pragma mark - UIView 的禁止动画：performWithoutAnimation
- (void)withoutAnimation {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 220, 50, 50)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionRepeat|UIViewKeyframeAnimationOptionAutoreverse animations:^{
        view.frame = CGRectMake(100, 100, 50, 50);
        [UIView performWithoutAnimation:^{
            // 在动画block中不执行动画的代码.
            view.backgroundColor = [UIColor blueColor];
        }];
    } completion:^(BOOL finished) {
        
        
    }];
}

#pragma mark - UIView 的移除子view的动画：performSystemAnimation
- (void)removeView {
    
    // 删除视图上的子视图 animation这个枚举只有一个删除值
    [UIView performSystemAnimation:UISystemAnimationDelete
                           onViews:@[self.subView1]
                           options:0
                        animations:^{
                            _subView1.alpha = 0;
                        } completion:^(BOOL finished) {
                            [_subView1 removeFromSuperview];
                        }];
}


- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        _contentView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        _contentView.backgroundColor = kThemeColor;
        UIImage *image = [UIImage imageNamed:@"jobs_youth"];

//        _testView.layer.contents = (__bridge id)image.CGImage;
    }
    return _contentView;
}

- (UIView *)subView2 {
    if (!_subView2) {
        _subView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _subView2.backgroundColor = kRedColor;
        UIImage *image = [UIImage imageNamed:@"jobs_youth"];
//        _testView1.layer.contents = (__bridge id)image.CGImage;
    }
    return _subView2;
}

- (UIImageView *)subView1 {
    if (!_subView1) {
        _subView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
        _subView1.backgroundColor = kGreenColor;
//        UIImage *image = [UIImage imageNamed:@"jobs_youth"];
//        _imageview.image = image;
    }
    return _subView1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
