//
//  UIWebView+JKLoadStatus.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIWebView+JKLoadInfo.h"
#import <objc/runtime.h>

static const void *k_bp_loadingCount = &k_bp_loadingCount;
static const void *k_bp_maxLoadCount = &k_bp_maxLoadCount;
static const void *k_bp_currentURL = &k_bp_currentURL;
static const void *k_bp_interactive = &k_bp_interactive;
static const void *k_bp_progress = &k_bp_progress;
static const void *k_bp_contentSize = &k_bp_contentSize;

static const void *k_bp_readyState = &k_bp_readyState;

static const void *k_bp_realDelegate = &k_bp_realDelegate;
static const void *k_bp_webViewLoadChangeBlock = &k_bp_webViewLoadChangeBlock;


NSString *bp_completeRPCURLPath = @"/bpwebviewprogressproxy/complete";

@implementation UIWebView (JKLoadStatus)
-(void)setBp_loadingCount:(NSUInteger)bp_loadingCount{
    NSNumber *number = [[NSNumber alloc]initWithInteger:bp_loadingCount];
    objc_setAssociatedObject(self,k_bp_loadingCount, number, OBJC_ASSOCIATION_ASSIGN);
}

-(NSUInteger)bp_loadingCount{
    return [objc_getAssociatedObject(self, k_bp_loadingCount) integerValue];
}

-(void)setBp_maxLoadCount:(NSUInteger)bp_maxLoadCount{
    NSNumber *number = [[NSNumber alloc]initWithInteger:bp_maxLoadCount];
    objc_setAssociatedObject(self,k_bp_maxLoadCount, number, OBJC_ASSOCIATION_ASSIGN);
}

-(NSUInteger)bp_maxLoadCount{
    return [objc_getAssociatedObject(self, k_bp_maxLoadCount) integerValue];
}

