//
//  BPIsMemberOfClassViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/2/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPIsMemberOfClassViewController.h"
#import "BPIsMemberOfClassModel.h"

@interface BPIsMemberOfClassViewController ()

@end

@implementation BPIsMemberOfClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSObject class] isKindOfClass:[NSObject class]];
    [[NSObject class] isMemberOfClass:[NSObject class]];
    
    [[UIViewController class] isKindOfClass:[UIViewController class]];
    [[UIViewController class] isMemberOfClass:[UIViewController class]];
    
    [[BPIsMemberOfClassModel class] isKindOfClass:[BPIsMemberOfClassModel class]];
    [[BPIsMemberOfClassModel class] isMemberOfClass:[BPIsMemberOfClassModel class]];
    
    BPIsMemberOfClassModel *model = [[BPIsMemberOfClassModel alloc] init];
    [model isKindOfClass:[BPIsMemberOfClassModel class]];
    [model isMemberOfClass:[BPIsMemberOfClassModel class]];

    BPLog(@"NSObject %d,%d",[[NSObject class] isKindOfClass:[NSObject class]],[[NSObject class] isMemberOfClass:[NSObject class]]); // 1,0
    BPLog(@"UIViewController %d,%d",[[UIViewController class] isKindOfClass:[UIViewController class]],[[UIViewController class] isMemberOfClass:[UIViewController class]]); // 0,0
    BPLog(@"BPIsMemberOfClassModel %d,%d",[[BPIsMemberOfClassModel class] isKindOfClass:[BPIsMemberOfClassModel class]],[[BPIsMemberOfClassModel class] isMemberOfClass:[BPIsMemberOfClassModel class]]); // 0,0
}

@end
