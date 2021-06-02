//
//  BPRouter+Handle.m
//  JSDRouterGuide
//
//  Created by ryan on 2020/2/19.
//  Copyright © 2019 Cactus. All rights reserved.
//

#import "BPRouter+Handle.h"

@implementation BPRouter (Handle)

+ (void)load {
    [self performSelectorOnMainThread:@selector(registerRouter) withObject:nil waitUntilDone:false];
}

//注册 Router
+ (void)registerRouter {
    
    //获取全局 RouterMapInfo
    NSDictionary *routerMapInfo = [BPRouterConfig configMapInfo];
    
    // router 对应控制器路径, 使用其来注册 Route, 当调用当前 Route 时会执行回调; 回调参数 parameters: 在执行 Route 时传入的参数;
    for (NSString *router in routerMapInfo.allKeys) {
        
        NSDictionary *routerMap = routerMapInfo[router];
        NSString *className = BPValidateString(routerMap[kRouteClassName]);
        if (className) {
            //注册所有控制器 Router,
            [self addRoute:router handler:^BOOL(NSDictionary  *_Nonnull parameters) {
                //执行路由匹配成功之后,跳转逻辑回调;
    //            NSMutableDictionary *mapInfo = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //
    //            [mapInfo setValue:className forKey:kRouteClassName];
    //            [mapInfo setValue:routerMap[kRouteClassTitle] forKey:kRouteClassTitle];
    //            [mapInfo setValue:routerMap[kRouteClassFlags] forKey:kRouteClassFlags];
    //            [mapInfo setValue:@(needLogin) forKey:kRouteNeedLogin];

                /*执行 Route 回调; 处理控制器跳转 + 传参;
                    routerMap: 当前 route 映射的  routeMap; 我们在 RouterConfig 配置的 Map;
                    parameters: 调用 route 时, 传入的参数;
                 */
                return [self executeRouterClassName:className routerMap:routerMap parameters:parameters];
            }];
        }
    }
    
    // 注册 Router 到指定TabBar Index; 使用 [BPRouter openURL:BPRouteCafeTab] 切换到 Cafe Index
    [self addRoute:@"/rootTab/:index" handler:^BOOL(NSDictionary  *_Nonnull parameters) {
        NSInteger index = [parameters[@"index"] integerValue];
        // 处理 UITabBarControllerIndex 切换;
        UITabBarController *tabBarVC = (UITabBarController *)kRootViewController;
        if ([tabBarVC isKindOfClass:[UITabBarController class]] && index >= 0 && tabBarVC.viewControllers.count >= index) {
            UIViewController *indexVC = tabBarVC.viewControllers[index];
            if ([indexVC isKindOfClass:[UINavigationController class]]) {
                indexVC = ((UINavigationController *)indexVC).topViewController;
            }
            //传参
            [self setupParameters:parameters forViewController:indexVC];
            tabBarVC.selectedIndex = index;
            return YES;
        } else {
            return NO;
        }
    }];

    // 注册返回上层页面 Router, 使用 [BPRouter openURL:kRouteSegueBack] 返回上一页 或 [BPRouter openURL:kRouteSegueBack parameters:@{kRouteBackIndex: @(2)}]  返回前两页
    [self addRoute:kRouteSegueBack handler:^BOOL(NSDictionary  *_Nonnull parameters) {
        return [self executeBackRouterParameters:parameters];
    }];
}

// 注册
+ (void)addRoute:(NSString *)route handler:(BOOL (^)(NSDictionary * _Nonnull parameters))handlerBlock {
    [[JLRoutes globalRoutes] addRoute:route handler:handlerBlock];
}

