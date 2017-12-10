//
//  UIViewController+BackButtonItemTitle.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKBackButtonItemTitleProtocol <NSObject>

@optional
- (NSString *)bp_navigationItemBackBarButtonTitle; //The length of the text is limited, otherwise it will be set to "Back"

@end

@interface UIViewController (JKBackButtonItemTitle) <JKBackButtonItemTitleProtocol>

@end
