//
//  BPPaletteCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/3.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPaletteCell.h"
#import "UIColor+BPAdd.h"
#import "UIColor+Hex.h"

@interface BPPaletteCell ()
@property (nonatomic,strong) UILabel *showColorLabel;
@property (nonatomic,strong) UILabel *showPercentageLabel;
@end

@implementation BPPaletteCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.contentView.backgroundColor = kDarkGrayColor;
        
        _showColorLabel = [[UILabel alloc]init];
        _showColorLabel.textColor = kWhiteColor;
        _showColorLabel.textAlignment = NSTextAlignmentCenter;

        _showColorLabel.shadowColor = kDarkGrayColor;
        _showColorLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
        _showColorLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:_showColorLabel];
        
        _showPercentageLabel = [[UILabel alloc]init];
        _showPercentageLabel.textAlignment = NSTextAlignmentCenter;
        _showPercentageLabel.textColor = kWhiteColor;
        _showPercentageLabel.shadowColor = kDarkGrayColor;
        _showPercentageLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
        _showPercentageLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:_showPercentageLabel];
        
        [_showColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.contentView);
            make.bottom.equalTo(_showPercentageLabel.mas_top);
        }];
        [_showPercentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.leading.trailing.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configureData:(PaletteColorModel*)model andKey:(NSString *)modeKey{
    NSString *showText;
    NSString *percentageText;
    if (![model isKindOfClass:[PaletteColorModel class]]){
        showText = [NSString stringWithFormat:@"%@:识别失败",modeKey];
    }else{
        showText = [NSString stringWithFormat:@"%@:%@",modeKey,model.imageColorString];
        percentageText = [NSString stringWithFormat:@"%.1f%@",model.percentage*100,@"%"];
        BPLog(@"%@",model.imageColorString);
        self.contentView.backgroundColor = [UIColor colorWithHexString:(model.imageColorString)];
    }
    _showColorLabel.text = showText;
    _showPercentageLabel.text = percentageText;
}

@end
