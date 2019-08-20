//
//  BPViewSizeController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPViewSizeController.h"

/*
 http://www.cocoachina.com/industry/20131012/7148.html
 */

/*
 
 想弄懂的是在布局未完成下不同类型UIView子类如何计算Size(不包括后期的显示，当然显示效果是正确的)：
 1. 未布局完成，直接读取frame肯定是不行的
 2. 布局完成，可以直接读取
 
 使用autolayout 设置约束后，不能立即获取 frame值的原因:
 对于使用auto layout机制布局的view，auto layout system会在布局过程中综合各种约束的考虑为之设置一个size，在布局完成后，该size的值即为view.frame.size的值；这包含的另外一层意思，即在布局完成前，我们是不能通过view.frame.size准确获取view的size的。但有时候，我们需要在auto layout system对view完成布局前就知道它的size，systemLayoutSizeFittingSize:方法正是能够满足这种要求的API。systemLayoutSizeFittingSize:方法会根据其constraints返回一个合适的size值。
 
 回顾下AutoLayout工作原理：根据我的理解，auto layout system在处理某个view的size时，参考值包括：
 1. 自身的intrinsicContentSize方法返回值；
 2. subviews的intrinsicContentSize方法返回值；
 3. 自身和subviews的constraints；
 
 UIView与size相关的对象方法：
 1. systemLayoutSizeFittingSize：
 获取UIView的size的UIView对象方法，iOS6之后出现的，仅用于那些使用AutoLayout的View对象上面的，并且可以提前立即计算好size；计算原理是通过约束+content；一般是计算拥有正确约束并且拥有subViews的ParentView；用于在view完成布局前（layoutSubViews之前）获取size值，如果view的constraints确保了完整性和正确性，通常它的返回值就是view完成布局之后的view.frame.size的值。
 2. intrinsicContentSize：
 含义：固定内容大小；但是开发者不会直接使用
 3. sizeThatFits：根据字符串及字体计算出来的size；一般用于单个带content的view，比如UILabel，比如UITextView；在计算size过程中，不需要考虑constraints；根据文本计算最适合UITextView的size；对于滚动的View，可以使用方法sizeThatFits获取size；sizeThatFits在布局未完成之前对UIView的对象算不出来；sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己

 4. sizetoFit：一般用于frame设置的view； = sizeThatFits + 立即布局
 5. [self.view layoutIfNeeded]：立即进行布局，用于获取布局后的值，相当于调用了updateViewConstraints，viewWillLayoutSubviews等方法，调用后可以立即获取frame
 6. preferredMaxLayoutWidth:解决文字的换行问题（当然如果你宽度约束设置对了，可以忽略此方法）；如果使用绝对布局，可以不用写，如果是用相对布局，需要写；Label的属性值小于等于preferredMaxLayoutWidth的属性值；
 7. 字符串的计算size的方法
 
 注意，如果使用AutoLayout提前计算size，条件满足其一即可
 1. 不使用相对动态witdh和height
 2. preferredMaxLayoutWidth
 
 */

@interface BPViewSizeController ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation BPViewSizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testLabel];
//    [self testLabel_label_bgView];
//    [self testLabel_textView_bgView];
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)testLabel {
    
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.leading.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
    }];
    self.label.text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？";
    
    CGSize size1,size2;
    
    BPLog(@"%@",NSStringFromCGSize(self.label.size));//NO:{0, 0}作为参考，获取不到size

    size1 = [self.label sizeThatFits:CGSizeMake(kScreenWidth-20, MAXFLOAT)]; //OK:{348, 50.5}
    BPLog(@"%@",NSStringFromCGSize(size1));

    // 计算不准确：因为，此时调用这个方法，autoLayout会让Label的固有内容API提供值，而label的宽度值及折行的范围没有确定，所以会按照单行来计算值，返回的固有内容值不对，因此systemLayoutSizeFittingSize计算出来的值也不对
    size2 = [self.label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];//NO:{738.5, 17}
    BPLog(@"%@",NSStringFromCGSize(size2));
    
    self.label.preferredMaxLayoutWidth = kScreenWidth-20;
//    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(kScreenWidth-20);
//    }];

    //此时AutoLayout要的固有内容值是正确的，因此systemLayoutSizeFittingSize计算出来的值也不对
    size2 = [self.label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];//OK:{355, 50.5}
    BPLog(@"%@",NSStringFromCGSize(size2));
    
    [self.view layoutIfNeeded];//OK
    BPLog(@"%@",NSStringFromCGSize(self.label.size));//标准：{355, 50.5}
}