#pragma mark - execute Router VC
// 当查找到指定 Router 时, 触发路由回调逻辑; 找不到已注册 Router 则直接返回 NO; 如需要的话, 也可以在这里注册一个全局未匹配到 Router 执行的回调进行异常处理;
+ (BOOL)executeRouterClassName:(NSString *)className routerMap:(NSDictionary *)routerMap parameters:(NSDictionary *)parameters {
    // 拦截 Router 映射参数,是否需要登录才可跳转;
    BOOL needLogin = [routerMap[kRouteClassNeedLogin] boolValue];
    if (needLogin && !userIsLogin) {
        [BPRouter openURL:BPRouteLogin];
        return NO;
    }
    //统一初始化控制器,传参和跳转;
    UIViewController *vc = [self viewControllerWithClassName:className routerMap:routerMap parameters: parameters];
    if (vc) {
        [self gotoViewController:vc parameters:parameters];
        return YES;
    } else {
        return NO;
    }
}

// 根据 Router 映射到的类名实例化控制器;
+ (UIViewController *)viewControllerWithClassName:(NSString *)className routerMap:(NSDictionary *)routerMap parameters:(NSDictionary *)parameters {
    
    id vc = [[NSClassFromString(className) alloc] init];
    if (![vc isKindOfClass:[UIViewController class]]) {
        vc = nil;
    }

#if DEBUG
    //vc不是UIViewController
    NSAssert(vc, @"%s: %@ is not kind of UIViewController class, routerMap: %@",__func__ ,className, routerMap);
#endif
    //参数赋值
    [self setupParameters:parameters forViewController:vc];
    
    return vc;
}

// 对 VC 参数赋值
+ (void)setupParameters:(NSDictionary *)params forViewController:(UIViewController *)vc {
    
    for (NSString *key in params.allKeys) {
        BOOL hasKey = [vc respondsToSelector:NSSelectorFromString(key)];
        BOOL notNil = params[key] != nil;
        if (hasKey && notNil) {
            [vc setValue:params[key] forKey:key];
        }
        
#if DEBUG
    //vc没有相应属性，但却传了值
        if ([key hasPrefix:@"JLRoute"]==NO &&
            [key hasPrefix:@"BPRoute"]==NO && [params[@"JLRoutePattern"] rangeOfString:[NSString stringWithFormat:@":%@",key]].location==NSNotFound) {
            NSAssert(hasKey == YES, @"%s: %@ is not property for the key %@",__func__ ,vc,key);
        }
#endif
    };
}

// 跳转和参数设置;
+ (void)gotoViewController:(UIViewController *)vc parameters:(NSDictionary *)parameters {
    
    UIViewController *currentVC = [UIViewController bp_currentViewController];
    NSString *segue = parameters[kRouteSegue] ? parameters[kRouteSegue] : kRouteSeguePush; //  决定 present 或者 Push; 默认值 Push
    BOOL animated = parameters[kRouteAnimated] ? [parameters[kRouteAnimated] boolValue] : YES;  // 转场动画;
    NSLog(@"%s 跳转: %@ %@ %@",__func__ ,currentVC, segue,vc);
    
    if ([segue isEqualToString:kRouteSeguePush]) { //PUSH
        if (currentVC.navigationController) {
            NSString *backIndexString = [NSString stringWithFormat:@"%@",parameters[kRouteBackIndex]];
            UINavigationController *nav = currentVC.navigationController;
            if ([backIndexString isEqualToString:kRouteIndexRoot]) {
                NSMutableArray *vcs = [NSMutableArray arrayWithObject:nav.viewControllers.firstObject];
                [vcs addObject:vc];
                [nav setViewControllers:vcs animated:animated];
                
            } else if ([backIndexString integerValue] && [backIndexString integerValue] < nav.viewControllers.count) {
                //移除掉指定数量的 VC, 在Push;
                NSMutableArray *vcs = [nav.viewControllers mutableCopy];
                [vcs removeObjectsInRange:NSMakeRange(vcs.count - [backIndexString integerValue], [backIndexString integerValue])];
                nav.viewControllers = vcs;
                [nav pushViewController:vc animated:YES];
            } else {
                [nav pushViewController:vc animated:animated];
            }
        }
        else { //由于无导航栏, 直接执行 Modal
            BOOL needNavigation = parameters[kRouteSegueNeedNavigation] ? NO : YES;
            if (needNavigation) {
                UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
                //vc.modalPresentationStyle = UIModalPresentationFullScreen;
                [currentVC presentViewController:navigationVC animated:YES completion:nil];
            }
            else {
                //vc.modalPresentationStyle = UIModalPresentationFullScreen;
                [currentVC presentViewController:vc animated:animated completion:nil];
            }
        }
    }
    else { //Modal
        BOOL needNavigation = parameters[kRouteSegueNeedNavigation] ? parameters[kRouteSegueNeedNavigation] : NO;
        if (needNavigation) {
            UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
            //vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [currentVC presentViewController:navigationVC animated:animated completion:nil];
        }
        else {
            //vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [currentVC presentViewController:vc animated:animated completion:nil];
        }
    }
}

