//
//  UIBezierPath+JKSVGString.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (JKSVGString)
/**
 *  @brief  UIBezierPath转成SVG
 *
 *  @return SVG
 */
- (NSString*)bp_SVGString;
@end
