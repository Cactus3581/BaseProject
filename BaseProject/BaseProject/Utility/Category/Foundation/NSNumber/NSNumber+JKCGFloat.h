
//
//  NSNumber+CGFloat.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (JKCGFloat)

- (CGFloat)jk_CGFloatValue;

- (id)initWithJKCGFloat:(CGFloat)value;

+ (NSNumber *)jk_numberWithCGFloat:(CGFloat)value;

@end
