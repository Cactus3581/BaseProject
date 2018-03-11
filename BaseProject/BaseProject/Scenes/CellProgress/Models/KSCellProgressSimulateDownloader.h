//
//  KSCellProgressSimulateDownloader.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCellProgressModel.h"

@interface KSCellProgressSimulateDownloader : NSObject
@property (nonatomic, strong)   KSCellProgressModel *model;
- (void)startDownload:(KSCellProgressModel *)model;

- (void)downLoadTimer;
@end
