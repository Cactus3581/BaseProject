//
//  BPCATransitionViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/9/4.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPCATransitionViewController.h"
//动画类型
typedef NS_ENUM(NSUInteger, AnimationType) {
    Fade = 1,                   //淡入淡出
    Push,                       //推出
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体旋转
    SuckEffect,                 //吮吸/ 收缩动画
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
};

typedef NS_ENUM(NSUInteger, AnimationDirection) {
    Left,
    Bottom,
    Right,
    Top,
};

/*
 转场/过渡动画：从一个场景转换到另外一个场景，比如移除屏幕和移入屏幕的动画效果
 
 CATransition通常用于删除子控件，添加子控件，切换两个子控件。
 
 imageView切换图片，控制器的push或modal，UIView对象调用exchangeSubviewAtIndex：WithIndex：方法的时候可以出发转场动画.

 type属性指定动画类型，subtype属性指定动画移动方向(有些动画是固定方向，指定subtype无效)。
 
 如果不需要动画执行整个过程(动画执行到中间部分就停止)，可以指定startProgress，endProgress属性。
 
 */

@interface BPCATransitionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,assign) AnimationDirection subtype;

@end


@implementation BPCATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self transitionAnimation];
            }
                break;
        }
    }
}

- (void)transitionAnimation {
    NSArray *array = @[
                       @"淡化效果",@"push效果",@"揭开效果",@"覆盖效果",@"3D立方效果",@"吮吸效果",@"翻转效果",@"波纹效果",@"翻页效果",@"反翻页效果",@"开镜头效果",@"关镜头效果",@"下翻页效果",@"上翻页效果",@"左翻转效果",@"右翻转效果"
                       ];
    
    
    for (int i = 0; i<16; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:kThemeColor forState:UIControlStateNormal];
        button.frame = CGRectMake(10+(i%2)*kScreenWidth/2, 25*(i/2)+100, 100, 25);
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [self.view addSubview:button];
    }
}

- (void)tapButton:(UIButton *)button {
    
    AnimationType animationType = button.tag;
    
    NSString *subtypeString;
    
    switch (_subtype) {
            
        case Left:
            subtypeString = kCATransitionFromLeft;
            break;
            
        case Bottom:
            subtypeString = kCATransitionFromBottom;
            break;
            
        case Right:
            subtypeString = kCATransitionFromRight;
            break;
            
        case Top:
            subtypeString = kCATransitionFromTop;
            break;
    }
    
    _subtype += 1;
    if (_subtype > 3) {
        _subtype = 0;
    }
    
    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade subtype:subtypeString];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush subtype:subtypeString];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal subtype:subtypeString];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn subtype:subtypeString];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" subtype:subtypeString];
            break;
            
        case SuckEffect:
            [self transitionWithType:@"suckEffect" subtype:subtypeString];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" subtype:subtypeString];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" subtype:subtypeString];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" subtype:subtypeString];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" subtype:subtypeString];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" subtype:subtypeString];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" subtype:subtypeString];
            break;
            
        case CurlDown:
            [self viewTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self viewTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self viewTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self viewTransition:UIViewAnimationTransitionFlipFromRight];
            break;
    }
}

#pragma mark - CATransition 动画实现
- (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype {

    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.type = type;
    animation.subtype = subtype;
    
    //设置动画开始的位置
    //animation.startProgress = 0.5;
    
    //设置动画结束的位置
    //animation.endProgress = 0.8;

    UIView *animationView = _imageView;
    UIView *animationView1 = self.view;
    
    [animationView.layer addAnimation:animation forKey:@"transitionAnimation"];
    
    if ([animationView isEqual:_imageView]) {
        [self exchangeImage];
    }
}

- (void)exchangeImage {
    UIImage *currentImage = self.imageView.image;
    
    UIImage *image01 = [UIImage imageNamed:@"module_landscape3.jpg"];
    UIImage *image02 = [UIImage imageNamed:@"module_landscape2.jpg"];
    
    NSData *currentData = UIImagePNGRepresentation(currentImage);
    NSData *data01 = UIImagePNGRepresentation(image01);
    
    UIImage *nextImage = image01;
    if ([currentData isEqual:data01]) {
        nextImage = image02;
    }
    _imageView.image = nextImage;
}

#pragma mark - UIView实现动画
- (void)viewTransition:(UIViewAnimationTransition)transition {
    
    UIView *animationView = _imageView;
    UIView *animationView1 = self.view;
    
    [UIView animateWithDuration:1.0f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:animationView cache:YES];
        if ([animationView isEqual:_imageView]) {
            [self exchangeImage];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
