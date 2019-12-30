//
//  SULoginViewModel1.h
//  MHDevelopExample
//
//  Created by senba on 2017/6/14.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  MVVM Without RAC 开发模式的 `登录界面的视图模型` -- VM

#import <Foundation/Foundation.h>

@interface SULoginViewModel1 : NSObject

@property (nonatomic, readwrite, copy) NSString *mobilePhone;
@property (nonatomic, readwrite, copy) NSString *verifyCode;
@property (nonatomic, readonly, copy) NSString *avatarUrlString;

- (void)loginSuccess:(void(^)(id json))success
         failure:(void (^)(NSError *error))failure;

@end
