//
//  BPDesignPatternsSingleClass.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPDesignPatternsSingleClass : NSObject

+ (BPDesignPatternsSingleClass *)shareSingleClass;

+ (BPDesignPatternsSingleClass *)shareSingleClassB;

@end
