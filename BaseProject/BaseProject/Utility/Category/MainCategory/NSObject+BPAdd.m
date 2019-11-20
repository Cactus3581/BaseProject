//
//  NSObject+BPAdd.m
//  BaseProject
//
//  Created by Ryan on 16/5/14.
//  Copyright © 2016年 cactus. All rights reserved.
//
#import "NSObject+BPAdd.h"
#import "NSString+BPAdd.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(NSObject_BPAdd)

@interface _BPBlockTarget : NSObject

/**添加一个KVOBlock*/
- (void)bp_addBlock:(void(^)(__weak id obj, id oldValue, id newValue))block;
- (void)bp_addNotificationBlock:(void(^)(NSNotification *notification))block;

- (void)bp_doNotification:(NSNotification*)notification;

@end

@implementation _BPBlockTarget{
    //保存所有的block
    NSMutableSet *_kvoBlockSet;
    NSMutableSet *_notificationBlockSet;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _kvoBlockSet = [NSMutableSet new];
        _notificationBlockSet = [NSMutableSet new];
    }
    return self;
}

- (void)bp_addBlock:(void(^)(__weak id obj, id oldValue, id newValue))block{
    [_kvoBlockSet addObject:[block copy]];
}

- (void)bp_addNotificationBlock:(void(^)(NSNotification *notification))block{
    [_notificationBlockSet addObject:[block copy]];
}

- (void)bp_doNotification:(NSNotification*)notification{
    if (!_notificationBlockSet.count) return;
    [_notificationBlockSet enumerateObjectsUsingBlock:^(void (^block)(NSNotification *notification), BOOL * _Nonnull stop) {
        block(notification);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (!_kvoBlockSet.count) return;
    BOOL prior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    //只接受值改变时的消息
    if (prior) return;
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    //执行该target下的所有block
    [_kvoBlockSet enumerateObjectsUsingBlock:^(void (^block)(__weak id obj, id oldVal, id newVal), BOOL * _Nonnull stop) {
        block(object, oldVal, newVal);
    }];
}

@end


@implementation NSObject (BPAdd)


+ (void)bp_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

+ (void)bp_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getClassMethod(self, originalSel);
    Method newMethod = class_getClassMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)bp_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)bp_setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)bp_setAssociateCopyValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)bp_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)bp_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

- (void)bp_removeAllAssociatedValues {
    objc_removeAssociatedObjects(self);
}

+ (NSArray *)bp_getAllPropertyNames {
    NSMutableArray *allNames = @[].mutableCopy;
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList(self, &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertys);
    return allNames.copy;
	
}

+ (NSArray *)bp_getAllIvarNames{
    NSMutableArray *allNames = @[].mutableCopy;
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(self, &ivarCount);
    for (int i = 0; i < ivarCount; i ++) {
        Ivar ivar = ivars[i];
        const char * ivarName = ivar_getName(ivar);
        [allNames addObject:[NSString stringWithUTF8String:ivarName]];
    }
    free(ivars);
    return allNames.copy;
}

+ (NSArray *)bp_getAllInstanceMethodsNames {
    NSMutableArray *methodNames = @[].mutableCopy;
    unsigned int count;
    Method *methods = class_copyMethodList(self, &count);
    for (int i = 0; i < count; i++){
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        if (name){
            [methodNames addObject:name];
        }
    }
    free(methods);
    return methodNames.copy;
	
}

+ (NSArray *)bp_getAllClassMethodsNames {
    return [objc_getMetaClass([NSStringFromClass(self) UTF8String]) bp_getAllInstanceMethodsNames];
}

- (void)bp_setAllNSStringPropertyWithString:(NSString *)string {
    NSArray *attributes = [[self class] _bp_getAllPropertyAttributesInClass];
    [attributes enumerateObjectsUsingBlock:^(NSString *attributeString, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSObject _bp_propertyWithAttribute:attributeString isClass:[NSString class]]) {
            NSString * propertyName = [NSObject _bp_getPropertyNameWithAttribute:attributeString];
            SEL setterMethod = [NSObject _bp_getSetterMethodWithProertyName:propertyName];
            if ([self respondsToSelector:setterMethod]) {
                [self performSelectorOnMainThread:setterMethod withObject:string waitUntilDone:YES];
            }
        }
    }];
}

static void *const BPKVOBlockKey = "BPKVOBlockKey";

- (void)bp_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id obj, id oldVal, id newVal))block {
    if (!keyPath || !block) return;
    //取出存有所有KVOTarget的字典
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, BPKVOBlockKey);
    if (!allTargets) {
        //没有则创建
        allTargets = [NSMutableDictionary new];
        //绑定在该对象中
        objc_setAssociatedObject(self, BPKVOBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    //获取对应keyPath中的所有target
    _BPBlockTarget *targetForKeyPath = allTargets[keyPath];
    if (!targetForKeyPath) {
        //没有则创建
        targetForKeyPath = [_BPBlockTarget new];
        //保存
        allTargets[keyPath] = targetForKeyPath;
        //如果第一次，则注册对keyPath的KVO监听
        [self addObserver:targetForKeyPath forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    [targetForKeyPath bp_addBlock:block];
    //对第一次注册KVO的类进行dealloc方法调剂
    [self _bp_swizzleDealloc];
}
- (void)bp_removeObserverBlockForKeyPath:(NSString *)keyPath{
    if (!keyPath.length) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, BPKVOBlockKey);
    if (!allTargets) return;
    _BPBlockTarget *target = allTargets[keyPath];
    if (!target) return;
    [self removeObserver:target forKeyPath:keyPath];
    [allTargets removeObjectForKey:keyPath];
}

- (void)bp_removeAllObserverBlocks {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, BPKVOBlockKey);
    if (!allTargets) return;
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id key, _BPBlockTarget *target, BOOL *stop) {
        [self removeObserver:target forKeyPath:key];
    }];
    [allTargets removeAllObjects];
}

