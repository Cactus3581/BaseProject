//
//  UIWebView+MetaParser.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JKMetaParser)
/**
 *  @brief  获取网页meta信息
 *
 *  @return meta信息
 */
-(NSArray *)bp_getMetaData;
@end
