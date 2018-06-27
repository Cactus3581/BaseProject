//
//  BPImageController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPImageController.h"

@interface BPImageController ()
@property (nonatomic,assign) NSInteger mode;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation BPImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    [self initializeViews];//image 切割
}

#pragma mark image 切割
- (void)initializeViews {
    UIImageView *view = [[UIImageView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(32);
    }];
    UIImage *image;
    image = [[UIImage imageNamed:@"cactus_ rect_steady"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    image = [[UIImage imageNamed:@"cactus_ rect_steady"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    view.image =  image;
    view.backgroundColor = kGreenColor;
    
    UIImageView *view1 = [[UIImageView alloc]init];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(30);
        make.centerX.equalTo(view);
        make.size.equalTo(view);
    }];
    
    UIImage *image1;
    //    image1 = [[UIImage imageNamed:@"cactus_ rect_steady"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    image1 = [UIImage imageNamed:@"cactus_ rect_steady"];
    //    image = [[UIImage imageNamed:@"cactus_ rect_steady"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    view1.image =  image1;
    view1.backgroundColor = kGreenColor;
    
}

- (void)test {
    self.rightBarButtonTitle = @"切换mode";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transitionWithType02"]];
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