//bgView的大小由里面的两个label撑起：约束和intrinsicContentSize起到了作用
- (void)testLabel_label_bgView {
    /*
     因为label1和label2的intrinsicContentSize方法会将content size告诉auto layout system，进而后者会为它们的size设置对应值；
     但对于bgView，它可是一个UIView对象，它的intrinsicContentSize回调方法的返回值为(-1,-1)，那么auto layout system会根据子view的intrinsicContentSize返回的size和自身的约束来设置合适的size。
     */
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.label];
    [self.bgView addSubview:self.label1];
    
    self.label.text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？";
    self.label1.text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？";

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.leading.trailing.equalTo(self.view);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView).offset(10);
        make.trailing.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.bgView).offset(10);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView).offset(10);
        make.trailing.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.label.mas_bottom).offset(10);
        make.bottom.equalTo(self.bgView).offset(-10);
    }];


    //此时bgView还未布局完成，直接读取bgView肯定是不行的。
    BPLog(@"%@",NSStringFromCGSize(self.bgView.size));//{0, 0}
    
    CGSize size;
    
    //systemLayoutSizeFittingSize:方法正是用于处理这个问题的。但是由于采用相对布局，布局未完成，不知道怎么根据label折行，所以算出来的size有问题，但是显示是正确的的。因为下个runloop，autoLayout会再次计算正确的
    size = [self.bgView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    BPLog(@"%@",NSStringFromCGSize(size));//NO:{758.5, 64}
    
    //sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己
    size = [self.bgView sizeThatFits:CGSizeMake(kScreenWidth, MAXFLOAT)];
    BPLog(@"%@",NSStringFromCGSize(size));//NO:{0, 0}
    
#pragma mark - 计算size-1:OK：preferredMaxLayoutWidth
//    self.label.preferredMaxLayoutWidth = kScreenWidth-20;
//    self.label1.preferredMaxLayoutWidth = kScreenWidth-20;
    
#pragma mark - 计算size-2:OK：addConstraint
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.width.equalTo(self.view); //相对布局
        //make.width.mas_equalTo(kScreenWidth);//绝对布局
    }];
    
#pragma mark - 计算size-3:OK：addConstraint
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kScreenWidth];
    [self.bgView addConstraint:widthFenceConstraint];
    
    size = [self.bgView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    BPLog(@"%@",NSStringFromCGSize(size));//{368, 131},{375, 131}，{375, 131}
    
    size = [self.bgView sizeThatFits:CGSizeMake(kScreenWidth, MAXFLOAT)];
    BPLog(@"%@",NSStringFromCGSize(size));//{0, 0}，{0, 0}，{0, 0}
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    BPLog(@"%@",NSStringFromCGSize(self.bgView.size));//{375, 131}
}

// bgView的大小由里面的一个label和textView撑起：约束 + sizeThatFits + intrinsicContentSize起到了作用
- (void)testLabel_textView_bgView {

    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.label];
    [self.bgView addSubview:self.textView];
    
    self.label.text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？";
    self.textView.text = @"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？";

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.leading.trailing.equalTo(self.view);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView).offset(10);
        make.trailing.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.bgView).offset(10);
    }];

    CGSize size = [self.textView sizeThatFits:CGSizeMake(kScreenWidth-20, MAXFLOAT)];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView).offset(10);
        make.trailing.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.label.mas_bottom).offset(10);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
        make.height.equalTo([NSNumber numberWithFloat:size.height]);
    }];
    
    //此时bgView还未布局完成，直接读取bgView肯定是不行的。
    BPLog(@"%@",NSStringFromCGSize(self.bgView.size));//{0, 0}
    
    CGSize size1;
    //算的不对，label不知道什么时候折行
    size1 = [self.bgView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    BPLog(@"%@",NSStringFromCGSize(size1));//  {758.5, 127.5}

    //算的不对，sizeThatFits在布局未完成之前算不出来
    size1 = [self.bgView sizeThatFits:CGSizeMake(kScreenWidth-20, MAXFLOAT)];
    BPLog(@"%@",NSStringFromCGSize(size1));//  {0, 0}
    
#pragma mark - 计算size-1:OK：preferredMaxLayoutWidth
//    self.label.preferredMaxLayoutWidth = kScreenWidth-20;
    
#pragma mark - 计算size-2:OK：addConstraint
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.width.equalTo(self.view); //相对布局
//        make.width.mas_equalTo(kScreenWidth);//绝对布局
    }];
    
#pragma mark - 计算size-3:OK：addConstraint
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kScreenWidth];
    [self.bgView addConstraint:widthFenceConstraint];
    
    size1 = [self.bgView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    BPLog(@"%@",NSStringFromCGSize(size1));//{368, 161},{375, 161},{375, 161}
    
    size1 = [self.bgView sizeThatFits:CGSizeMake(kScreenWidth, MAXFLOAT)];
    BPLog(@"%@",NSStringFromCGSize(size1));//{0, 0},{0, 0},{0, 0}
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    BPLog(@"%@",NSStringFromCGSize(self.bgView.size));//{375, 161}
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

- (UILabel *)label1 {
    if (!_label1) {
        UILabel *label1 = [[UILabel alloc] init];
        _label1 = label1;
        label1.font = [UIFont systemFontOfSize:14.0];
        label1.textColor = kWhiteColor;
        label1.backgroundColor = kLightGrayColor;
        label1.numberOfLines = 0;
    }
    return _label1;
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

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        bgView.backgroundColor = kThemeColor;
    }
    return _bgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
