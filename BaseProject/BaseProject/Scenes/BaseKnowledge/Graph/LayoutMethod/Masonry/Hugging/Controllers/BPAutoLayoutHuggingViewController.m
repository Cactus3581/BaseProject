//
//  BPAutoLayoutHuggingViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoLayoutHuggingViewController.h"

@interface BPAutoLayoutHuggingViewController ()
@property (nonatomic,weak) UILabel *leftLabel1;
@property (nonatomic,weak) UILabel *rightLabel1;

@property (nonatomic,weak) UILabel *leftLabel2;
@property (nonatomic,weak) UILabel *rightLabel2;

@property (nonatomic,weak) UILabel *leftLabel3;
@property (nonatomic,weak) UILabel *rightLabel3;

@property (nonatomic,weak) UILabel *label4;
@property (nonatomic,weak) UILabel *label5;

@property (nonatomic,weak) UILabel *label6;
@property (nonatomic,weak) UILabel *label7;

@property (nonatomic,assign) BOOL change;

@end

@implementation BPAutoLayoutHuggingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"change";
    
    self.leftLabel1.text = @"富裕的思维里";
    self.rightLabel1.text = @"贫穷的思维里";
    
    self.leftLabel2.text = @"富裕的思维里";
    self.rightLabel2.text = @"贫穷的思维里";
    
    self.leftLabel3.text = @"富裕的思维里 ，全都是感恩和付出！";
    self.rightLabel3.text = @"贫穷的思维里 ，写满了抱怨和算计；";
    
    
    /*
     * 抗拉伸:主要用在
     * leftLabel1、rightLabel1 限制后 还有空余空间，这个时候就需要谁来拉伸了，才能满足我们的限制
     * setContentHuggingPriority（值越高，越不容易拉伸，所以为‘抗拉伸’）
     **/
    [self.leftLabel2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.rightLabel2 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    
    /*
     * 抗压缩主要用在
     * leftLabel3、rightLabel3 限制后 ，没有空余空间，这个时候就 只能压缩某个label，才能满足我们的限制
     * setContentCompressionResistancePriority（值越高，越不容易压缩，所以为‘抗压缩’）
     **/
    [self.leftLabel3 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.rightLabel3 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    
    self.label4.text = @"富裕的思维里 ，全都是感恩和付出！";
    self.label5.text = @"富裕的思维里 ，全都是感恩和付出！";
    [self.label4 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.label5 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    self.label6.text = @"富裕的思维里";
    self.label7.text = @"贫穷的思维里";
    [self.label6 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.label7 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    self.change = !self.change;
    if (self.change) {
        self.leftLabel1.text = @"富裕的思维里 ，全都是感恩和付出！";
        self.rightLabel1.text = @"贫穷的思维里 ，写满了抱怨和算计；";
    }else {
        self.leftLabel1.text = @"富裕的思维里";
        self.rightLabel1.text = @"贫穷的思维里";
    }
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (UILabel *)leftLabel1 {
    if (!_leftLabel1) {
        UILabel *label = [[UILabel alloc] init];
        _leftLabel1 = label;
        _leftLabel1.backgroundColor = kThemeColor;
        _leftLabel1.textColor = kWhiteColor;
        [self.view addSubview:_leftLabel1];
        [_leftLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(10);
            make.leading.equalTo(self.view).offset(10);
        }];
    }
    return _leftLabel1;
}

- (UILabel *)rightLabel1 {
    if (!_rightLabel1) {
        UILabel *label = [[UILabel alloc] init];
        _rightLabel1 = label;
        _rightLabel1.backgroundColor = kThemeColor;
        _rightLabel1.textColor = kWhiteColor;
        [self.view addSubview:_rightLabel1];
        [_rightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_leftLabel1.mas_trailing).offset(10);
            make.centerY.equalTo(_leftLabel1);
            make.trailing.equalTo(self.view).offset(-10);
        }];
    }
    return _rightLabel1;
}

- (UILabel *)leftLabel2 {
    if (!_leftLabel2) {
        UILabel *label = [[UILabel alloc] init];
        _leftLabel2 = label;
        _leftLabel2.backgroundColor = kThemeColor;
        _leftLabel2.textColor = kWhiteColor;
        [self.view addSubview:_leftLabel2];
        [_leftLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftLabel1.mas_bottom).offset(50);
            make.leading.equalTo(self.view).offset(10);
        }];
    }
    return _leftLabel2;
}

