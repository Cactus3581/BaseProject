//
//  BPLayerController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPLayerController.h"

#import "BPCircleView.h"

#define widthBt [UIScreen mainScreen].bounds.size.width/5.0
#define heightBt 30.0

@interface BPLayerController ()

@property (nonatomic,strong) CALayer *test_layer;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,strong) UIView *aview;
@property (nonatomic,strong) UIView *view_test;
@end

@implementation BPLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self configureCircleView];
//    [self dealWithData];
//    [self set3DRotate];
//    [self creatlayer];

//    [self set3DMakeRotationn];
//    [self setMaskInLayer];
//    [self setReset];

//    [KSProgressNumberBar show];
//    [self setBig];
    
//    [self creatView];
//    [self setMakeTranslation];
//    [self setTranslation];
//    [self setMaskInView];
//    [self setReset_1];
}

- (void)setBig {
     self.aview = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 60, 60)];
    self.aview.backgroundColor = kGreenColor;
    self.aview.layer.cornerRadius = 30;
    [self.view addSubview:self.aview];
    [self performSelector:@selector(scan) withObject:nil afterDelay:2.0];

//    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    anmation.fromValue = @0.0;
//    anmation.toValue = @1;
//    anmation.duration = 2.5;
//    anmation.repeatCount = MAXFLOAT;
//    [self.shapeLayer addAnimation:anmation forKey:@""];
}
- (void)scan {
    [self transitionWithType:@"suckEffect" WithSubtype:@"kCATransitionFromRight" ForView:self.aview];

}
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.5;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)configureCircleView {
    BPCircleView *view = [[BPCircleView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(186.0);
        make.center.equalTo(self.view);
    }];
    [view setTotlaScore:710 score:100];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_delegate && [_delegate respondsToSelector:@selector(pushViewControllerWithModel)]) {
        [_delegate pushViewControllerWithModel];
    }
}

- (void)dealWithData
{
    // layer基本属性
//    [self creatlayer];
    
//    [self testshapeLayer];// 测试在mask情况下，贝塞尔曲线的frame，shapelayer的frame，如何受影响.
//    [self creatshapeLayer]; //一般绘制shapelayer的方法
//    [self creatshapeLayer_one];  //与CAGradientLayer联合使用，绘制渐变加载条动画
//    [self creatshapeLayer_two]; //扇形动画
//    [self creatshapeLayer_three]; //绘制起泡-不规则图形
    
    //重复图层
//    [self creatreplicatorLayer]; //复制同一个图层一般用法
//    [self creatreplicatorLayer_one];//音量
//    [self creatreplicatorLayer_two];//loading图
//    [self creatreplicatorLayer_three];//倒影
//    [self creatreplicatorLayer_four];//正方形移动的等待指示器
//    [self creatreplicatorLayer_five];//三角

    
    // 渐变色
//        [self creatgradientLayer];//颜色渐变-滑动解锁
        [self creatgradientLayer_two];//png渐变
    //    [self creatgradientLayer_three];//png覆盖图层
    
//    [self audioplaying];
}



// 喇叭动画
- (void)audioplaying
{
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.backgroundColor = kRedColor;
    [self.view addSubview:imageview];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(self.view.frame.size.width/2);
    }];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = imageview.bounds;
    
    UIImage *image = [UIImage imageNamed:@"layerTest"];
    shapeLayer.contents = (__bridge id _Nullable)(image.CGImage);
    imageview.layer.mask = shapeLayer;
    
    
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = imageview.bounds;
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.view.frame.size.width/4, self.view.frame.size.width/4)];
//    layer.fillColor = kRedColor.CGColor;
//    layer.strokeColor = kGreenColor.CGColor;
//    layer.lineWidth = 5;
//    layer.path = path.CGPath;
//    imageview.layer.mask = layer;
    
    
}
#pragma mark - 创建shapeLayer - 测试frame的影响
- (void)testshapeLayer
{
//    //测试1
    self.shapeLayer =[CAShapeLayer layer] ;
    //设置layer的frame，会改变贝塞尔曲线的frame，它根据layer的frame而改变，也就是说它作为子layer存在（在坐标系统上是存在这种父子关系的，其他不是）
    self.shapeLayer.frame = CGRectMake(200, 340, 60, 10);
    self.shapeLayer.backgroundColor = kGreenColor.CGColor;
    
    
    // bezierPathWithOvalInRect:xy坐标也是从左上开始，150不是半径!是宽度跟高度
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 150, 150)];

    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.fillColor = kBlueColor.CGColor;
    //重点在线宽
    self.shapeLayer.lineWidth = 50.0f;
    self.shapeLayer.strokeColor = kRedColor.CGColor;
    
