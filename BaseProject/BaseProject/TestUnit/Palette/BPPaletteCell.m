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
        self.contentView.backgroundColor = [UIColor darkGrayColor];
        
        _showColorLabel = [[UILabel alloc]init];
        _showColorLabel.textColor = [UIColor whiteColor];
        _showColorLabel.textAlignment = NSTextAlignmentCenter;

        _showColorLabel.shadowColor = [UIColor darkGrayColor];
        _showColorLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
        _showColorLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:_showColorLabel];
        
        _showPercentageLabel = [[UILabel alloc]init];
        _showPercentageLabel.textAlignment = NSTextAlignmentCenter;
        _showPercentageLabel.textColor = [UIColor whiteColor];
        _showPercentageLabel.shadowColor = [UIColor darkGrayColor];
        _showPercentageLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
        _showPercentageLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:_showPercentageLabel];
        
        [_showColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(_showPercentageLabel.mas_top);
        }];
        [_showPercentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.contentView);
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
        NSLog(@"%@",model.imageColorString);
        self.contentView.backgroundColor = [UIColor colorWithHexString:(model.imageColorString)];
    }
    _showColorLabel.text = showText;
    _showPercentageLabel.text = percentageText;
}

@end
