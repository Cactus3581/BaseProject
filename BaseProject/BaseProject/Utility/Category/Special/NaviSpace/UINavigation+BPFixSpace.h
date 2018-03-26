//
//  UINavigation+BPFixSpace.h
//  UINavigation-BPFixSpace
//
//  Created by xiaruzhen on 2017/9/8.
//  Copyright © 2017年 cactus. All rights reserved.
//

/**
 
 此类是主要类；
 该类的作用是通过 hook layoutsubviews，将navibar的margins置为0.
 
 */

#import <UIKit/UIKit.h>

#ifndef bp_defaultFixSpace
#define bp_defaultFixSpace 0
#endif

/**
 实现此类的目的：
 1. hook viewWillDisappear和viewWillDisappear:设置tableView的Behavior；单独处理UIImagePickerController；
 2. hook push和pop：对过度动画特殊处理，利用下面的分类将margins置为0；
 */
@interface UINavigationController (BPFixSpace)
@end

/**
 实现此类的目的：
 1. hook layoutSubviews：将margins置为0；主要！！！
 */
@interface UINavigationBar (BPFixSpace)
@end

@interface UINavigationItem (BPFixSpace)
@end

