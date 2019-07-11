//
//  BPSizeClassViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/28.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSizeClassViewController.h"

@interface BPSizeClassViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *ipadButton;

@end

@implementation BPSizeClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonAvtion:(id)sender {
    BPLog(@"iPhone")
}


@end
