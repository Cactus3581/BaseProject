//
//  BPWeakView.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^weakViewBlock)(NSString *str);

@protocol BPWeakViewDelegate<NSObject>
@optional
- (void)pop;
@end
@interface BPWeakView : UIView

@property (nonatomic,copy)  weakViewBlock block;
@property (nonatomic, copy) void(^block1) (NSString *str);
@property (nonatomic,copy)  dispatch_block_t block2;

@property (nonatomic,strong) id<BPWeakViewDelegate> delegate;

- (void)setSuccess:(NSString * (^)(NSString *str1))block1 fail:(void (^)(NSString *str2))block2;

- (void)setBlock1:(weakViewBlock)block1 block2:(dispatch_block_t)block2;

+ (void)setBlock2:(weakViewBlock)block1 block2:(dispatch_block_t)block2;
+ (void)setBlock3:(id)obj block:(dispatch_block_t)block;

@end
