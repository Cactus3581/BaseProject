//
//  BPCircleProgressButton.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/8/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPCircleProgressButton : UIButton
@property (nonatomic,assign) CGFloat progress;// 更新进度

@property (nonatomic,strong) UIColor *progressColor;
@property (nonatomic,strong) UIColor *borderColor;

@property (nonatomic,assign) BOOL progressHidden;
@property (nonatomic,assign) BOOL borderHidden;
@end
