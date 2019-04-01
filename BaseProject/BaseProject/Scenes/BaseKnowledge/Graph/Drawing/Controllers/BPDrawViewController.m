//
//  BPDrawViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/29.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPDrawViewController.h"

#import "BPDrawRectPathView.h"
#import "BPDrawRectCGView.h"

#import "BPDrawViewCGLayer.h"

@interface BPDrawViewController () <CALayerDelegate>

@property (nonatomic,weak) CALayer *layer;

@end


@implementation BPDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self drawRectInViewByCG];
            }
                break;
                
            case 1:{
                [self drawRectInViewByPath];
            }
                break;
                
            case 2:{
                /*
                 CALayer：- (void)drawInContext:(CGContextRef)ctx
                 注意:setNeedsDisplay
                 只能用CG方法
                 */
                [self drawInContextInLayerByCG];
            }
                break;
                
            case 3:{

                /*
                 代理方法：- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
                 */
                [self drawLayerInVC];
            }
                break;
                
            case 4:{
                /*
                 以上都是获取的系统的上下文，在其上画的；
                 以下是自己创建图形上下文
                 */
                [self drawImageWithType:type];
            }
                break;
                
            case 5:{
                [self drawImageWithType:type];
            }
                break;
                
            case 6:{
                [self drawImageWithType:type];
            }
                break;
        }
    }
}


#pragma mark - 在自定义View的drawRect方法里使用贝塞尔曲线绘图
- (void)drawRectInViewByPath {
    BPDrawRectPathView *aView =  [[BPDrawRectPathView alloc] init];
    aView.backgroundColor = kLightGrayColor;
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.leading.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(84);
    }];
}

#pragma mark - 在自定义View的drawRect里使用CoreGraphics绘图
- (void)drawRectInViewByCG {
    BPDrawRectCGView *aView =  [[BPDrawRectCGView alloc] init];
    aView.backgroundColor = kLightGrayColor;
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
        make.top.equalTo(self.view).offset(194);
        make.leading.trailing.equalTo(self.view);
    }];
}

#pragma mark - 在自定义Layer的drawInContext方法里使用CoreGraphics绘图
- (void)drawInContextInLayerByCG {
    BPDrawViewCGLayer *layer = [BPDrawViewCGLayer layer];
    layer.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2.0, 100, 100);
    layer.backgroundColor = kLightGrayColor.CGColor;
    
    // 有这句话才能执行 -drawInContext 和 drawRect 方法
    [layer setNeedsDisplay];
    
    [self.view.layer addSublayer:layer];
}

#pragma mark - 在控制器里直接创建Layer并实现代理drawLayer方法
- (void)drawLayerInVC {
    CALayer *layer = [CALayer layer];
    _layer = layer;
    layer.frame = CGRectMake(10, 410, kScreenWidth, 100);
    layer.backgroundColor = kLightGrayColor.CGColor;
    
#warning 设置代理，但是会引起崩溃，所以需要让属性接受下，在dealloc里把delegate设为nil;注意不要设置其delegate为uiview类型实例。会导致程序crash。
    layer.delegate = self; 
    [layer setNeedsDisplay];// 调用此方法，drawLayer: inContext:方法才会被调用。
    
    [self.view.layer addSublayer:layer];
}

//代理方法
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //CG-1
    // 1.画一个圆
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, 50, 50));
    // 填充颜色为红色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    // 在context上绘制
    CGContextFillPath(ctx);
    
    //CG-2
    // 2.画一个椭圆
    CGContextAddEllipseInRect(ctx, CGRectMake(80,10,30,60));
    //填充颜色为蓝色
    CGContextSetFillColorWithColor(ctx, kGreenColor.CGColor);
    //在context上绘制
    CGContextFillPath(ctx);
    
    // UIKit-1
    //使用UIKit进行绘制，因为UIKit只会对当前上下文栈顶的context操作，所以要把形参中的context设置为当前上下文
    UIGraphicsPushContext(ctx);
    UIImage* image = [UIImage imageNamed:@"jobs_youth"];
    //指定位置和大小绘制图片
    [image drawInRect:CGRectMake(140, 10,80 , 80)];
    UIGraphicsPopContext();
}

#pragma mark - 以下是自己创建图形上下文进行图片绘制，以上都是获取的系统的上下文，在其上画的；

- (UIImage *)drawImageWithType:(NSInteger)type {

    CGFloat width = kScreenWidth/3;
    
    //该函数会自动创建一个context，并把它push到上下文栈顶，坐标系也经处理和UIKit的坐标系相同
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width,width), NO, kScreenScale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (type == 4) {
        // 用贝塞尔曲线进行图片绘制
        
        UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,width,width)];
        [kGreenColor setFill];
        [path fill];
    } else if (type == 5) {
        // 用CG进行图片绘制
        
        CGContextAddEllipseInRect(context, CGRectMake(0,0,width,width));
        //填充颜色为蓝色
        CGContextSetFillColorWithColor(context, kGreenColor.CGColor);
        //在context上绘制
        CGContextFillPath(context);
    } else if (type == 6) {
        // 绘制空心/镂空图片
        
        CGContextSetLineWidth(context, 0);
        [kRedColor set];
        CGRect rect = CGRectMake(0, 0, width, width);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(width/2.0, width/2.0)];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        [kGreenColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(width/2.0, width/2.0)];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 2, 2) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(width/2.0, width/2.0)];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }
    
    //把当前context的内容输出成一个UIImage图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-width/2, kScreenHeight/2.0-width/2, width, width)];
    imageView.backgroundColor = kLightGrayColor;
    imageView.image = image;
    [self.view addSubview:imageView];
    
    return image;
}

- (void)dealloc {
    _layer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
