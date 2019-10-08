//
//  BPCoreImageViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/9/5.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPCoreImageViewController.h"

@interface BPCoreImageViewController ()
@property (nonatomic,assign) NSInteger mode;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation BPCoreImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self test];
    [self initializeViews];//image 切割
}

#pragma mark - 图片拉伸方法
- (void)initializeViews {
    
    UIImage *image = [UIImage imageNamed:@"popview_anchor_arrow"];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    
    UIImageView *view = [[UIImageView alloc] init];
    view.backgroundColor = kGreenColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(100);
    }];

    // 被废弃了，会自动计算出偏向中间的一个1*1的方格也就是被拉伸的地方(默认使用拉伸),一般传入的值为图片大小的一半.
    
    view.image = [image stretchableImageWithLeftCapWidth:imageW topCapHeight:imageH];
//    view.image = image;

    UIImageView *view1 = [[UIImageView alloc] init];
    view1.backgroundColor = kGreenColor;
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(30);
        make.centerX.equalTo(view);
        make.size.equalTo(view);
    }];

    //将Insets内围部分进行拉伸，外围不拉伸，一般设置成中心点。
    // UIImageResizingModeTile：平铺  UIImageResizingModeStretch：拉伸
    view1.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeStretch];
//    view1.image = image;
}

- (void)test {
    self.rightBarButtonTitle = @"切换mode";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_landscape2"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(self.view);
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.contentMode = UIViewContentModeRedraw;
    imageView.contentMode = UIViewContentModeCenter;
    imageView.contentMode = UIViewContentModeTop;
    _imageView = imageView;
}

- (void)rightBarButtonItemClickAction:(id)sender {
    
    switch (self.mode) {
        case 0:{
            self.imageView.contentMode = UIViewContentModeScaleToFill;
        }
            break;
            
        case 1:{
            self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        }
            break;
            
        case 2:{
            self.imageView.contentMode = UIViewContentModeRedraw;
        }
            break;
            
        case 3:{
            self.imageView.contentMode = UIViewContentModeCenter;
        }
            break;
            
        case 4:{
            self.imageView.contentMode = UIViewContentModeTop;
        }
            break;
            
        default:
            break;
    }
    ++self.mode;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

