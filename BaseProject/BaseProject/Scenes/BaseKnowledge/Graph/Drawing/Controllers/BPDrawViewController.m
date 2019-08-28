//
//  BPDrawViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/29.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPDrawViewController.h"
#import "BPDrawRectView.h"
#import "BPDrawLayer.h"

@interface BPDrawViewController () <CALayerDelegate>

@property (nonatomic,weak) CALayer *layer;
@property (nonatomic,weak) UIImageView *colorImageView;
@property (nonatomic,weak) UIView *colorView;

@end

/*
 
 要想自定义绘制，必须得有上下文，可以使用 UIKit、CG 函数进行绘制。
 
 怎么获取上下文：系统、自定义创建
 
 注意释放CF对象问题
 
 */

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
                [self drawRect];// 自定义view绘图
            }
                break;
                
            case 1:{
                [self drawLayer];// 自定义Layer绘图
            }
                break;
                
            case 2:{
                [self drawLayerDelegate];// 实现Layer的代理方法，自定义绘图
            }
                break;
                
            case 3:{
                [self drawImage];// 以下是自定义创建图形上下文，然后在其上面绘制，输出并返回一张图片
            }
                break;
                
            case 4:{
                [self takeColor];// 取色器
            }
                break;
        }
    }
}

#pragma mark - 以下都是获取系统传递过来的上下文，然后在其上面绘制
#pragma mark - 自定义view绘图
// drawRect系列方法 使用CG函数/贝塞尔曲线绘图/绘制过程
- (void)drawRect {
    BPDrawRectView *aView =  [[BPDrawRectView alloc] init];
    aView.backgroundColor = kLightGrayColor;
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
}

#pragma mark -  自定义Layer绘图
// 自定义Layer 并重写drawInContext。需要使用setNeedsDisplay，且只能用CG方法
- (void)drawLayer {
    BPDrawLayer *layer = [BPDrawLayer layer];
    layer.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2.0, 100, 100);
    layer.backgroundColor = kLightGrayColor.CGColor;
    // 有这句话才能执行 -drawInContext 和 drawRect 方法
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

#pragma mark - 实现Layer的代理方法，自定义绘图
- (void)drawLayerDelegate {
    CALayer *layer = [CALayer layer];
    _layer = layer;
    layer.frame = CGRectMake(0, 410, kScreenWidth, 100);
    layer.backgroundColor = kLightGrayColor.CGColor;
#warning 设置代理会引起崩溃，所以必须在dealloc方法里把delegate设为nil。注意不要设置其delegate为uiview类型实例。会导致程序crash。
    layer.delegate = self; 
    [layer setNeedsDisplay];// 调用此方法，drawLayer: inContext:方法才会被调用。
    [self.view.layer addSublayer:layer];
}

// CALayer的代理方法
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //CG
    // 1.画一个圆
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, 50, 50));
    // 填充颜色
    CGContextSetFillColorWithColor(ctx, kExplicitColor.CGColor);
    // 在context上绘制
    CGContextFillPath(ctx);
    
    // UIKit方法
    //使用UIKit进行绘制，因为UIKit只会对当前上下文栈顶的context操作，所以要把形参中的context设置为当前上下文
    UIGraphicsPushContext(ctx);
    UIImage *image = [UIImage imageNamed:@"jobs_youth"];
    //指定位置和大小绘制图片
    [image drawInRect:CGRectMake(140, 10,80 , 80)];
    UIGraphicsPopContext();
}

#pragma mark - 以下是自定义创建图形上下文，然后在其上面绘制，输出并返回一张图片
- (void)drawImage {
    
    //把当前context的内容输出成一个UIImage图片
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = kLightGrayColor;
    imageView.image = [self drawImageWithUIGraphicsCtx];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.5);
        make.height.equalTo(imageView.mas_width).multipliedBy(1);
    }];
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.backgroundColor = kLightGrayColor;
    imageView1.image = [self drawImageWithCGBitmapCtx];
    [self.view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.5);
        make.height.equalTo(imageView1.mas_width).multipliedBy(1);
    }];
    imageView1.layer.masksToBounds = YES;
}

