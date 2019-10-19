//
//  UIWebView+Blocks.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIWebView+BPBlocks.h"

static void (^__bp_loadedBlock)(UIWebView *webView);
static void (^__bp_failureBlock)(UIWebView *webView, NSError *error);
static void (^__bp_loadStartedBlock)(UIWebView *webView);
static BOOL (^__bp_shouldLoadBlock)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType);

static uint __bp_loadedWebItems;

@implementation UIWebView (BPBlock)

#pragma mark - UIWebView+Blocks

+ (UIWebView *)bp_loadRequest:(NSURLRequest *)request
                   loaded:(void (^)(UIWebView *webView))loadedBlock
                   failed:(void (^)(UIWebView *webView, NSError *error))failureBlock{

    return [self bp_loadRequest:request loaded:loadedBlock failed:failureBlock loadStarted:nil shouldLoad:nil];
}

+ (UIWebView *)bp_loadHTMLString:(NSString *)htmlString
                      loaded:(void (^)(UIWebView *webView))loadedBlock
                      failed:(void (^)(UIWebView *webView, NSError *error))failureBlock{
    
    return [self bp_loadHTMLString:htmlString loaded:loadedBlock failed:failureBlock loadStarted:nil shouldLoad:nil];
}

+ (UIWebView *)bp_loadHTMLString:(NSString *)htmlString
                      loaded:(void (^)(UIWebView *))loadedBlock
                      failed:(void (^)(UIWebView *, NSError *))failureBlock
                 loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
                  shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock{
    __bp_loadedWebItems = 0;
    __bp_loadedBlock = loadedBlock;
    __bp_failureBlock = failureBlock;
    __bp_loadStartedBlock = loadStartedBlock;
    __bp_shouldLoadBlock = shouldLoadBlock;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = (id)[self class];
    [webView loadHTMLString:htmlString baseURL:nil];
    
    return webView;
}

+ (UIWebView *)bp_loadRequest:(NSURLRequest *)request
                   loaded:(void (^)(UIWebView *webView))loadedBlock
                   failed:(void (^)(UIWebView *webView, NSError *error))failureBlock
              loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
               shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock{
    __bp_loadedWebItems    = 0;
    
    __bp_loadedBlock       = loadedBlock;
    __bp_failureBlock      = failureBlock;
    __bp_loadStartedBlock  = loadStartedBlock;
    __bp_shouldLoadBlock   = shouldLoadBlock;
    
    UIWebView *webView  = [[UIWebView alloc] init];
    webView.delegate    = (id) [self class];
    
    [webView loadRequest: request];
    
    return webView;
}

#pragma mark - Private Static delegate
+ (void)webViewDidFinishLoad:(UIWebView *)webView{
    __bp_loadedWebItems--;
    
    if(__bp_loadedBlock && (!TRUE_END_REPORT || __bp_loadedWebItems == 0)){
        __bp_loadedWebItems = 0;
        __bp_loadedBlock(webView);
    }
}

+ (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{    
    __bp_loadedWebItems--;
    
    if(__bp_failureBlock)
        __bp_failureBlock(webView, error);
}

+ (void)webViewDidStartLoad:(UIWebView *)webView{    
    __bp_loadedWebItems++;
    
    if(__bp_loadStartedBlock && (!TRUE_END_REPORT || __bp_loadedWebItems > 0))
        __bp_loadStartedBlock(webView);
}

+ (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if(__bp_shouldLoadBlock)
        return __bp_shouldLoadBlock(webView, request, navigationType);
    
    return YES;
}

@end
