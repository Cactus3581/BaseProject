//
//  BPRouterConfig.h
//  JSDRouterGuide
//
//  Created by ryan on 2020/2/19.
//  Copyright © 2019 Cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//控制器跳转相关参数配置;
extern NSString *const kRouteSegue; // 区分 Push 或 Modal
extern NSString *const kRouteAnimated; // 跳转时是否需要动画切换
extern NSString *const kRouteBackIndex; // 处理同级导航栏返回层级 Index
extern NSString *const kRouteBackPage; // 指定同级导航栏到此页面
extern NSString *const kRouteBackPageOffset; // 指定
extern NSString *const kRouteFromOutside; // 处理外部跳转到App
extern NSString *const kRouteNeedLogin; // 指定需要登录才能跳转的页面
extern NSString *const kRouteSegueNeedNavigation;  //Modal 时需要导航控制器;

extern NSString *const kRouteIndexRoot;  // 导航栏根控制器
extern NSString *const kRouteSeguePush;  // Push
extern NSString *const kRouteSegueModal; // 模态
extern NSString *const kRouteSegueBack;  //返回上一页;
extern NSString *const kRouteClassName;
extern NSString *const kRouteClassTitle;
extern NSString *const kRouteClassFlags;
extern NSString *const kRouteClassNeedLogin;

//TabBar 下控制器;
extern NSString *const BPRouteHomeTab;
extern NSString *const BPRouteCafeTab;
extern NSString *const BPRouteCoffeeTab;
extern NSString *const BPRouteMyCenterTab;

extern NSString *const BPRouteInvestTabGB;
extern NSString *const BPRouteInvestTabYX;

//App 内所有控制器
extern NSString *const BPRouteWebview;
extern NSString *const BPRouteLogin;
extern NSString *const BPRouteRegister;
extern NSString *const BPRouteAppear;
extern NSString *const BPRouteAppearNotNeedLogin;

@interface BPRouterConfig : NSObject

+ (NSDictionary *)configMapInfo;

@end

NS_ASSUME_NONNULL_END
