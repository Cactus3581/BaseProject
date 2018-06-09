//
//  BPDynamicJumpHelper.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDynamicJumpHelper.h"
#import "BPAppDelegate.h"

#define kLinkDataVCKey @"vc" //配置的串中，必须含有key：vc；

@implementation BPDynamicJumpHelper

+ (void)pushViewControllerWithNavigationController:(UINavigationController *)navigationController pushType:(NSInteger)type linkData:(NSString *)data {
    
    if ([data isEqual:[NSNull null]] || data.length == 0) {
        return;
    }
    
    if (!navigationController) {
        navigationController = kAppDelegate.selectedNavigationController;
    }
    
    switch (type) {
            
        case 0: {
            //内部界面（
            NSDictionary *linkDic = BPFromJSON(data);
            if (!linkDic) {
                //link格式不正确
                BPLog(@"服务器配置的 动态菜单协议不正确");
                return;
            }
            
            NSString *vcString = [linkDic objectForKey:kLinkDataVCKey];
            id vc = [self viewControllerFromString:vcString];
            if (vc && [vc isKindOfClass:[UIViewController class]]) {
                if ([vc conformsToProtocol:@protocol(BPDynamicJumpHelperProtocol)]) {
                    [vc loadWithData:linkDic];
                }
                [navigationController pushViewController:vc animated:YES];
            }
        }
            break;
            
        case 1: {
            //内部浏览器
            NSString *urlString ;
            NSURL *url = [NSURL URLWithString:urlString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
            break;
            
        case 2: {
            //外部浏览器
        }
            break;
            
        default:
            break;
    }
}

/**
 * 根据string返回vc
 */
+ (id)viewControllerFromString:(NSString *)string {
    Class vcClass = NSClassFromString(string);
    id vc = [[vcClass alloc] init];
    return vc;
}

@end
