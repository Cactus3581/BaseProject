//
//  NSURL+BPScheme.h
//  BaseProject
//
//  Created by Ryan on 2017/9/22.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (BPScheme)
/**
 *  自定义scheme
 */
- (NSURL *)customSchemeURL;

/**
 *  还原scheme
 */
- (NSURL *)originalSchemeURL;
@end