#pragma mark - 使用 UIGraphicsBeginImageContextWithOptions 自定义创建图形上下文。context坐标系原点在左下角
- (UIImage *)drawImageWithUIGraphicsCtx {

    CGFloat ctxWidth = kScreenWidth/2;
    CGFloat ctxHeight = ctxWidth;

    // 通过 UIKit 创建位图context，并把它push到上下文栈顶，坐标系也经处理和UIKit的坐标系相同
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ctxWidth,ctxHeight), NO, kScreenScale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 用贝塞尔曲线进行图片绘制
    {
        CGFloat imageWidth = ctxWidth/2;
        CGFloat imageWidtHeight = imageWidth;
        CGFloat x = ctxWidth/2-imageWidth/2;
        CGFloat y = ctxHeight/2-imageWidtHeight/2;
        UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x,y,imageWidth,imageWidtHeight)];
        [kExplicitColor setFill];
        [path fill];
    }
    
    //把当前context的内容输出成一个UIImage图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // context出栈
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 使用 CGBitmapContextCreate 自定义创建图形上下文。context坐标系原点在左上角

- (UIImage *)drawImageWithCGBitmapCtx {

    // 通过 Core Graphics API 创建位图context
    /*
     data：一个指向内存目标的指针，该内存用于存储需要渲染的图形数据。内存块的大小至少需要(bytePerRow * height)字节。
     width：指定位图的宽度，单位是像素(pixel)。
     height：指定位图的高度， 单位是像素(pixel)。
     bitsPerComponent：指定内存中一个像素的每个组件使用的位数。例如，一个32位的像素格式和一个rgb颜色空间，我们可以指定每个组件为8位。
     bytesPerRow：指定位图每行的字节数。
     colorspace：颜色空间用于位图上下文。在创建位图Graphics Context时，我们可以使用灰度(gray), RGB, CMYK, NULL颜色空间。
     bitmapInfo：位图的信息，这些信息用于指定位图是否需要包含alpha组件，像素中alpha组件的相对位置(如果有的话)，
     alpha组件是否是预乘的，及颜色组件是整型值还是浮点值。
     */
    
    CGFloat ctxWidth = kScreenWidth/2;
    CGFloat ctxHeight = ctxWidth;
    
    NSInteger pixelsWide = ctxWidth * kScreenScale;
    NSInteger pixelsHigh = pixelsWide;
    
    NSInteger bitmapBytesPerRow = pixelsWide * 4;
    
    NSInteger bitmapByteCount = bitmapBytesPerRow * pixelsHigh;
    void *bitmapData = calloc(bitmapByteCount,sizeof(unsigned char *));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    
    if (!bitmapData) {
        BPLog(@"Memory not allocated");
        return nil;
    }
    
    NSInteger bitPerComponent = 8;
    
    // 也可以让 参数 bitmapData = NULL
    CGContextRef ctx = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, bitPerComponent, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    
    //第二种方式创建ctx：根据图片
    /*
    UIImage *originalImage = nil;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage],rect);
     
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    CGContextRef ctx = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
     */

    if (!ctx) {
        BPLog(@"ctx == nil");
        return nil;
    }
    
    CGFloat imageWidth = ctxWidth/2*kScreenScale;
    CGFloat imageWidtHeight = imageWidth;
    
    CGFloat x1 = 0;
    CGFloat x2 = imageWidth;

    CGFloat y = ctxHeight/2*kScreenScale - imageWidtHeight/2;
    
    //用CG函数绘制画一个圆
    {
        CGContextAddEllipseInRect(ctx, CGRectMake(x1,y,imageWidth,imageWidtHeight));
        //填充颜色
        CGContextSetFillColorWithColor(ctx, kExplicitColor.CGColor);
        //在context上绘制
        CGContextFillPath(ctx);
    }
    
    // 绘制空心/镂空图片
    {
        CGContextSetLineWidth(ctx, 0);
        [kRedColor set];
        CGRect rect = CGRectMake(x2, y, imageWidth, imageWidtHeight);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(imageWidth/2.0, imageWidtHeight/2.0)];
        [rectPath appendPath:roundPath];
        CGContextAddPath(ctx, rectPath.CGPath);
        CGContextEOFillPath(ctx);
        [kExplicitColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(imageWidth/2.0, imageWidtHeight/2.0)];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 2, 2) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(imageWidth/2.0, imageWidtHeight/2.0)];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(ctx, borderOutterPath.CGPath);
        CGContextEOFillPath(ctx);
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CFRelease(bitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    return image;
}

