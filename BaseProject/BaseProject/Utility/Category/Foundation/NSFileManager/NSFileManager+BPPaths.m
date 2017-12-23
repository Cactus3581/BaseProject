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
+ (NSURL *)_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)_documentsURL
{
    return [self _URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)_documentsPath
{
    return [self _pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)_libraryURL
{
    return [self _URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)_libraryPath
{
    return [self _pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)_cachesURL
{
    return [self _URLForDirectory:NSCachesDirectory];
}

+ (NSString *)_cachesPath
{
    return [self _pathForDirectory:NSCachesDirectory];
}

+ (BOOL)_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self._documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}
@end
