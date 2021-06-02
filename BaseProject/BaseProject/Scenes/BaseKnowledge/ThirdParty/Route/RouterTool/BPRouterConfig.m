//
//  BPRouterConfig.m
//  JSDRouterGuide
//
//  Created by ryan on 2020/2/19.
//  Copyright © 2019 Cactus. All rights reserved.
//

#import "BPRouterConfig.h"

NSString *const kRouteSegue = @"BPRouteSegue";
NSString *const kRouteAnimated = @"BPRouteAnimated";
NSString *const kRouteBackIndex = @"BPRouteBackIndex";
NSString *const kRouteBackPage = @"BPRouteBackPage";
NSString *const kRouteBackPageOffset = @"BPRouteBackPageOffset";
NSString *const kRouteFromOutside = @"BPRouteFromOutside";
NSString *const kRouteNeedLogin = @"BPRouteNeedLogin";
NSString *const kRouteSegueNeedNavigation = @"BPRouteNeedNavigation";

NSString *const kRouteIndexRoot = @"root";
NSString *const kRouteSeguePush = @"push";
NSString *const kRouteSegueModal = @"modal";
NSString *const kRouteSegueBack = @"/back";

NSString *const kRouteClassName = @"class";
NSString *const kRouteClassTitle = @"title";
NSString *const kRouteClassFlags = @"flags";
NSString *const kRouteClassNeedLogin = @"needLogin";

NSString *const BPRouteHomeTab = @"/rootTab/0";
NSString *const BPRouteCafeTab = @"/rootTab/1";
NSString *const BPRouteCoffeeTab = @"/rootTab/2";
NSString *const BPRouteMyCenterTab = @"/rootTab/3";

//App 内相关控制器
NSString *const BPRouteWebview = @"/webView";
NSString *const BPRouteLogin = @"/login";
NSString *const BPRouteRegister = @"/register";
NSString *const BPRouteAppear = @"/home/Appear";
NSString *const BPRouteAppearNotNeedLogin = @"/home/AppearNotNeedLogin";

@implementation BPRouterConfig

+ (NSDictionary *)configMapInfo {
    
    return @{

        BPRouteWebview: @{kRouteClassName: @"JSDWebViewVC",
                             kRouteClassTitle: @"WebView",
                             kRouteClassFlags: @"",
                             kRouteClassNeedLogin: @""
        },

        BPRouteLogin: @{kRouteClassName: @"JSDLoginVC",
                             kRouteClassTitle: @"登录",
                             kRouteClassFlags: @"",
                             kRouteClassNeedLogin: @""
        },

        BPRouteRegister: @{kRouteClassName: @"JSDRegisterVC",
                              kRouteClassTitle: @"注册",
                              kRouteClassFlags: @"",
                              kRouteClassNeedLogin: @""
        },

        BPRouteAppear: @{kRouteClassName: @"BPTagViewController",
                              kRouteClassTitle: @"tag:",
                              kRouteClassFlags: @"",
                              kRouteClassNeedLogin: @"0"
        },

        BPRouteAppearNotNeedLogin: @{kRouteClassName: @"JSDAppearNotNeedLogInVC",
                              kRouteClassTitle: @"测试OpenRouterNotNeedLogin:",
                              kRouteClassFlags: @"",
                              kRouteClassNeedLogin: @"",
        }
    };
}

@end
