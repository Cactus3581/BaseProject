//
//  BPDesignPatternsDelegateViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsDelegateViewController.h"
#import "UIWebView+BPHookDelegate.h"
#import "BPDesignPatternsProtocolModel.h"
#import "BPMultiDelegateCenter.h"
#import "BPDesignPatternsTwoDelegateViewController.h"

@interface BPDesignPatternsDelegateViewController ()<BPDesignPatternsProtocol,UIWebViewDelegate>

@property (nonatomic,strong) BPDesignPatternsTwoDelegateViewController *vc1;

@end


@implementation BPDesignPatternsDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self baseUse];
            }
                break;
                
            case 1:{
                [self hookDelegate];
            }
                break;
                
            case 2:{
                [self multicastDelegate];
            }
                break;
        }
    }
}

#pragma mark - base use
- (void)baseUse {
    BPDesignPatternsProtocolModel *model = [[BPDesignPatternsProtocolModel alloc] init];
    
    if ([model conformsToProtocol:@protocol(BPDesignPatternsProtocol)]) {
        [model requiredMethod];
    }
    
    if ([model conformsToProtocol:@protocol(BPDesignPatternsProtocol)]) {
        [model optionalMethod];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(useDelegate:)]) {
        NSString *str = [_delegate useDelegate:@"delagete"];
        BPLog(@"%@",str);
    }
}

#pragma mark - Hook Delegate
- (void)hookDelegate {
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webview];
    [webview setDelegate:self];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    BPLog(@"webViewDidFinishLoad");
}

#pragma mark - 多播传播
- (void)multicastDelegate {
    [BPMultiDelegateCenter shareCenter].delegate = self;
    [[BPMultiDelegateCenter shareCenter] removeDelegate:self];

    _vc1 = [[BPDesignPatternsTwoDelegateViewController alloc] init];
    [BPMultiDelegateCenter shareCenter].delegate = _vc1;
}

- (void)requiredMethod {
    BPLog(@"requiredMethod - 1");
}

- (void)optionalMethod {
    BPLog(@"optionalMethod - 1");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[BPMultiDelegateCenter shareCenter] test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
