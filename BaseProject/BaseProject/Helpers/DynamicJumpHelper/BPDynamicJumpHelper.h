//
//  BPDynamicJumpHelper.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 动态VC的数据源协议，实现该协议的controller都得实现loadWithData方法
 */
@protocol BPDynamicJumpHelperProtocol <NSObject>
@required

- (void)loadWithData:(NSDictionary *)dict;

@end

/**
 * 动态VC的帮助类
 */
@interface BPDynamicJumpHelper : NSObject

/**
 动态VC跳转
 @param navigationController 传入navigationController,可以为空，如果为空，则为根视图导航控制器
 @param type 跳转类型， 0：内部界面 1:内部浏览器  2:外部浏览器
 @param data 跳转的vc名字和vc加载数据所需要的参数，其中vc是key，其他key自定义指定
 */
+ (void)pushViewControllerWithNavigationController:(UINavigationController *)navigationController pushType:(NSInteger)type linkData:(NSString *)data;

@end
