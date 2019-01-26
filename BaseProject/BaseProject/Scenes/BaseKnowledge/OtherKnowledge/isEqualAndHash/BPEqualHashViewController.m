//
//  BPEqualHashViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/18.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPEqualHashViewController.h"
#import "EqualHashModel.h"

@interface BPEqualHashViewController ()

@end

@implementation BPEqualHashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
