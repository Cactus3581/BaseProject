//
//  People.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/6.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation People

- (void)hello {
    BPLog(@"hello");
}

+ (void)hi {
    BPLog(@"hi");
}

#pragma mark - 获取对象所有的属性名称和属性值、获取对象所有成员变量名称和变量值、获取对象所有的方法名和方法参数数量。

- (NSDictionary *)allProperties {
    unsigned int count = 0;
    // 获取类的所有属性，如果没有属性count就为0
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for (NSUInteger i = 0; i < count; i ++) {
        // 获取属性的名称和值
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [self valueForKey:name];
        if (propertyValue) {
            resultDict[name] = propertyValue;
        } else {
            resultDict[name] = @"字典的key对应的value不能为nil哦！";
        }
    }
    // 这里properties是一个数组指针，我们需要使用free函数来释放内存。
    free(properties);
    return resultDict;
}

- (NSDictionary *)allIvars {
    unsigned int count = 0;
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (NSUInteger i = 0; i < count; i ++) {
        const char *varName = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:varName];
        id varValue = [self valueForKey:name];
        
        if (varValue) {
            resultDict[name] = varValue;
        } else {
            resultDict[name] = @"字典的key对应的value不能为nil哦！";
        }
    }
    free(ivars);
    return resultDict;
}

- (NSDictionary *)allMethods {
    unsigned int count = 0;
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    // 获取类的所有方法，如果没有方法count就为0
    Method *methods = class_copyMethodList([self class], &count);
    for (NSUInteger i = 0; i < count; i ++) {
        // 获取方法名称
        SEL methodSEL = method_getName(methods[i]);
        const char *methodName = sel_getName(methodSEL);
        NSString *name = [NSString stringWithUTF8String:methodName];
        // 获取方法的参数列表
        int arguments = method_getNumberOfArguments(methods[i]);
        resultDict[name] = @(arguments-2);
    }
    free(methods);
    return resultDict;
}

#pragma mark - 自动归档&反归档

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([People class], &count);
    for (NSUInteger i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([People class], &count);
        for (NSUInteger i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

#pragma mark - 自动模型转换与KVC的比较

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        for (NSString *key in dictionary.allKeys) {
            id value = dictionary[key];
            SEL setter = [self propertySetterByKey:key];
            if (setter) {
                // 这里还可以使用NSInvocation或者method_invoke，不再继续深究了，有兴趣google。
                ((void (*)(id, SEL, id))objc_msgSend)(self, setter, value);
            }
        }
    }
    return self;
}

- (NSDictionary *)covertToDictionary {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    if (count != 0) {
        NSMutableDictionary *resultDict = [@{} mutableCopy];
        for (NSUInteger i = 0; i < count; i ++) {
            const void *propertyName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            SEL getter = [self propertyGetterByKey:name];
            if (getter) {
                id value = ((id (*)(id, SEL))objc_msgSend)(self, getter);
                if (value) {
                    resultDict[name] = value;
                } else {
                    resultDict[name] = @"字典的key对应的value不能为nil哦！";
                }
            }
        }
        free(properties);
        return resultDict;
    }
    free(properties);
    return nil;
}

// 生成setter方法
- (SEL)propertySetterByKey:(NSString *)key {
    // 首字母大写，你懂得
    NSString *propertySetterName = [NSString stringWithFormat:@"set%@:", key.capitalizedString];
    SEL setter = NSSelectorFromString(propertySetterName);
    if ([self respondsToSelector:setter]) {
        return setter;
    }
    return nil;
}

// 生成getter方法
- (SEL)propertyGetterByKey:(NSString *)key {
    SEL getter = NSSelectorFromString(key);
    if ([self respondsToSelector:getter]) {
        return getter;
    }
    return nil;
}

#pragma mark - 动态添加方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    // 我们没有给People类声明sing方法，我们这里动态添加方法
    if ([NSStringFromSelector(sel) isEqualToString:@"sing"]) {
    //if (sel == @selector(sing)) {

        /*
         动态添加run方法
        
         第一个参数：给哪个类添加方法
         第二个参数：添加方法的方法编号
         第三个参数：添加方法的函数实现（函数地址）
         第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
         */
        class_addMethod(self, sel, (IMP)otherSing, "v@:");
        //class_addMethod(self, @selector(sing), (IMP)otherSing, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void otherSing(id self, SEL cmd) {
    BPLog(@"%@ 唱歌啦！",((People *)self).name);
}

@end
