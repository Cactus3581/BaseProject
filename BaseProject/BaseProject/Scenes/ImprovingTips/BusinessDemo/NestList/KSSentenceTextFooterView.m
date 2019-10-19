//
//  KSSentenceTextFooterView.m
//  BaseProject
//
//  Created by Ryan on 2019/4/30.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSSentenceTextFooterView.h"

CGFloat const KSSentenceTextFooterViewHeight = 65;

@interface KSSentenceTextFooterView()

@property (weak, nonatomic) IBOutlet UIButton *expansionButton;

@end


@implementation KSSentenceTextFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_expansionButton setTitle:@"展开主题" forState:UIControlStateNormal];
    [_expansionButton setTitle:@"收起主题" forState:UIControlStateSelected];
}

- (IBAction)expansionAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(sentenceTextFooterView:isExpansion:)]) {
        _expansionButton.selected = !_expansionButton.selected;
        [_delegate sentenceTextFooterView:self isExpansion:_expansionButton.selected];
    }
}

@end
