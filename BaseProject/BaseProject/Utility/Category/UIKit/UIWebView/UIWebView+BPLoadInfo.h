//
//  UIWebView+BPLoadInfo.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, BPReadyState) {
    BP_BPReadyState_uninitialized = 0, //还未开始载入
    BP_BPReadyState_loading,      //载入中
    BP_BPReadyState_interactive, //已加载，文档与用户可以开始交互
    BP_BPReadyState_complete    //载入完成

};
typedef void(^bp_webViewLoadChangeBlock)(UIWebView *webView,float progress,CGSize contentSize);

@interface UIWebView (BPLoadInfo)<UIWebViewDelegate>
@property (nonatomic, readonly) float bp_progress; // 0.0..1.0
@property (nonatomic, readonly) CGSize bp_contentSize;
@property (nonatomic, readonly) BPReadyState bp_readyState;
@property (copy, nonatomic)     bp_webViewLoadChangeBlock bp_webViewLoadChangeBlock;

-(void)setBp_webViewLoadChangeBlock:(bp_webViewLoadChangeBlock)bp_webViewLoadChangeBlock;
@end
