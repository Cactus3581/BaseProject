//
//  BPClassObjectMethod.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/24.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPClassObjectMethod : NSObject

@property (nonatomic,copy) NSString *title;

+ (void) classMethod;

- (void) objcMethod;
    
@end
