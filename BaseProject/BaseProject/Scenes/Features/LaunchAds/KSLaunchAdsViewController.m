//
//  KSLaunchAdsViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/27.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSLaunchAdsViewController.h"

@interface KSLaunchAdsViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end


@implementation KSLaunchAdsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我是广告";
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.view addSubview:self.webView];
}

@end
