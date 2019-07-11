//
//  BPPlistViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/9.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPPlistViewController.h"

#import "BPDataManager.h"

@implementation BPPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - NSString_plist
- (void)setNSString_plist {
    NSString *str = @"NSString_path";
    NSString *path = [[BPDataManager shareBPDataManager] getPath:@"str.plist"];
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [self getNSString_plist];
}

- (void)getNSString_plist {
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"str.plist"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    BPLog(@"%@",str);
}

#pragma mark - NSArray_plist
- (void)setNSArray_plist {
    NSArray *array = @[@"plist_a",@"plist_b",@"plist_c"];
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"array_plist.plist"];
    [array writeToFile:path atomically:YES];
    [self getNSArray_plist];
}

- (void)getNSArray_plist {
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"array_plist.plist"];
    //解析文件就好
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    BPLog(@"%@",array);
}

#pragma mark - NSString_plist
- (void)setDic_plist {
    NSDictionary *dic = @{
                          @"a":@"A",
                          @"b":@"B",
                          @"c":@"C",
                          };
    NSString *path = [[BPDataManager shareBPDataManager] getPath:@"dic.plist"];
    [dic writeToFile:path atomically:YES];
    [self getDic_plist];
}

- (void)getDic_plist {
    NSString *path = [[BPDataManager shareBPDataManager] getPath:@"dic.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    [dic setObject:@"d" forKey:@"a"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

@end
