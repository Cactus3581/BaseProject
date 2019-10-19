//
//  BPDataManager.h
//  BaseProject
//
//  Created by Ryan on 2017/2/17.
//  Copyright © 2017年 Ryan. All rights reserved.
//

@interface BPDataManager : NSObject

+ (BPDataManager *)shareBPDataManager;

- (NSString *)getPath:(NSString *)pathName;

@end
