//
//  NSNumber+BPAdd.h
//  CatergoryDemo
//
//  Created by xiaruzhen on 16/5/13.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (BPAdd)

/**将NSString数字字符串转成NSNumber，如果满足规则返回想要值，不满足返回nil*/
+ (nullable NSNumber *)bp_numberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
