//
//  BPAutoresizingViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoresizingViewController.h"
#import "UIView+BPAdd.h"
#import "BPAutoresizingViewA.h"
#import "BPAutoresizingViewB.h"
#import "BPAppDelegate.h"

//http://www.cnblogs.com/GarveyCalvin/p/4165151.html
@interface BPAutoresizingViewController ()
@property (nonatomic,weak) BPAutoresizingViewA *autoresizingViewA;
@property (nonatomic,weak) BPAutoresizingViewB *autoresizingViewB;
@end

@implementation BPAutoresizingViewController

/*
 
 Autoresizing可以与AutoLayout一块混合使用，但是不能在同一个view上使用；比如这样是可以的：Autoresizing作用于子视图，autoLayout作用于它的父视图
 
 autoresizing是UIView的属性
 typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
 UIViewAutoresizingNone                 = 0,     不会随父视图的改变而改变
 UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,自动调整view与父视图左边距，以保证右边距不变
 UIViewAutoresizingFlexibleWidth        = 1 << 1,自动调整view的宽度，保证左边距和右边距不变
 UIViewAutoresizingFlexibleRightMargin  = 1 << 2,自动调整view与父视图右边距，以保证左边距不变
 UIViewAutoresizingFlexibleTopMargin    = 1 << 3,自动调整view与父视图上边距，以保证下边距不变
 UIViewAutoresizingFlexibleHeight       = 1 << 4,自动调整view的高度，以保证上边距和下边距不变
 UIViewAutoresizingFlexibleBottomMargin = 1 << 5 自动调整view与父视图的下边距，以保证上边距不变
 };
 
 UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin
 意思是：view的宽度按照父视图的宽度比例进行缩放，距离父视图顶部距离不变。
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"Autoresizing";
//    [kAppDelegate reserTrackString];
//    [kAppDelegate trackString:@"viewDidLoad"];
//    [self initSubViews_frame];
//    [self initSubViews_center];

//    [self initAutoresizingView];
    
    
    [self initSubViews_intoViews];

}

-  (void)rightBarButtonItemClickAction:(id)sender {
//    self.autoresizingViewA.frame = CGRectMake(30, 283.5, 325, 260);
//    [self.view layoutIfNeeded];
//    [self.autoresizingViewA layoutIfNeeded];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
//    [kAppDelegate trackString:[NSString stringWithFormat:@"updateViewConstraints:%.2f",self.autoresizingViewA.height]];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    [kAppDelegate trackString:[NSString stringWithFormat:@"viewWillLayoutSubviews:%.2f",self.autoresizingViewA.height]];
}

- (void)initSubViews_intoViews {
    BPAutoresizingViewA *autoresizingViewA = [[BPAutoresizingViewA alloc] init];
    self.autoresizingViewA = autoresizingViewA;
    [self.view addSubview:self.autoresizingViewA];
    self.autoresizingViewA.bounds = CGRectMake(0, 0, kScreenWidth-50, 100);
    self.autoresizingViewA.frame = CGRectMake(20, 100, kScreenWidth-50, 100);
    [self.autoresizingViewA setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
}

- (void)initSubViews_frame {
    UIView *topView = [[UIView alloc] init];
    topView.bounds = CGRectMake(0, 0, kScreenWidth-50, 50);
    topView.frame = CGRectMake(20, 100, kScreenWidth-50, 50);
    topView.backgroundColor = kPurpleColor;
    [self.view addSubview:topView];

    UILabel *textLabel = [[UILabel alloc] init];
    [topView addSubview:textLabel];
    textLabel.bounds = CGRectMake(0, 0, topView.width/2.0, topView.height/2.0);
    textLabel.center = CGPointMake(topView.width/2.0, topView.height/2.0);
    [textLabel setText:@"autoresizing"];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setBackgroundColor:kGreenColor];
    [textLabel setTextColor:kWhiteColor];
    
    //设置textLabel的宽度按照父视图（topView）的比例进行缩放
    [textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    //设置topView控件的宽度按照父视图的比例进行缩放，距离父视图顶部、左边距和右边距的距离不变
    [topView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin];
}

- (void)initSubViews_center {
    UIView *topView = [[UIView alloc] init];
    topView.bounds = CGRectMake(0, 0, kScreenWidth-50, 50);
    topView.center = CGPointMake(self.view.width/2.0, self.view.height/2.0);
    topView.backgroundColor = kPurpleColor;
    [self.view addSubview:topView];
    
    UILabel *textLabel = [[UILabel alloc] init];
    [topView addSubview:textLabel];
    textLabel.bounds = CGRectMake(0, 0, topView.width/2.0, topView.height/2.0);
    textLabel.center = CGPointMake(topView.width/2.0, topView.height/2.0);
    [textLabel setText:@"autoresizing"];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setBackgroundColor:kGreenColor];
    [textLabel setTextColor:kWhiteColor];
    
    // 设置textLabel的宽度按照父视图（topView）的比例进行缩放
    [textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    // 设置topView控件的宽度按照父视图的比例进行缩放，距离父视图顶部、左边距和右边距的距离不变
    [topView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
}

- (void)initAutoresizingView {
    //BPAutoresizingViewA *autoresizingView = [[BPAutoresizingViewA alloc] init];
    BPAutoresizingViewA *autoresizingView = [[BPAutoresizingViewA alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    self.autoresizingViewA = autoresizingView;
    [self.view addSubview:autoresizingView];
    autoresizingView.backgroundColor = kLightGrayColor;
    autoresizingView.bounds = CGRectMake(0, 0, kScreenWidth-50, autoresizingView.height);
    autoresizingView.center = self.view.center;
    
    //    [autoresizingView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        autoresizingView.leading.trailing.equalTo(self.view);
    //        make.top.equalTo((self.view)).offset(300);
    //    }];
    //    [self.view layoutIfNeeded];
    //    [autoresizingView layoutIfNeeded];
    //    CGSize size;
    //    size = [autoresizingView sizeThatFits:CGSizeMake(kScreenWidth-50, 0)];
    //    BPLog(@"size = %@",NSStringFromCGSize(size));
    //
    //    size = [autoresizingView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //    BPLog(@"size = %@",NSStringFromCGSize(size));
    //
    //    size = [autoresizingView intrinsicContentSize];//ok //但是开发者不会直接使用
    //    BPLog(@"size = %@",NSStringFromCGSize(size));
    
    BPLog(@"%.2f",autoresizingView.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
