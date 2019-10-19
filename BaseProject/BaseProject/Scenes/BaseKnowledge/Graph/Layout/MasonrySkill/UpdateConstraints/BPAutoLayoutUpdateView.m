//
//  BPAutoLayoutUpdateView.m
//  BaseProject
//
//  Created by Ryan on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoLayoutUpdateView.h"

static CGFloat const kArrayExampleIncrement = 10.0;

@interface BPAutoLayoutUpdateView ()
@property (nonatomic, strong) NSArray *buttonViews;
@property (nonatomic, assign) CGFloat offset;
@end

@implementation BPAutoLayoutUpdateView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeSubViews];
    }
    return self;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    
    [self.buttonViews mas_updateConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.mas_centerY).with.offset(self.offset);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)setOffset:(CGFloat)offset {
    
    _offset = offset;
    
    if (self.animate) {
        // tell constraints they need updating
        [self setNeedsUpdateConstraints];
        
        // update constraints now so we can animate the change
        [self updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    }else {
        [self setNeedsUpdateConstraints];
    }
}

- (void)initializeSubViews {
    UIButton *raiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [raiseButton setTitle:@"Raise" forState:UIControlStateNormal];
    raiseButton.backgroundColor = kExplicitColor;
    raiseButton.titleLabel.textColor = kWhiteColor;
    [raiseButton addTarget:self action:@selector(raiseAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:raiseButton];
    
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerButton setTitle:@"Center" forState:UIControlStateNormal];
    centerButton.backgroundColor = kThemeColor;
    centerButton.titleLabel.textColor = kWhiteColor;
    [centerButton addTarget:self action:@selector(centerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:centerButton];
    
    UIButton *lowerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lowerButton setTitle:@"Lower" forState:UIControlStateNormal];
    lowerButton.backgroundColor = kExplicitColor;
    lowerButton.titleLabel.textColor = kWhiteColor;
    [lowerButton addTarget:self action:@selector(lowerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lowerButton];
    
    [lowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10.0);
    }];
    
    [centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
    }];
    
    [raiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
    }];
    
    self.buttonViews = @[ raiseButton, lowerButton, centerButton ];
}

- (void)centerAction {
    self.offset = 0.0;
}

- (void)raiseAction {
    self.offset -= kArrayExampleIncrement;
}

- (void)lowerAction {
    self.offset += kArrayExampleIncrement;
}

@end
