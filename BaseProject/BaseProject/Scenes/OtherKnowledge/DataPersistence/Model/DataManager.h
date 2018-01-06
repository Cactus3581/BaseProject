//
//  DataManager.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/17.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//



@interface DataManager : NSObject
+ (DataManager *)shareDataManager;
- (NSString *)getPath:(NSString *)pathName;

@end
