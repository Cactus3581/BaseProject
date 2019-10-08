//
//  BPLayerPropertyViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/8/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPLayerPropertyViewController.h"

@interface BPLayerPropertyViewController ()

@property (nonatomic,weak) CALayer *layer;

@end


@implementation BPLayerPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
            
            case 0: {
                [self base];
            }
                break;
                
            case 1: {
                [self shadow];
            }
                break;

            case 2: {
                [self corner];
            }
                break;

            case 3: {
                [self anchorPoint];
            }
                break;

            case 4: {
                [self mask];
            }
                break;
                
            case 5: {
                [self alpha];
            }
                break;
                
                
        }
    }
}

- (CALayer *)layer {
    if(!_layer) {
        CAShapeLayer *layer = [CAShapeLayer layer] ;
        _layer = layer;
        _layer.bounds = (CGRect){0,0,100,100};
        _layer.position = (CGPoint){kScreenWidth/2,kScreenHeight/2};
        _layer.backgroundColor = kLightGrayColor.CGColor;
        [self.view.layer addSublayer:_layer];
    }
    return _layer;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //    backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:backView.layer.bounds].CGPath;
}

#pragma mark - 基础属性
- (void)base {
    
#pragma mark - 边框
    
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 2;
    
#pragma mark - contents
    
    self.layer.contents = (id)[UIImage imageNamed:@"image001"].CGImage;
}

#pragma mark - 阴影
- (void)shadow {
    
    self.layer.shadowColor = kRedColor.CGColor;//阴影颜色
    self.layer.shadowOpacity = 0.5f; //颜色透明度
    self.layer.shadowRadius = 5; // 阴影宽度;设置虚化范围程度
    self.layer.shadowOffset = CGSizeMake(0, 5); //不露出上边的阴影，左右下露出
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 80)];
    self.layer.shadowPath = [path CGPath];
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath;
    self.layer.masksToBounds = YES;
}

#pragma mark - 圆角
- (void)corner {
//    self.layer.cornerRadius = 50;
    
    //    因为UIImageView的Image并不是直接添加在层上面的，而是添加在layer中的contents里。UIImageView中是UIView的主layer上添加了一个次layer（用来绘制contents），我们设置边框的是主layer，但是次layer在上变，不会有任何的影响，所以当我们调用切割语句的时候，超出边框意外的都被切割了！！.
    // //    我们设置层的所有属性它只作用在层上面，对contents里面的东西并不起作用，所以如果我们不进行裁剪，我们是看不到图片的圆角效果的。想要让图片有圆角的效果，就必须把masksToBounds这个属性设为YES，当设为YES，把就会把超过根层以外的东西都给裁剪掉。

//    self.layer.masksToBounds = YES;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kThemeColor;
    view.layer.backgroundColor = kThemeColor.CGColor;
    view.layer.contents = (id)[UIImage imageNamed:kRandomSmallImage].CGImage;
    view.layer.cornerRadius = 10;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(50);
        make.leading.equalTo(self.view).offset(10);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = kRandomShortText;

    // 给UILabel设置圆角的关键代码：将label的layer层设置成有颜色
    label.layer.backgroundColor = kThemeColor.CGColor;
    label.layer.cornerRadius = 10;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.leading.equalTo(view.mas_trailing).offset(10);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = kThemeColor;
    imageView.layer.cornerRadius = 10;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:kRandomSmallImage];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.leading.equalTo(label.mas_trailing).offset(10);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"button" forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.backgroundColor = kThemeColor;
    [button setImage:[UIImage imageNamed:kRandomSmallImage] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.size.mas_equalTo(80);
        make.leading.equalTo(imageView.mas_trailing).offset(10);
    }];
}

#pragma mark - alpha
- (void)alpha {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kThemeColor;
    view.layer.allowsGroupOpacity = NO;
    view.alpha = 0.5;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(200);
    }];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = kExplicitColor;
    view1.alpha = 1;
    view1.opaque = YES;
    [view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(100);
    }];
}

#pragma mark - anchorPoint
- (void)anchorPoint {
    
    CALayer *layer = [CALayer layer];
    //设置尺寸和位置
    layer.frame = CGRectMake(50, 50, 100, 100);
    //设置背景
    layer.backgroundColor = [UIColor redColor].CGColor;
    //给layer设置图片.
    layer.contents = (id)[UIImage imageNamed:@"image001"].CGImage;
    //加载绘制
    [self.view.layer addSublayer:layer];

//    //下面两行代码就是设置views的 正中间 坐标（200，200）
//    _views.layer.position = CGPointMake(200, 200);
//    _views.layer.anchorPoint = CGPointMake(0.5, 0.5);
//
//    //下面两行代码就是设置views的 左上角 坐标（200，200）
//    _views.layer.position = CGPointMake(200, 200);
//    _views.layer.anchorPoint = CGPointMake(0, 0);
//
//    //下面两行代码就是设置views的 右下角 坐标（200，200）
//    _views.layer.position = CGPointMake(200, 200);
//    _views.layer.anchorPoint = CGPointMake(1, 1);
}

#pragma mark - mask
- (void)mask {

    self.view.backgroundColor = kExplicitColor;
    UIImage *maskImage = [UIImage imageNamed:@"chatMessageBkg"];
    
    //mask的坐标系是根据对象view的
    
    // 使用CALayer作为mask
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, 0, 100, 100);
    maskLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    // maskLayer.backgroundColor = kWhiteColor.CGColor;//如果mask的背景色为非clearcolor 会完全展现。
    //_imageView.layer.mask = maskLayer;
    
    // 使用UIView作为mask
    UIImageView *maskView = [[UIImageView alloc] init];
    maskView.frame = CGRectMake(0, 0, 100, 100);
    maskView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    maskView.image = maskImage;
    // _imageView.maskView = maskView;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    shapeLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    shapeLayer.fillColor = kGreenColor.CGColor;
    shapeLayer.strokeColor = kBlueColor.CGColor;
//    shapeLayer.backgroundColor = kLightGrayColor.CGColor;
    shapeLayer.lineWidth = 1;
    
    // 构造了一个镂空的layer
    UIBezierPath *outPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UIBezierPath *inPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kScreenWidth/2, kScreenHeight/2, 100, 100) cornerRadius:5];
    [outPath appendPath:[inPath bezierPathByReversingPath]];//内嵌路径反转绘制
    shapeLayer.path = outPath.CGPath;


    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"module_landscape3"].CGImage;

    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alphaView.backgroundColor = kBlackColor;
    alphaView.alpha = 0.6;
    [self.view addSubview:alphaView];
    
    //mask：相当于将maskLayer添加到父layer上，然后将该父layer按照mask的有效内容区域（图片或者背景色）进行裁剪。
    // 在有效内容区域范围内，看到的是父layer上的内容。
    alphaView.layer.mask = shapeLayer;

    // 可以通过下面这个查看shapeLayer的位置及大小
//    [self.view.layer addSublayer:shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
