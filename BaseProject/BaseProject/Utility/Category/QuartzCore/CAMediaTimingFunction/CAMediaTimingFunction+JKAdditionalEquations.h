//
//  CAMediaTimingFunction+AdditionalEquations.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAMediaTimingFunction (JKAdditionalEquations)


///---------------------------------------------------------------------------------------
/// @name Circ Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)_easeInCirc;
+(CAMediaTimingFunction *)_easeOutCirc;
+(CAMediaTimingFunction *)_easeInOutCirc;

///---------------------------------------------------------------------------------------
/// @name Cubic Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)_easeInCubic;
+(CAMediaTimingFunction *)_easeOutCubic;
+(CAMediaTimingFunction *)_easeInOutCubic;

///---------------------------------------------------------------------------------------
/// @name Expo Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)_easeInExpo;
+(CAMediaTimingFunction *)_easeOutExpo;
+(CAMediaTimingFunction *)_easeInOutExpo;

///---------------------------------------------------------------------------------------
/// @name Quad Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)_easeInQuad;
+(CAMediaTimingFunction *)_easeOutQuad;
+(CAMediaTimingFunction *)_easeInOutQuad;

///---------------------------------------------------------------------------------------
/// @name Quart Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)_easeInQuart;
+(CAMediaTimingFunction *)_easeOutQuart;
+(CAMediaTimingFunction *)_easeInOutQuart;

///---------------------------------------------------------------------------------------
/// @name Quint Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)_easeInQuint;
+(CAMediaTimingFunction *)_easeOutQuint;
+(CAMediaTimingFunction *)_easeInOutQuint;

///---------------------------------------------------------------------------------------
/// @name Sine Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)_easeInSine;
+(CAMediaTimingFunction *)_easeOutSine;
+(CAMediaTimingFunction *)_easeInOutSine;

///---------------------------------------------------------------------------------------
/// @name Back Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)_easeInBack;
+(CAMediaTimingFunction *)_easeOutBack;
+(CAMediaTimingFunction *)_easeInOutBack;

@end
