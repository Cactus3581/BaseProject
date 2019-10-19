//
//  BPTagAutoLayoutView.h
//  BaseProject
//
//  Created by Ryan on 2018/5/18.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BPTagAutoLayoutView;

@protocol BPTagAutoLayoutViewDelegate <NSObject>
@optional
- (void)tagLabelView:(BPTagAutoLayoutView *)tagLabelView didSelectRowAtIndex:(NSInteger)index;
@end

@interface BPTagAutoLayoutView : UIView

@property (nonatomic,strong) NSArray <NSString *>*titlesArray;
@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGFloat interval;

@property (nonatomic,assign) UIEdgeInsets contentInsets;
@property (nonatomic,assign) CGFloat horizontalSpacing;
@property (nonatomic,assign) CGFloat verticalSpacing;
@property (nonatomic,assign) CGFloat itemHeight;

@property (nonatomic,assign) BOOL shouldCorner;

@property (nonatomic,assign) BOOL shouldBorder;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,strong) UIColor *selectedBorderColor;

@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIFont *selectedFont;

@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *selectedTextColor;

@property (nonatomic,strong) UIColor *itemBackgroundColor;
@property (nonatomic,strong) UIColor *itemSelectedBackgroundColor;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,weak) id <BPTagAutoLayoutViewDelegate> delegate;

- (UIButton *)viewAtIndex:(NSInteger)index;
- (NSInteger)indexOfObject:(UIButton *)button;

- (void)reloadData;

- (void)removeStatus;

@end
