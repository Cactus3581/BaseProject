//
//  NSString+BPFilepath.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/9/22.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSString+BPFilepath.h"

@implementation NSString (BPFilepath)

+ (NSString *)tempFilePath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"AudioTemp.mp3"];
}


+ (NSString *)cacheFolderPath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"AudioCaches"];
}

+ (NSString *)fileNameWithURL:(NSURL *)url {
    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
    //    return [NSString stringWithFormat:@"%@.mp3",[urlStr md5]];
    //return [[url.path componentsSeparatedByString:@"/"] lastObject];
    return [[url.path componentsSeparatedByString:@"/"] lastObject];
}

@end

