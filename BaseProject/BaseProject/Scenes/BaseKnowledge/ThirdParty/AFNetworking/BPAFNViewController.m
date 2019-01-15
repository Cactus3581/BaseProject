//
//  BPAFNViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/14.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPAFNViewController.h"
#import <AFNetworking.h>

@interface BPAFNViewController ()

@end

@implementation BPAFNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self creatingDataTask]; //普通请求数据
            }
                break;
                
            case 1:{
                [self creatingDownloadTask]; //下载
            }
                break;
                
            case 2:{
                [self creatingUploadTask]; //上传
            }
                break;
                
            case 3:{
                [self creatingUploadTaskForMultiRequest]; //为一个包含多个部分的请求创建上传任务，并显示进度
            }
                break;
                
            case 4:{
                [self requestSerialization]; //请求序列化
            }
                break;
                
            case 5:{
                [self sharedNetworkReachability]; //网络监听
            }
                break;
               
            case 6:{
                [self allowingCertificates]; //SSL证书
            }
                break;
        }
    }
}

#pragma mark - 普通请求数据
- (void)creatingDataTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            BPLog(@"Error: %@", error);
        } else {
            BPLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

#pragma mark - 下载
- (void)creatingDownloadTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        BPLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

#pragma mark - 上传
- (void)creatingUploadTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            BPLog(@"Error: %@", error);
        } else {
            BPLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

#pragma mark - 为一个包含多个部分的请求创建上传任务，并显示进度
- (void)creatingUploadTaskForMultiRequest {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          BPLog(@"%.2f",uploadProgress.fractionCompleted);
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          BPLog(@"Error: %@", error);
                      } else {
                          BPLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
}

#pragma mark - 请求序列化

- (void)requestSerialization {
    NSString *URLString = @"http://example.com";
    NSDictionary *parameters = @{
                                 @"foo": @"bar",
                                 @"baz": @[@1, @2, @3]
                                 };
    //Query String Parameter Encoding
    /*
     GET http://example.com?foo=bar&baz[]=1&baz[]=2&baz[]=3
     */
    
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
    //URL Form Parameter Encoding
    /*
     POST http://example.com/
     Content-Type: application/x-www-form-urlencoded
     
     foo=bar&baz[]=1&baz[]=2&baz[]=3
     
     */
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    //JSON Parameter Encoding
    /*
     POST http://example.com/
     Content-Type: application/json
     
     {"foo": "bar", "baz": [1,2,3]}
     
     */
    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
}

#pragma mark - 网络监听
- (void)sharedNetworkReachability {

    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        BPLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - SSL证书
- (void)allowingCertificates {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
}

@end
