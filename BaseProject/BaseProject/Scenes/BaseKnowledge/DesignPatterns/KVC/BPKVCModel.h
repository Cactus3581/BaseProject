//
//  BPKVCModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/4/7.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BPKVCSubModel;

@interface BPKVCModel : NSObject {
    // 用于查找key
    NSString *_isNoSetter;
}

@property (nonatomic,copy) NSString *normalKey;

// 用于集合操作
@property (nonatomic,strong) NSNumber *numberKey;

// KVC也可以访问基础数据类型、用于测试异常处理
@property (nonatomic,assign) NSInteger intKey;

// 用于keypath
@property (nonatomic,strong) BPKVCSubModel *subModel;


// 找不到key时候的操作
@property (nonatomic,copy) NSString *userId;

// 对集合的操作
@property (nonatomic,strong) NSMutableArray *muArray;

@end


@interface BPKVCSubModel : NSObject

@property (nonatomic,copy) NSString *sublKey;

@end
