//
//  BPIntrinsicContentSizeController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIntrinsicContentSizeController.h"
#import "BPIntrinsicContentSizeLabel.h"

/*
 
intrinsicContentSize：
 含义：固有内容大小；但是开发者不会直接使用
 
 Content简单分类：
 1. 文字
 2. 图片
 3. 视频
 
 UIView简单分类：
 1. A类：没有subView也没有Content的view，比如UIView的对象；intrinsicContentSize返回的值是(-1,-1)。
 2. B类：leaf-level views，含有Content但是不是UIScroll子类的view，比如UILabel，UIButton，UIImageView
 3. C类：包含content，但是是UIscroll的子类，比如UITextView，UITableView；intrinsicContentSize返回值也是(-1,-1)，
 
 1. 对于A类View直接设置约束，里面包含SubView的情况请往下看
 2. 对于B类View，设置关于位置的约束一般就可以完整显示出来，但是要注意文字的换行问题（可以使用preferredMaxLayoutWidth，当然如果你宽度约束设置对了，可以忽略此方法）；当设置完位置约束后，AutoLayout会向此对象回调intrinsicContentSize方法，这个方法会根据B类View的属性（字体，字符串）返回size给autolayout，对于A类C类，因为没有Content，所以返回（-1，-1）
 3. 对于C类View，同A类，需要设置size相关的约束，因为它是可以滚动的，intrinsicContentSize返回（-1，-1），可以使用方法sizeThatFits获取size；
 
 注意：
 不要重写intrinsicContentSize，会侵害内容，建议重写对齐矩形alignmentRectInsets
 */

@interface BPIntrinsicContentSizeController ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) BPIntrinsicContentSizeLabel *intrinsicContentSizeLabel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation BPIntrinsicContentSizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testLabel];
    [self testIntrinsicContentSizeLabel];
    [self testView];
    [self testTextView];
}

#pragma mark - UILabel
- (void)testLabel {
    
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.leading.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
    }];
    self.label.text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？";
    
    CGSize size;

    // 布局没有完成，无法得知宽度或最大宽度，也就是说不知道什么时候折行
    size = [self.label intrinsicContentSize];//{738.5, 17}
    BPLog(@"%@",NSStringFromCGSize(size));
    
    // 布局没有完成，无法得知宽度或最大宽度，也就是说不知道什么时候折行
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth-20);
    }];
    size = [self.label intrinsicContentSize];//{738.5, 17}
    BPLog(@"%@",NSStringFromCGSize(size));
    
    // 布局没有完成，但是给出折行了，可以得出正确的数据
    self.label.preferredMaxLayoutWidth = kScreenWidth-20;
    size = [self.label intrinsicContentSize];//{348, 50.5}
    BPLog(@"%@",NSStringFromCGSize(size));
}

#pragma mark - UILabel + 重写intrinsicContentSize+继承
- (void)testIntrinsicContentSizeLabel {
    
    [self.view addSubview:self.intrinsicContentSizeLabel];
    
    [self.intrinsicContentSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).offset(10);
        make.leading.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
    }];
    
    self.intrinsicContentSizeLabel.text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？";
    self.intrinsicContentSizeLabel.preferredMaxLayoutWidth = kScreenWidth-20;
    CGSize size = [self.intrinsicContentSizeLabel intrinsicContentSize];//{388, 50.5}
    BPLog(@"%@",NSStringFromCGSize(size));
}

#pragma mark - UIView
- (void)testView {

    [self.view addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.top.equalTo(self.intrinsicContentSizeLabel.mas_bottom).offset(10);
    }];

    CGSize size = [self.bgView intrinsicContentSize];
    BPLog(@"%@",NSStringFromCGSize(size));// {-1, -1}
}

#pragma mark - UITextView
- (void)testTextView {

    [self.view addSubview:self.textView];
    
    self.textView.text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？";

    CGSize size = [self.textView sizeThatFits:CGSizeMake(kScreenWidth-20, MAXFLOAT)];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
        make.top.equalTo(self.bgView.mas_bottom).offset(10);
        make.height.equalTo([NSNumber numberWithFloat:size.height]);
    }];
    
    CGSize size1 = [self.textView intrinsicContentSize];
    BPLog(@"%@",NSStringFromCGSize(size1));// {-1, -1}
}

#pragma mark - 懒加载
- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        _label = label;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = kWhiteColor;
        label.backgroundColor = kLightGrayColor;
        label.numberOfLines = 0;
    }
    return _label;
}

- (BPIntrinsicContentSizeLabel *)intrinsicContentSizeLabel {
    if (!_intrinsicContentSizeLabel) {
        BPIntrinsicContentSizeLabel *label = [[BPIntrinsicContentSizeLabel alloc] init];
        _intrinsicContentSizeLabel = label;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = kWhiteColor;
        label.backgroundColor = kLightGrayColor;
        label.numberOfLines = 0;
    }
    return _intrinsicContentSizeLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        bgView.backgroundColor = kThemeColor;
    }
    return _bgView;
}

- (UITextView *)textView {
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] init];
        _textView = textView;
        textView.font = [UIFont systemFontOfSize:18.0];
        textView.textColor = kWhiteColor;
        textView.backgroundColor = kExplicitColor;
    }
    return _textView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
