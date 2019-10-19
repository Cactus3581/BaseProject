//
//  BPResponderViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/7/5.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPResponderViewController.h"
#import "BPResponder.h"

@interface BPResponderViewController ()
@property (nonatomic,strong) BPResponder *responder;
@end

@implementation BPResponderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_responder isFirstResponder];
    [_responder nextResponder];
    [_responder canBecomeFirstResponder];
    [_responder becomeFirstResponder];
    [_responder canResignFirstResponder];
    [_responder resignFirstResponder];
    [_responder touchesBegan:@[] withEvent:nil];
}

@end
