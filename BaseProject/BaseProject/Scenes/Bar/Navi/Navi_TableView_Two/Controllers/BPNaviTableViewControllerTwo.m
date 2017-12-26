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
#import "BPAppInfoMacro.h"

@interface BPNaviTableViewControllerTwo ()<UITableViewDataSource, UITabBarDelegate, UIScrollViewDelegate>

@end

@implementation BPNaviTableViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];    
//    self.navigationController.hideBottomLine = YES;
    //self.navigationItem.bp_leftMargin = 150;
//    self.navigationController.customBackImage = [UIImage imageNamed:bp_naviItem_backImage];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    if (kiOS11) {
        //self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 100);
    }
    BPLog(@"%@",NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets));
    BPLog(@"%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

