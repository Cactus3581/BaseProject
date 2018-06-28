//
//  BPBaseWebViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"
#import <WebKit/WebKit.h>

@interface BPBaseWebViewController : BPBaseViewController<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,weak) WKWebView *webView;

@property (copy, nonatomic) NSString *url;

- (void)loadUrl:(NSString *)url;

@end
