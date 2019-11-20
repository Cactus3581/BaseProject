//
//  NSObject+BPSwizzling.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/10/25.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BPSwizzling)

+ (void)bp_swizzleInstanceMethodWithClass:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel;
+ (void)bp_swizzleDelegateMethodWithOrigClass:(Class)origClass origSelector:(SEL)origSel swizClass:(Class)swizClass swizSelector:(SEL)swizSel placedSelector:(SEL)placedSel;

@end

NS_ASSUME_NONNULL_END
