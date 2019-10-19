//
//  BPMapTableViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPMapTableViewController.h"

@interface BPMapTableViewController ()
@property (nonatomic,strong) NSMapTable *map;
@property (nonatomic,strong) NSMapTable *map1;
@property (nonatomic,strong) NSArray *array;
@end

@implementation BPMapTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMapTable *map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    self.map = map;
    NSString *str = @"value"; // 常量，并不会释放
    [map setObject:str forKey:@"key"];
    
    NSMapTable *map1 = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    self.map1 = map1;// 堆,会释放
    [map1 setObject:@[@"value"] forKey:@"key"];
    
    self.array = @[@"array"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BPLog(@"map = %@",self.map)
    BPLog(@"map1 = %@",self.map1)
    BPLog(@"array = %@",self.array)
}

@end
