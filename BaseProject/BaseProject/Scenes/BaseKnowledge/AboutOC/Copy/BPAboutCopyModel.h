//
//  BPAboutCopyModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/6/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPAboutCopyModel : NSObject

@property (nonatomic, assign) NSInteger *age;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *array;

@end

NS_ASSUME_NONNULL_END
