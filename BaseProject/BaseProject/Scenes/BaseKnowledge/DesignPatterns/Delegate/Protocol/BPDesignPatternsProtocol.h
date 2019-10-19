//
//  BPDesignPatternsProtocol.h
//  BaseProject
//
//  Created by Ryan on 2019/7/25.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//创建协议
@protocol BPDesignPatternsProtocol <NSObject>

//声明方法

//默认就是required;
@required
- (void)requiredMethod;

@optional
- (void)optionalMethod;
- (NSString *)useDelegate:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