//    self.shapeLayer.masksToBounds = YES;
    
    [self.view.layer addSublayer:self.shapeLayer];
    
    
    
//    //测试2
//    CALayer *layer =[CALayer layer] ;
//    layer.frame = CGRectMake(0, 64, 150, 150);
//    layer.backgroundColor = kGreenColor.CGColor;
//    
//    
//    CALayer *layer1 =[CALayer layer] ;
//    layer1.frame = CGRectMake(20, 20, 100, 80);
////    layer1.frame = layer.bounds;
//
//    layer1.backgroundColor = kRedColor.CGColor;
//    layer.mask = layer1;
//    [self.view.layer addSublayer:layer];
    
    
    //测试3:fillcolor没有动画；strokeColor有动画,这样只能在strokeColor上考虑动画了
//    self.shapeLayer =[CAShapeLayer layer] ;
//    self.shapeLayer.frame = CGRectMake(60, 100, 150, 150);
//    [self.view.layer addSublayer:self.shapeLayer];
//    // bezierPathWithOvalInRect:xy坐标也是从左上开始，150不是半径!是宽度跟高度
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 150, 150)];
//    
//    self.shapeLayer.path = path.CGPath;
//    self.shapeLayer.fillColor = kRedColor.CGColor;
//    //重点在线宽
//    self.shapeLayer.lineWidth = 3;
//    self.shapeLayer.strokeColor = kBlueColor.CGColor;
//    self.shapeLayer.strokeStart = 0;
//    self.shapeLayer.strokeEnd = 0;
//
//    
//    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    anmation.fromValue = @0.0;
//    anmation.toValue = @1;
//    anmation.duration = 2.5;
//    anmation.repeatCount = MAXFLOAT;
//    [self.shapeLayer addAnimation:anmation forKey:@""];
    
    
//    //测试4
//    
//    CALayer *layer =[CALayer layer] ;
//    layer.frame = CGRectMake(50, 250, 150, 150);
//    layer.backgroundColor = kPurpleColor.CGColor;
//    [self.view.layer addSublayer:layer];
//
//    
//    self.shapeLayer =[CAShapeLayer layer] ;
//    self.shapeLayer.frame = CGRectMake(0, 0, 150, 150);
////    self.shapeLayer.backgroundColor = kGreenColor.CGColor;
//    
//    [layer addSublayer:self.shapeLayer];
//
//    
//    
//    // bezierPathWithOvalInRect:xy坐标也是从左上开始，150不是半径!是宽度跟高度
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 150, 150)];
//    
//    self.shapeLayer.path = path.CGPath;
//    self.shapeLayer.fillColor = kRedColor.CGColor;
//    //重点在线宽
//    self.shapeLayer.lineWidth = 3;
//    self.shapeLayer.strokeColor = kClearColor.CGColor;
//    
//    layer.mask = self.shapeLayer;
//    
//    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    anmation.fromValue = @0.0;
//    anmation.toValue = @1;
//    anmation.duration = 2.5;
//    anmation.repeatCount = MAXFLOAT;
//    [self.shapeLayer addAnimation:anmation forKey:@""];
    
    
//    //测试5
//    CALayer *layer =[CALayer layer] ;
//    layer.frame = CGRectMake(50, 250, 150, 150);
//    layer.backgroundColor = kPurpleColor.CGColor;
//    [self.view.layer addSublayer:layer];
//    
//    
//    self.shapeLayer =[CAShapeLayer layer] ;
//    self.shapeLayer.frame = CGRectMake(0, 0, 150, 150);
//    [layer addSublayer:self.shapeLayer];
//    
//    // bezierPathWithOvalInRect:xy坐标也是从左上开始，150不是半径!是宽度跟高度
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(75/2, 75/2, 75, 75)];
//    
//    self.shapeLayer.path = path.CGPath;
//    self.shapeLayer.fillColor = kClearColor.CGColor;
//    //重点在线宽
//    self.shapeLayer.lineWidth = 75;
//    self.shapeLayer.strokeColor = kRedColor.CGColor;
//    
//    layer.mask = self.shapeLayer;
//    
//    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    anmation.fromValue = @0.0;
//    anmation.toValue = @1;
//    anmation.duration = 2.5;
//    anmation.repeatCount = MAXFLOAT;
//    [self.shapeLayer addAnimation:anmation forKey:@""];
    
