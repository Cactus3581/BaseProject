//
//  BPPresentBViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPresentBViewController.h"
#import "BPAppDelegate.h"
#import "BPPresentAViewController.h"
#import "BPPresentCViewController.h"

@interface BPPresentBViewController ()

@end

@implementation BPPresentBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kLightGrayColor;
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(100, 220, 44, 44);
    [backBtn setImage:[UIImage imageNamed:bp_naviItem_backImage] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismissViewControllerAnimated) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *pushBtn = [[UIButton alloc]init];
    pushBtn.frame = CGRectMake(150, 220, 44, 44);
    [pushBtn setImage:[UIImage imageNamed:bp_naviItem_backImage] forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
}

- (void)push {
    BPPresentCViewController *vc = [[BPPresentCViewController alloc] init];
    if (self.navigationController) {
        UINavigationController *navc = kAppDelegate.selectedNavigationController;
        if ([navc isEqual:self.navigationController]) {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else {
        UINavigationController *navc = kAppDelegate.selectedNavigationController;
        if ([navc isEqual:self.navigationController]) {
            [self.navigationController pushViewController:vc animated:YES];
        }
        [self.navigationController pushViewController:vc animated:YES];
        //[navc pushViewController:vc animated:YES];
    }
}

- (void)dismissViewControllerAnimated {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
