//
//  BPDownLoadDataSource.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPAudioModel.h"

@interface BPDownLoadDataSource : NSObject

+ (NSArray *)downLoadMoreDataSource;


+ (BPAudioModel *)downLoadOneDataSourceWithIndex:(NSInteger)index;

+ (BPAudioModel *)downLoadRanDomOneDataSource;

@end
