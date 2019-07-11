//
//  BPDesignPatternsKVOViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsKVOViewController.h"
#import "NSObject+BPCustomKVO.h"
#import "BPCustomKVOModel.h"
#import "BPKVOModel.h"

@interface BPDesignPatternsKVOViewController ()
@property (nonatomic,copy) NSString *name;
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
                [self handleManualUseKVO];//手动实现KVO
                break;
            }
                
            case 1:{
                [self handleCustomKVO];//自定义实现KVO
                break;
            }
                
            case 2:{
                [self handleManualUseIvar];//观察有&没有setter方法的实例变量
                break;
            }
        }
    }
}

#pragma mark - 观察有&没有setter方法的实例变量
- (void)handleManualUseIvar {
    
    BPKVOModel *model = [[BPKVOModel alloc] init];
    [model addObserver:self forKeyPath:@"macbook" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"macbook"];
    [model setValue:@"macbook" forKey:@"macbook"];
    
    [model addObserver:self forKeyPath:@"iphone" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"iphone"];
    [model changeIphone:@"iphone"];
    
    [model addObserver:self forKeyPath:@"ipad" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"ipad"];
    model->_ipad = @"ipad"; // 不会引发kvo，因为没有调用子类的setter方法，而是直接访问的实例变量
}

#pragma mark - 手动实现KVO
- (void)handleManualUseKVO {
    // model 会被 self 持有吗？否则在出函数栈的时候为什么不会被释放呢？
    BPKVOModel *model = [[BPKVOModel alloc] init];
    model.name = @"name";
    [model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"handleManualUseKVO"];
    [model willChangeValueForKey:@"name"]; // 手动触发的方法:该方法和下面的方法默认是在setter中实现的
    [model didChangeValueForKey:@"name"];// 手动触发的方法：这个方法调用之后，通知会回调
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSString *obj = (__bridge NSString *)context;
    if([keyPath isEqualToString:@"name"] && [obj isEqualToString:@"handleManualUseKVO"]) {
        NSString *oldName = change[NSKeyValueChangeOldKey];
        NSString *newName = change[NSKeyValueChangeNewKey];
        BPLog(@"name:oldName = %@,newName = %@",oldName,newName);
    } else if ([keyPath isEqualToString:@"macbook"] && [obj isEqualToString:@"macbook"]) {
        NSString *oldName = change[NSKeyValueChangeOldKey];
        NSString *newName = change[NSKeyValueChangeNewKey];
        BPLog(@"macbook:oldName = %@,newName = %@",oldName,newName);
    } else if ([keyPath isEqualToString:@"iphone"] && [obj isEqualToString:@"iphone"]) {
        NSString *oldName = change[NSKeyValueChangeOldKey];
        NSString *newName = change[NSKeyValueChangeNewKey];
        BPLog(@"iphone:oldName = %@,newName = %@",oldName,newName);
    } else if ([keyPath isEqualToString:@"ipad"] && [obj isEqualToString:@"ipad"]) {
        NSString *oldName = change[NSKeyValueChangeOldKey];
        NSString *newName = change[NSKeyValueChangeNewKey];
        BPLog(@"ipad:oldName = %@,newName = %@",oldName,newName);
    }
}

#pragma mark - 自定义实现KVO
- (void)handleCustomKVO {
    BPKVOModel *model = [[BPKVOModel alloc] init];
    _model = model;
    [model bp_addObserver:self forKey:NSStringFromSelector(@selector(text))
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
    self.model.text = msgs[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