//    总结：frame的影响
//    mask父影响-》masklayer影响-》贝塞尔曲线 -进而决定了shapelayer的最终形状。
}

#pragma mark - 创建shapeLayer - 1 一般用法
- (void)creatshapeLayer
{
    /*

     只不过要处理好，我们不能创建的CAShapeLayer的frame小于贝塞尔曲线 因为如果这样只要设置了masksToBounds这个属性会把超出部分截掉。
     */
    
    self.shapeLayer =[CAShapeLayer layer] ;
    self.shapeLayer.frame = CGRectMake(0, 0, 80, 150);
    self.shapeLayer.backgroundColor = kGreenColor.CGColor;

//    UIBezierPath  *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    UIBezierPath  *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)];

    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.strokeColor = kRedColor.CGColor;
    self.shapeLayer.fillColor = kPurpleColor.CGColor;
    
    //描述path路径从哪里开始，这两个值的范围是[0,1]

//    self.shapeLayer.strokeStart = .0;
    //描述path路径从哪里结束
//    self.shapeLayer.strokeEnd = 0.2;
    
    
//    self.shapeLayer.masksToBounds = YES;

//    [self.view.layer addSublayer:self.shapeLayer];
    self.view.layer.mask = self.shapeLayer;

//    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    anmation.fromValue = @0.0;
//    anmation.toValue = @1;
//    anmation.duration = 2.5;
//    anmation.repeatCount = MAXFLOAT;
//    [self.shapeLayer addAnimation:anmation forKey:@"strokeEnd"];
}

#pragma mark - 创建shapeLayer - 2 加载条动画、转圈动画(与CAGradientLayer一块使用)
- (void)creatshapeLayer_one
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(40, self.view.center.y - 200, 120, 120);
    gradientLayer.position =CGPointMake(kScreenWidth/2, kScreenHeight/2) ;

    gradientLayer.cornerRadius = 60;

    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    NSMutableArray *colors = [NSMutableArray array];
    for (int hue  = 0; hue <= 360; hue++) {
        UIColor *color =  [UIColor colorWithHue:hue / 360.0 saturation:1.0 brightness:1.0 alpha:1];
        [colors addObject:(id)color.CGColor];
    }
    gradientLayer.colors = colors;
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = gradientLayer.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(gradientLayer.bounds.size.width/2, gradientLayer.bounds.size.width/2) radius:50 startAngle:0 endAngle:M_PI * 2  clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth = 3;
    layer.strokeStart = 0;
//    layer.strokeEnd = 0;
    layer.strokeEnd = 0.8;

    layer.fillColor = kClearColor.CGColor;
    layer.strokeColor = kBlueColor.CGColor;
//    [self.view.layer addSublayer:layer];
    gradientLayer.mask = layer;
    [self.view.layer addSublayer:gradientLayer];
    
    //加载条动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.5;
    animation.fromValue = @0;
    animation.toValue = @0.8;

    [layer addAnimation:animation forKey:nil];
    
    
    //转圈动画
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.duration = 2.5;
//    animation.fromValue = @0;
//    animation.toValue = @(M_PI*2);
//    animation.repeatCount = MAXFLOAT;
//
//    [gradientLayer addAnimation:animation forKey:nil];
}

#pragma mark - 创建shapeLayer - 3 -扇形动画，利用lineWidth及strokeEnd
-(void)creatshapeLayer_two
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    view.center = self.view.center;
    UIImage *image = [UIImage imageNamed:@"layerTest"];
    view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    view.layer.contentsGravity = kCAGravityCenter;
    view.layer.contentsScale = [UIScreen mainScreen].scale;
    view.backgroundColor = kYellowColor;
