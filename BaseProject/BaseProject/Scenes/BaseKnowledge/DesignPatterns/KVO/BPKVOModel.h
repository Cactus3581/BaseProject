//
//  BPKVOModel.h
//  BaseProject
//
//  Created by Ryan on 2019/1/8.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPKVODependModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKVOModel : NSObject {
    NSString *_testNormalIvar;
    NSString *_manualImplementSetterIvar;
@public
    NSString *_testPublicIvar;
}

@property (nonatomic,copy) NSString *testNormalProperty;
@property (nonatomic,copy) NSString *testDynamic;
@property (nonatomic,copy) NSString *testForbidLock;
@property (nonatomic,copy) NSString *testRepeatKVO;

@property (nonatomic, copy) NSString *dependProperty;
@property (nonatomic, strong) BPKVODependModel *dependModel;

// 对集合的操作
@property (nonatomic,strong) NSMutableArray *muArray;

- (void)changeIphone:(NSString *)iphone;

@end
NS_ASSUME_NONNULL_END
