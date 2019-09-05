//
//  BPBezierPathViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBezierPathViewController.h"

#define btn_inset (10)
#define btn_bottom (-20)

@interface BPBezierPathViewController ()

@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) UIBezierPath *path;

@end


@implementation BPBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViews];
}

#pragma mark - 点方法
- (void)bezierPath_point {
    //   创建折线
    UIBezierPath *path = [UIBezierPath bezierPath];
    //  添加路径起点
    [path moveToPoint:(CGPoint){0,self.shapeLayer.bounds.size.height}];
    // 添加路径之外的其他点,绘制直线
    [path addLineToPoint:(CGPoint){self.shapeLayer.bounds.size.width/2.0,0}];
    [path addLineToPoint:(CGPoint){self.shapeLayer.bounds.size.width,self.shapeLayer.bounds.size.height}];
    [path closePath];  // 关闭路径,首位相连，连接当前subPath的起始点与终止点
    [self shapeLayerWithPath:path];
}

#pragma mark - 圆形方法
- (void)bezierPath_oval {
    //创建圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){0,0,self.shapeLayer.bounds.size.width,self.shapeLayer.bounds.size.height}];
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_halfOval {
    //创建椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){0,self.shapeLayer.bounds.size.height/4.0,self.shapeLayer.bounds.size.width,self.shapeLayer.bounds.size.height/2.0}];
    [self shapeLayerWithPath:path];
}

#pragma mark - 矩形方法
- (void)bezierPath_rect {
    //创建矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(40,40,self.shapeLayer.bounds.size.width-80,self.shapeLayer.bounds.size.height-80)];    
    [self shapeLayerWithPath:path];
}

#pragma mark - 圆角矩形方法
- (void)bezierPath_roundedRect {
    //创建圆角矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){40,40,self.shapeLayer.bounds.size.width-80,self.shapeLayer.bounds.size.height-80} cornerRadius:20];
    [self shapeLayerWithPath:path];
}

#pragma mark - 指定画单角的圆角矩形
- (void)bezierPath_roundedCornerRect {
    //画单角的圆角矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){40,40,self.shapeLayer.bounds.size.width-80,self.shapeLayer.bounds.size.height-80} byRoundingCorners:UIRectCornerTopLeft cornerRadii:(CGSize){20,0}];
    [self shapeLayerWithPath:path];
}

#pragma mark - 弧线方法
- (void)bezierPath_arc {
    /*圆弧
    Center : 圆点
    radius :半径
    startAngle :开始画弧的起始角度；默认从0度开始；
    0度：正右方； 90度（M_PI_2）：正下方； 180度（M_PI）：正左方； 270度：正上方（M_PI+M_PI_2）
    endAngle :终点画弧的终点角度
    M_PI : 转化为180度角
    M_PI_2 : 转化为90度角
    clockwise : 是否为顺时针方向
     
    */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.shapeLayer.bounds.size.width/2.0,self.shapeLayer.bounds.size.height) radius:self.shapeLayer.bounds.size.width/2.0 startAngle:M_PI+M_PI_4 endAngle:M_PI+M_PI_2+M_PI_4 clockwise:YES];
    [self shapeLayerWithPath:path];
}

#pragma mark - 拼接：折线和弧线构成曲线
- (void)bezierPath_arcCenter {
    UIBezierPath *path = [UIBezierPath bezierPath];
    //折线
    [path moveToPoint:(CGPoint){self.shapeLayer.bounds.size.width/2.0,self.shapeLayer.bounds.size.height}];
    //添加一条弧线:在原有的线上添加一条弧线
    [path addArcWithCenter:CGPointMake(self.shapeLayer.bounds.size.width/2.0,self.shapeLayer.bounds.size.height) radius:self.shapeLayer.bounds.size.width/2.0 startAngle:M_PI+M_PI_4 endAngle:M_PI+M_PI_2+M_PI_4 clockwise:YES];
    [path closePath]; // 连接当前subPath的起始点与终止点
    [self shapeLayerWithPath:path];
}

