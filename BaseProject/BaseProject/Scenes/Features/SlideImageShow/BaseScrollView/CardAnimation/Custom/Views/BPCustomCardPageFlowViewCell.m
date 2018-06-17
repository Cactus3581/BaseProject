//
//  BPCustomCardPageFlowViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCustomCardPageFlowViewCell.h"

@interface BPCustomCardPageFlowViewCell ()

@end

@implementation BPCustomCardPageFlowViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.indexLabel];
    }
    
    return self;
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = self.bounds;
    self.indexLabel.frame = CGRectMake(0, 10, superViewBounds.size.width, 20);
}

- (UILabel *)indexLabel {
    if (_indexLabel == nil) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _indexLabel.font = [UIFont systemFontOfSize:16.0];
        _indexLabel.textColor = kWhiteColor;
    }
    return _indexLabel;
}

@end
