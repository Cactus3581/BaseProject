//
//  BPSingletonMacro.h
//  BaseProject
//
//  Created by Ryan on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#ifndef BPSingletonMacro_h
#define BPSingletonMacro_h

# define SingletonH(name) + (instancetype)share##name;

#if __has_feature(objc_arc)//ARC单例宏
# define SingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{ \
\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)share##name{ \
\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone{ \
\
return _instance; \
}//最后一个位置不能加斜杠
#else//非ARC单例宏
# define SingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{ \
\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)share##name{ \
\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone{ \
\
return _instance; \
} \
\
- (oneway void)release{ \
\
} \
\
- (instancetype)autorelease{ \
return _instance; \
} \
\
- (instancetype)retain{ \
\
return _instance; \
} \
\
- (NSUInteger)retainCount{ \
\
return 1; \
}
#endif

#endif /* BPSingletonMacro_h */
