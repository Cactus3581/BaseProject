//
//  BPLayoutProcessView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPLayoutProcessView : UIView

@property (nonatomic,weak) UIButton *button;

- (void)changeSize;
- (void)changeCenter;

- (void)changeSubViewSize;
- (void)changeSubViewCenter;
@end
