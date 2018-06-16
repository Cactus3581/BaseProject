//
//  UITextField+History.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (BPHistory)

/**
 *  identity of this textfield
 */
@property (retain, nonatomic) NSString *bp_identify;

/**
 *  load textfiled input history
 *
 *
 *  @return the history of it's input
 */
- (NSArray *)bp_loadHistroy;

/**
 *  save current input text
 */
- (void)bp_synchronize;

- (void)bp_showHistory;
- (void)bp_hideHistroy;

- (void)bp_clearHistory;

@end
