// AutoCoding.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
//
// Distributed under the permissive zlib License
// Get the latest version from here:
//
// https://github.com/nicklockwood/AutoCoding
//
// This software is provided 'as-is', without any express or implied
// warranty. In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
// claim that you wrote the original software. If you use this software
// in a product, an acknowledgment in the product documentation would be
// appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such, and must not be
// misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//
#import <Foundation/Foundation.h>
@interface NSObject (JKAutoCoding) <NSSecureCoding>
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
