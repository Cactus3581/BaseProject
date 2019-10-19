//
//  BPCalendarAppearance.h
//  BaseProject
//
//  Created by Ryan on 2017/11/30.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPCalendarAppearance : NSObject

+ (instancetype)appearance;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic,assign) CGFloat  ymFont;
@property (nonatomic,assign) CGFloat  weekFont;
@property (nonatomic,assign) CGFloat  dayFont;

@property (nonatomic,strong) UIColor  *ymColor;
@property (nonatomic,strong) UIColor  *weekColor;
@property (nonatomic,strong) UIColor  *dayColor;

@property (nonatomic,strong) UIColor  *ymBackColor;
@property (nonatomic,strong) UIColor  *weekBackColor;
@property (nonatomic,strong) UIColor  *dayBackColor;

@property (nonatomic,strong) UIColor  *lineColor;

@end