- (UILabel *)rightLabel2 {
    if (!_rightLabel2) {
        UILabel *label = [[UILabel alloc] init];
        _rightLabel2 = label;
        _rightLabel2.backgroundColor = kThemeColor;
        _rightLabel2.textColor = kWhiteColor;
        [self.view addSubview:_rightLabel2];
        [_rightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_leftLabel2.mas_trailing).offset(10);
            make.centerY.equalTo(_leftLabel2);
            make.trailing.equalTo(self.view).offset(-10);
        }];
    }
    return _rightLabel2;
}

- (UILabel *)leftLabel3 {
    if (!_leftLabel3) {
        UILabel *label = [[UILabel alloc] init];
        _leftLabel3 = label;
        _leftLabel3.backgroundColor = kThemeColor;
        _leftLabel3.textColor = kWhiteColor;
        [self.view addSubview:_leftLabel3];
        [_leftLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftLabel2.mas_bottom).offset(10);
            make.leading.equalTo(self.view).offset(10);
        }];
    }
    return _leftLabel3;
}

- (UILabel *)rightLabel3 {
    if (!_rightLabel3) {
        UILabel *label = [[UILabel alloc] init];
        _rightLabel3 = label;
        _rightLabel3.backgroundColor = kThemeColor;
        _rightLabel3.textColor = kWhiteColor;
        [self.view addSubview:_rightLabel3];
        [_rightLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_leftLabel3.mas_trailing).offset(10);
            make.centerY.equalTo(_leftLabel3);
            make.trailing.equalTo(self.view).offset(-10);
        }];
    }
    return _rightLabel3;
}

- (UILabel *)label4 {
    if (!_label4) {
        UILabel *label = [[UILabel alloc] init];
        _label4 = label;
        _label4.backgroundColor = kThemeColor;
        _label4.textColor = kWhiteColor;
        [self.view addSubview:_label4];
        [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftLabel3.mas_bottom).offset(50);
            make.leading.equalTo(self.view).offset(100);
            make.trailing.equalTo(self.view).offset(-100).with.priorityLow();
        }];
    }
    return _label4;
}

- (UILabel *)label5 {
    if (!_label5) {
        UILabel *label = [[UILabel alloc] init];
        _label5 = label;
        _label5.backgroundColor = kThemeColor;
        _label5.textColor = kWhiteColor;
        [self.view addSubview:_label5];
        [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label4.mas_bottom).offset(10);
            make.leading.equalTo(self.view).offset(100).with.priorityLow();
            make.trailing.equalTo(self.view).offset(-100);
        }];
    }
    return _label5;
}

- (UILabel *)label6 {
    if (!_label6) {
        UILabel *label = [[UILabel alloc] init];
        _label6 = label;
        _label6.backgroundColor = kThemeColor;
        _label6.textColor = kWhiteColor;
        [self.view addSubview:_label6];
        [_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label5.mas_bottom).offset(50);
            make.leading.equalTo(self.view).offset(10);
            make.trailing.equalTo(self.view).offset(-10).with.priorityLow();
        }];
    }
    return _label6;
}

- (UILabel *)label7 {
    if (!_label7) {
        UILabel *label = [[UILabel alloc] init];
        _label7 = label;
        _label7.backgroundColor = kThemeColor;
        _label7.textColor = kWhiteColor;
        [self.view addSubview:_label7];
        [_label7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label6.mas_bottom).offset(10);
            make.leading.equalTo(self.view).offset(10).with.priorityLow();
            make.trailing.equalTo(self.view).offset(-10);
        }];
    }
    return _label7;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
