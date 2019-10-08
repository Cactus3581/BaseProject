//
//  BPReplicatorLayerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPReplicatorLayerViewController.h"

#define widthBt [UIScreen mainScreen].bounds.size.width/5.0
#define heightBt 30.0

@interface BPReplicatorLayerViewController ()

@property (nonatomic,strong) CAReplicatorLayer *replicatorLayer;

@end


@implementation BPReplicatorLayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0: {
                [self creatreplicatorLayer]; //复制同一个图层一般用法
            }
                break;

            case 1: {
                [self creatreplicatorLayer_one];//音量
            }
                break;

            case 2: {
                [self creatreplicatorLayer_four];//正方形移动的等待指示器
            }
                break;

            case 3: {
                [self creatreplicatorLayer_two];//loading图
            }
                break;

            case 4: {
                [self creatreplicatorLayer_three];//倒影
            }
                break;
                
            case 5: {
                [self creatreplicatorLayer_five];//三角
            }
                break;
        }
    }
}

#pragma mark - 复制同一个图层
- (void)creatreplicatorLayer {
    /*
     CAReplicatorLayer可以对它自己的子Layer进行复制操作。
     */
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 200, 200);;
    replicatorLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2-200);
    replicatorLayer.backgroundColor = kGreenColor.CGColor;
    // replicator.masksToBounds = YES;
    [self.view.layer addSublayer:replicatorLayer];
    
    //复制个数，包括自己。但是复制子层形变(不包括原生子层)
    replicatorLayer.instanceCount = 10;
    
    // instanceColor：子层颜色，会和原生子层背景色冲突，因此二者选其一设置。
    replicatorLayer.instanceColor = kPurpleColor.CGColor;
//    replicatorLayer.instanceRedOffset = -0.1;
//    replicatorLayer.instanceGreenOffset = -0.1;
//    replicatorLayer.instanceBlueOffset = -0.1;
//    replicatorLayer.instanceAlphaOffset = -0.1;

// instanceTransform:复制图层的位置，可以是位移，旋转，缩放。复制出来的层相对上一个做操作。子layer相对于前一个复制layer的形变属性。
    
  // 变换是逐步增加的，每个实例都是相对于前一实例布局。这就是为什么这些复制体最终不会出现在同一个位置上
    
    
  // 因为instanceTransform属性都是根据frame的center作为基准的，所以要设置CAReplicatorLayer的frame，
  // 复制图层有一个关键的地方是，你往原始的图层中添加动画效果，复制出来的副本可以实时的复制这些动画效果。
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicatorLayer.instanceTransform = transform;
    
    // 是否将3D例子系统平面化到一个图层（默认NO）
    replicatorLayer.preservesDepth = NO;
    
    //动画时间延迟。默认为0。复制出来的层的动画相对前一个延迟0.5秒
    replicatorLayer.instanceDelay = 0;
    
    CALayer *subLayer = [CALayer layer];
    subLayer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    subLayer.backgroundColor = kLightGrayColor.CGColor;
    
    // 想要复制subLayer，必须让replicatorLayer添加该subLayer
    [replicatorLayer addSublayer:subLayer];
}

#pragma mark - 创建replicatorLayer  - 1 - 音量条
- (void)creatreplicatorLayer_one {
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame =CGRectMake(10, 300, 30, 100);
    //设置锚点
    replicatorLayer.anchorPoint =CGPointMake(0.5,1 );
    
    [self.view.layer addSublayer:replicatorLayer];
    
    
    CALayer * layer = [CALayer layer];
    //设置锚点
    layer.anchorPoint = CGPointMake(0.5,1);
    
    layer.frame = replicatorLayer.bounds;//: 0, y: 0, width: 30, height: 90)
    
    layer.backgroundColor = kGreenColor.CGColor;
    [replicatorLayer addSublayer:layer];
    
    CABasicAnimation * moveRectangle = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    moveRectangle.toValue = @1.5;
    
    moveRectangle.duration = 0.7;
    moveRectangle.autoreverses = true;
    moveRectangle.repeatCount = HUGE;
    
    //    [layer addAnimation:moveRectangle forKey:nil];
    
    replicatorLayer.instanceCount = 4;
    //平移点的间隔 x y z
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(30 + 10, 0, 0);
    replicatorLayer.instanceDelay =0.3;//延迟动画开始时间 以造成上下移动的效果
    
    // 子层颜色，会和原生子层背景色冲突，因此二者选其一设置。
    //    replicatorLayer.instanceColor = kPurpleColor.CGColor;
    
    //    设置颜色通道偏移量，相等上一个一点偏移量，就是阴影效果
    replicatorLayer.instanceGreenOffset = -0.3;
    //    replicatorLayer.instanceRedOffset = 0.3;
    //    replicatorLayer.instanceGreenOffset = -0.3;
}

#pragma mark - 创建replicatorLayer  - 2 - loading图
- (void)creatreplicatorLayer_two {
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
    replicatorLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    replicatorLayer.backgroundColor = kRedColor.CGColor;
    [self.view.layer addSublayer:replicatorLayer];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = kGreenColor.CGColor;
    layer.frame = CGRectMake(0, 0, 15, 15);
    layer.cornerRadius = 7.5;
    [replicatorLayer addSublayer:layer];
    
    replicatorLayer.instanceCount = 15;
    CGFloat angle = 2 * M_PI/ 15.;
    
    
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replicatorLayer.instanceDelay = 1/15.0;//延迟动画开始时间 以造成旋转的效果
    
    layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1;
    scale.toValue = @0.1;
    scale.duration = 1;
    scale.repeatCount = HUGE;
    [layer addAnimation:scale forKey:nil];
}

