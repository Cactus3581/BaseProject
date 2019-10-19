//
//  BPPushViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/5/3.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPPushViewController.h"
#import "BPPushChildViewController.h"

@interface BPPushViewController ()

@property (nonatomic,weak) UIViewController *subVc;

@end

@implementation BPPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        
        switch (type) {
                
            case 0:{
                [self removeVC];
            }
                break;
                
            case 1:{
                [self addChildViewControllerInViewByCustomController];
            }
                break;
        }
    }
}

- (void)removeVC {
    
}

- (void)addChildViewControllerInViewByCustomController {
    BPPushChildViewController *subVc = [[BPPushChildViewController alloc] init];
    _subVc = subVc;
    subVc.view.backgroundColor = kExplicitColor;
    [self addChildViewController:subVc];
    [self.view addSubview:subVc.view];
    subVc.view.frame = self.view.bounds;
    [subVc didMoveToParentViewController:self];
}

@end
