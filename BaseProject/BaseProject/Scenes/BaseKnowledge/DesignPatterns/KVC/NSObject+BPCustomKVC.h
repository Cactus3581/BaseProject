//
//  NSObject+BPCustomKVC.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/8/4.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BPCustomKVC)

-(void)bp_setValue:(id)value forKey:(NSString*)key;
-(id)bp_valueforKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
