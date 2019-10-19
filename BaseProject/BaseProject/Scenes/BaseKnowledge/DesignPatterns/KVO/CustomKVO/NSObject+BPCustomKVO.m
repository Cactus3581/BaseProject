//
//  NSObject+BPCustomKVO.m
//  BaseProject
//
//  Created by Ryan on 2018/12/30.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "NSObject+BPCustomKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

NSString *const kBPKVOClassPrefix = @"BPKVOClassPrefix_";
NSString *const kBPKVOAssociatedObservers = @"BPKVOAssociatedObservers";

#pragma mark - BPObservationInfo
@interface BPObservationInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) BPObservingBlock block;
@end

@implementation BPObservationInfo

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(BPObservingBlock)block {
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}

@end


#pragma mark - Helpers
//获得相应的 getter 的名字
static NSString * getterForSetter(NSString *setter) {
    if (setter.length <=0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    
    // remove 'set' at the begining and ':' at the end
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    // lower case the first letter
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:firstLetter];
    
    return key;
}

//获得相应的 setter 的名字
static NSString * setterForGetter(NSString *getter) {
    if (getter.length <= 0) {
        return nil;
    }
    
    // upper case the first letter
    NSString *firstLetter = [[getter substringToIndex:1] uppercaseString];
    NSString *remainingLetters = [getter substringFromIndex:1];
    
    // add 'set' at the begining and ':' at the end
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", firstLetter, remainingLetters];
    
    return setter;
}

#pragma mark - 重写新生成的子类的setter方法，新的 setter 在调用原 setter 方法后，通知每个观察者（调用之前传入的 block ）：
static void kvo_setter(id self, SEL _cmd, id newValue) {
    
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    
    if (!getterName) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, setterName];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // 强转指针，这样编译器就不会报错了
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    // 调用super的setter，这是原始类的setter方法
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);
    
    // block的回调
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kBPKVOAssociatedObservers));
    for (BPObservationInfo *each in observers) {
        if ([each.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
        }
    }
}

// 获取该类的父类
static Class kvo_class(id self, SEL _cmd) {
    return class_getSuperclass(object_getClass(self));
}

#pragma mark - KVO Category
@implementation NSObject (BPCustomKVO)

- (void)bp_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(BPObservingBlock)block {
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    //检查对象的类有没有相应的 setter 方法。如果没有抛出异常；
    if (!setterMethod) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have a setter for key %@", self, key];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    Class clazz = object_getClass(self);
    NSString *superClass = NSStringFromClass(clazz);
    
    // 检查对象 isa 指向的类是不是一个 KVO 类。如果不是，新建一个继承原来类的子类，并把 isa 指向这个新建的子类；
    if (![superClass hasPrefix:kBPKVOClassPrefix]) {
        clazz = [self makeKvoClassWithOriginalClassName:superClass];
        object_setClass(self, clazz);
    }
    
    // 检查对象的 KVO 类重写过没有这个 setter 方法。如果没有，添加重写的 setter 方法；
    if (![self hasSelector:setterSelector]) {
        const char *types = method_getTypeEncoding(setterMethod);
        class_addMethod(clazz, setterSelector, (IMP)kvo_setter, types);
    }
    
    // 添加这个观察者
    BPObservationInfo *info = [[BPObservationInfo alloc] initWithObserver:observer Key:key block:block];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kBPKVOAssociatedObservers));
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(kBPKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}

- (void)bp_removeObserver:(NSObject *)observer forKey:(NSString *)key {
    NSMutableArray* observers = objc_getAssociatedObject(self, (__bridge const void *)(kBPKVOAssociatedObservers));
    BPObservationInfo *infoToRemove;
    for (BPObservationInfo* info in observers) {
        if (info.observer == observer && [info.key isEqual:key]) {
            infoToRemove = info;
            break;
        }
    }
    
    [observers removeObject:infoToRemove];
}


// 根据originalsuperClass新建一个继承此类的子类
- (Class)makeKvoClassWithOriginalClassName:(NSString *)originalsuperClass {
    
    NSString *kvosuperClass = [kBPKVOClassPrefix stringByAppendingString:originalsuperClass];
    
    Class clazz = NSClassFromString(kvosuperClass);
    
    if (clazz) {
        return clazz;
    }
    
    // KVO类不存在，创建它
    Class originalClazz = object_getClass(self);
    Class kvoClazz = objc_allocateClassPair(originalClazz, kvosuperClass.UTF8String, 0);
    
    // 获取类方法的签名，以便我们可以借用它
    Method clazzMethod = class_getInstanceMethod(originalClazz, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClazz, @selector(class), (IMP)kvo_class, types);
    objc_registerClassPair(kvoClazz);
    return kvoClazz;
}

// 有没有该方法
- (BOOL)hasSelector:(SEL)selector {
    Class clazz = object_getClass(self);
    unsigned int methodCount = 0;
    Method* methodList = class_copyMethodList(clazz, &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}

@end
