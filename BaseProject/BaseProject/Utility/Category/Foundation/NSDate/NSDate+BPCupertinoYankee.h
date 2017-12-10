// NSDate+CupertinoYankee.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 */
@interface NSDate (BPCupertinoYankee)

///---------------------------------------
/// @name Calculate Beginning / End of Day
///---------------------------------------

/**
 
 */
- (NSDate *)_beginningOfDay;

/**
 
 */
- (NSDate *)_endOfDay;

///----------------------------------------
/// @name Calculate Beginning / End of Week
///----------------------------------------

/**
 
 */
- (NSDate *)_beginningOfWeek;

/**
 
 */
- (NSDate *)_endOfWeek;

///-----------------------------------------
/// @name Calculate Beginning / End of Month
///-----------------------------------------

/**
 
 */
- (NSDate *)_beginningOfMonth;

/**
 
 */
- (NSDate *)_endOfMonth;

///----------------------------------------
/// @name Calculate Beginning / End of Year
///----------------------------------------

/**
 
 */
- (NSDate *)_beginningOfYear;

/**
 
 */
- (NSDate *)_endOfYear;

@end
