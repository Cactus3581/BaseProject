//
//  NSObject+JKReflection.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSObject (JKReflection)
//类名
- (NSString *)_className;
+ (NSString *)_className;
//父类名称
- (NSString *)_superClassName;
+ (NSString *)_superClassName;

//实例属性字典
-(NSDictionary *)_propertyDictionary;

//属性名称列表
- (NSArray*)_propertyKeys;
+ (NSArray *)_propertyKeys;

//属性详细信息列表
- (NSArray *)_propertiesInfo;
+ (NSArray *)_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)_propertiesWithCodeFormat;

//方法列表
-(NSArray*)_methodList;
+(NSArray*)_methodList;

-(NSArray*)_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)_registedClassList;
//实例变量
+ (NSArray *)_instanceVariable;

//协议列表
-(NSDictionary *)_protocolList;
+ (NSDictionary *)_protocolList;


- (BOOL)_hasPropertyForKey:(NSString*)key;
- (BOOL)_hasIvarForKey:(NSString*)key;

@end
