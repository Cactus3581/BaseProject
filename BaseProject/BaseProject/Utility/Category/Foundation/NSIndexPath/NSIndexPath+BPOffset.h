//
//  NSIndexPath+Offset.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NSIndexPath (BPOffset)
/**
 *
 *  Compute previous row indexpath
 *
 */
- (NSIndexPath *)_previousRow;
/**
 *
 *  Compute next row indexpath
 *
 */
- (NSIndexPath *)_nextRow;
/**
 *
 *  Compute previous item indexpath
 *
 */
- (NSIndexPath *)_previousItem;
/**
 *
 *  Compute next item indexpath
 *
 */
- (NSIndexPath *)_nextItem;
/**
 *
 *  Compute next section indexpath
 *
 */
- (NSIndexPath *)_nextSection;
/**
 *
 *  Compute previous section indexpath
 *
 */
- (NSIndexPath *)_previousSection;

@end
