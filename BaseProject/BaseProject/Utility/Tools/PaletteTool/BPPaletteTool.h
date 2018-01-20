//
//  BPPaletteTool.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPPaletteTool : UIView

- (void)handleColorWithImage:(UIImage *)image paletteViewBounds:(CGRect)bounds resultBlock:(void (^)(UIColor *color))success;

@end
