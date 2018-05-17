//
//  BP_Four_TopSliderCatergoryViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP_Four_TopSliderCatergoryViewController.h"
#import "DHCustomSlideView.h"
#import "DHScrollTabbarView.h"
#import "BP_Four_TopSliderCatergorySubViewController.h"

@interface BP_Four_TopSliderCatergoryViewController ()<DHCustomSlideViewDelegate>
@property (nonatomic,weak) DHCustomSlideView *customSlideView;
@property (nonatomic,weak) DHScrollTabbarView *scrollTabbarView;
@property (nonatomic, strong) NSArray *cateogry;
@end

@implementation BP_Four_TopSliderCatergoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handlaData];
    [self configThemes];
}

- (void)handlaData {
    self.cateogry = @[@"中国",@"俄罗斯",@"加拿大",@"尼日利亚",@"马达加斯加",@"格林尼治",@"埃塞尔比亚",@"中美",@"美国"];
}

- (void)configThemes {
    self.title = @"权威词典";
    NSArray *itemArray = [self itemTitleData];

    DHScrollTabbarView *scrollTabbarView = [[DHScrollTabbarView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, itemArray.count > 1 ? 40 : 0)];
//    DHScrollTabbarView *scrollTabbarView = [[DHScrollTabbarView alloc] init];
    [self.view addSubview:scrollTabbarView];
//    [scrollTabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(44);
//        make.height.equalTo(@40);
//        make.leading.trailing.equalTo(self.view);
//    }];
    self.scrollTabbarView = scrollTabbarView;
    self.scrollTabbarView.trackViewWidthEqualToTextLength = NO;////滑动线条宽度是否跟文字长度相同 否则跟显示文字的区域宽度相同
    self.scrollTabbarView.shouldChangeBackViewColor = NO;
    self.scrollTabbarView.trackViewWidth = 15;
    self.scrollTabbarView.shouldChangeFontWhenSelected = NO;
    self.scrollTabbarView.shouldTrackViewAutoScroll = YES;
    self.scrollTabbarView.shouldBackViewAutoScroll = NO;
    self.scrollTabbarView.isSimpleThemePage = YES;
    self.scrollTabbarView.tabItemNormalColor = kDarkTextColor;
    self.scrollTabbarView.tabItemSelectedColor = kGreenColor;
    self.scrollTabbarView.tabItemNormalFontSize = 15.0f;
    self.scrollTabbarView.itemsLabelNeedBold = YES;
    self.scrollTabbarView.trackColor = kGreenColor;
    self.scrollTabbarView.tabbarItems = itemArray;
    self.scrollTabbarView.shouldShowBottomSeparateLine = YES;
    self.scrollTabbarView.bottomSeparateView.backgroundColor = kGreenColor;
    self.scrollTabbarView.backgroundColor = kLightGrayColor;
    
    DHCustomSlideView *customSlideView = [[DHCustomSlideView alloc] init];
    [self.view addSubview:customSlideView];

    [customSlideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollTabbarView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    self.customSlideView = customSlideView;
    self.customSlideView.tabbarView = self.scrollTabbarView;

    self.customSlideView.delegate = self;
    self.customSlideView.tabbarBottomSpacing = 0;
    self.customSlideView.baseViewController = self;
    self.customSlideView.backgroundColor = kClearColor;
    [self.customSlideView setup];
    [self.customSlideView setSlideViewBackgroundColor:kClearColor];
    self.customSlideView.selectedIndex = 0;
}

- (NSArray *)itemTitleData {
    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i < self.cateogry.count; i++) {
        CGFloat width = [self getWidthWithString:self.cateogry[i] font:[UIFont systemFontOfSize:15]] + 35;
        DHScrollTabbarItem *item = [DHScrollTabbarItem itemWithTitle:self.cateogry[i] width:width];
        BPLog(@"DHScrollTabbarItem = %.2f",width);
        [itemArray addObject:item];
    }
    return itemArray;
}

- (CGFloat )getWidthWithString:(NSString *)string font:(UIFont *)font {
    if (!BPValidateString(string).length) {
        return 0;
    }
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:font}];
    return ceilf(size.width);
}

#pragma mark - DHCustomSlideViewDelegate
- (NSInteger)numberOfTabsInDHCustomSlideView:(DHCustomSlideView *)customSlideView{
    return self.cateogry.count;
}

- (UIViewController *)DHCustomSlideView:(DHCustomSlideView *)customSlideView controllerAtIndex:(NSInteger)index {
    BP_Four_TopSliderCatergorySubViewController *vc = [[BP_Four_TopSliderCatergorySubViewController alloc] init];
    return vc;
}

- (void)DHCustomSlideView:(DHCustomSlideView *)customSlideView didSelectedAtIndex:(NSInteger)index{
    BPLog(@"第几个item：%@",@(index));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
