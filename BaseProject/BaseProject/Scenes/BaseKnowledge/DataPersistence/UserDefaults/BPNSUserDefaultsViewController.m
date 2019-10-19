//
//  BPNSUserDefaultsViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/12/26.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPNSUserDefaultsViewController.h"

@interface BPNSUserDefaultsViewController ()

@end

@implementation BPNSUserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:@"BPNSUserDefaultsViewController"];
    
    BPLog(@"value = %@",value);
    
    if(!value) {
        NSLog(@"没有这个 key");
    }

    // 相当于以上的判断：如果之前还没在NSUserDefaults中设置key，直接获取key，是不存在value的；
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"BPNSUserDefaultsViewController":@"1"}];

    BPLog(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"BPNSUserDefaultsViewController"]);
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"BPNSUserDefaultsViewController"];
    BPLog(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"BPNSUserDefaultsViewController"]);
}

@end
