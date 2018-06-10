//
//  BPTagViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagViewController.h"
#import "BPTagAutoLayoutView.h"
#import "BPTagCollectionView.h"
#import "BPTagFrameView.h"
#import "UIView+BPAdd.h"

@interface BPTagViewController ()<BPTagAutoLayoutViewDelegate,BPTagCollectionViewDelegate>
@property (weak, nonatomic) BPTagAutoLayoutView *tagLabelView;
@property (weak, nonatomic) BPTagCollectionView *tagCollectionView;
@property (nonatomic,weak) BPTagFrameView *autoresizingView;

@end

@implementation BPTagViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"选择标签";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTagLabelView];
    [self configTagCollectionView];
    [self configTagFrameView];
}

- (void)configTagFrameView {
    BPTagFrameView *autoresizingView = [[BPTagFrameView alloc] init];
    _autoresizingView = autoresizingView;
    [self.view addSubview:autoresizingView];
    autoresizingView.backgroundColor = kLightGrayColor;
    autoresizingView.titlesArray = @[@"objective-c",@"swift",@"java",@"C++",@"python",@"php",@"html5",@"我是要成为全栈的人"];
    autoresizingView.bounds = CGRectMake(0, 0, kScreenWidth, autoresizingView.height);
    autoresizingView.center = CGPointMake(self.view.centerX, self.view.height-200);
    //    [autoresizingView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        autoresizingView.leading.trailing.equalTo(self.view);
    //        make.top.equalTo((self.view)).offset(300);
    //    }];
    //    [self.view layoutIfNeeded];
    //    [autoresizingView layoutIfNeeded];
    //    BPLog(@"size = %@",NSStringFromCGSize(size));
    
}

- (void)configTagCollectionView {
    BPTagCollectionView *tagCollectionView = [[BPTagCollectionView alloc] init];
    [self.view addSubview:tagCollectionView];
    tagCollectionView.delegate = self;
    tagCollectionView.backgroundColor = kLightGrayColor;
    tagCollectionView.titlesArray = @[@"objective-c",@"swift",@"java",@"C++",@"python",@"php",@"html5",@"我是要成为全栈的人"];
    [tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo((self.view)).offset(100);
        make.height.mas_equalTo(tagCollectionView.cardHeight);
    }];
    self.tagCollectionView = tagCollectionView;
}

- (void)getHeight:(CGFloat)height {
//    BPLog(@"self.collectionView.contentSize.height = %.2f ,%.2f",height,self.tagCollectionView.cardHeight);
    [self.tagCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(self.tagCollectionView.cardHeight);
        make.height.mas_equalTo(height);
    }];
}

- (void)tagCollectionView:(BPTagCollectionView *)tagCollectionView didSelectRowAtIndex:(NSInteger)index {
    BPLog(@"点击了第%ld个",index);
}

- (void)configTagLabelView {
    BPTagAutoLayoutView *tagLabelView = [[BPTagAutoLayoutView alloc] init];
    [self.view addSubview:tagLabelView];
    tagLabelView.delegate = self;
    tagLabelView.backgroundColor = kLightGrayColor;    
    tagLabelView.titlesArray = @[@"objective-c",@"swift",@"java",@"C++",@"python",@"php",@"html5",@"我是要成为全栈的人"];
    [tagLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo((self.view)).offset(300);
    }];
    self.tagLabelView = tagLabelView;
}

- (void)tagLabelView:(BPTagAutoLayoutView *)tagLabelView didSelectRowAtIndex:(NSInteger)index {
    BPLog(@"点击了第%ld个",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
