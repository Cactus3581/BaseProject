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

@end

@implementation BPBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTransformButton];
}

- (CAShapeLayer *)shapeLayer {
    if(!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer] ;
        _shapeLayer = shapeLayer;
        //设置layer的frame，会改变贝塞尔曲线的frame，它根据layer的frame而改变，也就是说它作为子layer存在（在坐标系统上是存在这种父子关系的，其他不是）
        _shapeLayer.frame = (CGRect){50,100,200,200};
        _shapeLayer.backgroundColor = kLightGrayColor.CGColor;
        // path坐标系统是从layer的左上开始，也就是说path是根据layer的frame的坐标系统；100不是半径，是宽度跟高度。
        _shapeLayer.fillColor = kGreenColor.CGColor;
        _shapeLayer.lineWidth = 2.0f;
        _shapeLayer.strokeColor = kRedColor.CGColor;
        //self.shapeLayer.masksToBounds = YES;
    }
    return _shapeLayer;
}

#pragma mark - 创建不同的path
- (void)bezierPath_point {
    //   创建折线
    UIBezierPath *path = [UIBezierPath bezierPath];
    //  添加路径起点
    [path moveToPoint:(CGPoint){20,20}];
    // 添加路径之外的其他点
    [path addLineToPoint:(CGPoint){160,160}];
    [path addLineToPoint:(CGPoint){180,50}];
    [path closePath];  // 关闭路径  添加一个结尾和起点相同的点
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_oval {
    //创建圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){0,0,100,100}];
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_halfOval {
    //创建椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){0,0,180,100}];
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_rect {
    //创建矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 100, 80)];
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_roundedRect {
    //创建圆角矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){0,0,200,200} cornerRadius:30];
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_roundedCornerRect {
    //画单角的圆角矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){10,10,100,100} byRoundingCorners:UIRectCornerTopLeft cornerRadii:(CGSize){30,0}];
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_arc {
    /*圆弧
    Center : 圆点
    radius :半径
    startAngle :开始画弧的起始角度； 0度：右 90度：下 180度；左 270度：上
    endAngle :终点画弧的终点角度
    M_PI : 转化为180度角
    M_PI_2 : 转化为90度角
    clockwise : 是否为顺时针方向
    */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle:M_PI_2+M_PI endAngle:M_PI clockwise:YES];
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_arcCenter {
    //折线和弧线构成的曲线
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //折线
    [path moveToPoint:(CGPoint){0,0}];
    [path addLineToPoint:CGPointMake(100, 100)];
    //添加一条弧线:在原有的线上添加一条弧线
    [path addArcWithCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI clockwise:YES];
    [self shapeLayerWithPath:path];

}
- (void)bezierPath_2quadCurve {
    /*二次贝塞尔曲线
    moveToPoint :起点
    ToPoint : 终点
    controlPoint : 控制点
    曲线是由起点趋向控制点最后到达终点（不会经过控制点）的曲线。控制点决定曲线的起始方向，起点和终点的距离决定曲线趋向控制点的程度
     */
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:(CGPoint){0,150}];
    [path addQuadCurveToPoint:(CGPoint){200,200} controlPoint:(CGPoint){100,0}];
    [self shapeLayerWithPath:path];
}

- (void)bezierPath_3quadCurve {
     //三次贝塞尔曲线
     UIBezierPath *path = [UIBezierPath bezierPath];
     [path moveToPoint:(CGPoint){0,150}];
     [path addCurveToPoint:(CGPoint){200,50} controlPoint1:CGPointMake(50, 75) controlPoint2:CGPointMake(150, 125)];
    [self shapeLayerWithPath:path];
}

- (void)shapeLayerWithPath:(UIBezierPath *)path {
    [_shapeLayer removeFromSuperlayer];
    self.shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:self.shapeLayer];
    //self.view.layer.mask = shapeLayer;  // layer 的 mask属性，添加蒙版
}

#pragma mark - 创建Button 操作Layer的属性
- (void)creatTransformButton {
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
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*4);
    }];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button1.mas_right).offset(btn_inset);
        make.bottom.equalTo(button1.mas_bottom);
    }];
    
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button2.mas_right).offset(btn_inset);
        make.bottom.equalTo(button1.mas_bottom);
    }];
    
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button3.mas_right).offset(btn_inset);
        make.bottom.equalTo(button1.mas_bottom);
    }];
    
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button4.mas_right).offset(btn_inset);
        make.bottom.equalTo(button1.mas_bottom);
    }];
    
    [button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*2);
    }];
    
    [button7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button6.mas_right).offset(btn_inset);
        make.bottom.equalTo(button6.mas_bottom);
    }];
    
    [button8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button7.mas_right).offset(btn_inset);
        make.bottom.equalTo(button6.mas_bottom);
    }];
    
    [button9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button8.mas_right).offset(btn_inset);
        make.bottom.equalTo(button6.mas_bottom);
    }];
    
    [button10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
