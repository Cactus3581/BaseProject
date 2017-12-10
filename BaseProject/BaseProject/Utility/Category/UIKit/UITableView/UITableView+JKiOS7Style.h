//
//  UITableView+iOS7Style.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UITableView (JKiOS7Style)
/**
 *  @brief  ios7设置页面的UITableViewCell样式
 *
 *  @param cell      cell
 *  @param indexPath indexPath
 */
-(void)bp_applyiOS7SettingsStyleGrouping:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