//    view.layer.masksToBounds =YES; //这句话解释了下面可操作的原因了。
    [self.view addSubview:view];
    
    self.shapeLayer = [CAShapeLayer layer];
    // 如果设置了mask，那么之前设置这个layer的frame得根据父layer重现设置了。
    
    //结论：跟mask有关系，layer作为mask的子layer，要重新设置贝塞尔曲线的frame,并且如果把作为mask层的子layer添加到self.view.layer上的时候，会移除这个，并作为mask重现布局。
//    self.shapeLayer.frame = CGRectMake(0, 0, 100, 100);
    self.shapeLayer.frame = view.bounds;

    self.shapeLayer.strokeStart = 0.0f;
    self.shapeLayer.strokeEnd = 1.0f;
    

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.fillColor = kClearColor.CGColor;
    //重点在线宽
    self.shapeLayer.lineWidth = 100.0f;
    self.shapeLayer.strokeColor = kRedColor.CGColor;
    view.layer.mask = self.shapeLayer;
    
    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmation.fromValue = @0.0;
    anmation.toValue = @1;
    anmation.duration = 2.5;
    anmation.repeatCount = MAXFLOAT;
    [self.shapeLayer addAnimation:anmation forKey:@"strokeEnd"];
}

#pragma mark - 创建shapeLayer - 3 - 绘制不规则图形
-(void)creatshapeLayer_three
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 100.0f, 100.0f)];
    view.center = self.view.center;
    view.backgroundColor = kGreenColor;
    [self.view addSubview:view];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(30.0f, 30.0f)];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.bounds = view.frame;
    layer.position = CGPointMake(50.0f, 50.0f);
    layer.fillColor = kRedColor.CGColor;

    layer.path = path.CGPath;
    view.layer.mask = layer;
//    [self.view.layer addSublayer:layer];
}



#pragma mark - 创建replicatorLayer 复制同一个图层 - 一般用法
- (void)creatreplicatorLayer
{
    /*
     CAReplicatorLayer能复制子层。
     也就是说，想要复制层，必须先让这个层成为CAReplicatorLayer的子层sublayer。
     CAReplicatorLayer可以对它自己的子Layer进行复制操作。创建了CAReplicatorLayer实例后，设置了它的尺寸大小、位置、锚点位置、背景色，并且将它添加到了replicatorAnimationView的Layer中。
     instanceCount:要创建的副本个数(默认一个),复制出来的层的个数，包括自己.但是复制子层形变(不包括原生子层)，
     preservesDepth:是否将3D例子系统平面化到一个图层(默认NO)
     instanceDelay:动画时间延迟。默认为0。复制出来的层的动画相对前一个延迟0.5秒
     instanceTransform:迭代图层的位置 CATransform3D对象(创建方法用:CATransform3DMakeRotation圆形排列，CATransform3DMakeTranslation水平排列)。可以是位移，旋转，缩放。复制出来的层相对上一个做操作。子layer相对于前一个复制layer的形变属性。 变换是逐步增加的，每个实例都是相对于前一实例布局。这就是为什么这些复制体最终不会出现在同意位置上，图6.8是代码运行结果。
     instanceColor:颜色组件添加到实例k - 1产生的颜色实例的调制颜色k。清晰的颜色(默认不透明白色)
     instanceRedOffset，instanceGreenOffset，instanceBlueOffset，instanceAlphaOffset:加到实例K-1的颜色的颜色分量，以产生实例k的调制颜色。默认为鲜明的色彩（无变化）。
     
     注意！一定要设置CAReplicatorLayer的frame，因为instanceTransform属性都是根据frame的center作为基准的。
     复制图层有一个关键的地方是，你往原始的图层中添加动画效果，复制出来的副本可以实时的复制这些动画效果。
     */
    
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(10, 100, 200, 200);;
    replicatorLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2-200);
    replicatorLayer.backgroundColor = kGreenColor.CGColor;
//    replicator.masksToBounds = YES;
    [self.view.layer addSublayer:replicatorLayer];
    
    //数量
    replicatorLayer.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicatorLayer.instanceTransform = transform;
    
    replicatorLayer.instanceBlueOffset = -0.1;
    replicatorLayer.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = kLightGrayColor.CGColor;
    [replicatorLayer addSublayer:layer];
}

