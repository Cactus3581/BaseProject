//
//  BPPopViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPopViewController.h"
#import "Masonry.h"

@interface BPPopViewController ()

@property (nonatomic,strong) UIView *taobaoView;
@end

@implementation BPPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureButton];
}

- (UIView *)taobaoView {
    if (!_taobaoView) {
        _taobaoView = [[UIView alloc] init];
        [self.view addSubview:_taobaoView];
        _taobaoView.backgroundColor = kPurpleColor;
        [_taobaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@400);
            make.leading.trailing.equalTo(self.view);
            make.top.equalTo(self.view.mas_bottom);
        }];
    }
    return _taobaoView;
}

- (void)configureButton {
    self.view.backgroundColor = kGreenColor;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kRedColor;
    
    // 只有在title时设置对其方式。无用：rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //但是问题又出来，此时文字会紧贴到做边框，我们可以设置    使文字距离做边框保持10个像素的距离。
    //rightButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    
    
    /*
     setBackgroundImage:跟button一样大
     setImage:也会被拉伸
     */
    //    [rightButton setBackgroundImage:[UIImage imageNamed:@"headImage"] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"headImage"] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"headimage1"] forState:UIControlStateSelected];
    //    [rightButton setImage:[UIImage imageNamed:@"headimage2"] forState:UIControlStateHighlighted];
    
    //rightButton.imageView.layer.masksToBounds = YES;//无用
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [rightButton setTitle:@"push" forState:UIControlStateNormal];
    
    /*
     设置UIButton上字体的颜色设置UIButton上字体的颜色，不是用：
     [btn.titleLabel setTextColor:[UIColorblackColor]];
     btn.titleLabel.textColor=kRedColor;
     而是用：
     */
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    
    [rightButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    //[rightButton.titleLabel sizeToFit];//无用
    
    //    rightButton.backgroundColor = kGreenColor;
    [self.view addSubview:rightButton];
    [[rightButton layer] setCornerRadius:25.0f];
    
    rightButton.showsTouchWhenHighlighted = YES;
    
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [rightButton addGestureRecognizer:longPress];
    
    
    if (@available(iOS 11,*)) {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.trailing.equalTo(self.view.mas_trailing).offset(-30);
            make.bottom.equalTo(self.view).offset(-200);
        }];
    }else {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.trailing.equalTo(self.view).offset(-30);
            make.bottom.equalTo(self.view).offset(-200);
        }];
    }
}

- (void)btnLong:(UILongPressGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        BPLog(@"长按事件");
        self.taobaoView.backgroundColor = kPurpleColor;
        [self.view layoutIfNeeded];
        [self.taobaoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset((-(CGRectGetHeight(self.taobaoView.bounds))));
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
