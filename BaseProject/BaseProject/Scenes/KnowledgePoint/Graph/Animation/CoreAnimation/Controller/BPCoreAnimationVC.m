//
//  BPCoreAnimationVC.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPCoreAnimationVC.h"

@interface BPCoreAnimationVC ()
@property (nonatomic,strong) UIView *testView;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UIImageView *transviewimageview;

@property (nonatomic, assign) int subtype;

@end

typedef enum :NSUInteger{
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
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
    
} AnimationType;

@implementation BPCoreAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.testView];
//    [self.view addSubview:self.imageview];

//    [self opacityAniamtion];
//    [self scaleAnimation];
//
//    [self rotateAnimation];
//    [self backgroundAnimation];
    
//    [self keyframeAnimation_values];
//    [self keyframeAnimation_path];
//    [self groupAnimation];
    
    //转场动画_2
//    [self transitionAnimation_1];
    
    //转场动画_2
    //2_1
//    [self.view addSubview:self.transviewimageview];
    //2_2
//    [self addBgImageWithImageName:@"transitionWithType02.jpg"];

    _subtype = 0;
//    [self transitionAnimation_2];
    
    //[self springAnimation];

}

- (void)springAnimation {
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    label.text = @"CASpringAnimation";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position.x"];
    spring.damping = 5;
    spring.stiffness = 100;
    spring.mass = 1;
    spring.initialVelocity = 0;
    
    spring.fromValue = @(label.layer.position.x);
    spring.toValue = @(label.layer.position.x + 50);
    spring.duration = spring.settlingDuration;
    [label.layer addAnimation:spring forKey:@""];
}

#pragma mark - CABasicAnimation-基础动画:位移、透明度、缩放、旋转
/**
 *  透明度动画
 */
-(void)opacityAniamtion{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0f];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    anima.duration = 1.0f;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
//    anima.autoreverses = YES;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.testView.layer addAnimation:anima forKey:@"opacityAniamtion"];
}
/**
 *  缩放动画
 */
-(void)scaleAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
    anima.toValue = [NSNumber numberWithFloat:2.0f];
    anima.duration = 1.0f;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.testView.layer addAnimation:anima forKey:@"scaleAnimation"];
}

/**
 *  旋转动画
 */
-(void)rotateAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima.toValue = [NSNumber numberWithFloat:3*M_PI];
    anima.duration = 1.0f;
    [self.testView.layer addAnimation:anima forKey:@"rotateAnimation"];
}
/**
 *  背景色变化动画
 */
-(void)backgroundAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue =(id) kGreenColor.CGColor;
    anima.duration = 1.0f;
    [self.testView.layer addAnimation:anima forKey:@"backgroundAnimation"];
}

#pragma mark - CAKeyframeAnimation-关键帧:路径、抖动
-(void)keyframeAnimation_values{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyAnimation.duration = 3.0f;
    keyAnimation.beginTime = CACurrentMediaTime() + 1.0;
    
    CATransform3D transform1 = CATransform3DMakeScale(1.5, 1.5, 0);
    CATransform3D transform2 = CATransform3DMakeScale(0.8, 0.8, 0);
    CATransform3D transform3 = CATransform3DMakeScale(3, 3, 0);
    
    keyAnimation.values = @[[NSValue valueWithCATransform3D:transform1],[NSValue valueWithCATransform3D:transform2],[NSValue valueWithCATransform3D:transform3]];
    keyAnimation.keyTimes = @[@0,@0.5,@1];
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    [self.testView.layer addAnimation:keyAnimation forKey:nil];
}

/**
 *  path动画
 */
