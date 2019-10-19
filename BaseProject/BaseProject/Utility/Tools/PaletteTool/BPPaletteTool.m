//
//  BPPaletteTool.m
//  BaseProject
//
//  Created by Ryan on 2018/1/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPaletteTool.h"
#import "Palette.h"
#import "UIImage+Palette.h"
#import "UIColor+BPAdd.h"

static NSString *kPaletteDefaultColor = @"#000000";

@interface BPPaletteTool ()<NSCacheDelegate>
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) NSString *url;

@property (nonatomic,assign) CGRect paletteViewBounds;
@property (nonatomic,strong) NSMutableArray *colorArray;
@property (nonatomic,strong) NSMutableSet *set;//缓存机制
@property (nonatomic,strong) NSCache *cache;
@end

@implementation BPPaletteTool

- (void)handleColorWithImage:(UIImage *)image url:(NSString *)url paletteViewBounds:(CGRect)bounds resultBlock:(void (^)(UIColor *color))success {
    _url = url;
    if (BPValidateString(url).length) {
        UIColor *color = [self checkCacheWithKey:url];
        if (color) {
            success(color);
        }else {
            __weak typeof (self) weaBPelf = self;
            [self handleColorWithImage:image url:url paletteViewBounds:bounds resultBlock:^(UIColor *color) {
                __strong typeof (weaBPelf) strongSelf = weaBPelf;
                [strongSelf addCacheWithObj:color key:url];
                if (strongSelf) {
                    if (success) {
                        success(color);
                    }
                }
            }];
        }
    }else {
        __weak typeof (self) weaBPelf = self;
        [self handleColorWithImage:image paletteViewBounds:bounds resultBlock:^(UIColor *color) {
            __strong typeof (weaBPelf) strongSelf = weaBPelf;
            if (strongSelf) {
                if (success) {
                    success(color);
                }
            }
        }];
    }
}

- (void)handleColorWithImage:(UIImage *)image paletteViewBounds:(CGRect)bounds resultBlock:(void (^)(UIColor *color))success {
    _image = image;
    _paletteViewBounds = bounds;
    //TODO 加个缓存机制，防止多次计算同一张图片的色值;NSCache;ios UIImage isEqual ==
    if (!image) {
        return;
    }
    __weak typeof (self) weaBPelf = self;
    [self.image getPaletteImageColorWithMode:ALL_MODE_PALETTE withCallBack:^(PaletteColorModel *recommendColor, NSDictionary *allModeColorDic,NSError *error) {
        __strong typeof (weaBPelf) strongSelf = weaBPelf;
        if (strongSelf) {
            NSString *imageColorString = [strongSelf choiceColorWithDic:allModeColorDic];
            UIColor *color = [strongSelf mergeColorWithHexString:imageColorString];
            if (success) {
                success(color);
            }
        }
    }];
}

- (NSString *)choiceColorWithDic:(NSDictionary *)dic {
    if (!BPValidateDict(dic).allKeys.count) {
        return kPaletteDefaultColor;
    }
    NSArray *array = @[@"dark_vibrant",@"muted",@"dark_muted",@"vibrant"];
    for (int i = 0; i < array.count; i++) {
        PaletteColorModel * model = [dic objectForKey:array[i]];
        if (![model isKindOfClass:[PaletteColorModel class]]){
            BPLog(@"识别失败");
        }else {
            return model.imageColorString;
        }
    }
    return kPaletteDefaultColor;
}

- (UIColor *)mergeColorWithHexString:(NSString *)hexString {
    UIColor *color =  [UIColor bp_colorWithHexString:hexString];
    UIColor *alphaColor1 = [color colorWithAlphaComponent:0.0];
    UIColor *alphaColor2 = [color colorWithAlphaComponent:1.0];
    [self.colorArray removeAllObjects];
    [self.colorArray addObject:alphaColor1];
    [self.colorArray addObject:alphaColor2];
    UIColor *mergeColor = [UIColor bp_colorWithGradientStyle:BPGradientStyleTopToBottom withFrame:_paletteViewBounds andColors:self.colorArray.copy];
    return mergeColor;
}

- (NSMutableSet *)set {
    if (!_set) {
        _set = [NSMutableSet set];
    }
    return _set;
}

- (NSCache *)cache{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.totalCostLimit = 0;
        _cache.countLimit = 0;
        _cache.delegate = self;
    }
    return _cache;
}

// 添加缓存
- (void)addCacheWithObj:(id)obj key:(NSString *)key {
    //[self.cache setObject:obj forKey:key cost:1];
    [self.cache setObject:obj forKey:key];
}

// 检查缓存
- (UIColor *)checkCacheWithKey:(NSString *)key {
    UIColor *color = [self.cache objectForKey:key];
    if (color) {
        return color;
    }
    return nil;
}

// 清理缓存
- (void)deleteCache {
    [self.cache removeAllObjects];
}

#pragma mark - NSCacheDelegate
// 即将回收对象的时候进行调用，实现代理方法之前要遵守NSCacheDelegate协议。
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    BPLog(@"回收--------%@",obj);
}

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}

@end
