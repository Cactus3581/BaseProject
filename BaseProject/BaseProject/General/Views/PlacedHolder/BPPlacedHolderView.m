//
//  BPPlacedHolderView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/10/24.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPPlacedHolderView.h"

@interface BPPlacedHolderView()

@end

@implementation BPPlacedHolderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.textLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.reloadButton.layer.cornerRadius = 4;
    self.reloadButton.layer.masksToBounds = YES;
    [self.reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.reloadButton.backgroundColor = kThemeColor;
}

@end
