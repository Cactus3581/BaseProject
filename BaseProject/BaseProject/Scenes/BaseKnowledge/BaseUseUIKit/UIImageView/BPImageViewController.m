//
//  BPImageViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPImageViewController.h"

@interface BPImageViewController ()
@property (nonatomic,assign) NSInteger mode;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation BPImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testContentMode];
}

- (void)testContentMode {
    //contentMode 是UIView的属性，不只是用于UIImageView；
    UIImageView *exampleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_autoLayoutHeight02"]];
    [self.view addSubview:exampleImageView];
    [exampleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.top.equalTo(self.view).offset(80);
        make.centerX.equalTo(self.view);
    }];
    exampleImageView.backgroundColor = kLightGrayColor;
    
    self.rightBarButtonTitle = @"切换mode";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_autoLayoutHeight02"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.equalTo(self.view);
        make.top.equalTo(exampleImageView.mas_bottom).offset(10);

    }];
    imageView.backgroundColor = kLightGrayColor;
    _imageView = imageView;
}

- (void)rightBarButtonItemClickAction:(id)sender {
    switch (self.mode) {
        case 0:{
            self.imageView.contentMode = UIViewContentModeScaleToFill;//缩放图片,使图片充满容器，属性会导致图片变形。
        }
            break;
            
        case 1:{
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;//会保证图片比例不变，而且全部显示在ImageView中，这意味着ImageView会有部分空白，不会填充整个区域。
        }
            break;
           
        case 2:{
            self.imageView.contentMode = UIViewContentModeScaleAspectFill;// 最常用 //需要配合view.clipToBounds或者是layer.masktuBounds //会证图片比例不变，但是是填充整个ImageView的，可能只有部分图片显示出来。
        }
            break;
            
        case 3:{
            self.imageView.contentMode = UIViewContentModeRedraw;
        }
            break;
            
        case 4:{
            self.imageView.contentMode = UIViewContentModeCenter;
        }
            break;
            
        case 5:{
            self.imageView.contentMode = UIViewContentModeTop;//Top,Left,Right等等就是将突破放在View中的位置进行调整。
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
