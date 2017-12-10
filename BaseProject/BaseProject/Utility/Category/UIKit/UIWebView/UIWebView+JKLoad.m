//
//  UIWebView+loadURL.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UIWebView+JKLoad.h"

@implementation UIWebView (JKLoad)
/**
 *  @brief  读取一个网页地址
 *
 *  @param URLString 网页地址
 */
- (void)bp_loadURL:(NSString*)URLString{
    NSString *encodedUrl = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes (NULL, (__bridge CFStringRef) URLString, NULL, NULL,kCFStringEncodingUTF8);
    NSURL *url = [NSURL URLWithString:encodedUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self loadRequest:req];
}
/**
 *  @brief  读取bundle中的webview
 *
 *  @param htmlName webview名称
 */
- (void)bp_loadLocalHtml:(NSString*)htmlName{
    [self bp_loadLocalHtml:htmlName inBundle:[NSBundle mainBundle]];
}
- (void)bp_loadLocalHtml:(NSString*)htmlName inBundle:(NSBundle*)inBundle{
    NSString *filePath = [inBundle pathForResource:htmlName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}
/**
 *  @brief  清空cookie
 */
- (void)bp_clearCookies
{
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    
    for (NSHTTPCookie *cookie in storage.cookies)
        [storage deleteCookie:cookie];
    
    [NSUserDefaults.standardUserDefaults synchronize];
}
@end
