//
//  BPMainPageSpeakBannerCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMainPageSpeakBannerCollectionViewCell.h"
#import "BPInsideSliderShowView.h"

@interface BPMainPageSpeakBannerCollectionViewCell ()
@property (weak, nonatomic) BPInsideSliderShowView *sliderShowView;
@end

@implementation BPMainPageSpeakBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.contentView.backgroundColor = [UIColor redColor];
    self.sliderShowView.imageArray = @[kRedColor,kYellowColor,kBlueColor];
    self.sliderShowView.clickImageBlock = ^(NSInteger currentIndex) {

    };
}

- (BPInsideSliderShowView *)sliderShowView {
    if (!_sliderShowView) {
        BPInsideSliderShowView *sliderShowView = [[BPInsideSliderShowView alloc] init];
        _sliderShowView = sliderShowView ;
        _sliderShowView.placeHolderImage = [UIImage imageNamed:@"cactus_theme"];
        [self.contentView addSubview:_sliderShowView];
        [_sliderShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _sliderShowView;
}

@end
