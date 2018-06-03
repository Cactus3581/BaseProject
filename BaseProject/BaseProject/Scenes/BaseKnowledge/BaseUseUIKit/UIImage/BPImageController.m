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
