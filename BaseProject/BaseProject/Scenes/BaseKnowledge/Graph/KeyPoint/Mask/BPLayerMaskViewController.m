//
//  BPLayerMaskViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/3/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPLayerMaskViewController.h"

@interface BPLayerMaskViewController ()

@property (nonatomic,weak) UIView *maskView;

@end


@implementation BPLayerMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testMaskLayer];
}

- (void)testMaskLayer {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"cell_autoLayoutHeight03"];
    [self.view addSubview:imageView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView = maskView;
    maskView.backgroundColor = [kRedColor colorWithAlphaComponent:1];
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    [maskView addGestureRecognizer:tap];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(5, 436, 90, 40) cornerRadius:5] bezierPathByReversingPath]];
    
    
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

@end
