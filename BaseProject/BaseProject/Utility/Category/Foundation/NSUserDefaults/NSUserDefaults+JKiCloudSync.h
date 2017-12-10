//
//  NSUserDefaults+iCloudSync.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
//https://github.com/RiccardoPaolillo/NSUserDefault-iCloud
// A very simple iOS Category for synchronize NSUserDefaults with iCloud (NSUbiquitousKeyValueStore)

#import <Foundation/Foundation.h>


@interface NSUserDefaults (JKiCloudSync)

-(void)_setValue:(id)value  forKey:(NSString *)key iCloudSync:(BOOL)sync;
-(void)_setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

-(id)_valueForKey:(NSString *)key  iCloudSync:(BOOL)sync;
-(id)_objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

-(BOOL)_synchronizeAlsoiCloudSync:(BOOL)sync;

@end
