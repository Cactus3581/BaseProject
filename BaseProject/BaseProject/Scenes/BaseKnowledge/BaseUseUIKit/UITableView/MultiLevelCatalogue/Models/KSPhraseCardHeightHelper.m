//
//  KSPhraseCardHeightHelper.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSPhraseCardHeightHelper.h"
#import "KSMultiLevelCatalogueModel.h"

static CGFloat smallCellV = 25.0f;//top=20 + middle=5
static CGFloat smallHeadV = 10.0f;//top=10
static CGFloat bigHeadV = 25.0f;//top=25

static CGFloat smallCellH = 75.0f;//35+15+10+15
static CGFloat smallHeadH = 50.0f;//35+15
static CGFloat bigHeadH = 30.0f;//15+15

static CGFloat font = 15.0f;

static NSInteger limitNumber = 2;

@implementation KSPhraseCardHeightHelper

+ (void)handleData:(KSMultiLevelCatalogueModel *)data successblock:(dispatch_block_t)succeed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self handleData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (succeed) {
                succeed();
            }
        });
    });
}

+ (void)handleData:(KSMultiLevelCatalogueModel *)data {
    [data.array enumerateObjectsUsingBlock:^(KSMultiLevelCatalogueModel1st *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [model.array_1st enumerateObjectsUsingBlock:^(KSMultiLevelCatalogueModel2nd *jxModel, NSUInteger idx, BOOL * _Nonnull stop) {
            __block CGFloat smallHeight = 0.f;
            [jxModel.array_2nd enumerateObjectsUsingBlock:^(KSMultiLevelCatalogueModel3rd *jxLjModel, NSUInteger idx, BOOL * _Nonnull stop) {
                jxLjModel.cellHeight = [KSPhraseCardHeightHelper getHeightWithString:BPValidateString(jxLjModel.title_3rd) font:[UIFont systemFontOfSize:font] width:kScreenWidth-smallCellH lineSpace:1 kern:0] + [KSPhraseCardHeightHelper getHeightWithString:BPValidateString(jxLjModel.brief_3rd) font:[UIFont systemFontOfSize:font] width:kScreenWidth-smallCellH lineSpace:4 kern:0];
                if (jxLjModel.cellHeight > 0.01) {
                    jxLjModel.cellHeight += smallCellV;
                }
                /* 暂时用不到,如果用到了需要接口加个是否需要limit的参数，比如+ (void)handleData:(KSDictionaryPhrase *)data limit:(BOOL)limit
                 if (limit) {
                    if (idx + 1 <= limitNumber) {
                    smallHeight += jxLjModel.cellHeight;
                 }
                 }else {
                    smallHeight += jxLjModel.cellHeight;
                 }
                 */
                smallHeight += jxLjModel.cellHeight;
            }];
            jxModel.headerHeight = [KSPhraseCardHeightHelper getHeightWithString:BPValidateString(jxModel.title_2nd) font:[UIFont systemFontOfSize:font] width:kScreenWidth-smallHeadH lineSpace:4 kern:0];
            if (jxModel.headerHeight > 0.01) {
                jxModel.headerHeight += smallHeadV;
            }
            smallHeight += jxModel.headerHeight;
            if (smallHeight > 0.01) {
                jxModel.cellHeight = smallHeight;
            }
        }];
        NSString *str  = BPValidateString(model.title_1st);
        if (model.title_1st.length) {
            str = [NSString stringWithFormat:@"%ld. %@",idx,str];
        }
        UIFont *textFont;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.2) {
            textFont = [UIFont systemFontOfSize:font];
        } else {
            textFont = [UIFont systemFontOfSize:font weight:UIFontWeightMedium];
        }
        model.headerHeight = [KSPhraseCardHeightHelper getHeightWithString:str font:textFont width:kScreenWidth-bigHeadH lineSpace:1 kern:0];
        if (model.headerHeight > 0.01 && idx > 0) {
            model.headerHeight += bigHeadV;
        }
    }];
}

+ (CGFloat )getHeight:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    if (!BPValidateString(string).length) {
        return 0;
    }
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return ceilf(size.height);
}

+ (CGFloat )getHeightWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern {
    if (!BPValidateString(string).length) {
        return 0;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;//设置行间距
    NSDictionary *attriDict = @{
                                NSParagraphStyleAttributeName:paragraphStyle,
                                //NSKernAttributeName:@(kern),//字间距
                                NSFontAttributeName:font
                                };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attriDict context:nil].size;
    return ceilf(size.height);
}

@end