#pragma mark - 二次贝塞尔曲线
- (void)bezierPath_2quadCurve {
    /*二次贝塞尔曲线
    moveToPoint :起点
    ToPoint : 终点
    controlPoint : 控制点
    曲线是由起点趋向控制点最后到达终点（不会经过控制点）的曲线。控制点决定曲线的起始方向，起点和终点的距离决定曲线趋向控制点的程度
     */
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startPoint = CGPointMake(40,self.shapeLayer.bounds.size.height/2.0);
    CGPoint endPoint = CGPointMake(self.shapeLayer.bounds.size.width-40,self.shapeLayer.bounds.size.height/2.0);
    CGPoint controlPoint = CGPointMake(self.shapeLayer.bounds.size.width/2.0, 10);

    [path moveToPoint:startPoint];
    
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    [self shapeLayerWithPath:path];
}

#pragma mark - 三次贝塞尔曲线
- (void)bezierPath_3quadCurve {
     //三次贝塞尔曲线
     UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startPoint = CGPointMake(10,self.shapeLayer.bounds.size.height/2.0);
    CGPoint endPoint = CGPointMake(self.shapeLayer.bounds.size.width-10,self.shapeLayer.bounds.size.height/2.0);
    
    CGPoint controlPoint1 = CGPointMake(self.shapeLayer.bounds.size.width/4.0, 0);
    CGPoint controlPoint2 = CGPointMake(self.shapeLayer.bounds.size.width/4.0*3, self.shapeLayer.bounds.size.height);

    [path moveToPoint:startPoint];
    
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    [self shapeLayerWithPath:path];
}

#pragma mark - 以 path 创建 path
- (void)bezierPath_byCGPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 100, 80)];
    path = [UIBezierPath bezierPathWithCGPath:path.CGPath];
    [self shapeLayerWithPath:path];
}

#pragma mark - 反方向绘制path
- (void)bezierPath_reversingPath {

    //创建矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(40,40,self.shapeLayer.bounds.size.width-80,self.shapeLayer.bounds.size.height-80)];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:CGRectMake(80,80,self.shapeLayer.bounds.size.width-160,self.shapeLayer.bounds.size.height-160)];
    
    UIBezierPath *path2 = [path1 bezierPathByReversingPath];
    
    [path appendPath:path2];// 拼接路径
    
    [self shapeLayerWithPath:path];
}

#pragma mark - 移除所有的点，删除所有的subPath
- (void)removePath {
    [_path removeAllPoints];
}

#pragma mark - 贝塞尔曲线的绘制在图形上下文中的路径操作
- (void)configInContextWithPath:(UIBezierPath *)path {
    if (!path || ![path isKindOfClass:[UIBezierPath class]]) {
        return;
    }
    
    [path fill]; //填充内部颜色
    [path fillWithBlendMode:kCGBlendModeNormal alpha:1];
    
    [path stroke];//各个点连线，填充边框颜色
    [path strokeWithBlendMode:kCGBlendModeNormal alpha:1];
    
    //裁剪，使用当前path剪切当前的图形，之后在超出path区域的地方绘图将显示不出来
    [path addClip];
}

#pragma mark - 贝塞尔曲线的绘制属性
- (void)shapeLayerWithPath:(UIBezierPath *)path {
    _path = path;
    
    CGPoint currentPoint = path.currentPoint;//返回当前原点的位置
    path.lineWidth = 10; //绘线宽度
    path.lineCapStyle = kCGLineCapRound; //线段终点类型
    
    path.lineJoinStyle = kCGLineJoinRound; // 曲线交叉点的类型
    path.miterLimit = 1; // 两条线交汇处内角和外角之间的最大距离,需要交叉点类型为kCGLineJoinMiter是生效，最大限制为10
    path.flatness = 0.6; //个人理解为绘线的精细程度，默认为0.6，数值越大，需要处理的时间越长
    path.usesEvenOddFillRule = NO; //决定使用even-odd或者non-zero规则

    [_shapeLayer removeFromSuperlayer];
    self.shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:self.shapeLayer];
    //self.view.layer.mask = shapeLayer;  // layer 的 mask属性，添加蒙版
}

- (CAShapeLayer *)shapeLayer {
    if(!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer] ;
        _shapeLayer = shapeLayer;
        _shapeLayer.bounds = (CGRect){0,0,kScreenWidth-100,kScreenWidth-100};
        _shapeLayer.position = (CGPoint){kScreenWidth/2,kScreenHeight/2};
        _shapeLayer.backgroundColor = kLightGrayColor.CGColor;
        _shapeLayer.fillColor = kGreenColor.CGColor; // 填充颜色
        _shapeLayer.lineWidth = 2.0f;
        _shapeLayer.strokeColor = kRedColor.CGColor;// 边框颜色
        //self.shapeLayer.masksToBounds = YES;
    }
    return _shapeLayer;
}

