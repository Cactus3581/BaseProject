//
//  BPAlignmentRectInsetsTemplateView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAlignmentRectInsetsTemplateView.h"
@interface BPAlignmentRectInsetsTemplateView()

@property (strong, nonatomic) NSArray *array;
@end
@implementation BPAlignmentRectInsetsTemplateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setText];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setText];
}

- (void)updateIndex:(NSInteger)index text:(NSString *)text {
    UILabel *label = self.array[index];
    label.text = text;
}

- (void)setText {
    self.backgroundColor = kThemeColor;
    self.label1.backgroundColor = kWhiteColor;
    self.label1.textColor = kThemeColor;
    
    self.label2.backgroundColor = kWhiteColor;
    self.label2.textColor = kThemeColor;
    
    self.label3.backgroundColor = kWhiteColor;
    self.label3.textColor = kThemeColor;
    
    self.label4.backgroundColor = kWhiteColor;
    self.label4.textColor = kThemeColor;
    self.array = @[self.label1,self.label2,self.label3,self.label4];
}

@end
