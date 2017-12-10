//
//  UIScrollView+BPPages.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (BPPages)
- (NSInteger)bp_pages;
- (NSInteger)bp_currentPage;
- (CGFloat)bp_scrollPercent;

- (CGFloat)bp_pagesY;
- (CGFloat)bp_pagesX;
- (CGFloat)bp_currentPageY;
- (CGFloat)bp_currentPageX;
- (void)bp_setPageY:(CGFloat)page;
- (void)bp_setPageX:(CGFloat)page;
- (void)bp_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)bp_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
