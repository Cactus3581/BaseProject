//
//  BPTagViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagViewController.h"
#import "BPTagLabelView.h"
#import "BPTagCollectionView.h"

@interface BPTagViewController ()<BPTagLabelViewDelegate,BPTagCollectionViewDelegate>
@property (weak, nonatomic) BPTagLabelView *tagLabelView;
@property (weak, nonatomic) BPTagCollectionView *tagCollectionView;
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
    BPTagLabelView *tagLabelView = [[BPTagLabelView alloc] init];
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

- (void)tagLabelView:(BPTagLabelView *)tagLabelView didSelectRowAtIndex:(NSInteger)index {
    BPLog(@"点击了第%ld个",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