#pragma mark - 创建replicatorLayer  - 1 - 音量条
- (void)creatreplicatorLayer_one
{
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
    
//    复制图层有一个关键的地方是，你往原始的图层中添加动画效果，复制出来的副本可以实时的复制这些动画效果。
    CABasicAnimation * moveRectangle = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    moveRectangle.toValue = @1.5;

    moveRectangle.duration = 0.7;
    moveRectangle.autoreverses = true;
    moveRectangle.repeatCount = HUGE;
    
//    [layer addAnimation:moveRectangle forKey:nil];
    
    //复制动画和状态
    //重复次数
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
- (void)creatreplicatorLayer_two
{
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
    replicatorLayer.instanceDelay=1/15.0;//延迟动画开始时间 以造成旋转的效果
    
    layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);

    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1;
    scale.toValue = @0.1;
    scale.duration = 1;
    scale.repeatCount = HUGE;
    [layer addAnimation:scale forKey:nil];
}

#pragma mark - 创建replicatorLayer  - 3 - 倒影
- (void)creatreplicatorLayer_three
{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 300, 300);
    replicatorLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2+100);
    replicatorLayer.backgroundColor = kRedColor.CGColor;
    [self.view.layer addSublayer:replicatorLayer];
    
    CALayer *layer = [CALayer layer];
    UIImage *image = [UIImage imageNamed:@"layerTest"];
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
    replicatorLayer.instanceDelay=2.;//延迟动画开始时间 以造成旋转的效果
    replicatorLayer.instanceAlphaOffset = -0.6;//instanceAlphaOffset = -0.6f; 即当前图层实例的alpha值 = 上一个图层实例的alpha - 0.6f，


}

