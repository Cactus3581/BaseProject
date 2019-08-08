//
//  BPDesignPatternsKVOViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsKVOViewController.h"
#import "NSObject+BPCustomKVO.h"
#import "BPKVOModel.h"
#import "BPKVODependModel.h"

@interface BPDesignPatternsKVOViewController ()

@property (nonatomic,strong) BPKVOModel *model;

@end


@implementation BPDesignPatternsKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self kvoIvarAndProperty];//对实例变量和属性分别进行KVO
                break;
            }
                
            case 1:{
                [self manualUseKVO];//手动调用KVO
                break;
            }
                
            case 2:{
                [self dependKVO];
                break;
            }
                
            case 3:{
                [self optimizeKVO];//优化KVO
                break;
            }
                
            case 4:{
                [self customKVO];//自定义实现KVO
                break;
            }
        }
    }
}

#pragma mark - 对实例变量和属性分别进行KVO
- (void)kvoIvarAndProperty {
    
    /* 总结：
     触发kvo，必须有setter方法（编译器实现还是自己重写setter方法）；即使没有setter手动调用willChangeValueForKey，也可以触发KVO
     */
    
    BPKVOModel *model = [[BPKVOModel alloc] init];
    
    //实例变量：
    [model addObserver:self forKeyPath:@"testNormalIvar" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    // 会触发kvo，虽然实例变量没有setter方法，但是内部手动调用了willChangeValueForKey方法。
    [model changeIphone:@"testNormalIvar-1"];
    // 会触发kvo。虽然没有setter方法。但是为什么呢
    [model setValue:@"testNormalIvar-2" forKey:@"testNormalIvar"];
    //报错
    //model->testNormalIvar = @"testNormalIvar-3";
    

    // 实例变量：会触发kvo。因为虽然是实例变量但是帮助实现了setter方法。
    [model addObserver:self forKeyPath:@"manualImplementSetterIvar" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [model setValue:@"manualImplementSetterIvar-1" forKey:@"manualImplementSetterIvar"];

    
     // 实例变量：不会触发kvo，因为没有setter方法，而是直接访问的实例变量
    [model addObserver:self forKeyPath:@"testPublicIvar" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    model->_testPublicIvar = @"testPublicIvar";
    
    
    //属性：正常情况，会触发kvo
    [model addObserver:self forKeyPath:@"testNormalProperty" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    model.testNormalProperty = @"testNormalProperty-1";
    [model setTestNormalProperty:@"testNormalProperty-2"];
    [model setValue:@"testNormalProperty-3" forKey:@"testNormalProperty"];
    
    
    //属性：@dynamic修饰了，没有生成setter方法。所以以下三种方法会崩溃
    [model addObserver:self forKeyPath:@"testDynamic" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    model.testDynamic = @"testDynamic-1";
//    [model setTestDynamic:@"testDynamic-2"];
//    [model setValue:@"testDynamic-3" forKey:@"testDynamic"];
    
    
    //属性：自动发送通知被禁止了。所以不会会触发kvo
    [model addObserver:self forKeyPath:@"testForbidLock" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    model.testForbidLock = @"testForbidLock-1";
    [model setTestForbidLock:@"testForbidLock-2"];
    [model setValue:@"testForbidLock-3" forKey:@"testForbidLock"];
    
    //属性：会两次触发kvo，因为重写了setter方法，并且在setter方法里c手动调用了willChangeValueForKey方法
    [model addObserver:self forKeyPath:@"testRepeatKVO" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    model.testRepeatKVO = @"testRepeatKVO-1";
    [model setTestRepeatKVO:@"testRepeatKVO-2"];
    [model setValue:@"testRepeatKVO-3" forKey:@"testRepeatKVO"];
}

#pragma mark - 手动调用KVO
- (void)manualUseKVO {
    // model 会被 self 持有吗？否则在出函数栈的时候为什么不会被释放呢？
    BPKVOModel *model = [[BPKVOModel alloc] init];
    
    model.testNormalProperty = @"testNormalProperty";
    
    [model addObserver:self forKeyPath:@"testNormalProperty" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    // 手动触发的方法:该方法和下面的方法默认是在setter中实现的
    [model willChangeValueForKey:@"testNormalProperty"];
    // 手动触发的方法：这个方法调用之后，通知会回调
    [model didChangeValueForKey:@"testNormalProperty"];
}

#pragma mark - 依赖KVO
- (void)dependKVO {
    BPKVOModel *model = [[BPKVOModel alloc] init];
    
    [model addObserver:self forKeyPath:@"dependProperty" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    model.dependModel.dependProperty1 = @"dependProperty1";
    model.dependModel.dependProperty2 = @"dependProperty2";
}

#pragma mark - 优化KVO
- (void)optimizeKVO {
    
}

#pragma mark - 观察集合的变化
- (void)kvo_collection {
    BPKVOModel *model = [[BPKVOModel alloc] init];
    // 观察集合的变化
    [model addObserver:self forKeyPath:@"muArray" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    NSMutableArray *muArray = @[@"item1",@"item2"].mutableCopy;
    [model setValue:muArray forKey:@"muArray"];
    
    [muArray insertObject:@"item3" atIndex:2];
    
    NSMutableArray *muArray1 = [model valueForKey:@"muArray"];
    
    BPLog(@"muArray = %@",muArray1)
}

#pragma mark - KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // 标识符，区分消息
    NSString *identifier = (__bridge NSString *)context;
    if([keyPath isEqualToString:@"testNormalProperty"]) {
        NSString *old = change[NSKeyValueChangeOldKey];
        NSString *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } else if ([keyPath isEqualToString:@"testNormalIvar"]) {
        NSString *old = change[NSKeyValueChangeOldKey];
        NSString *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } else if ([keyPath isEqualToString:@"testPublicIvar"]) {
        NSString *old = change[NSKeyValueChangeOldKey];
        NSString *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } else if ([keyPath isEqualToString:@"manualImplementSetterIvar"]) {
        NSString *old = change[NSKeyValueChangeOldKey];
        NSString *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } else if ([keyPath isEqualToString:@"testDynamic"]) {
        NSString *old = change[NSKeyValueChangeOldKey];
        NSString *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } else if ([keyPath isEqualToString:@"testForbidLock"]) {
        NSString *old = change[NSKeyValueChangeOldKey];
        NSString *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } else if ([keyPath isEqualToString:@"testRepeatKVO"]) {
        NSString *old = change[NSKeyValueChangeOldKey];
        NSString *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } else if ([keyPath isEqualToString:@"dependProperty"]) {
        NSString *old = change[NSKeyValueChangeOldKey];
        NSString *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } else if ([keyPath isEqualToString:@"muArray"]) {
            NSMutableArray *old = change[NSKeyValueChangeOldKey];
            NSMutableArray *new = change[NSKeyValueChangeNewKey];
            BPLog(@"old = %@,new = %@",old,new);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 自定义实现KVO

- (void)customKVO {
    BPKVOModel *model = [[BPKVOModel alloc] init];
    _model = model;
    [model bp_addObserver:self forKey:NSStringFromSelector(@selector(testNormalProperty))
                withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        BPLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
                    });
                }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changeMessage];
    });
}

- (void)changeMessage {
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.model.testNormalProperty = msgs[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
