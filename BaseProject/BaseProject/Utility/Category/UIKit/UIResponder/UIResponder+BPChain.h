//
//  UIResponder+BPChain.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (BPChain)
/**
 *  @brief  响应者链
 *
 *  @return  响应者链
 */
- (NSString *)bp_responderChainDescription;
@end
