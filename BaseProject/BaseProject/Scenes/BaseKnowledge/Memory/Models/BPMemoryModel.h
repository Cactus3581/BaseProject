//
//  BPMemoryModel.h
//  BaseProject
//
//  Created by Ryan on 2018/12/25.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPMemoryModel : NSObject {
@public
    NSString *_readonlyInstanceString;//这违背了面向对象语言的封装特性吧，要访问的话暴露出属性就行
}

@property(nonatomic,copy) NSString *memoryName;
@property (nonatomic,readonly,copy) NSString *readonlyString;

@end

NS_ASSUME_NONNULL_END
