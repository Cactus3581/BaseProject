//
//  NSObject+BPAddProperty.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSObject+BPAddProperty.h"
#import <objc/runtime.h>

//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
static const void *BPStringProperty = &BPStringProperty;
static const void *BPIntegerProperty = &BPIntegerProperty;
//static char IntegerProperty;
@implementation NSObject (BPAddProperty)

@dynamic _stringProperty;
@dynamic _integerProperty;

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
- (void)setBp_stringProperty:(NSString *)_stringProperty{
    //use that a static const as the key
    objc_setAssociatedObject(self, BPStringProperty, _stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //use that property's selector as the key:
    //objc_setAssociatedObject(self, @selector(stringProperty), stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
- (NSString *)_stringProperty{
    return objc_getAssociatedObject(self, BPStringProperty);
}

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
- (void)setBp_integerProperty:(NSInteger)_integerProperty{
    NSNumber *number = [[NSNumber alloc]initWithInteger:_integerProperty];
    objc_setAssociatedObject(self,BPIntegerProperty, number, OBJC_ASSOCIATION_ASSIGN);
}
//get
- (NSInteger)_integerProperty{
    return [objc_getAssociatedObject(self, BPIntegerProperty) integerValue];
}

@end
