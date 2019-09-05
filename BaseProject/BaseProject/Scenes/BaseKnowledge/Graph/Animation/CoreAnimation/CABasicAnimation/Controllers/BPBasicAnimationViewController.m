//
//  BPBasicAnimationViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/8/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBasicAnimationViewController.h"

@interface BPBasicAnimationViewController ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *alarmView;
@property (nonatomic, weak) IBOutlet UIImageView *hourHand;
@property (nonatomic, weak) IBOutlet UIImageView *minuteHand;
@property (nonatomic, weak) IBOutlet UIImageView *secondHand;
@property (nonatomic, weak) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIView *animationView;

@end


@implementation BPBasicAnimationViewController

//CABasicAnimation 有两个重要的属性：fromValue 初始值  toValue目标值

- (void)viewDidLoad {
    [super viewDidLoad];
    _alarmView.hidden = YES;
    _animationView.backgroundColor = kThemeColor;
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self setUpAlarm];
            }
                break;
                
            case 1:{
                [self combine];
            }
                break;
                
            case 2:{
                [self translation];
            }
                break;
                
            case 3:{
                [self scale];
            }
                break;
                
            case 4:{
                [self rotation];
            }
                break;
                
            case 5:{
                [self rotationX];
            }
                break;
                
            case 6:{
                [self rotationY];
            }
                break;
                
            case 7:{
                [self rotationZ];
            }
                break;
                
            case 8:{
                [self position];
            }
                break;
                
            case 9:{
                [self positionX];
            }
                break;
                
            case 10:{
                [self positionY];
            }
                break;
                
            case 11:{
                [self bounds];
            }
                break;
                
            case 12:{
                [self size];
            }
                break;
                
            case 13:{
                [self sizeW];
            }
                break;
                
            case 14:{
                [self sizeH];
            }
                break;
                
            case 15:{
                [self opacity];
            }
                break;
                
            case 16:{
                [self backgroundColor];
            }
                break;
                
            case 17:{
                [self cornerRadius];
            }
                break;
                
            case 18:{
                [self borderWidth];
            }
                break;
                
            case 19:{
                [self contents];
            }
                break;
                
            case 20:{
                [self shadowColor];
            }
                break;
                
            case 21:{
                [self shadowOffset];
            }
                break;
                
                
            case 22:{
                [self shadowOpacity];
            }
                break;
                
                
            case 23:{
                [self shadowRadius];
            }
                break;
                
            case 24:{
                [self addAnimationObj];
            }
                break;
        }
    }
}

#pragma mark - 闹钟
- (void)setUpAlarm {
    _alarmView.hidden = NO;
    _animationView.hidden = YES;
    
    _alarmView.layer.borderColor = kExplicitColor.CGColor;
    _alarmView.layer.borderWidth = 1;
    _alarmView.layer.cornerRadius = 100;

    _secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    _minuteHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    _hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCall) userInfo:nil repeats:YES];
    
    [self updateHandsAnimated:NO];
}

- (void)timerCall {
    [self updateHandsAnimated:YES];
}

- (void)updateHandsAnimated:(BOOL)animated {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0) *M_PI *2.0;
    CGFloat minuteAngle = (components.minute / 60.0) *M_PI *2.0;
    CGFloat secondAngle = (components.second / 60.0) *M_PI *2.0;
    [self setAngle:hourAngle forHand:_hourHand animated:animated];
    [self setAngle:minuteAngle forHand:_minuteHand animated:animated];
    [self setAngle:secondAngle forHand:_secondHand animated:animated];
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated {
    
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        [self updateHandsAnimated:NO];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        [animation setValue:handView forKey:@"Alarm"];
        [handView.layer addAnimation:animation forKey:nil];
        
    } else {
        handView.layer.transform = transform;
    }
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    UIView *handView = [anim valueForKey:@"Alarm"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}


#pragma mark - 属性：可动画属性

#pragma mark - 属性：CATransform3D：旋转
- (void)combine {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeRotation(M_PI, 1.0, 0.f, 0.f), CATransform3DConcat(CATransform3DMakeTranslation(100, -100, 0.f), CATransform3DMakeScale(0.7, 0.7, 1.0)))];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"transformCombineAnimation"];
}

- (void)translation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.f, -50, 0.f)];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"translationAnimation"];
}

- (void)scale {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"scaleAnimation"];
}

- (void)rotation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1.0, 0.f, 0.f)];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"rotationAnimation"];
}

