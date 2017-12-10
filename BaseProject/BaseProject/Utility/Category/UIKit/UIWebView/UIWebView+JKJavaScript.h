//
//  UIWebView+JS.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JKJavaScript)

#pragma mark -
#pragma mark 获取网页中的数据
/// 获取某个标签的结点个数
- (int)bp_nodeCountOfTag:(NSString *)tag;
/// 获取当前页面URL
- (NSString *)bp_getCurrentURL;
/// 获取标题
- (NSString *)bp_getTitle;
/// 获取图片
- (NSArray *)bp_getImgs;
/// 获取当前页面所有链接
- (NSArray *)bp_getOnClicks;
#pragma mark -
#pragma mark 改变网页样式和行为
/// 改变背景颜色
- (void)bp_setBackgroundColor:(UIColor *)color;
/// 为所有图片添加点击事件(网页中有些图片添加无效)
- (void)bp_addClickEventOnImg;
/// 改变所有图像的宽度
- (void)bp_setImgWidth:(int)size;
/// 改变所有图像的高度
- (void)bp_setImgHeight:(int)size;
/// 改变指定标签的字体颜色
- (void)bp_setFontColor:(UIColor *) color withTag:(NSString *)tagName;
/// 改变指定标签的字体大小
- (void)bp_setFontSize:(int) size withTag:(NSString *)tagName;

#pragma mark 删除
///根据 ElementsID 删除WebView 中的节点
- (void )bp_deleteNodeByElementID:(NSString *)elementID;
/// 根据 ElementsClass 删除 WebView 中的节点
- (void )bp_deleteNodeByElementClass:(NSString *)elementClass;
///根据  TagName 删除 WebView 的节点
- (void)bp_deleteNodeByTagName:(NSString *)elementTagName;

@end
