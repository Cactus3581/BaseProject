//
//  BPBaseWebViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseWebViewController.h"

@interface BPBaseWebViewController ()

@end

@implementation BPBaseWebViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configRightBarButtomItem];
    WKWebView *webView = [[WKWebView alloc] init];
    _webView = webView;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    if (self.url) {
        [self loadUrl:self.url];
    }
}

#pragma mark - config rightBarButtonItem
- (void)configRightBarButtomItem {
    UIView *view = [[UIView alloc] init];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTintColor:kWhiteColor];
    [rightBarButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton setTitle:@"copy" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font  = BPFont(16);
    [rightBarButton addTarget:self action:@selector(copyEvent) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton sizeToFit];
    rightBarButton.frame = CGRectMake(CGRectGetMinX(rightBarButton.frame), 0, CGRectGetWidth(rightBarButton.bounds), bp_naviItem_height);
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    UIButton *rightBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton1 setTintColor:kWhiteColor];
    [rightBarButton1 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton1 setTitle:@"share" forState:UIControlStateNormal];
    rightBarButton1.titleLabel.font  = BPFont(16);
    [rightBarButton1 addTarget:self action:@selector(shareEvent) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton1.frame = CGRectMake(CGRectGetMaxX(rightBarButton.frame)+10, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton1 sizeToFit];
    rightBarButton1.frame = CGRectMake(CGRectGetMinX(rightBarButton1.frame), 0, CGRectGetWidth(rightBarButton1.bounds), bp_naviItem_height);
    rightBarButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    [view addSubview:rightBarButton];
    [view addSubview:rightBarButton1];
    
    view.frame = CGRectMake(0, 0, rightBarButton.width+10+rightBarButton1.width+5, bp_naviItem_height);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

- (void)copyEvent {
    BPLog(@"url = %@",self.url)
}

- (void)shareEvent {
    
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.webView.scrollView.contentInset = BPSafeAreaInset(self.view);
}

- (void)loadUrl:(NSString *)url {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.view bp_makeToastActivity];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.view bp_hideToastActivity];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self.view bp_hideToastActivity];
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    BPLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    BPLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}

// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}

// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    BPLog(@"%@",message);
    completionHandler();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
