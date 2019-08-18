//
//  BPTableViewSectionFooterView.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/8/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPTableViewSectionFooterView.h"

@implementation BPTableViewSectionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    
    UIView *view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    view.backgroundColor = kWhiteColor;
    self.backgroundView = view;

    UILabel *label = [[UILabel alloc] init];
    _label = label;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