// 返回上层页面回调;
+ (BOOL)executeBackRouterParameters:(NSDictionary *)parameters {
    BOOL animated = parameters[kRouteAnimated] ? [parameters[kRouteAnimated] boolValue] : YES;
    NSString *backIndexString = BPValidateString(parameters[kRouteBackIndex] ? [NSString stringWithFormat:@"%@",parameters[kRouteBackIndex]] : nil);  // 指定返回个数, 优先处理此参数;
    id backPage = parameters[kRouteBackPage] ? parameters[kRouteBackPage] : nil; // 指定返回到某个页面,
    NSInteger backPageOffset = parameters[kRouteBackPageOffset] ? [parameters[kRouteBackPageOffset] integerValue] : 0; // 指定返回到的页面并进行偏移;
    UIViewController *visibleVC = [UIViewController bp_currentViewController];
    UINavigationController *navigationVC = visibleVC.navigationController;
    if (navigationVC) {
        // 处理 pop 按索引值处理;
        if (backIndexString) {
            if ([backIndexString isEqualToString:kRouteIndexRoot]) {//返回根
                [navigationVC popToRootViewControllerAnimated:animated];
            }
            else {
                NSUInteger backIndex = backIndexString.integerValue;
                NSMutableArray *vcs = navigationVC.viewControllers.mutableCopy;
                if (vcs.count > backIndex) {
                    [vcs removeObjectsInRange:NSMakeRange(vcs.count - backIndex, backIndex)];
                    [navigationVC setViewControllers:vcs animated:animated];
                    return YES;
                }
                else {
                    return NO; //指定返回索引值超过当前导航控制器包含的子控制器;
                }
            }
        }
        else if (backPage) { //处理返回指定的控制器, 可以处理
            NSMutableArray *vcs = navigationVC.viewControllers.mutableCopy;
            NSInteger pageIndex = NSNotFound;
            //页面标识为字符串
            if ([backPage isKindOfClass:[NSString class]]) {
                for (int i=0; i<vcs.count; i++) {
                    if ([vcs[i] isKindOfClass:NSClassFromString(backPage)]) {
                        pageIndex = i;
                        break;
                    }
                }
            }
            //页面标识为vc实例
            else if ([backPage isKindOfClass:[UIViewController class]]) {
                for (int i=0; i<vcs.count; i++) {
                    if (vcs[i] == backPage) {
                        pageIndex = i;
                        break;
                    }
                }
            }
            //有指定页面，根据参数跳转
            if (pageIndex != NSNotFound) {
                NSUInteger backIndex = (vcs.count-1) - pageIndex + backPageOffset;
                if (vcs.count > backIndex) {
                    [vcs removeObjectsInRange:NSMakeRange(vcs.count-backIndex, backIndex)];
                    [navigationVC setViewControllers:vcs animated:animated];
                    return YES;
                }
            }
            //指定页面不存在，return NO，可用于判断当前vc栈里有没有当前页面。
        }
        else {
            [navigationVC popViewControllerAnimated:animated];
            return YES;
        }
    }
    else {
        [visibleVC dismissViewControllerAnimated:animated completion:nil];
        return YES;
    }
    return NO;
}

@end
