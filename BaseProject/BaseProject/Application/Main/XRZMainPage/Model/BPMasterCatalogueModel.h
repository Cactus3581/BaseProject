//
//  BPMasterCatalogueModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/9.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPMasterCatalogueModel : NSObject
@property (nonatomic,copy)  NSString *title;
@property (nonatomic,copy)  NSString *fileName;
@property (nonatomic,copy)  NSString *briefIntro;

- (NSArray *)getArrayData;

@end
