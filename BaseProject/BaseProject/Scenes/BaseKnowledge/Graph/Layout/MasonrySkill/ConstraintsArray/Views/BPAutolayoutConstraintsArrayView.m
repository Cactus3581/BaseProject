//
//  BPAutolayoutConstraintsArrayView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutolayoutConstraintsArrayView.h"

@interface BPAutolayoutConstraintsArrayView ()

@property (nonatomic, strong) NSMutableArray *animatableConstraints;
@property (nonatomic, assign) int padding;
@property (nonatomic, assign) BOOL animating;

@end

@implementation BPAutolayoutConstraintsArrayView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectZero];
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectZero];
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self addSubview:redView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectZero];
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];
    
    UIView *superview = self;
    int padding = self.padding = 10;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
    
    self.animatableConstraints = @[].mutableCopy;
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
                                                          make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
                                                          make.bottom.equalTo(blueView.mas_top).offset(-padding),
                                                          ]];
        
        make.size.equalTo(redView);
        make.height.equalTo(blueView.mas_height);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
                                                          make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
                                                          make.left.equalTo(greenView.mas_right).offset(padding),
                                                          make.bottom.equalTo(blueView.mas_top).offset(-padding),
                                                          ]];
        
        make.size.equalTo(greenView);
        make.height.equalTo(blueView.mas_height);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
                                                          make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
                                                          ]];
        make.height.equalTo(@[redView, greenView]);
    }];
    
    return self;
}

- (void)didMoveToWindow {
    [self layoutIfNeeded];
    
    if (self.window) {
        self.animating = YES;
        [self animateWithInvertedInsets:NO];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    self.animating = newWindow != nil;
}

- (void)animateWithInvertedInsets:(BOOL)invertedInsets {
    if (!self.animating) return;
    
    int padding = invertedInsets ? 100 : self.padding;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    for (MASConstraint *constraint in self.animatableConstraints) {
        constraint.insets = paddingInsets;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        //repeat!
        [self animateWithInvertedInsets:!invertedInsets];
    }];
}

@end
