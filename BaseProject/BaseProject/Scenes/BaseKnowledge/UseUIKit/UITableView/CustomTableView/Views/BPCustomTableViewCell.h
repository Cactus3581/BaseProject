//
//  BPCustomTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/8/20.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPCustomTableViewCell : UIView

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIView *lineView;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
