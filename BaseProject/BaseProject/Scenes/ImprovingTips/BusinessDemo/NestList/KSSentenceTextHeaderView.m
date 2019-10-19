//
//  KSSentenceTextHeaderView.m
//  BaseProject
//
//  Created by Ryan on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSSentenceTextHeaderView.h"

CGFloat const KSSentenceTextHeaderViewHeight = 50;


@interface KSSentenceTextHeaderView()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation KSSentenceTextHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(KSDailySentenceContentModel *)model {
    _model = model;
    _titleLabel.text = model.title;
}

@end
