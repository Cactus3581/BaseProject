//
//  MasonryViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/3/19.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "MasonryViewController.h"
#import "MPlayerView.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@interface MasonryViewController ()
@property (nonatomic,strong) UIView *testview;
@property (nonatomic,strong) UILabel *testlabel;
@property (nonatomic,strong) MPlayerView *mPlayerView;


@end
// 关于static与const结合
// 定义了一个对象类型为 NSString *,变量名为static_Const_str1，初值为@"static_Const_str1"的指针变量

// 1. *static_Const_str1 不可改变，是常量；static_Const_str1可改变
//指向字符串的指针，指针所指向的地址中所存的内容不能改变
static const NSString *static_Const_str1 = @"static_Const_str1";//仅限本文件使用，字符串能被修改

// 2. *static_Const_str2 可改变；static_Const_str2（指针或者说是地址）不可改变,是常量
//指向字符串的指针，指针所指向的地址不能改变
static  NSString * const static_Const_str2 = @"static_Const_str2";//字符串不能被修改

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self differentjixing];
    
//    [self.view addSubview:self.mPlayerView];
    
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
    








    

//    [self.mPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view);
//        make.top.equalTo(self.view).offset(0);
//        make.center.equalTo(self.view);
//        make.width.equalTo(self.view.mas_height).multipliedBy(radio);
//    }];
}

- (MPlayerView *)mPlayerView
{
    if (!_mPlayerView) {
        _mPlayerView = [[MPlayerView alloc]init];
    }
    return _mPlayerView;
}




- (void)previous
{
    BPLog(@"%p",static_Const_str1);
    BPLog(@"%p",static_Const_str2);
    
    static_Const_str1 = @"change"; // 对象内容不可变，指针可以变，也就是说可以指向别的对象。这里指向了@"change"这个对象，static_Const_str1里存储的地址也就变了
    BPLog(@"%p",static_Const_str1);
    
    // 下面这行会报错：对象内容可变，指针不可以变，也就是说static_Const_str2不可以指向别的对象了，只能指向@"static_Const_str2"这个对象
    //    static_Const_str2 = @"change2";
    //    BPLog(@"%p",static_Const_str2);
    
    
    //    @"test_1"  和  @"test_2" 是两个不同的字符串，即两个对象；
    //    test_1才是指针或者说是指针变量
    
    //test_1指向了第一个对象@"test_1"，指针变量里面存储的地址是@"test_1"的地址
    NSString * test_1 = @"test_1";
    BPLog(@"%p",test_1);
    
    //test_1指向了第二个对象@"test_2"，指针变量里面存储的地址也就变为了@"test_2"的地址
    test_1 = @"test_2";
    BPLog(@"%p",test_1);
    
    
    //        extern NSString * const testStr2;
    //        testStr2 = @"const_test2_change";
    //        BPLog(@"%@", testStr2); //
    
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
- (void)testLabel
{
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
- (void)commonView
{
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
//        make.left.equalTo(self.view).with.offset(100);
//
//        make.bottom.equalTo(self.view).with.offset(-100);
//
//        make.right.equalTo(self.view).with.offset(-100);
        
        // 第四种方法
//        make.top.left.bottom.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(100, 100, 100, 100));
//    make.top.left.bottom.and.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(100, 100, 100, 100));

        make.edges.equalTo(self.view);
//        make.height.equalTo(200);
    }];
}


- (UIView *)testview
{
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
