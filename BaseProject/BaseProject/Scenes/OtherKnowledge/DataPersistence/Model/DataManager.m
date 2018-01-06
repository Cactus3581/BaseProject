//
//  DataManager.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/17.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "DataManager.h"
static DataManager *manager = nil;

@implementation DataManager


+ (DataManager *)shareDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc]init];
    });
    
//    @synchronized(self){
//        if (manager == nil) {
//            //            创建
//            manager = [[DataManager alloc]init];
//        }
//        
//    }
    
    return manager;
}


- (NSString *)getPath:(NSString *)pathName
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documentsPath stringByAppendingPathComponent:pathName];
    BPLog(@"%@",path);
    
    return path;
    
}


+ (void)setUserDefaultsValue:(id)value key:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
    
    //重置清零
//    [NSUserDefaults resetStandardUserDefaults];
    
    
}

+ (id)objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
