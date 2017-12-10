//
//  NSURLSession+SynchronousTask.h
//
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//                                    
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
// https://github.com/floschliep/NSURLSession-SynchronousTask

#import <Foundation/Foundation.h>

@interface NSURLSession (BPSynchronousTask)

#pragma mark - NSURLSessionDataTask

- (nullable NSData *)_sendSynchronousDataTaskWithURL:(nonnull NSURL *)url returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing*_Nullable)error;
- (nullable NSData *)_sendSynchronousDataTaskWithRequest:(nonnull NSURLRequest *)request returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing*_Nullable)error;

#pragma mark - NSURLSessionDownloadTask

- (nullable NSURL *)_sendSynchronousDownloadTaskWithURL:(nonnull NSURL *)url returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error;
- (nullable NSURL *)_sendSynchronousDownloadTaskWithRequest:(nonnull NSURLRequest *)request returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error;

#pragma mark - NSURLSessionUploadTask

- (nullable NSData *)_sendSynchronousUploadTaskWithRequest:(nonnull NSURLRequest *)request fromFile:(nonnull NSURL *)fileURL returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error;
- (nullable NSData *)_sendSynchronousUploadTaskWithRequest:(nonnull NSURLRequest *)request fromData:(nonnull NSData *)bodyData returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error;

@end
