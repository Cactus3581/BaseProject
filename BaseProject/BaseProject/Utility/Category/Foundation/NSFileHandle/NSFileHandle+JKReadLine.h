//
//  NSFileHandle+readLine.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

// A Cocoa / Objective-C NSFileHandle category that adds the ability to read a file line by line.
//https://github.com/arbalest/NSFileHandle-readLine
#import <Foundation/Foundation.h>

@interface NSFileHandle (JKReadLine)
/**
 *  @brief   A Cocoa / Objective-C NSFileHandle category that adds the ability to read a file line by line.

 *
 *  @param theDelimier 分隔符
 *
 *  @return An NSData* object is returned with the line if found, or nil if no more lines were found
 */
- (NSData *)_readLineWithDelimiter:(NSString *)theDelimier;

@end
