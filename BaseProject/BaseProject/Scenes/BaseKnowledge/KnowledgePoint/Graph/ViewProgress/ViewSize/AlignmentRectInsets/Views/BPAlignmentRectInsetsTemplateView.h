//
//  BPAlignmentRectInsetsTemplateView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPAlignmentRectInsetsLabel.h"

@interface BPAlignmentRectInsetsTemplateView : UIView

@property (weak, nonatomic) IBOutlet BPAlignmentRectInsetsLabel *label1;
@property (weak, nonatomic) IBOutlet BPAlignmentRectInsetsLabel *label2;
@property (weak, nonatomic) IBOutlet BPAlignmentRectInsetsLabel *label3;
@property (weak, nonatomic) IBOutlet BPAlignmentRectInsetsLabel *label4;
- (void)updateIndex:(NSInteger)index text:(NSString *)text ;

@end
