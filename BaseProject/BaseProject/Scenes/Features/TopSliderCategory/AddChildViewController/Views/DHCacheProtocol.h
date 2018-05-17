//
//  DHCacheProtocol.h
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/15.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#ifndef DHCacheProtocol_h
#define DHCacheProtocol_h

#import <Foundation/Foundation.h>

@protocol DHCacheProtocol <NSObject>

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end

#endif /* DHCacheProtocol_h */