// 使用CG自定义创建位图并返回位图
- (CGContextRef)createBitmapContextWithPixelsWide:(NSInteger)pixelsWide pixelsHigh:(NSInteger)pixelsHigh {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    NSInteger             bitmapByteCount;
    NSInteger             bitmapBytesPerRow;
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    
    bitmapData = calloc(bitmapByteCount,sizeof(unsigned char *));

    
    if (!bitmapData) {
        fprintf (stderr, "Memory not allocated!");
        return NULL;
    }
    
    context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    if (!context) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    CGColorSpaceRelease( colorSpace );
    return context;
}

#pragma mark - 创建取色器
- (void)takeColor {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scroll_nyc"]];
    _colorImageView = imageView;
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    
    UIView *colorView = [[UIView alloc] init];
    _colorView = colorView;
    [self.view addSubview:colorView];
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.centerX.equalTo(imageView);
        make.width.height.mas_equalTo(100);
    }];
    
}

// 把要取色的图片转换成位图
- (CGContextRef)createRGBABitmapContext:(CGImageRef) image {
    size_t imageWidth = CGImageGetWidth(image);
    size_t imageHeight = CGImageGetHeight(image);
    //使用设备颜色空间，和mac OS不同，iOS只能使用设备相关颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //位图布局信息
    CGImageAlphaInfo bitmapInfo = kCGImageAlphaPremultipliedFirst;
    //创建位图上下文
    CGContextRef context = CGBitmapContextCreate(NULL, imageWidth, imageHeight, 8, 0, colorSpace, bitmapInfo);
    //绘制bitmap到上下文中
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image);
    if (context == NULL){
        printf("Context not created!");
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

// 获取触摸图片的位置
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_colorView) {
        return;
    }
    
    UITouch *touch = touches.anyObject;
    CGPoint currentP = [touch locationInView:_colorImageView];

    UIColor * color = [self pickerColorInPoint:currentP fromImage:_colorImageView.image size:_colorImageView.frame.size];
    _colorView.backgroundColor = color;

    const CGFloat * colorString = CGColorGetComponents(color.CGColor);
    BPLog(@"%@",[NSString stringWithFormat:@"R:%.1f\n G:%.1f\n B:%.1f\n", colorString[0] * 255, colorString[1] * 255, colorString[2] * 255]);
}

// 从一个点取颜色
- (UIColor *)pickerColorInPoint:(CGPoint) point fromImage:(UIImage *) image size:(CGSize) imageViewSize {
    
    static CGContextRef context;
    CGImageRef cgImage = image.CGImage;

    if (!context) {
        context = [self createRGBABitmapContext:cgImage];
    }

    size_t w = CGImageGetWidth(cgImage);
    size_t h = CGImageGetHeight(cgImage);
    //传入imageView的size主要是为了得到当前坐标在位图上下文上的坐标
    CGPoint finalPoint = CGPointMake(point.x / imageViewSize.width * w, point.y / imageViewSize.height * h);
    
    UIColor * color = nil;
    unsigned char * data = CGBitmapContextGetData(context);
    if (data != NULL) {
        //我们选用的颜色空间为RGB，像素格式为32bpp，8bpc，别忘了每个像素占4个字节，由此可以计算出当前触摸点在data数组中的位置
        int offset = 4 * ((w * round(finalPoint.y)) + round(finalPoint.x));
        int alpha =  data[offset];
        int red = data[offset + 1];
        int green = data[offset + 2];
        int blue = data[offset + 3];
        NSLog(@"offset: %i colors: RGB A %i %i %i  %i", offset, red, green, blue, alpha);
        color = [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:(blue / 255.0f) alpha:(alpha / 255.0f)];
    }
    
    return color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _layer.delegate = nil;
}

@end