#pragma mark - 创建 Button 操作 Layer 的属性
- (void)initializeViews {
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 addTarget:self action:@selector(bezierPath_point) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"point_折线" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 addTarget:self action:@selector(bezierPath_oval) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"圆" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button3 addTarget:self action:@selector(bezierPath_halfOval) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitle:@"椭圆" forState:UIControlStateNormal];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button4 addTarget:self action:@selector(bezierPath_rect) forControlEvents:UIControlEventTouchUpInside];
    [button4 setTitle:@"矩形" forState:UIControlStateNormal];
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button5 addTarget:self action:@selector(bezierPath_roundedRect) forControlEvents:UIControlEventTouchUpInside];
    [button5 setTitle:@"圆角矩形" forState:UIControlStateNormal];
    [self.view addSubview:button5];
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button6 addTarget:self action:@selector(bezierPath_roundedCornerRect) forControlEvents:UIControlEventTouchUpInside];
    [button6 setTitle:@"单角的圆角矩形" forState:UIControlStateNormal];
    [self.view addSubview:button6];
    
    UIButton *button7 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button7 addTarget:self action:@selector(bezierPath_arc) forControlEvents:UIControlEventTouchUpInside];
    [button7 setTitle:@"圆弧" forState:UIControlStateNormal];
    [self.view addSubview:button7];
    
    UIButton *button8 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button8 addTarget:self action:@selector(bezierPath_arcCenter) forControlEvents:UIControlEventTouchUpInside];
    [button8 setTitle:@"折线和弧线构成的曲线" forState:UIControlStateNormal];
    [self.view addSubview:button8];
    
    UIButton *button9 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button9 addTarget:self action:@selector(bezierPath_2quadCurve) forControlEvents:UIControlEventTouchUpInside];
    [button9 setTitle:@"二次贝塞尔曲线" forState:UIControlStateNormal];
    [self.view addSubview:button9];
    
    UIButton *button10 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button10 addTarget:self action:@selector(bezierPath_3quadCurve) forControlEvents:UIControlEventTouchUpInside];
    [button10 setTitle:@"三次贝塞尔曲线" forState:UIControlStateNormal];
    [self.view addSubview:button10];
    
    UIButton *button11 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button11 addTarget:self action:@selector(bezierPath_reversingPath) forControlEvents:UIControlEventTouchUpInside];
    [button11 setTitle:@"反方向绘制" forState:UIControlStateNormal];
    [self.view addSubview:button11];
    
    UIButton *button12 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button12 addTarget:self action:@selector(removePath) forControlEvents:UIControlEventTouchUpInside];
    [button12 setTitle:@"移除所有的点" forState:UIControlStateNormal];
    [self.view addSubview:button12];
        
    UIButton *button13 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button13 addTarget:self action:@selector(configInContextWithPath:) forControlEvents:UIControlEventTouchUpInside];
    [button13 setTitle:@"在图形上下文中的路径操作" forState:UIControlStateNormal];
    [self.view addSubview:button13];
    
    UIButton *button14 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button14 addTarget:self action:@selector(bezierPath_byCGPath) forControlEvents:UIControlEventTouchUpInside];
    [button14 setTitle:@"以 path 创建 path" forState:UIControlStateNormal];
    [self.view addSubview:button14];

    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*7);
    }];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button1.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button1.mas_bottom);
    }];
    
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button2.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button1.mas_bottom);
    }];
    
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button3.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button1.mas_bottom);
    }];
    
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button4.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button1.mas_bottom);
    }];
    
    [button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*5);
    }];
    
    [button7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button6.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button6.mas_bottom);
    }];
    
    [button8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button7.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button6.mas_bottom);
    }];
    
    [button9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button8.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button6.mas_bottom);
    }];
    
    [button10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*3);
    }];
    
    [button11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button10.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button10.mas_bottom);
    }];
    
    [button12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button11.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button10.mas_bottom);
    }];
    
    [button13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*1);
    }];
    
    [button14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button13.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(button13.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
