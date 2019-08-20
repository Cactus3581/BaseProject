//
//  BPCALayerBasePropertyViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCALayerBasePropertyViewController.h"

@interface BPCALayerBasePropertyViewController ()

@property(nonatomic,weak) UIView *maskView;

@end


@implementation BPCALayerBasePropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
            case 0:{
                [self testBase];// 基本属性
            }
                break;
                
            case 1:{
                [self testMaskLayer];// mask 遮罩
            }
                break;
                
            case 2:{
                [self testShadow]; // 阴影
            }
                break;
        }
    }
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //    backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:backView.layer.bounds].CGPath;
}

- (void)testBase {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    backView.backgroundColor = kThemeColor;
    [self.view addSubview:backView];
    backView.center = self.view.center;
    
    backView.layer.shadowColor = kRedColor.CGColor;//阴影颜色
    backView.layer.shadowOpacity = 0.5f; //颜色透明度
    backView.layer.shadowRadius = 5; // 阴影宽度;设置虚化范围程度
    backView.layer.shadowOffset = CGSizeMake(0, 5); //不露出上边的阴影，左右下露出
    // UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 80)];
    //    backView.layer.shadowPath = [path CGPath];
    //    backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:backView.layer.bounds].CGPath;
    //backView.layer.masksToBounds = YES;
}




- (void)testMaskLayer {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"cell_autoLayoutHeight03"];
    [self.view addSubview:imageView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView = maskView;
    maskView.backgroundColor = [kRedColor colorWithAlphaComponent:1];
    [kWindow addSubview:maskView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    [maskView addGestureRecognizer:tap];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.bounds];
    
    /*
     关键代码：
     两条路径（UIBezierPath）叠加，内嵌的路径调用bezierPathByReversingPath方法达到反转镂空的效果。相应的，如果我们改变内嵌路径所绘制的形状和位置，我们就可以得到不同的镂空形状的效果，这为适配不同屏幕尺寸引导中的镂空效果提供了很大的方便。
    */
     [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(kScreenWidth/2-50, kScreenHeight/2, 100, 50) cornerRadius:5] bezierPathByReversingPath]];
    
    // 构造e了一个镂空的layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = kGreenColor.CGColor;
    shapeLayer.strokeColor = kBlueColor.CGColor;
    shapeLayer.lineWidth = 1;
    shapeLayer.path = path.CGPath;
    
    // 当shapeLayer的部分有颜色时，才能看到maskView；关键点是：没有颜色（透明）时看不到maskView，但是能看到maskView.layer的前一个
    [maskView.layer setMask:shapeLayer];
    
    //[maskView.layer addSublayer:shapeLayer];
}

- (void)remove {
    [_maskView removeFromSuperview];
}

- (void)testShadow {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
