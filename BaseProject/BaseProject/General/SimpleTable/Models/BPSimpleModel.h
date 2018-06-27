//
//  BPSimpleModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseModel.h"

//完成情况
typedef NS_ENUM(NSInteger, BPCompletePerformance) {
    BPCompletePerformanceNone,//没有开始写
    BPCompletePerformanceDoing,//在写
    BPCompletePerformanceWillDone,//将要完成
    BPCompletePerformanceDone//已完成
};

//重要程度
typedef NS_ENUM(NSInteger, BPImportance) {
    BPImportanceRegular,//一般的
    BPImportanceMedium,//中等的
    BPImportanceHigh,//重要的
};

@class BPBaseModel;

@interface BPSimpleModel : BPBaseModel
@property (nonatomic,copy)  NSString *title;
@property (nonatomic,copy)  NSString *fileName;
@property (nonatomic,strong)  NSArray *subVc_array;

//以下是非必需的字段
@property (nonatomic,copy)  NSString *dynamicJumpString;//动态跳转数据
@property (nonatomic,copy)  NSString *briefIntro; // 简短说明
@property (nonatomic,copy)  NSString *planIntro; //进度补充说明
@property (nonatomic,copy)  NSString *url;//web地址
@property (nonatomic,assign)  BPCompletePerformance completePerformance; //完成情况
@property (nonatomic,assign)  BPImportance importance; //涉及的知识重要程度
@end
