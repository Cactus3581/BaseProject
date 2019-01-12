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
    NSString *_macbook;
    NSString *_iphone;
}

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSNumber *price;
@property (nonatomic,strong) BPKVCSubModel *subModel;
@end


@interface BPKVCSubModel : NSObject

@property (nonatomic,copy) NSString *lastName;
@property (nonatomic,strong) NSNumber *age;

@end