-(void)keyframeAnimation_path{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anima.beginTime = CACurrentMediaTime() + 1.0;

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kScreenWidth/2-100, kScreenHeight/2-100, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.testView.layer addAnimation:anima forKey:@"pathAnimation"];
}
#pragma mark - CAAnimationGroup-组合动画:多个动画的结合
-(void)groupAnimation{
    //位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, kScreenHeight/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/3, kScreenHeight/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/3, kScreenHeight/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth*2/3, kScreenHeight/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth*2/3, kScreenHeight/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth, kScreenHeight/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
    groupAnimation.duration = 4.0f;
    
    [self.testView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}


#pragma mark - CATransition:转场动画:淡入淡出、推挤、解开、覆盖
-(void)transitionAnimation_1
{
    /*
     什么是转场动画？
     就是从一个场景转换到另外一个场景，像导航控制器的push效果，就是一个转场。能为层提供移除屏幕和移入屏幕的动画效果
     
     CATransition通常用于通过CALayer控制UIView内子控件的过渡动画，比如删除子控件，添加子控件，切换两个子控件等。
     
     imageView切换图片，控制器的push或modal，UIView对象调用exchangeSubviewAtIndex：WithIndex：方法的时候可以出发转场动画.
     
     
     基本使用
     
     创建CATransition对象。
     为CATransition设置type和subtype两个属性，type指定动画类型，subtype指定动画移动方向(有些动画是固定方向，指定subtype无效)。
     如果不需要动画执行整个过程(动画执行到中间部分就停止)，可以指定startProgress，endProgress属性。
     调用UIView的layer属性的addAnimation: forKey:方法控制该UIView内子控件的过渡动画。
     
     
     
     动画类型:
     
     CATransition的type有以下几个值
     kCATransitionFade 渐变
     kCATransitionMoveIn 覆盖
     kCATransitionPush 推出
     kCATransitionReveal 揭开
     
     除此之外，该type还支持如下私有动画
     cube 立方体旋转
     suckEffect  收缩动画
     oglFlip  翻转
     rippleEffect  水波动画
     pageCurl  页面揭开
     pageUnCurl 放下页面
     cemeraIrisHollowOpen  镜头打开
     cameraIrisHollowClose 镜头关闭
     
     
     CATransition的subtype属性用于控制动画方向，支持如下值
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromTop
     kCATransitionFromBottom
     
     */
    
    //创建一个转场动画
    CATransition *animation = [CATransition animation];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;


    animation.beginTime = CACurrentMediaTime() + 1.0;

    animation.duration = 1.0;
    //设置转场类型
    animation.type = kCATransitionMoveIn;
//    animation.type = @"oglFlip";

    //设置转场的方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画开始的位置
    //animation.startProgress = 0.5;
    //设置动画结束的位置
    //animation.endProgress = 0.8;
    
    UIImage *image = [UIImage imageNamed:@"maskImage"];
    
    [UIView animateWithDuration:1.0f animations:^{
        self.imageview.image = image;
    }];
    
    //添加动画
    [self.imageview.layer addAnimation:animation forKey:@"transitionAnimation"];


}

- (void)transitionAnimation_2
{
    NSArray *array = @[@"淡化效果",@"push效果",@"揭开效果",@"覆盖效果",@"3D立方效果",@"吮吸效果",@"翻转效果",@"波纹效果",@"翻页效果",@"反翻页效果",@"开镜头效果",@"关镜头效果",@"下翻页效果",@"上翻页效果",@"左翻转效果",@"右翻转效果"];

    
    for (int i = 0; i<16; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:array[i] forState:UIControlStateNormal];
        [bt setTitleColor:kRedColor forState:UIControlStateNormal];
        bt.frame = CGRectMake(10+(i%2)*kScreenWidth/2, 25*(i/2)+100, 100, 25);
        [bt addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag = i+1;
        [self.view addSubview:bt];
    }
}
- (void)tapButton:(UIButton *)bt{
    UIButton *button = bt;
    AnimationType animationType = button.tag;
    
    NSString *subtypeString;
    
    switch (_subtype) {
        case 0:
            subtypeString = kCATransitionFromLeft;
            break;
        case 1:
            subtypeString = kCATransitionFromBottom;
            break;
        case 2:
            subtypeString = kCATransitionFromRight;
            break;
        case 3:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    _subtype += 1;
    if (_subtype > 3) {
        _subtype = 0;
    }
    
    
    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:self.view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CurlDown:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }
    
    static int i = 0;
    if (i == 0) {
        [self addBgImageWithImageName:@"transitionWithType01.jpg"];
        i = 1;
    }
    else
    {
        [self addBgImageWithImageName:@"transitionWithType02.jpg"];
        i = 0;
    }
    
}

#pragma 给View添加背景图
-(void)addBgImageWithImageName:(NSString *) imageName
{
    
    //2_1
    UIImage *image = [UIImage imageNamed:imageName];
    self.transviewimageview.image = image;
    
    //2_2
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];

}

#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 1.0f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    
    //2_1
    [self.transviewimageview.layer addAnimation:animation forKey:@"animation"];
    
    //2_2
//    [view.layer addAnimation:animation forKey:@"animation"];

}



#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:1.0f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

- (UIView *)testView
{
    if (!_testView) {
        _testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        _testView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        _testView.backgroundColor = kGreenColor;
        UIImage *image = [UIImage imageNamed:@"layerTest"];
        _testView.layer.contents = (__bridge id)image.CGImage;
        
    }
    return _testView;
}
- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        _imageview.center = CGPointMake(kScreenWidth/2, kScreenHeight/2-200);
        
        _imageview.backgroundColor = kGreenColor;
        UIImage *image = [UIImage imageNamed:@"layerTest"];
        _imageview.image = image;
    }
    return _imageview;
}
- (UIImageView *)transviewimageview
{
    if (!_transviewimageview) {
        _transviewimageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
        
        _transviewimageview.backgroundColor = kGreenColor;
        UIImage *image = [UIImage imageNamed:@"transitionWithType02.jpg"];
        _transviewimageview.image = image;
    }
    return _transviewimageview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
