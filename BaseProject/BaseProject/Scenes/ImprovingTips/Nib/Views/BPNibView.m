//
//  BPNibView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/8/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNibView.h"
@interface BPNibView()
@property (weak, nonatomic) IBOutlet UILabel *firstLabelInView;
@property (weak, nonatomic) IBOutlet UIView *secondBackViewInView;
@property (weak, nonatomic) IBOutlet UILabel *secondLabelInView;

@end

@implementation BPNibView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // view中的xib的第二个平行view
    self.secondBackViewInView.backgroundColor = kRedColor;
    [self addSubview:self.secondBackViewInView];
}

- (void)layoutSubviews {
    self.secondBackViewInView.frame = CGRectMake(0, 60, 375, 40);
}

@end
