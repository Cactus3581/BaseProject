//
//  SULoginViewModel1.m
//  MHDevelopExample
//
//  Created by senba on 2017/6/14.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "SULoginViewModel1.h"

@interface SULoginViewModel1 ()

@property (nonatomic, readwrite, copy) NSString *avatarUrlString;

@end


@implementation SULoginViewModel1

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self addObserver:self forKeyPath:@"mobilePhone" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"mobilePhone"]) {
        NSString *mobilePhone = change[NSKeyValueChangeNewKey];
        if (!mobilePhone.length) {
            self.avatarUrlString = nil;
            return ;
        }
        // 模拟从数据库获取用户头像的数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.75f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 假数据 别在意
            //self.avatarUrlString = [AppDelegate sharedDelegate].account.avatarUrl;
        });
    }
}

- (void)loginSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 发起请求 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 登录成功 保存数据 简单起见 随便存了哈
        // 保存用户数据 这个逻辑就不要我来实现了吧 假数据参照 [AppDelegate sharedDelegate].account
        // 失败的回调 我就不处理 现实中开发绝逼不是这样的
//        !success?:success([AppDelegate sharedDelegate].account);
    });
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"mobilePhone"];
}

@end
