//
//  BPDataManager.m
//  BaseProject
//
//  Created by Ryan on 2017/2/17.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPDataManager.h"

static BPDataManager *manager = nil;
@implementation BPDataManager

+ (BPDataManager *)shareBPDataManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BPDataManager alloc]init];
    });
    return manager;
}


- (NSString *)getPath:(NSString *)pathName  {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documentsPath stringByAppendingPathComponent:pathName];
    BPLog(@"%@",path);
    return path;
}

+ (void)setUserDefaultsValue:(id)value key:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
    //重置清零？同步变化Default中，并且释放内存中的值？
//    [NSUserDefaults resetStandardUserDefaults];
}

+ (id)objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
