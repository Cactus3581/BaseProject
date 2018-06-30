//
//  BPPreferredMaxLayoutWidthView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPreferredMaxLayoutWidthView.h"


static UIEdgeInsets const kPadding = {10, 10, 10, 10};

@interface BPPreferredMaxLayoutWidthView ()

@property (nonatomic, strong) UILabel *shortLabel;
@property (nonatomic, strong) UILabel *longLabel;

@end

@implementation BPPreferredMaxLayoutWidthView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeSubViews];
    }
    return self;
}

- (void)initializeSubViews {
    self.shortLabel = [[UILabel alloc] init];
    self.shortLabel.numberOfLines = 1;
    self.shortLabel.textColor = [UIColor purpleColor];
    self.shortLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.shortLabel.text = @"Bacon";
    [self addSubview:self.shortLabel];
    
    self.longLabel = [[UILabel alloc] init];
    self.longLabel.numberOfLines = 8;
    self.longLabel.textColor = [UIColor darkGrayColor];
    self.longLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.longLabel.text = @"Bacon ipsum dolor sit amet spare ribs fatback kielbasa salami, tri-tip jowl pastrami flank short loin rump sirloin. Tenderloin frankfurter chicken biltong rump chuck filet mignon pork t-bone flank ham hock.";
    [self addSubview:self.longLabel];
    
    [self.longLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(kPadding.left);
        make.top.equalTo(self).offset(kPadding.top);
    }];
    
    [self.shortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.longLabel.mas_lastBaseline);
        make.top.equalTo(self.longLabel.mas_bottom);

        make.trailing.equalTo(self).insets(kPadding);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // for multiline UILabel's you need set the preferredMaxLayoutWidth
    // you need to do this after [super layoutSubviews] as the frames will have a value from Auto Layout at this point
    
    // stay tuned for new easier way todo this coming soon to Masonry
    
    CGFloat width = CGRectGetMinX(self.shortLabel.frame) - kPadding.left;
    width -= CGRectGetMinX(self.longLabel.frame);
    self.longLabel.preferredMaxLayoutWidth = width;
    
    // need to layoutSubviews again as frames need to recalculated with preferredLayoutWidth
    [super layoutSubviews];
}

@end
