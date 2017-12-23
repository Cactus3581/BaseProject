
//
//  NSNumber+CGFloat.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (BPCGFloat)

- (CGFloat)_CGFloatValue;

- (id)initWithBPCGFloat:(CGFloat)value;

+ (NSNumber *)_numberWithCGFloat:(CGFloat)value;

@end