- (void)rotationX {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"rotationXAnimation"];
}

- (void)rotationY {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"rotationYAnimation"];
}

- (void)rotationZ {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"rotationZAnimation"];
}

#pragma mark - 属性：position
- (void)position {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:_animationView.center];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"PostionAnimation"];
}

- (void)positionX {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.toValue = [NSNumber numberWithFloat:_animationView.center.x];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"PostionXAnimation"];
}

- (void)positionY {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue = [NSNumber numberWithFloat:_animationView.center.y];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"PostionYAnimation"];
}

#pragma mark - 属性：bounds
- (void)bounds {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.toValue = [NSValue valueWithCGRect:_animationView.bounds];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"boundsAnimation"];
}

- (void)size {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    animation.toValue = [NSValue valueWithCGSize:_animationView.bounds.size];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"sizeAnimation"];
}

- (void)sizeW {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    animation.toValue = [NSNumber numberWithFloat:_animationView.bounds.size.width];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"sizeWAnimation"];
}

- (void)sizeH {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
    animation.toValue = [NSNumber numberWithFloat:_animationView.bounds.size.height];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"sizeHAnimation"];
}

#pragma mark - 属性：opacity
- (void)opacity {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.f];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"opacityAnimation"];
}

#pragma mark - 属性：backgroundColor
- (void)backgroundColor {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.toValue = (id)[UIColor colorWithRed:0.399 green:0.4804 blue:0.9887 alpha:1.0].CGColor;
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"backgroundColorAnimation"];
}

#pragma mark - 属性：cornerRadius
- (void)cornerRadius {
    
    _animationView.layer.masksToBounds = YES;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.toValue = [NSNumber numberWithFloat:_animationView.bounds.size.height / 2];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"cornerRadiusAnimation"];
}

#pragma mark - 属性：borderWidth
- (void)borderWidth {
    
    _animationView.layer.masksToBounds = YES;
    _animationView.layer.cornerRadius = _animationView.bounds.size.height / 2;
    _animationView.layer.borderColor = [UIColor colorWithRed:0.3499 green:0.5986 blue:1.0 alpha:1.0].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    animation.toValue = [NSNumber numberWithFloat:5.0];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"borderWidthAnimation"];
}

#pragma mark - 属性：contents
- (void)contents {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.toValue = (id)[UIImage imageNamed:@"Raffle"].CGImage;
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"contentsAnimation"];
}

#pragma mark - 属性：shadowColor
- (void)shadowColor {
    
    _animationView.layer.shadowOpacity = 1.0;
    _animationView.layer.shadowColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowColor"];
    animation.toValue = (id)[UIColor colorWithRed:0.0 green:0.502 blue:1.0 alpha:1.0].CGColor;
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"shadowColorAnimation"];
}

#pragma mark - 属性：shadowOffset
- (void)shadowOffset {
    
    _animationView.layer.shadowOpacity = 1.0;
    _animationView.layer.shadowColor = [UIColor colorWithRed:0.502 green:0.0 blue:1.0 alpha:1.0].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(3,3)];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"shadowOffsetAnimation"];
}

#pragma mark - 属性：shadowOpacity
- (void)shadowOpacity {
    
    _animationView.layer.shadowColor = [UIColor colorWithRed:0.502 green:0.0 blue:1.0 alpha:1.0].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"shadowOpacityAnimation"];
}

#pragma mark - 属性：shadowRadius
- (void)shadowRadius {
    
    _animationView.layer.shadowRadius = 0.f;
    _animationView.layer.shadowOpacity = 1.0;
    _animationView.layer.shadowColor = [UIColor redColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    animation.toValue = [NSNumber numberWithFloat:5.0];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"shadowRadiusAnimation"];
}

#pragma mark - 属性：添加多个动画对象
- (void)addAnimationObj {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
    animation.toValue = [NSNumber numberWithFloat:2.0f];
    [self setupAnimation:animation];
    [_animationView.layer addAnimation:animation forKey:@"scaleAnimation"];
    
    //改变颜色
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation2.repeatCount=100;
    animation2.fromValue = (id)kRedColor.CGColor;
    animation2.toValue = (id)kGreenColor.CGColor;
    [self setupAnimation:animation2];
    [_animationView.layer addAnimation:animation2 forKey:@"backgroundColor"];
}

- (void)setupAnimation:(CABasicAnimation *)animation {
    animation.duration = 2.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
