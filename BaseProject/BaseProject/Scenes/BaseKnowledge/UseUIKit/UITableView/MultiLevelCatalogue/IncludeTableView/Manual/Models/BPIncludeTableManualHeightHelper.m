//
//  BPIncludeTableManualHeightHelper.m
//  BaseProject
//
//  Created by Ryan on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIncludeTableManualHeightHelper.h"
#import "BPMultiLevelCatalogueModel.h"
#import "BPMultiLevelCatalogueModel+BPHeight.h"
#import "MJExtension.h"

static CGFloat smallCellV = 20.0f;//top=15 + middle=5
static CGFloat smallHeadV = 9.0f;//top=9
static CGFloat bigHeadV = 25.0f;//top=25

static CGFloat smallCellH = 65.0f;
static CGFloat smallHeadH = 40.0f;
static CGFloat bigHeadH = 40.0f;

static CGFloat font = 15.0f;

static NSInteger limitNumber = 2;

@implementation BPIncludeTableManualHeightHelper

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
    [data.array enumerateObjectsUsingBlock:^(BPMultiLevelCatalogueModel1st *model, NSUInteger idx1, BOOL * _Nonnull stop) {
        [model.array_1st enumerateObjectsUsingBlock:^(BPMultiLevelCatalogueModel2nd *model2, NSUInteger idx2, BOOL * _Nonnull stop) {
            
            __block CGFloat smallHeight = 0.f;
            [model2.array_2nd enumerateObjectsUsingBlock:^(BPMultiLevelCatalogueModel3rd *model3, NSUInteger idx3, BOOL * _Nonnull stop) {
                model3.cellHeight = [model3.title_3rd heightWithFont:[UIFont systemFontOfSize:font] width:kScreenWidth-smallCellH lineSpace:1]  + [model3.brief_3rd heightWithFont:[UIFont systemFontOfSize:font] width:kScreenWidth-smallCellH lineSpace:4];
                if (model3.cellHeight > 0.01) {
                    model3.cellHeight += smallCellV;
                    model3.cellHeight = ceil(model3.cellHeight+kOnePixel);

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
            model2.headerHeight = [model2.title_2nd heightWithFont:[UIFont systemFontOfSize:font] width:kScreenWidth-smallHeadH lineSpace:4];
            if (model2.headerHeight > 0.01) {
                model2.headerHeight += smallHeadV;
                model2.headerHeight = ceil(model2.headerHeight);
            }
            smallHeight += model2.headerHeight;
            if (smallHeight > 0.01) {
                model2.cellHeight = smallHeight;
                 model2.cellHeight = ceil(model2.cellHeight + kOnePixel);
            }
        }];
        NSString *title_1st  = BPValidateString(model.title_1st);
        UIFont *textFont = [UIFont fontOfSize:font weight:UIFontWeightMedium];
        model.headerHeight = [title_1st heightWithFont:textFont width:kScreenWidth-bigHeadH lineSpace:1];
        if (model.headerHeight > 0.01 && idx1 > 0) {
            model.headerHeight += bigHeadV;
            model.headerHeight = ceil(model.headerHeight);
        }
    }];
}

@end
