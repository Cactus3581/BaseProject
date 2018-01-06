//
//  BPPaletteView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/3.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPaletteView.h"
#import "Palette.h"
#import "UIImage+Palette.h"
#import "UIColor+BPAdd.h"
#import "UIColor+Hex.h"

@interface BPPaletteView ()
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSMutableArray *colorArray;
@end

@implementation BPPaletteView

- (void)handleColorWithImage:(UIImage *)image {
    _image = image;
    //TODO 加个缓存机制，防止多次计算同一张图片的色值
    if (!image) {
        return;
    }
    __weak typeof (self) weakSelf = self;
    [self.image getPaletteImageColorWithMode:ALL_MODE_PALETTE withCallBack:^(PaletteColorModel *recommendColor, NSDictionary *allModeColorDic,NSError *error) {
        if (!recommendColor) {
            BPLog(@"识别失败");
            return;
        }
        
        PaletteColorModel * model = [allModeColorDic objectForKey:@"dark_muted"];
        if (![model isKindOfClass:[PaletteColorModel class]]){
            BPLog(@"识别失败");
        }else{
            [weakSelf mergeColorWithHexString:model.imageColorString];
        }
    }];
}

- (void)mergeColorWithHexString:(NSString *)hexString {
    if (!BPValidateString(hexString).length) {
        return;
    }
    UIColor *color = [UIColor colorWithHexString:hexString];
    UIColor *alphaColor1 = [color colorWithAlphaComponent:0.2];
    UIColor *alphaColor2 = [color colorWithAlphaComponent:0.5];
    UIColor *alphaColor3 = [color colorWithAlphaComponent:0.7];
    [self.colorArray removeAllObjects];
    [self.colorArray addObject:alphaColor1];
    [self.colorArray addObject:alphaColor2];
    [self.colorArray addObject:alphaColor3];
    UIColor *mergeColor = [UIColor bp_colorWithGradientStyle:BPGradientStyleTopToBottom withFrame:self.frame andColors:self.colorArray.copy];
    self.backgroundColor = mergeColor;
}

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}

@end