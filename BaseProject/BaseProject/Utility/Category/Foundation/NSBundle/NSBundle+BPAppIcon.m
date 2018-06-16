//
//  NSBundle+BPAppIcon.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSBundle+BPAppIcon.h"

@implementation NSBundle (BPAppIcon)
- (NSString *)_appIconPath {
    NSString * iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString * iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString * iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

- (UIImage*)_appIcon {
    UIImage*appIcon = [[UIImage alloc] initWithContentsOfFile:[self _appIconPath]] ;
    return appIcon;
}
@end
