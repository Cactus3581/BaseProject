//
//  BP1STManualHeightHelper.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPMultiLevelCatalogueModel.h"

@interface BP1STManualHeightHelper : NSObject
+ (void)handleData:(BPMultiLevelCatalogueModel *)data successblock:(dispatch_block_t)succeed;
+ (void)handleData:(BPMultiLevelCatalogueModel *)data;
@end
