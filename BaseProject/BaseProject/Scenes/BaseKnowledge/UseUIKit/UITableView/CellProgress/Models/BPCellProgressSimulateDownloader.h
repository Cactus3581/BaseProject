//
//  BPCellProgressSimulateDownloader.h
//  BaseProject
//
//  Created by Ryan on 2018/3/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPCellProgressModel.h"

@interface BPCellProgressSimulateDownloader : NSObject
@property (nonatomic, strong)   BPCellProgressModel *model;
- (void)startDownload:(BPCellProgressModel *)model;

- (void)downLoadTimer;
@end
