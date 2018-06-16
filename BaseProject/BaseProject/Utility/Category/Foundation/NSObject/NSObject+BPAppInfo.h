//
//  NSObject+BPAppInfo.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BPAppInfo)
- (NSString *)_version;
- (NSInteger)_build;
- (NSString *)_identifier;
- (NSString *)_currentLanguage;
- (NSString *)_deviceModel;
@end
