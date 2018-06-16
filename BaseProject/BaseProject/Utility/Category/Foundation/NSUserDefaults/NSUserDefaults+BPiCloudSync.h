//
//  NSUserDefaults+iCloudSync.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSUserDefaults (BPiCloudSync)

- (void)_setValue:(id)value  forKey:(NSString *)key iCloudSync:(BOOL)sync;
- (void)_setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

- (id)_valueForKey:(NSString *)key  iCloudSync:(BOOL)sync;
- (id)_objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

- (BOOL)_synchronizeAlsoiCloudSync:(BOOL)sync;

@end
