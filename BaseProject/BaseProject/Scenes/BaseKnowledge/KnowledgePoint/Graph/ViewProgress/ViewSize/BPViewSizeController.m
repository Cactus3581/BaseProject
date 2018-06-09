//
//  BPViewSizeController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPViewSizeController.h"
#import "BPIntrinsicContentSizeLabel.h"

@interface BPViewSizeController ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) BPIntrinsicContentSizeLabel *intrinsicContentSizeLabel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation BPViewSizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self testLabel];
    [self testLabel_textView_bgView];
}

/*
 使用autolayout 设置约束后，不能立即获取 frame值的原因
 对于使用auto layout机制布局的view，auto layout system会在布局过程中综合各种约束的考虑为之设置一个size，在布局完成后，该size的值即为view.frame.size的值；这包含的另外一层意思，即在布局完成前，我们是不能通过view.frame.size准确获取view的size的。但有时候，我们需要在auto layout system对view完成布局前就知道它的size，systemLayoutSizeFittingSize:方法正是能够满足这种要求的API。systemLayoutSizeFittingSize:方法会根据其constraints返回一个合适的size值。
 */

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //BPLog(@"testLabel.origin = %@", NSStringFromCGPoint(self.label.frame.origin));
    //BPLog(@"testLabel.size = %@", NSStringFromCGSize(self.label.frame.size));
    // print: "self.label.origin = {10, 40}"
    // print: "self.label.size = {240, 17}"
}

- (void)testLabel_textView_bgView {
    /*
     代码中除了添加各种各样的constraints，没有任何设置frame的代码，显然都是基于auto layout的。
     
     那么问题来了，理解label1和label2的布局没啥子问题，因为它们的intrinsicContentSize方法会将content size告诉auto layout system，进而后者会为它们的size设置对应值；但对于bgView，它可是一个UIView对象，它的intrinsicContentSize回调方法的返回值为(-1,-1)，那么auto layout system是如何为它设置合适的size的呢？
     
     根据我的理解，auto layout system在处理某个view的size时，参考值包括：
     
     自身的intrinsicContentSize方法返回值；
     subviews的intrinsicContentSize方法返回值；
     自身和subviews的constraints；
     */
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.label];
    [self.bgView addSubview:self.textView];
    
    self.label.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张 寒来暑往 秋收冬藏 闰余成岁 律吕调阳";
    self.textView.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张 寒来暑往 秋收冬藏 闰余成岁 律吕调阳";

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.width.equalTo(self.view.mas_width);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView.mas_leading).offset(10);
        make.trailing.equalTo(self.bgView.mas_trailing).offset(-10);
        make.top.equalTo(self.bgView.mas_top).offset(10);
    }];
    
    CGSize size1 = [self.textView sizeThatFits:CGSizeMake(kScreenWidth-20, 0)];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView.mas_leading).offset(10);
        make.trailing.equalTo(self.bgView.mas_trailing).offset(-10);
        make.top.equalTo(self.label.mas_bottom).offset(10);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
        make.height.equalTo([NSNumber numberWithFloat:size1.height]);
    }];
    
    //[self.bgView layoutIfNeeded];
    [self.view layoutIfNeeded];
    CGSize size;
//    毕竟此时cell还未布局完成啊，直接读取cell.frame.size肯定是不行的。systemLayoutSizeFittingSize:方法正是用于处理这个问题的。
//    size = [self.bgView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    size = [self.bgView sizeThatFits:CGSizeMake(kScreenWidth-20, 0)];
    //    size = [self.bgView intrinsicContentSize];// NO
    BPLog(@"%@",NSStringFromCGRect(self.bgView.frame));//  直接打印，打印不出来；
}

#pragma mark - bgView的大小由里面的两个label撑起
- (void)testLabel_label_bgView {
    /*
     下面的代码，理解label1和label2的布局没有问题，因为它们的intrinsicContentSize方法会将content size告诉auto layout system，进而后者会为它们的size设置对应值；
     但对于bgView，它可是一个UIView对象，它的intrinsicContentSize回调方法的返回值为(-1,-1)，那么auto layout system是如何为它设置合适的size的呢？
     
     根据我的理解，auto layout system在处理某个view的size时，参考值包括：
     1. 自身的intrinsicContentSize方法返回值；
     2. subviews的intrinsicContentSize方法返回值；
     3. 自身和subviews的constraints；
     
     */
    [self.view addSubview:self.bgView];

    [self.bgView addSubview:self.label];
    [self.bgView addSubview:self.label1];
    
    self.label1.preferredMaxLayoutWidth = 30;

    self.label.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张 寒来暑往 秋收冬藏 闰余成岁 律吕调阳";
    self.label1.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张 寒来暑往 秋收冬藏 闰余成岁 律吕调阳";

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.width.equalTo(self.view.mas_width);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView.mas_leading).offset(10);
        make.trailing.lessThanOrEqualTo(self.bgView.mas_trailing).offset(-10);
        make.top.equalTo(self.bgView.mas_top).offset(10);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label.mas_leading);
        make.trailing.lessThanOrEqualTo(self.bgView.mas_trailing).offset(-10);
        make.top.equalTo(self.label.mas_bottom).offset(10);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
    }];
}