#pragma mark - 创建replicatorLayer  - 4 - 正方形移动的等待指示器
- (void)creatreplicatorLayer_four
{
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
- (void)creatreplicatorLayer_five
{
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
    replicatorLayer.instanceDelay = 0.0;    // 动画延迟秒数
    replicatorLayer.instanceCount = 3;    // 子layer复制数
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

#pragma mark - 创建gradientLayer 颜色渐变-滑动解锁

/*
 文字渐变实现思路:
 
 1.创建一个颜色渐变层，渐变图层跟文字控件一样大。
 
 2.用文字图层裁剪渐变层，只保留文字部分，就会让渐变层只保留有文字的部分，相当于间接让渐变层显示文字，我们看到的其实是被裁剪过后，渐变层的部分内容。
 
 注意：如果用文字图层裁剪渐变层，文字图层就不在拥有显示功能，这个图层就被弄来裁剪了，不会显示,在下面代码中也会有说明。
 
 2.1 创建一个带有文字的label，label能显示文字。
 
 2.2 设置渐变图层的mask为label图层，就能用文字裁剪渐变图层了。
 
 3.mask图层工作原理: 根据透明度进行裁剪，只保留非透明部分，显示底部内容。
 */
- (void)creatgradientLayer
{
    self.view.backgroundColor=kGrayColor;
    
    CAGradientLayer *gradientLayer=[CAGradientLayer layer];
    
    gradientLayer.frame=CGRectMake(30, 200, 200, 66);
    
    //颜色分布范围--渐变颜色的数组
//    gradientLayer.colors=@[
//                          
//                          (__bridge id)kBlackColor.CGColor,
//                          
//                          (__bridge id)kWhiteColor.CGColor,
//                          
//                          (__bridge id)kBlackColor.CGColor
//                          
//                          ];
    gradientLayer.colors=@[
                          
                          (__bridge id)kRedColor.CGColor,
                          
                          (__bridge id)kGreenColor.CGColor,
                          
                          (__bridge id)kYellowColor.CGColor,
                          (__bridge id)kBlueColor.CGColor,
//                          (__bridge id)kPurpleColor.CGColor

                          ];

    //设置好 colors 要设置好与之相对应的 locations 值

    gradientLayer.locations=@[@.5,@0.9];
    //CAGradientLayer 默认的渐变方向是从上到下，即垂直方向。
    //映射locations中第一个位置，用单位向量表示，比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0)
    //映射locations中最后一个位置，用单位向量表示，比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0)。
    //如果要改变 CAGradientLayer 的渐变方向，则要显式的给 startPoint和 endPoint 两个属性赋值。两个属性共同决定了颜色渐变的方向，如果要改为水平方向，则需要改成:

    gradientLayer.startPoint=CGPointMake(0, 0.5);
    
    gradientLayer.endPoint=CGPointMake(1., 0.5);
    
    [self.view.layer addSublayer:gradientLayer];

    
//    
//    //label文字:文字是模型 提供轮廓
//    
//    UILabel *label=[[UILabel alloc]initWithFrame:gradientLayer.bounds];
//    // 疑问：label只是用来做文字裁剪，能否不添加到view上。
//    // 必须要把Label添加到view上，如果不添加到view上，label的图层就不会调用drawRect方法绘制文字，也就没有文字裁剪了。
//    // 如何验证，自定义Label,重写drawRect方法，看是否调用,发现不添加上去，就不会调用
//    [self.view addSubview:label];
//    
//    label.alpha=0.5;
//    
//    label.text=@"滑动解锁 >>";
//    
//    label.textAlignment=NSTextAlignmentCenter;
//    
//    label.font=[UIFont boldSystemFontOfSize:30];
//    // mask层工作原理:按照透明度裁剪，只保留非透明部分，文字就是非透明的，因此除了文字，其他都被裁剪掉，这样就只会显示文字下面渐变层的内容，相当于留了文字的区域，让渐变层去填充文字的颜色。
//    // 设置渐变层的裁剪层  注意:一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层
//    gradientLayer.mask=label.layer;
//    
//    // 添加色变动画：将keyPath赋值为“locations”是让CAGradientLayer的locations属性做动画，因为locations对应着颜色，那么颜色也会跟着动，最终的显示效果就是：
//    CABasicAnimation *theAnima=[CABasicAnimation animationWithKeyPath:@"locations"];
//    
//    theAnima.fromValue=@[@0,@0,@0.25];
//    
//    theAnima.toValue=@[@0.25,@1,@1];
//    
//    theAnima.duration=2.5;
//    
//    theAnima.repeatCount=HUGE;

//    [gradientLayer addAnimation:theAnima forKey:@"locations"];
    
}
#pragma mark - 创建gradientLayer png渐变
- (void)creatgradientLayer_two
{
    self.view.backgroundColor = kWhiteColor;
    self.test_layer =[CALayer layer] ;
    self.test_layer.frame = CGRectMake(50, 100, 200, 200);
    UIImage *maskImage1 = [UIImage imageNamed:@"layerTest"];
    self.test_layer.contents = (__bridge id)maskImage1.CGImage;
    self.test_layer.shouldRasterize = YES;
    [self.view.layer addSublayer:self.test_layer];
    
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    gradLayer.frame = self.test_layer.bounds;
    
    //颜色分布范围
    UIColor *startColor = kClearColor;
    UIColor *endColor = kBlueColor;
    gradLayer.colors = @[(id)startColor.CGColor,(id)endColor.CGColor,(id)endColor.CGColor];
    gradLayer.locations = @[@.1,@1];
    
    //颜色渐变方向-从左向右
    //    gradLayer.startPoint = CGPointMake(0, 0.5);
    //    gradLayer.endPoint = CGPointMake(1, 0.5);
    
    self.test_layer.mask = gradLayer;
}



#pragma mark - 创建gradientLayer png覆盖图层
- (void)creatgradientLayer_three
{
    //初始化imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"layerTest"]];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    //初始化渐变层
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:self.gradientLayer];
    
    //设置渐变颜色方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设定颜色组
    self.gradientLayer.colors = @[(__bridge id)kClearColor.CGColor,
                                  (__bridge id)kPurpleColor.CGColor];
    //设定颜色分割点
    self.gradientLayer.locations = @[@(0.5f) ,@(1.0f)];

}

#pragma mark - 创建test_layer
- (void)creatlayer
{
    self.test_layer =[CALayer layer] ;
    self.test_layer.frame = CGRectMake(50, 64, 200, 200);
    UIImage *maskImage1 = [UIImage imageNamed:@"layerTest"];
    self.test_layer.contents = (__bridge id)maskImage1.CGImage;
    self.test_layer.shouldRasterize = YES;
    [self.view.layer addSublayer:self.test_layer];
    
}


- (void)set3DMakeRotationn
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(0, kScreenHeight-100, widthBt, heightBt);
    [bt addTarget:self action:@selector(MakeRotationBt) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"3DMakeRotation" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)MakeRotationBt
{
    //方法一
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeRotation(70/180.0 * M_PI,1, 0, 0);
    transform.m34 = 0.0005;
    self.test_layer.transform =  transform;
    
    
//    //方法二
//    //旋转也可以用CATransform3DScale，当为负数的时候起到即旋转又缩放的效果
//    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DScale(transform, -1, -1, 0);
//    self.test_layer.transform =  transform;
}

- (void)set3DRotate
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(widthBt,kScreenHeight-100, widthBt, heightBt);
    [bt addTarget:self action:@selector(RotateBt) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"3DRotate" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)RotateBt
{
    CATransform3D transform = CATransform3DRotate(self.test_layer.transform, M_1_PI, 0, 1, 0);
    transform.m34 = 0.0005;
    self.test_layer.transform =  transform;
}

- (void)setMaskInLayer
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(2*widthBt,kScreenHeight-100, widthBt, heightBt);
    [bt addTarget:self action:@selector(MaskInLayerBt) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"MaskLayer" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
    
}

- (void)MaskInLayerBt
{
    //第一种 maskLayer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.test_layer.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"maskImage"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    self.test_layer.mask = maskLayer;
}


- (void)setReset
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(3*widthBt,kScreenHeight-100, widthBt, heightBt);
    [bt addTarget:self action:@selector(resetBt) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"重写运行" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)resetBt
{
    self.test_layer.transform =  CATransform3DIdentity;
    [self.test_layer removeFromSuperlayer];
    self.test_layer = nil;
    [self creatlayer];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)setMakeTranslation {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(0, kScreenHeight-100, widthBt, heightBt);
    [bt addTarget:self action:@selector(MakeTranslationBt) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"MakeTranslation" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)MakeTranslationBt {
    self.view_test.transform = CGAffineTransformMakeTranslation(30, 30);
}

- (void)setTranslation {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(widthBt,kScreenHeight-100, widthBt, heightBt);
    [bt addTarget:self action:@selector(TranslationBt) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"Translation" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)TranslationBt {
    self.view_test.transform = CGAffineTransformTranslate(self.view_test.transform, 30, 30);
}

- (void)setMaskInView {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(2*widthBt,kScreenHeight-100, widthBt, heightBt);
    [bt addTarget:self action:@selector(MaskInViewBt) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"Mask" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)MaskInViewBt {
    //第一种 maskLayer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.view_test.bounds;
    
    UIImage *maskImage = [UIImage imageNamed:@"maskImage"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    //如果mask的背景色为非clearcolor 会完全展现。
    //    maskLayer.backgroundColor = kWhiteColor.CGColor;
    self.view_test.layer.mask = maskLayer;
    
    //第二种 maskView
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view_test.bounds];
    image.frame = CGRectMake(20, 20, 50, 50);
    image.image = maskImage;
    //    self.view_test.maskView = image;
}

- (void)setReset_1 {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(3*widthBt,kScreenHeight-100, widthBt, heightBt);
    [bt addTarget:self action:@selector(resetBt_1) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"重写运行" forState:UIControlStateNormal];
    [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bt];
}

- (void)resetBt_1 {
    [self.view_test removeFromSuperview];
    self.view_test = nil;
    [self creatView];
}

#pragma mark - 创建View
- (void)creatView {
    self.view_test = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 100)];
    self.view_test.backgroundColor = kRedColor;
    UIImage *maskImage1 = [UIImage imageNamed:@"layerTest"];
    self.view_test.layer.contents = (__bridge id)maskImage1.CGImage;
    [self.view addSubview:self.view_test];
    
    //    UILabel *label = [[UILabel alloc]init];
    //    label.frame =CGRectMake(10, 20, 40, 20);
    //    label.text = @"滑动解锁";
    //    self.view_test.layer.mask = label.layer;
}

@end