#pragma mark - 创建replicatorLayer  - 3 - 倒影
- (void)creatreplicatorLayer_three {
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 300, 300);
    replicatorLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2+100);
    replicatorLayer.backgroundColor = kRedColor.CGColor;
    [self.view.layer addSublayer:replicatorLayer];
    
    CALayer *layer = [CALayer layer];
    UIImage *image = [UIImage imageNamed:@"module_landscape2"];
    layer.contents = (__bridge id)image.CGImage;
    layer.backgroundColor = kGreenColor.CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(replicatorLayer.bounds.size.width/2, layer.bounds.size.height/2);
    
    [replicatorLayer addSublayer:layer];
    
    replicatorLayer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform = CATransform3DScale(transform, 1, -1, 0);
    transform = CATransform3DTranslate(transform, 0.0f,-10+layer.bounds.size.height, 0.0f);
    
    
    replicatorLayer.instanceTransform = transform;
    replicatorLayer.instanceDelay=2.;
    replicatorLayer.instanceAlphaOffset = -0.6;//instanceAlphaOffset = -0.6f; 即当前图层实例的alpha值 = 上一个图层实例的alpha - 0.6f，
}

#pragma mark - 创建replicatorLayer  - 4 - 正方形移动的等待指示器
- (void)creatreplicatorLayer_four {
    CGFloat radius = 15;
    CGFloat transX = radius + 5;
    CAShapeLayer *baseLayer = [CAShapeLayer layer];
    baseLayer.frame = CGRectMake(0, 100, radius, radius);
    baseLayer.fillColor = kRedColor.CGColor;
    baseLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    
    //横向创建5个圆形baseLayer
    CAReplicatorLayer *replicator1 = [CAReplicatorLayer layer];
    replicator1.frame = CGRectMake(100, 100, radius, radius);
    replicator1.instanceCount = 5;
    replicator1.instanceTransform = CATransform3DMakeTranslation(transX, 0, 0);
    replicator1.instanceDelay = 0.3; //这个属性很重要，设置延迟时间才会出现逐个变化的效果
    [replicator1 addSublayer:baseLayer];
    
    //将上面创建的replicator1 作为子视图在纵向创建5个，形成一个正方形。
    CAReplicatorLayer *replicator2 = [CAReplicatorLayer layer];
    replicator1.frame = CGRectMake(100, 100+radius+10, radius, radius);
    replicator2.instanceCount = 5;
    replicator2.instanceTransform = CATransform3DMakeTranslation(0, transX, 0);
    replicator2.instanceDelay = 0.3;
    [replicator2 addSublayer:replicator1];
    [self.view.layer addSublayer:replicator2];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 0)];
    animation.repeatCount = HUGE;
    animation.autoreverses = YES; //autoreverses需要注意，他的意思是动画结束时执行逆动画
    [baseLayer addAnimation:animation forKey:nil];
}

#pragma mark - 创建replicatorLayer - 5 - 三角
- (void)creatreplicatorLayer_five {
    
    /** 子layer实现 */
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, 25, 25);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 25, 25)];
    shape.path = path.CGPath;
    shape.fillColor = kBlackColor.CGColor;
    
    /** CAReplicatorLayer的实现 */
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc] init];
    replicatorLayer.frame = CGRectMake(100, 100, 25, 25);
    replicatorLayer.backgroundColor = kCyanColor.CGColor;
    replicatorLayer.instanceDelay = 0.0;
    replicatorLayer.instanceCount = 3;
    //这里面要设置复制的layer的变换了。先向右移动一定像素，再顺时针移动一定角度。这里有个点，至少我当时不是很明白，就是为什么这么设置就会闭合成一个三角形。
    
    CATransform3D t = CATransform3DTranslate(CATransform3DIdentity, 50, 0, 0);
    t = CATransform3DRotate(t ,120 / 180.0 * M_PI, 0, 0, 1);
    replicatorLayer.instanceTransform = t;
    replicatorLayer.instanceAlphaOffset = -0.4;    // 设置透明系数是方便看复制layer的层次
    [replicatorLayer addSublayer:shape];
    //    replicatorLayer.masksToBounds = YES;
    [self.view.layer addSublayer:replicatorLayer];
    
    
    //动画1- 缩放动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 2;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 0)];
    animation.repeatCount = HUGE;
    animation.autoreverses = YES; //autoreverses需要注意，他的意思是动画结束时执行逆动画
    [shape addAnimation:animation forKey:nil];
    
    
    //动画2- 旋转-没做完
    CATransform3D transform = CATransform3DIdentity;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"instanceTransform"];
    animation1.duration = 2;
    //    animation1.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1)];
    
    animation1.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1)];
    animation1.repeatCount = HUGE;
    animation1.autoreverses = YES;
    [shape addAnimation:animation1 forKey:nil];
}

@end
