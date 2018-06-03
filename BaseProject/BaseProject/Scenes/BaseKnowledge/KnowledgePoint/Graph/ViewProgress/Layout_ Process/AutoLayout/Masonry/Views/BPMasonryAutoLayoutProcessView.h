//
//  BPMasonryAutoLayoutProcessView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPMasonryAutoLayoutProcessView : UIView

@property (nonatomic,weak) UIButton *button;

- (void)changeSize;
- (void)changeCenter;

- (void)changeSubViewSize;
- (void)changeSubViewCenter;

@end
