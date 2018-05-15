//
//  BPTagCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagCell.h"

#import "Masonry.h"

@interface BPTagCell ()

@end

@implementation BPTagCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _textLabel = [[UILabel alloc] init];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    _textLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_textLabel];
    
    [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView).offset(0);
        make.width.equalTo(self);
    }];
}

- (void)setModel:(BPTagModel *)model {
    _model = model;
    _textLabel.text = model.name;
    if (self.type == BPTagCellTypeSelected1) {
        
        _textLabel.layer.cornerRadius = 4;
        _textLabel.layer.backgroundColor = [UIColor purpleColor].CGColor;
        [_textLabel setTextColor:[UIColor whiteColor]];
    } else {
        if (!model.isChoose) {
            [_textLabel setTextColor:[UIColor purpleColor]];
            _textLabel.layer.cornerRadius = 4;
            _textLabel.layer.borderColor = [UIColor purpleColor].CGColor;
            _textLabel.layer.borderWidth = 0.5;
        } else {
            [_textLabel setTextColor:[UIColor purpleColor]];
            _textLabel.layer.borderWidth = 0.5;
            _textLabel.layer.cornerRadius = 4;
            _textLabel.layer.borderColor = [UIColor purpleColor].CGColor;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self);
}

@end

