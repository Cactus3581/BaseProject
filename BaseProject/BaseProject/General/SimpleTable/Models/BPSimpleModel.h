//
//  BPSimpleModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseModel.h"
@class BPBaseModel;

@interface BPSimpleModel : BPBaseModel
@property (nonatomic,copy)  NSString *title;
@property (nonatomic,copy)  NSString *fileName;
@property (nonatomic,copy)  NSString *briefIntro;
@property (nonatomic,strong)  NSArray *subVc_array;
@end
