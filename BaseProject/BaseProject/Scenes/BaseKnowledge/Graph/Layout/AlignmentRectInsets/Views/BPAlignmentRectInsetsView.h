//
//  BPAlignmentRectInsetsView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPAlignmentRectInsetsView : UIView
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

- (void)updateIndex:(NSInteger)index text:(NSString *)text ;
@end