-(void)setBp_currentURL:(NSURL*)bp_currentURL{
    objc_setAssociatedObject(self,k_bp_currentURL, bp_currentURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSURL*)bp_currentURL{
    return objc_getAssociatedObject(self, k_bp_currentURL) ;
}

-(void)setBp_interactive:(BOOL)bp_interactive{
    NSNumber *number = [[NSNumber alloc]initWithBool:bp_interactive];
    objc_setAssociatedObject(self,k_bp_interactive, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)bp_interactive{
    return [objc_getAssociatedObject(self, k_bp_interactive) boolValue];
}

-(void)setBp_progress:(float)bp_progress{
    NSNumber *number = [[NSNumber alloc]initWithFloat:bp_progress];
    objc_setAssociatedObject(self,k_bp_progress, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)bp_progress{
    return [objc_getAssociatedObject(self, k_bp_progress) floatValue];
}

-(void)setBp_contentSize:(CGSize)bp_contentSize{
    objc_setAssociatedObject(self,k_bp_progress, NSStringFromCGSize(bp_contentSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGSize)bp_contentSize{
    return CGSizeFromString(objc_getAssociatedObject(self, k_bp_progress));
}

-(void)setBp_readyState:(JKReadyState)bp_readyState{
    objc_setAssociatedObject(self,k_bp_readyState, @(bp_readyState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(JKReadyState)bp_readyState{
    return (JKReadyState)[objc_getAssociatedObject(self, k_bp_readyState) integerValue];
}

-(void)setBp_realDelegate:(id<UIWebViewDelegate>)bp_realDelegate{
    objc_setAssociatedObject(self,k_bp_realDelegate, bp_realDelegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<UIWebViewDelegate>)bp_realDelegate{
    return objc_getAssociatedObject(self, k_bp_realDelegate);
}

-(void (^)(UIWebView *, float))bp_webViewLoadChangeBlock{
    return objc_getAssociatedObject(self, k_bp_webViewLoadChangeBlock);
}

- (void)setBp_webViewLoadChangeBlock:(bp_webViewLoadChangeBlock)bp_webViewLoadChangeBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, k_bp_webViewLoadChangeBlock, bp_webViewLoadChangeBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark --delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.path isEqualToString:bp_completeRPCURLPath]) {
        [self bp_completeProgress];
        return NO;
    }
    
    BOOL ret = YES;
    if ([self.bp_realDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        ret = [self.bp_realDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    BOOL isFragmentJump = NO;
    if (request.URL.fragment) {
        NSString *nonFragmentURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:request.URL.fragment] withString:@""];
        isFragmentJump = [nonFragmentURL isEqualToString:webView.request.URL.absoluteString];
    }
    
    BOOL isTopLevelNavigation = [request.mainDocumentURL isEqual:request.URL];
    
    BOOL isHTTPOrLocalFile = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"file"];
    if (ret && !isFragmentJump && isHTTPOrLocalFile && isTopLevelNavigation) {
        self.bp_currentURL = request.URL;
        [self bp_reset];
    }
    return ret;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.bp_readyState = BP_JKReadyState_loading;

    if ([self.bp_realDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.bp_realDelegate webViewDidStartLoad:webView];
    }
    
    self.bp_loadingCount++;
    self.bp_maxLoadCount = fmax(self.bp_maxLoadCount, self.bp_loadingCount);
    [self bp_startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.bp_realDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.bp_realDelegate webViewDidFinishLoad:webView];
    }
   
    self.bp_loadingCount--;
    [self bp_incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        self.bp_interactive = YES;
        self.bp_readyState = BP_JKReadyState_interactive;
        
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, bp_completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = self.bp_currentURL && [self.bp_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect) {
        [self bp_completeProgress];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([self.bp_realDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.bp_realDelegate webView:webView didFailLoadWithError:error];
    }
    
    self.bp_loadingCount--;
    [self bp_incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        self.bp_interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, bp_completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = self.bp_currentURL && [self.bp_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if ((complete && isNotRedirect) || error) {
        [self bp_completeProgress];
    }
}

- (void)bp_startProgress
{
    if (self.bp_progress < 0.1) {
        [self bp_updateProgress:0.1];
    }
}
- (void)bp_incrementProgress
{
    float progress = self.bp_progress;
    float maxProgress = self.bp_interactive ? 0.9 : 0.5f;
    float remainPercent = (float)self.bp_loadingCount / (float)self.bp_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self bp_updateProgress:progress];
}

- (void)bp_completeProgress
{
    self.bp_readyState = BP_JKReadyState_complete;
    [self bp_updateProgress:1.0];
//    CGFloat webViewHeight= [[self stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]floatValue];
//    NSLog(@"body.offsetHeight:%lf",webViewHeight);
//    
//    CGFloat webViewHeight2=self.scrollView.contentSize.height;
//    NSLog(@"scrollView contentSize:%lf",webViewHeight2);
}

- (void)bp_updateProgress:(float)progress
{
    if (progress > self.bp_progress || progress == 0) {
        self.bp_progress = progress;
        if (self.bp_webViewLoadChangeBlock) {
           self.bp_webViewLoadChangeBlock(self,progress,self.scrollView.contentSize);
        }
    }
}
- (void)bp_reset
{
    self.bp_maxLoadCount = self.bp_loadingCount = 0;
    self.bp_interactive = NO;
    [self bp_updateProgress:0.0];
    self.bp_readyState = BP_JKReadyState_uninitialized;
}
//会影响未包含头文件的webview
//-(void)awakeFromNib{
//    [super awakeFromNib];
//    [self bp_setDelegateIfNoDelegateSet];
//}
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self bp_setDelegateIfNoDelegateSet];
//    }
//    return self;
//}
#pragma mark - Delegate Forwarder
- (void)bp_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UIWebViewDelegate>)self) {
        self.bp_realDelegate  = self.delegate;
        self.delegate = (id<UIWebViewDelegate>)self;
    }
}


//- (void)setDelegate:(id<UIWebViewDelegate>)delegate {
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0){
//        // UIScrollView delegate keeps some flags that mark whether the delegate implements some methods (like scrollViewDidScroll:)
//        // setting *the same* delegate doesn't recheck the flags, so it's better to simply nil the previous delegate out
//        // we have to setup the realDelegate at first, since the flag check happens in setter
////        [super setDelegate:nil];
////        self.delegate = nil;
//        self.bp_realDelegate = delegate != self ? delegate : nil;
////        [super setDelegate:delegate ? self : nil];
//        self.delegate = delegate ? self : nil;
//        
//    }else {
////        [super setDelegate:delegate];
////        self.delegate = delegate;
//
//    }
//}

//- (BOOL)respondsToSelector:(SEL)selector {
//    return [super respondsToSelector:selector] || [self.bp_realDelegate respondsToSelector:selector];
//}
//- (id)forwardingTargetForSelector:(SEL)selector {
//    id delegate = self.bp_realDelegate;
//    return [delegate respondsToSelector:selector] ? delegate : [super forwardingTargetForSelector:selector];
//}
@end