- (void)testIntrinsicContentSizeLabel {
    [self.view addSubview:self.intrinsicContentSizeLabel];

    [self.intrinsicContentSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.leading.equalTo(self.view.mas_leading).offset(10);
    }];
    self.intrinsicContentSizeLabel.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张";
    CGSize size = [self.intrinsicContentSizeLabel intrinsicContentSize];//ok //但是开发者不会直接使用
}

- (void)testLabel {
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.leading.equalTo(self.view.mas_leading).offset(10);
    }];
    self.label.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张";
    self.label.preferredMaxLayoutWidth = 30;

    /*
     补充引申：
     布局：
     1. Frame Layout
     2. Autoresizing
     3. Auto Layout
     
     Content简单分类：
     1. 文字
     2. 图片
     3. 视频
     
     
     UIView简单分类：
     1. A类：没有subView也没有Content的view，比如UIView的对象；intrinsicContentSize返回的值是(-1,-1)。
     2. B类：leaf-level views，含有Content但是不是UIScroll子类的view，比如UILabel，UIButton，UIImageView
     3. C类：包含content，但是是UIscroll的子类，比如UITextView，UITableView；intrinsicContentSize返回值也是(-1,-1)，
     
     AutoLayout工作原理：
     1. 对于A类View直接设置约束，里面包含子viewe的情况请往下看
     2. 对于B类View，设置关于位置的约束一般就可以完整显示出来，但是要注意文字的换行问题（可以使用preferredMaxLayoutWidth，当然如果你宽度约束设置对了，可以忽略此方法）；当设置完位置约束后，AutoLayout会向此对象回调intrinsicContentSize方法，这个方法会根据B类View的属性（字体，字符串）返回size给autolayout，对于A类C类，因为没有Content，所以返回（-1，-1）
     3. 对于C类View，同A类，需要设置size相关的约束，因为它是可以滚动的，intrinsicContentSize返回（-1，-1），可以使用方法sizeThatFits获取size
     

     1. 先是从cell计算高度看起的，看到几个UIView的对象方法：systemLayoutSizeFittingSize；intrinsicContentSize；sizeThatFits；sizetoFit；layoutIfNeeded。
     2. 然后想弄懂他们：以下这几个方法都是与size相关
        1. systemLayoutSizeFittingSize：
            获取UIView的size的UIView对象方法，iOS6之后出现的，仅用于那些使用AutoLayout的View对象上面的，并且可以提前立即计算好size；计算原理是通过约束+content；一般是计算带正确约束并且带subViews的bgView；用于在view完成布局前（layoutSubViews之前）获取size值，如果view的constraints确保了完整性和正确性，通常它的返回值就是view完成布局之后的view.frame.size的值。
        2. intrinsicContentSize：
            含义：固定内容大小；但是开发者不会直接使用
        3. sizeThatFits：根据字符串及字体计算出来的size；一般用于单个带content的view，比如UILabel，比如UITextView；在计算size过程中，不需要考虑constraints；根据文本计算最适合UITextView的size
        4. sizetoFit：一般用于frame设置的view； = sizeThatFits + 立即布局
        5. [self.view layoutIfNeeded]：立即进行布局，用于获取布局后的值，相当于调用了updateViewConstraints，viewWillLayoutSubviews等方法，调用后可以立即获取frame
        6. preferredMaxLayoutWidth:那么最后testLabel的width是不是就是preferredMaxLayoutWidth的属性值呢？No，最终testLabel的属性值小于等于preferredMaxLayoutWidth的属性值。
        7. 还有字符串的计算size的方法

     */
    
    CGSize size;
    [self.view layoutIfNeeded];//OK
    size = [self.label sizeThatFits:CGSizeMake(30, 0)]; //OK
    size = [self.label intrinsicContentSize];//ok
    size = [self.label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];//OK
}

#pragma mark - 懒加载
- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        _label = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = kWhiteColor;
        label.backgroundColor = kLightGrayColor;
        label.numberOfLines = 0;
    }
    return _label;
}

- (UILabel *)label1 {
    if (!_label1) {
        UILabel *label1 = [[UILabel alloc] init];
        _label1 = label1;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:14.0];
        label1.textColor = kWhiteColor;
        label1.backgroundColor = kLightGrayColor;
        label1.numberOfLines = 0;
    }
    return _label1;
}

- (BPIntrinsicContentSizeLabel *)intrinsicContentSizeLabel {
    if (!_intrinsicContentSizeLabel) {
        BPIntrinsicContentSizeLabel *label = [[BPIntrinsicContentSizeLabel alloc] init];
        _intrinsicContentSizeLabel = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = kWhiteColor;
        label.backgroundColor = kLightGrayColor;
        label.numberOfLines = 0;
    }
    return _intrinsicContentSizeLabel;
}

- (UITextView *)textView {
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] init];
        textView.font = [UIFont systemFontOfSize:18.0];
        textView.textColor = kWhiteColor;
        textView.backgroundColor = kRedColor;
        _textView = textView;
    }
    return _textView;
}

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = kGrayColor;
        _bgView = bgView;
    }
    return _bgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
