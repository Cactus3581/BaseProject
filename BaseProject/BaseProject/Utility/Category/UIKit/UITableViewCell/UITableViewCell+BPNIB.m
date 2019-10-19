//
//  UITableViewCell+NIB.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UITableViewCell+BPNIB.h"

@implementation UITableViewCell (BPNIB)
/**
 *  @brief  加载同类名的nib
 *
 *  @return nib
 */
+ (UINib*)bp_nib{
   return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end
