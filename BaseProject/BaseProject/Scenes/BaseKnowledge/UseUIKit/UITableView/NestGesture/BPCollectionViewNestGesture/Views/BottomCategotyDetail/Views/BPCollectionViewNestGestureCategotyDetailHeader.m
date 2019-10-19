//
//  BPCollectionViewNestGestureCategotyDetailHeader.m
//  BaseProject
//
//  Created by Ryan on 2018/6/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCollectionViewNestGestureCategotyDetailHeader.h"

@interface BPCollectionViewNestGestureCategotyDetailHeader()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation BPCollectionViewNestGestureCategotyDetailHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    self.titleLabel.backgroundColor = kWhiteColor;
}

@end