static void *const BPNotificationBlockKey = "BPNotificationBlockKey";

- (void)bp_addNotificationForName:(NSString *)name block:(void (^)(NSNotification *notification))block {
    if (!name || !block) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, BPNotificationBlockKey);
    if (!allTargets) {
        allTargets = @{}.mutableCopy;
        objc_setAssociatedObject(self, BPNotificationBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    _BPBlockTarget *target = allTargets[name];
    if (!target) {
        target = [_BPBlockTarget new];
        allTargets[name] = target;
        [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(bp_doNotification:) name:name object:nil];
    }
    [target bp_addNotificationBlock:block];
    [self _bp_swizzleDealloc];
    
}

- (void)bp_removeNotificationForName:(NSString *)name{
    if (!name) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, BPNotificationBlockKey);
    if (!allTargets.count) return;
    _BPBlockTarget *target = allTargets[name];
    if (!target) return;
    [[NSNotificationCenter defaultCenter] removeObserver:target];
    
}

- (void)bp_removeAllNotification{
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, BPNotificationBlockKey);
    if (!allTargets.count) return;
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, _BPBlockTarget *target, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:target];
    }];
    [allTargets removeAllObjects];
}

- (void)bp_postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}

#pragma mark - private methods

static void * deallocHasSwizzledKey = "deallocHasSwizzledKey";

/**
 *  调剂dealloc方法，由于无法直接使用运行时的swizzle方法对dealloc方法进行调剂，所以稍微麻烦一些
 */
- (void)_bp_swizzleDealloc{
    //我们给每个类绑定上一个值来判断dealloc方法是否被调剂过，如果调剂过了就无需再次调剂了
    BOOL swizzled = [objc_getAssociatedObject(self.class, deallocHasSwizzledKey) boolValue];
    //如果调剂过则直接返回
    if (swizzled) return;
    //开始调剂
    Class swizzleClass = self.class;
    //获取原有的dealloc方法
    SEL deallocSelector = sel_registerName("dealloc");
    //初始化一个函数指针用于保存原有的dealloc方法
    __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
    //实现我们自己的dealloc方法，通过block的方式
    id newDealloc = ^(__unsafe_unretained id objSelf){
        //在这里我们移除所有的KVO
        [objSelf bp_removeAllObserverBlocks];
        //移除所有通知
        [objSelf bp_removeAllNotification];
        //根据原有的dealloc方法是否存在进行判断
        if (originalDealloc == NULL) {//如果不存在，说明本类没有实现dealloc方法，则需要向父类发送dealloc消息(objc_msgSendSuper)
            //构造objc_msgSendSuper所需要的参数，.receiver为方法的实际调用者，即为类本身，.super_class指向其父类
            struct objc_super superInfo = {
                .receiver = objSelf,
                .super_class = class_getSuperclass(swizzleClass)
            };
            //构建objc_msgSendSuper函数
            void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
            //向super发送dealloc消息
            msgSend(&superInfo, deallocSelector);
        }else{//如果存在，表明该类实现了dealloc方法，则直接调用即可
            //调用原有的dealloc方法
            originalDealloc(objSelf, deallocSelector);
        }
    };
    //根据block构建新的dealloc实现IMP
    IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
    //尝试添加新的dealloc方法，如果该类已经复写的dealloc方法则不能添加成功，反之则能够添加成功
    if (!class_addMethod(swizzleClass, deallocSelector, newDeallocIMP, "v@:")) {
        //如果没有添加成功则保存原有的dealloc方法，用于新的dealloc方法中
        Method deallocMethod = class_getInstanceMethod(swizzleClass, deallocSelector);
        originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
        originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
    }
    //标记该类已经调剂过了
    objc_setAssociatedObject(self.class, deallocHasSwizzledKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray *)_bp_getAllPropertyAttributesInClass{
    NSMutableArray *allNames = @[].mutableCopy;
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList(self, &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getAttributes(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertys);
    return allNames.copy;
}

+ (BOOL)_bp_propertyWithAttribute:(NSString *)attributeString isClass:(Class)className{
    NSString *classSring = NSStringFromClass(className);
    if ([[NSObject _bp_getPropertyClassNameWithAttribute:attributeString] isEqualToString:classSring]) {
        return YES;
    }
    return NO;
}

+ (NSString *)_bp_getPropertyClassNameWithAttribute:(NSString *)attributeString{
    if (!attributeString.length) {
        return nil;
    }
    if ([attributeString rangeOfString:@"\""].location == NSNotFound || [attributeString rangeOfString:@"@"].location == NSNotFound) {
        return nil;
    }
    return [attributeString componentsSeparatedByString:@"\""][1];
}

+ (NSString *)_bp_getPropertyNameWithAttribute:(NSString *)attributeString{
    if (!attributeString.length) {
        return nil;
    }
    NSArray *temp = [attributeString componentsSeparatedByString:@"_"];
    if (temp.count < 2) {
        return nil;
    }
    return temp[1];
}

+ (SEL)_bp_getSetterMethodWithProertyName:(NSString *)proertyName{
    return NSSelectorFromString([NSString stringWithFormat:@"set%@:",proertyName.firstCharUpperString]);
}

@end
