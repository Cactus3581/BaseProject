//
//  BPAutoModel.h
//  BaseProject
//
//  Created by Ryan on 2018/12/27.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BPAutoNestModel;
NS_ASSUME_NONNULL_BEGIN

@interface BPAutoModel : NSObject
@property (nonatomic, copy) NSArray *arrays;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, strong) BPAutoNestModel *nestModel;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, assign) BOOL iBool;
@end

@interface BPAutoNestModel : NSObject
@property (nonatomic, copy) NSArray *deepArrays;
@property (nonatomic, copy) NSDictionary *deepDict;
@property (nonatomic, copy) NSString *deepTitle;
@property (nonatomic, strong) NSNumber *deepNumber;
@property (nonatomic, assign) NSInteger deepInteger;
@property (nonatomic, assign) BOOL deepIBool;
@end

NS_ASSUME_NONNULL_END
