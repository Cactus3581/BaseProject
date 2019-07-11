//
//  BPAsyncDrawLabel.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/3.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPAsyncDrawLabel : UIView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic) NSInteger lineSpace;
@property (nonatomic) NSTextAlignment textAlignment;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
