//
//  BP1STManualHeightHelper.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP1STManualHeightHelper.h"
#import "BPMultiLevelCatalogueModel.h"
#import "MJExtension.h"

static CGFloat smallCellV = 20.0f;//top=15 + middle=5
static CGFloat smallHeadV = 9.0f;//top=10
static CGFloat bigHeadV = 25.0f;//top=25

static CGFloat smallCellH = 75.0f;//35+15+10+15
static CGFloat smallHeadH = 50.0f;//35+15
static CGFloat bigHeadH = 50.0f;//15+20+15

static CGFloat font = 15.0f;

static NSInteger limitNumber = 2;

@implementation BP1STManualHeightHelper

+ (void)handleData:(BPMultiLevelCatalogueModel *)data successblock:(dispatch_block_t)succeed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self handleData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (succeed) {
                succeed();
            }
        });
    });
}

+ (void)handleData:(BPMultiLevelCatalogueModel *)data {
    [data.array enumerateObjectsUsingBlock:^(BPMultiLevelCatalogueModel1st *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [model.array_1st enumerateObjectsUsingBlock:^(BPMultiLevelCatalogueModel2nd *model2, NSUInteger idx, BOOL * _Nonnull stop) {
            __block CGFloat smallHeight = 0.f;
            [model2.array_2nd enumerateObjectsUsingBlock:^(BPMultiLevelCatalogueModel3rd *model3, NSUInteger idx, BOOL * _Nonnull stop) {
                model3.cellHeight = [BP1STManualHeightHelper getHeightWithString:BPValidateString(model3.title_3rd) font:[UIFont systemFontOfSize:font] width:kScreenWidth-smallCellH lineSpace:1 kern:0] + [BP1STManualHeightHelper getHeightWithString:BPValidateString(model3.brief_3rd) font:[UIFont systemFontOfSize:font] width:kScreenWidth-smallCellH lineSpace:4 kern:0];
                if (model3.cellHeight > 0.01) {
                    model3.cellHeight += smallCellV;
                }
                /* 暂时用不到,如果用到了需要接口加个是否需要limit的参数，比如+ (void)handleData:(BPMultiLevelCatalogueModel *)data limit:(BOOL)limit
                 if (limit) {
                    if (idx + 1 <= limitNumber) {
                        smallHeight += model3.cellHeight;
                    }
                 }else {
                    smallHeight += model3.cellHeight;
                 }
                 */
                smallHeight += model3.cellHeight;
            }];
            model2.headerHeight = [BP1STManualHeightHelper getHeightWithString:BPValidateString(model2.title_2nd) font:[UIFont systemFontOfSize:font] width:kScreenWidth-smallHeadH lineSpace:4 kern:0];
            if (model2.headerHeight > 0.01) {
                model2.headerHeight += smallHeadV;
            }
            smallHeight += model2.headerHeight;
            if (smallHeight > 0.01) {
                model2.cellHeight = smallHeight;
            }
        }];
        NSString *cizu_name  = BPValidateString(model.title_1st);
        UIFont *textFont = [UIFont systemFontOfSize:font weight:UIFontWeightMedium];
        model.headerHeight = [BP1STManualHeightHelper getHeightWithString:cizu_name font:textFont width:kScreenWidth-bigHeadH lineSpace:1 kern:0];
        if (model.headerHeight > 0.01 && idx > 0) {
            model.headerHeight += bigHeadV;
        }
    }];
}

+ (CGFloat )getWidthWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern {
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
    return ceilf(size.width);
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
