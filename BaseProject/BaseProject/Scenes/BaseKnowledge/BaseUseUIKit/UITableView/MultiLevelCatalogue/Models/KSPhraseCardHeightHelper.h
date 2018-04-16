//
//  KSPhraseCardHeightHelper.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSMultiLevelCatalogueModel.h"

@interface KSPhraseCardHeightHelper : NSObject
+ (void)handleData:(KSMultiLevelCatalogueModel *)data successblock:(dispatch_block_t)succeed;
+ (void)handleData:(KSMultiLevelCatalogueModel *)data;
@end
