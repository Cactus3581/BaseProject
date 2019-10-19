//
//  BPDataTool.h
//  BaseProject
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSInteger second = 3600;

NS_ASSUME_NONNULL_BEGIN

/**
 判断是否为字符串
 
 @return 字符串
 */
static inline NSString * BPValidateString(NSString *rawString) {
    if (!rawString || [rawString isKindOfClass: [NSNull class]]) {
        return @"";
    }
    if (![rawString isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@", rawString];
    }
    return rawString;
};


//文字宽度处理
static inline CGSize BPStringSize(NSString *rawString,UIFont *font) {
    NSString *string = BPValidateString(rawString);
    return [string length] > 0 ? [string sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
};

static inline CGSize BPMultiineStringSize(NSString *rawString,UIFont *font,CGSize maxSize,NSStringDrawingOptions mode) {
    NSString *string = BPValidateString(rawString);
    return [string length] > 0 ? [string boundingRectWithSize:maxSize options:mode attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
};

/**
 obj->json
 
 @return json字符串
 */
static inline NSString * BPJSON(id theData) {
    if (!theData) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData && error == nil) {
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return BPValidateString(jsonStr);
    }
    return @"";
}

// 将JSON串转化为字典或者数组
static inline id BPFromJSON(NSString *jsonString) {
    jsonString = BPValidateString(jsonString);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                             options:NSJSONReadingMutableContainers
                                               error:&err];
    if(err) {
        BPLog(@"json解析失败：%@",err);
        return nil;
    }
    return obj;
}


/**
 判断是否为字典
 
 @return 字典
 */
static inline NSDictionary * BPValidateDict(NSDictionary *rawDict) {
    if (![rawDict isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    return rawDict;
};

/**
 判断是否为数组
 
 @return 数组
 */
static inline NSArray * BPValidateArray(NSArray *rawArray) {
    if (![rawArray isKindOfClass:[NSArray class]]) {
        return @[];
    }
    return rawArray;
};

static inline NSMutableArray * BPValidateMuArray(NSMutableArray *rawArray) {
    if (![rawArray isKindOfClass:[NSMutableArray class]]) {
        return @[].mutableCopy;
    }
    return rawArray;
};

/**
 判断是否越界
 
 @return id|nil
 */
static inline id BPValidateArrayObjAtIdx(NSArray * rawArray, NSUInteger idx) {
    if (![rawArray isKindOfClass:[NSArray class]] || !rawArray.count) {
        return nil;
    }
    return idx > rawArray.count - 1 ? nil : rawArray[idx];
};

static inline id BPValidateMuArrayObjAtIdx(NSMutableArray * rawArray, NSUInteger idx) {
    if (![rawArray isKindOfClass:[NSMutableArray class]] || !rawArray.count) {
        return nil;
    }
    return idx > rawArray.count - 1 ? nil : rawArray[idx];
};

/**
 判断是否为NSNumber
 
 @return NSNumber
 */
static inline NSNumber * BPValidateNumber(NSNumber *rawNumber) {
    if ([rawNumber isKindOfClass:[NSNumber class]]) {
        return rawNumber;
    }
    if ([rawNumber isKindOfClass:[NSString class]]) {
        id result;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        result=[formatter numberFromString:(NSString *)rawNumber];
        if(!(result)) {
            result=@0;
        }
        return result;
    }
    return @0;
};


/**
 判断是否为数组
 
 @return 数组
 */
static inline id BPValidateID(id obj) {
    if (obj) {
        return obj;
    }
    return @"";
};

static inline NSString * BPTimeString(NSInteger seconds) {
    if (seconds >= second) {
        //传入秒 返回:xx:xx:xx
        NSInteger hour = seconds/second;
        NSInteger minute = (seconds % second) / 60;
        NSInteger second = seconds % 60 ;
        return  [NSString stringWithFormat:@"%02td:%02td:%02td",hour,minute,second];
    }
    //传入秒,返回xx:xx
    NSInteger minute = seconds / 60;
    NSInteger second = (NSInteger)seconds % 60;
    return  [NSString stringWithFormat:@"%02td:%02td",minute,second];
};

// 占位符
#ifndef kPlacedString
#define kPlacedString BPPlacedString()
#endif

#ifndef kZero
#define kZero 0
#endif

/**
 占位空字符串
 */
static inline NSString * BPPlacedString () {
    static NSString *placedString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        placedString = @"";
        
    });
    return placedString;
}


/*以下方法使用Foundation框架对 完整url 进行编解码*/
/**
 URL编码
 此方法适用于url或者参数中包含中文以及其它非法字符的情况，但不适用于参数包含保留字和其他特殊字符的情况。
 
 @return URL
 */
static inline NSString * BPUrlStringEncode(NSString *url) {
    if (!BPValidateString(url).length) {
        return kPlacedString;
    }
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodeUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    return encodeUrl;
};

/**
 URL解码
 
 @return URL
 */
static inline NSString * BPUrlStringDecode(NSString *url) {
    if (!BPValidateString(url).length) {
        return kPlacedString;
    }
    NSString *decodeUrl = [url stringByRemovingPercentEncoding];
    return decodeUrl;
};

/*
 使用CoreFoundation对 url参数 进行encode
 此方法适用于，url前缀不包含中文以及其它非法字符的情况，只需要对参数进行编码即可。
 */
static inline NSString * BPUrlStringParamEncode(NSString *url) {
    if (!BPValidateString(url).length) {
        return kPlacedString;
    }
    //9.0之后被废弃，encode方法建议用上面的方法
    CFStringRef encodeParaCf = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)url, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString *encodePara = (__bridge NSString *)(encodeParaCf);
    CFRelease(encodeParaCf);
    return encodePara;
};

/*使用CoreFoundation 对 url参数 进行decode*/
static inline NSString * BPUrlStringParamDecode(NSString *url) {
    if (!BPValidateString(url).length) {
        return kPlacedString;
    }
    //9.0之后被废弃
    //NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,(__bridge CFStringRef)url,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSString *decodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef) url,NULL));
    return decodedString;
}

#pragma mark - 随机数据

#ifndef kRandomShortText
#define kRandomShortText XRandomText(NO)
#endif

#ifndef kRandomLengthText
#define kRandomLengthText XRandomText(YES)
#endif

#ifndef kRandomSmallImage
#define kRandomSmallImage XRandomImage(NO)
#endif

#ifndef kRandomLargeImage
#define kRandomLargeImage XRandomImage(YES)
#endif

static inline NSString * XRandomText(BOOL length) {

    NSArray *texts = nil;
    
    if (length) {
        texts = @[@"白日依山尽",@"黄河入海流",@"欲穷千里目",@"更上一层楼"];
    } else {
        texts = @[
                  @"ryan"
                  ];
    }
    NSInteger random = kRandomNumber(0, texts.count-1);
    return texts[random];
}

static inline NSString * XRandomImage(BOOL large) {
    
    NSArray *images = nil;
    
    if (large) {
        images = @[
                @"module_landscape1",@"module_landscape2",@"module_landscape3",@"module_landscape4",@"module_landscape5",@"module_landscape6"
                ];
    } else {
        images = @[
                   @"cactus_rect_steady",
//                   @"cactus_round_steady"
                   ];
    }

    NSInteger random = kRandomNumber(0, images.count-1);
    return images[random];
}

NS_ASSUME_NONNULL_END
