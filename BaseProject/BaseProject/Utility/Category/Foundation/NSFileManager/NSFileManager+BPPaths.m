//
//  NSFileManager+Paths.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSFileManager+BPPaths.h"
#include <sys/xattr.h>

@implementation NSFileManager (BPPaths)
+ (NSURL *)bp_URLForDirectory:(NSSearchPathDirectory)directory {
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)bp_pathForDirectory:(NSSearchPathDirectory)directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)bp_documentsURL {
    return [self bp_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)bp_documentsPath {
    return [self bp_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)bp_libraryURL {
    return [self bp_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)bp_libraryPath {
    return [self bp_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)bp_cachesURL {
    return [self bp_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)bp_cachesPath {
    return [self bp_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)bp_addSkipBackupAttributeToFile:(NSString *)path {
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)bp_availableDiskSpace {
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.bp_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

@end
