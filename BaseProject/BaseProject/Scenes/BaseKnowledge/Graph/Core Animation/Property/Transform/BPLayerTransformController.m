//
//  BPLayerTransformController.m
//  BaseProject
//
//  Created by Ryan on 2017/1/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPLayerTransformController.h"

#define btn_inset (10)
#define btn_bottom (-20)

@interface BPLayerTransformController ()

@property (nonatomic,strong) CALayer *testLayer;

@end


@implementation BPLayerTransformController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViews];
}

#pragma mark - 平移
- (void)makeTranslation {
    BPLog(@"%@",@(_testLayer.frame));
    BPLog(@"%@",@(_testLayer.position));
    BPLog(@"%@",@(_testLayer.bounds));
    _testLayer.transform = CATransform3DMakeTranslation(0, 30, 0);
    BPLog(@"%@",@(_testLayer.frame));
    BPLog(@"%@",@(_testLayer.position));
    BPLog(@"%@",@(_testLayer.bounds));
}

- (void)translation {
    //1.直接使用基本的三维赋值方法
    _testLayer.transform = CATransform3DTranslate(_testLayer.transform, 0, 30, 0);
    
    
    //2.使用KVC将CATransform3DMakeScale生成的对象给layer
    NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 0, 0)];
//    [_testLayer setValue:value forKeyPath:@"transform.scale"];
    
    //3.使用快捷方法设置属性
//    [_testLayer setValue:@5 forKeyPath:@"transform.scale.y"];
}

#pragma mark - 缩放
- (void)makeScale {
    _testLayer.transform = CATransform3DMakeScale(0.5f, 0.5f, 1.0f);
}

- (void)scale {
    //_testLayer.transform = CATransform3DScale(CATransform3DIdentity, 0.5f, 0.5f, 1.0f);
    _testLayer.transform = CATransform3DScale(_testLayer.transform, 0.5f, 0.5f, 1.0f);
}

#pragma mark - 旋转
- (void)makeRotation {
    //方法一
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeRotation(kDegreesToRadian(45),1, 0, 0);
    transform.m34 = 0.0005;
    _testLayer.transform =  transform;
}

- (void)rotate {
    CATransform3D transform = CATransform3DRotate(_testLayer.transform, kDegreesToRadian(45), 0, 1, 0);
    transform.m34 = 0.0005;
    _testLayer.transform =  transform;
}

- (void)scaleRotation {
    //方法二
    //旋转也可以用CATransform3DScale，当为负数的时候起到即旋转又缩放的效果
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, -1, 0.5, 1.0);
    _testLayer.transform =  transform;
}

#pragma mark - initializeViews
- (void)initializeViews {
    
    _testLayer =[CALayer layer] ;
    _testLayer.frame = CGRectMake(50, 64, 200, 200);
    UIImage *maskImage1 = [UIImage imageNamed:@"module_landscape2"];
    _testLayer.contents = (__bridge id)maskImage1.CGImage;
    _testLayer.shouldRasterize = YES;
    [self.view.layer addSublayer:_testLayer];
    
    
    UIButton *transform_makeRotation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeRotation addTarget:self action:@selector(makeRotation) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeRotation setTitle:@"Make旋转" forState:UIControlStateNormal];
    [transform_makeRotation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeRotation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_makeRotation];
    
    UIButton *transform_rotation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_rotation addTarget:self action:@selector(rotate) forControlEvents:UIControlEventTouchUpInside];
    [transform_rotation setTitle:@"旋转" forState:UIControlStateNormal];
    [transform_rotation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_rotation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_rotation];

    UIButton *transform_makeTranslation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeTranslation addTarget:self action:@selector(makeTranslation) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeTranslation setTitle:@"Make平移" forState:UIControlStateNormal];
    [transform_makeTranslation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeTranslation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_makeTranslation];
    
    UIButton *transform_translation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_translation addTarget:self action:@selector(translation) forControlEvents:UIControlEventTouchUpInside];
    [transform_translation setTitle:@"平移" forState:UIControlStateNormal];
    [transform_translation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_translation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_translation];
    
    UIButton *transform_makeScale = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeScale addTarget:self action:@selector(makeScale) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeScale setTitle:@"Make缩放" forState:UIControlStateNormal];
    [transform_makeScale setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeScale.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_makeScale];
    
    UIButton *transform_scale = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_scale addTarget:self action:@selector(scale) forControlEvents:UIControlEventTouchUpInside];
    [transform_scale setTitle:@"缩放" forState:UIControlStateNormal];
    [transform_scale setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_scale.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_scale];
    
    UIButton *transform_scaleRotation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_scaleRotation addTarget:self action:@selector(scaleRotation) forControlEvents:UIControlEventTouchUpInside];
    [transform_scaleRotation setTitle:@"scale 缩放+旋转" forState:UIControlStateNormal];
    [transform_scaleRotation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_scaleRotation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_scaleRotation];
    
    [transform_makeRotation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*4);
    }];
    
    [transform_rotation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_makeRotation.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_makeTranslation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_rotation.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_translation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_makeTranslation.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_makeScale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_translation.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_scale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_makeScale.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_scaleRotation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_scale.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
