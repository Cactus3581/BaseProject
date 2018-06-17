//
//  BPAutoLayoutCodeViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoLayoutCodeViewController.h"
#import "BPMasonryAutoLayoutProcessView.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)


@interface BPAutoLayoutCodeViewController ()
@property (nonatomic,strong) UIView *testview;
@property (nonatomic,strong) UILabel *testlabel;
@property (nonatomic,strong) BPMasonryAutoLayoutProcessView *masonryView;
@end

@implementation BPAutoLayoutCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - masonry布局及技巧
- (void)masonry {
    
}

#pragma mark - 约束使用及属性
- (void)contraint {
    
    for (int i = 0; i<3; i++) {
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
}

#pragma mark - vfl语言使用
- (void)vfl {
    
}

#pragma mark - 测试

- (void)test {
    //    [self differentjixing];
    
    //    [self.view addSubview:self.BPMasonryAutoLayoutProcessView];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat px = 1.0f;
    CGFloat pt = px / scale;
    
    CGFloat lineWidth = SINGLE_LINE_WIDTH;
    CGFloat pixelAdjustOffset = SINGLE_LINE_WIDTH;
    //仅当要绘制的线宽为奇数像素时，绘制位置需要调整
    if (((int)(lineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    BPLog(@"%.2f",pixelAdjustOffset);
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 400, 200,pt)];
    line.backgroundColor = kRedColor;
    [self.view addSubview:line];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, 405, 200, 1)];
    line2.backgroundColor = kRedColor;
    [self.view addSubview:line2];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
    line1.frame = CGRectMake(10-pixelAdjustOffset, 410-pixelAdjustOffset, 200, lineWidth);
    line1.backgroundColor = kRedColor;
    [self.view addSubview:line1];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 250, 50)];
    view.backgroundColor = kGreenColor;
    [self.view addSubview:view];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 470, 40, 20)];
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = kRedColor.CGColor;
    [self.view addSubview:label];
    
    //    [self.BPMasonryAutoLayoutProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(self.view);
    //        make.top.equalTo(self.view).offset(0);
    //        make.center.equalTo(self.view);
    //        make.width.equalTo(self.view.mas_height).multipliedBy(radio);
    //    }];
}

- (BPMasonryAutoLayoutProcessView *)masonryView {
    if (!_masonryView) {
        _masonryView = [[BPMasonryAutoLayoutProcessView alloc]init];
    }
    return _masonryView;
}

- (void)previous {

    
    //    [self commonView];
    
    //    [self.view addSubview:self.testview];
    _testlabel = [[UILabel alloc]init];
    //    _testlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 300, 30)];
    
    _testview = [[UIView alloc]init];
    _testview.backgroundColor = kGreenColor;
    
    [self.view addSubview:_testview];
    
    _testlabel.backgroundColor = kRedColor;
    _testlabel.text = @"上课到拉萨的卡到拉萨的卡拉屎的考拉大山里的快乐撒的快乐撒的卡拉屎的考拉圣诞快乐撒昆德拉圣诞快乐撒的快乐撒的卡索拉大";
    _testlabel.numberOfLines = 0;
    [self.view addSubview:_testlabel];
    [_testlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_testview);
        make.width.equalTo(_testview);
        //        make.height.offset(40);
        //        make.height.equalTo(@40);
        //        make.height.equalTo(_testview).multipliedBy(0.5);
        //        make.height.equalTo(_testview.mas_height);
        //        make.height.mas_equalTo(100);
        //        make.size.mas_equalTo(CGSizeMake(100, 200));
        //        make.edges.mas_equalTo(UIEdgeInsetsZero);
        UIEdgeInsets edge = UIEdgeInsetsMake(100, 20, 100, 100);
        make.edges.mas_equalTo(edge);
        
        
    }];
    
    
    
    
    //测试1
    [_testview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.center.equalTo(self.view);
        //        make.width.height.equalTo(@50);
        
        //测试2
        
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(@100);
        make.bottom.equalTo(self.view).offset(-10);
        
    }];
}

- (void)testLabel {
    _testlabel = [[UILabel alloc]init];
    //    _testlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 300, 30)];
    
    _testlabel.backgroundColor = kRedColor;
    _testlabel.text = @"上课到拉萨的卡到拉萨的卡拉屎的考拉大山里的快乐撒的快乐撒的卡拉屎的考拉圣诞快乐撒昆德拉圣诞快乐撒的快乐撒的卡索拉大";
    _testlabel.numberOfLines = 0;
    [self.view addSubview:_testlabel];
    [_testlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_testview);
        make.width.equalTo(@300);
    }];
}

- (void)commonView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 200)];
    view.backgroundColor = kRedColor;
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 第一种方法
        //        make.center.equalTo(self.view);
        //        mas_equalTo所支持的类型 除了NSNumber支持的那些数值类型之外 就只支持CGPoint ,CGSize,和UIEdgeInsets。
        //        make.size.mas_equalTo(CGSizeMake(100, 200));
        // 第二种方法
        //        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        
        // 第三种方法
        //        bottom和right里的offset是负数
        //        make.top.equalTo(self.view).with.offset(100);
        //        make.leading.equalTo(self.view).with.offset(100);
        //
        //        make.bottom.equalTo(self.view).with.offset(-100);
        //
        //        make.trailing.equalTo(self.view).with.offset(-100);
        
        // 第四种方法
        //        make.top.leading.bottom.trailing.equalTo(self.view).with.insets(UIEdgeInsetsMake(100, 100, 100, 100));
        //    make.top.leading.bottom.and.trailing.equalTo(self.view).with.insets(UIEdgeInsetsMake(100, 100, 100, 100));
        
        make.edges.equalTo(self.view);
        //        make.height.equalTo(200);
    }];
}


- (UIView *)testview {
    if (!_testview) {
        _testview = [[UIView alloc]init];
        _testview.backgroundColor = kRedColor;
        [_testview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.height.equalTo(@50);
        }];
    }
    return _testview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
