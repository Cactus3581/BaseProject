//
//  BPEqualHashViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/1/18.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPEqualHashViewController.h"
#import "EqualHashModel.h"

@interface BPEqualHashViewController ()

@end

@implementation BPEqualHashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
    [self test2];
}

- (void)test2 {
    EqualHashModel *model1 = [[EqualHashModel alloc] init];
    EqualHashModel *model2 = [[EqualHashModel alloc] init];
    
    model1.var1 = @"A";
    model2.var1 = @"A";
    model2.var2 = @"B";
    model2.var2 = @"B";
    
    BOOL result = [model1 isEqual:model2];
    
    NSLog(@"isEqual = %d",result);
    
    NSMutableSet *set = [NSMutableSet set];
    [set addObject:model1];
    [set addObject:model2];
    NSLog(@"集合（SET） count = %lu", (unsigned long)set.count);
}

- (void)test1 {
    
    NSString *str1 = @"a";
    NSString *str2 = @"a";
    
    NSNumber *number1 = @(1);
    NSNumber *number2 = @(1);
    
    
    NSArray *array = @[str1,number1];
    
    BPLog(@"%d,%d,%d,%d",[str1 isEqual:str2],[number1 isEqual:number2],[array containsObject:str2],[array containsObject:number2]);
}

@end
