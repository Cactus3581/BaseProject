//
//  UITableViewCell+NIB.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UITableViewCell+JKNIB.h"

@implementation UITableViewCell (JKNIB)
/**
 *  @brief  加载同类名的nib
 *
 *  @return nib
 */
+(UINib*)bp_nib{
   return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end
