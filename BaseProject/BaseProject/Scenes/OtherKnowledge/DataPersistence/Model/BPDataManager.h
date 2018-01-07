//
//  BPDataManager.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/17.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

@interface BPDataManager : NSObject

+ (BPDataManager *)shareBPDataManager;

- (NSString *)getPath:(NSString *)pathName;

@end
