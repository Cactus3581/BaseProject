// AutoCoding.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (BPAutoCoding) <NSSecureCoding>
//coding
+ (NSDictionary *)_codableProperties;
- (void)_setWithCoder:(NSCoder *)aDecoder;
//property access
- (NSDictionary *)_codableProperties;
- (NSDictionary *)_dictionaryRepresentation;
//loading / saving
+ (instancetype)_objectWithContentsOfFile:(NSString *)path;
- (BOOL)_writeToFile:(NSString *)filePath atomically:(BOOL)useAuxiliaryFile;
@end
