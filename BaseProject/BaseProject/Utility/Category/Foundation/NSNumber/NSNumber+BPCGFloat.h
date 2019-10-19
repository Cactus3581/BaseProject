
//
//  NSNumber+CGFloat.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (BPCGFloat)

- (CGFloat)_CGFloatValue;

- (instancetype)initWithBPCGFloat:(CGFloat)value;

+ (NSNumber *)_numberWithCGFloat:(CGFloat)value;

@end
