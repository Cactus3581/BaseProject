//
//  NSObject+JKAppInfo.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JKAppInfo)
-(NSString *)jk_version;
-(NSInteger)jk_build;
-(NSString *)jk_identifier;
-(NSString *)jk_currentLanguage;
-(NSString *)jk_deviceModel;
@end
