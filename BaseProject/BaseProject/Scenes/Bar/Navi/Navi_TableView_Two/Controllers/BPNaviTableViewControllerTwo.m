//
//  BPNaviTableViewControllerTwo.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/11.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPNaviTableViewControllerTwo.h"
#import <Masonry.h>
//#import "UINavigationItem+BPMargin.h"
#import "UINavigationController+BPAdd.h"
#import "UIBarButtonItem+BPBadge.h"
#import "UIBarButtonItem+BPCreate.h"
#import "BPAppInfoMacro.h"

@interface BPNaviTableViewControllerTwo ()<UITableViewDataSource, UITabBarDelegate, UIScrollViewDelegate>

@end

@implementation BPNaviTableViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];    
//    self.navigationController.hideBottomLine = YES;
    //self.navigationItem.bp_leftMargin = 150;
//    self.navigationController.customBackImage = [UIImage imageNamed:@"navi_back"];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(popAction) image:[UIImage imageNamed:@"navi_back"]];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    if (kiOS11) {
        //self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 100);
    }
    BPLog(@"%@",NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets));
    BPLog(@"%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
}

- (void)popAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

