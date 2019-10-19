//
//  BPCustomTransitonViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/9/4.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPCustomTransitonViewController.h"

@interface BPCustomTransitonViewController ()

@property (weak, nonatomic) IBOutlet UIView *animationView;

@end


@implementation BPCustomTransitonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self springAnimation];
            }
                break;
        }
    }
}

#pragma mark - 
- (void)springAnimation {
    
}

@end
