//
//  GZIP.h
//
//  Version 1.1.1
//
//  Created by Nick Lockwood on 03/06/2012.
//  Copyright (C) 2012 Charcoal Design
//


#import <Foundation/Foundation.h>
@interface NSData (BPGzip)
/**
 *  @brief  GZIP压缩
 *
 *  @param level 压缩级别
 *
 *  @return 压缩后的数据
 */
- (NSData *)_gzippedDataWithCompressionLevel:(float)level;

/**
 *  @brief  GZIP压缩 压缩级别 默认-1
 *
 *  @return 压缩后的数据
 */
- (NSData *)_gzippedData;

/**
 *  @brief  GZIP解压
 *
 *  @return 解压后数据
 */
- (NSData *)_gunzippedData;

- (BOOL)_isGzippedData;
@end
