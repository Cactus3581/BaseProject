//
//  BPAutoLayoutEqualInsetViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoLayoutEqualInsetViewController.h"

@interface BPAutoLayoutEqualInsetViewController ()
@property (nonatomic,strong) NSMutableArray <UIView *> *horizontalSpaceViewArray;
@property (nonatomic,strong) NSMutableArray <UIView *> *horizontalWidthViewArray;
@property (nonatomic,strong) NSMutableArray <UIView *> *verticalSpaceViewArray;
@property (nonatomic,strong) NSMutableArray <UIView *> *verticalWidthViewArray;
@property (nonatomic,assign) BOOL change;
@end

@implementation BPAutoLayoutEqualInsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"change";
    [self normalSkill];
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.horizontalSpaceViewArray = nil;
    self.horizontalWidthViewArray = nil;
    self.verticalSpaceViewArray = nil;
    self.verticalWidthViewArray = nil;
    
    if (self.change) {
        [self normalSkill];
    }else {
        [self highSkill];
    }
    
    self.change = !self.change;
}

- (void)normalSkill {
    [self horizontal_fixSpace];
    [self horizontal_fixWidth];
}

// 等宽度布局：给出间隔（间隔呈不等，可以相等），宽度未知，让其等宽
- (void)horizontal_fixSpace {
    CGFloat space = 10;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i ++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kThemeColor;
        [self.view addSubview:view];
        [array addObject:view];
        if (i == 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.view).offset(10);
                make.centerY.equalTo(self.view).offset(-100);
                make.height.mas_equalTo(50);
            }];
        }else {
            UIView *lastView = array[i-1];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(lastView.mas_trailing).offset(space+5*i);//间隔不相等的情况
                //make.leading.equalTo(lastView.mas_trailing).offset(space);//间隔相等的情况
                make.centerY.height.width.equalTo(lastView);
            }];
        }
    }
    UIView *lastView = array.lastObject;
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-10);
    }];
}

// 等间隔布局：给出宽度(宽度呈不等，可以相等），间隔未知，让其等间隔
- (void)horizontal_fixWidth {
    CGFloat width = 50;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    //等宽等间隔
    NSInteger viewCount = 4;
    for (int i = 0; i < viewCount*2-1; i ++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kThemeColor;
        [self.view addSubview:view];
        [array addObject:view];
        if (i == 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.view).offset(10);
                make.centerY.equalTo(self.view).offset(100);
                make.height.mas_equalTo(50);
                make.width.mas_equalTo(width);
            }];
        }else {
            UIView *lastView = array[i-1];
            
            if (i%2 == 0) { //目标显示view
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(lastView.mas_trailing);
                    make.centerY.height.equalTo(lastView);
                    //make.width.mas_equalTo(width);// 宽度可以相等的情况
                    make.width.mas_equalTo(width+5*i);//宽度不相等的情况
                }];
            } else {
                //占位间隔view
                view.backgroundColor = kClearColor;
                if (i>=2) {
                    UIView *lastPlacedView = array[i-2];
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.leading.equalTo(lastView.mas_trailing);
                        make.centerY.height.equalTo(lastView);
                        make.width.equalTo(lastPlacedView);
                    }];
                }else {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.leading.equalTo(lastView.mas_trailing);
                        make.centerY.height.equalTo(lastView);
                    }];
                }
            }
        }
    }
    UIView *lastView = array.lastObject;
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-10);
    }];
}

- (void)highSkill {
    [self test_masonry_horizontal_fixSpace];
    [self test_masonry_horizontal_fixItemWidth];
    [self test_masonry_vertical_fixSpace];
    [self test_masonry_vertical_fixItemWidth];
}

- (void)test_masonry_horizontal_fixSpace {

    // 实现masonry水平固定间隔方法
    [self.horizontalSpaceViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
    
    // 设置array的垂直方向的约束
    [self.horizontalSpaceViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.height.mas_equalTo(80);
    }];
}

- (void)test_masonry_horizontal_fixItemWidth {
    
    UIView *lastView = self.horizontalSpaceViewArray.lastObject;
    
    // 实现masonry水平固定控件宽度方法
    [self.horizontalWidthViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
    
    // 设置array的垂直方向的约束
    [self.horizontalWidthViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(10);
        make.height.equalTo(lastView.mas_height);
    }];
}

- (void)test_masonry_vertical_fixSpace {
    UIView *lastView = self.horizontalWidthViewArray.lastObject;

    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];

    // 实现masonry垂直固定控件高度方法
    [self.verticalSpaceViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:30 leadSpacing:CGRectGetMaxY(lastView.frame)+10 tailSpacing:10];
    
    // 设置array的水平方向的约束
    [self.verticalSpaceViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.width.mas_equalTo(80);
    }];
}

- (void)test_masonry_vertical_fixItemWidth {
    UIView *lastView = self.verticalSpaceViewArray.firstObject;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    // 实现masonry垂直方向固定控件高度方法
    [self.verticalWidthViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:80 leadSpacing:lastView.y tailSpacing:10];
    
    // 设置array的水平方向的约束
    [self.verticalWidthViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lastView.mas_trailing).offset(10);
        make.width.equalTo(lastView.mas_width);
    }];
}

- (NSMutableArray *)horizontalSpaceViewArray {
    if (!_horizontalSpaceViewArray) {
        _horizontalSpaceViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = kExplicitColor;
            [self.view addSubview:view];
            [_horizontalSpaceViewArray addObject:view];
        }
    }
    return _horizontalSpaceViewArray;
}

- (NSMutableArray *)horizontalWidthViewArray {
    if (!_horizontalWidthViewArray) {
        _horizontalWidthViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = kThemeColor;
            [self.view addSubview:view];
            [_horizontalWidthViewArray addObject:view];
        }
    }
    return _horizontalWidthViewArray;
}

- (NSMutableArray<UIView *> *)verticalSpaceViewArray {
    if (!_verticalSpaceViewArray) {
        _verticalSpaceViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = kExplicitColor;
            [self.view addSubview:view];
            [_verticalSpaceViewArray addObject:view];
        }
    }
    return _verticalSpaceViewArray;
}

- (NSMutableArray<UIView *> *)verticalWidthViewArray {
    if (!_verticalWidthViewArray) {
        _verticalWidthViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = kLightGrayColor;
            [self.view addSubview:view];
            [_verticalWidthViewArray addObject:view];
        }
    }
    return _verticalWidthViewArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
