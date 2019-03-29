//
//  BPNetRequestViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/14.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPNetRequestViewController.h"

static NSString *urlString = @"http://api.yanagou.net/app/web.json";

static NSString *urlStringImage = @"http://120.25.226.186:32812/resources/images/minion_01.png";

@interface BPNetRequestViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate>

@end


@implementation BPNetRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self dataTask_block];
            }
                break;
                
            case 1:{
                [self dataTask_delegate];
            }
                break;
                
            case 2:{
                [self downLoadTask_block];
            }
                break;
                
            case 3:{
                [self downLoadTask_delegate];
            }
                break;
                
            case 4:{
                [self uploadTask_block];
            }
                break;
                
            case 5:{
                [self uploadTask_delegate];
            }
                break;
                
            case 6:{
                [self streamTask_block];
            }
                break;
                
            case 7:{
                [self streamTask_delegate];
            }
                break;
                
            case 8:{
                [self configSession];
            }
                break;
        }
    }
}

#pragma mark - 配置Session
- (void)configSession {
    //作用：可以统一配置NSURLSession,如请求超时等
    
    //创建NSURLSessionConfiguration的三种方式
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config = [NSURLSessionConfiguration ephemeralSessionConfiguration];//仅内存缓存, 不做磁盘缓存的配置
    config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.cactus.backgroundSessionIdentifier"];//identifier用来后台重连session对象. (做后台上传/下载就是这个config)
    
    config.timeoutIntervalForRequest = 10;//设置请求超时为10秒钟
    config.allowsCellularAccess = NO;//在蜂窝网络情况下是否继续请求（上传或下载）
    config.HTTPAdditionalHeaders =@{@"Content-Encoding":@"gzip"};//配置请求头
    
    //创建NSURLSession的三种方式
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config]; // 最常用的
    session = [NSURLSession sharedSession];
    session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];//专门用于做后台上传/下载任务
    
//    NSURLSessionDelegate : session-level的代理方法
//    NSURLSessionTaskDelegate : task-level面向all的代理方法
//    NSURLSessionDataDelegate : task-level面向data和upload的代理方法
//    NSURLSessionDownloadDelegate : task-level的面向download的代理方法
//    NSURLSessionStreamDelegate : task-level的面向stream的代理方法
}

#pragma mark - 普通网络请求 DataTask：Block
//也可以实现下载 上传等功能
- (void)dataTask_block {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    //直接使用 URL 请求，相当于GET请求，如果使用其他请求就必须使用 NSMutableURLRequest
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=ss&pwd=ss&type=JSON"];
    
    // 第一种
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 第二种
    NSURLSessionDataTask *dataTask1 = [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        /*
         注意：该block是在子线程中调用的，如果拿到数据之后要做一些UI刷新操作，那么需要回到主线程刷新
         NSData:该请求的响应体
         NSURLResponse:存放本次请求的响应信息，响应头，真实类型为NSHTTPURLResponse
         NSErroe:请求错误信息
         */
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;//拿到响应头信息
        NSLog(@"%@\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);//解析拿到的响应数据
    }];
    
    // post 请求
    NSURL *postUrl = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:postUrl];
    // 设置请求方法
    mRequest.HTTPMethod = @"POST";// 必须明确写明
    [mRequest setHTTPMethod:@"POST"];
    //把参数放在请求体中传递
    NSData *parametersData = [@"username=520it&pwd=520it&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    mRequest.HTTPBody = parametersData;
    // 设置请求头参数
    [mRequest addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    //或者下面这种方式 添加所有请求头信息
    mRequest.allHTTPHeaderFields = @{@"Content-Encoding":@"gzip"};
    //设置缓存策略
    [mRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    // 设置请求超时 默认超时时间60s
    [mRequest setTimeoutInterval:30.0];
    
    NSURLSessionDataTask *dataTask2 = [session dataTaskWithRequest:mRequest completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;//拿到响应头信息
        NSLog(@"%@\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);//解析拿到的响应数据
    }];
    
    [dataTask resume];//刚创建出来的task默认是挂起状态的，需要调用该方法来启动任务（执行任务）
    [dataTask1 resume];//开始或者恢复
    [dataTask2 resume];

    //[dataTask cancel];//取消任务
    //[dataTask suspend];//暂停任务
}

#pragma mark - 普通网络请求 DataTask：Delegate

- (void)dataTask_delegate {
    //1.创建NSURLSession,并设置代理
    /*
     第一个参数：session对象的全局配置设置，一般使用默认配置就可以
     第二个参数：谁成为session对象的代理
     第三个参数：代理方法在哪个队列中执行（在哪个线程中调用）,如果是主队列那么在主线程中执行，如果是非主队列，那么在子线程中执行
     */
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //创建task
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_01.png"];
    
    //注意：如果要发送POST请求，那么请使用dataTaskWithRequest,设置一些请求头信息
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask1 = [session dataTaskWithRequest:request];
    
    [dataTask resume];
    [dataTask1 resume];
}

/*
 1.当接收到服务器响应的时候调用
 session：发送请求的session对象
 dataTask：根据NSURLSession创建的task任务
 response:服务器响应信息（响应头）
 completionHandler：通过该block回调，告诉服务器端是否接收返回的数据
 */

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 允许处理服务器的响应，才会继续接收服务器返回的数据
    //默认情况下，当接收到服务器响应之后，服务器认为客户端不需要接收数据，所以后面的代理方法不会调用
    //如果需要继续接收服务器返回的数据，那么需要调用block,并传入对应的策略
    
    /*
     NSURLSessionResponseCancel = 0, 取消任务
     NSURLSessionResponseAllow = 1,  接收任务
     NSURLSessionResponseBecomeDownload = 2, 转变成下载
     NSURLSessionResponseBecomeStream NS_ENUM_AVAILABLE(10_11, 9_0) = 3, 转变成流
     */
    
    completionHandler(NSURLSessionResponseAllow);
}
/*
 2.当接收到服务器返回的数据时调用
 该方法可能会被调用多次
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 处理每次接收的数据
}
/*
 3.当请求完成之后调用该方法
 不论是请求成功还是请求失败都调用该方法，如果请求失败，那么error对象有值，否则那么error对象为空
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
}

#pragma mark - 下载请求 DownloadTask：Block

- (void)downLoadTask_block {
    
    //downloadTaskWithURL方法已经实现了在下载文件数据的过程中边下载文件数据，边写入到沙盒文件的操作,缺点：没有办法监控下载进度

    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // Block 三种方式
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:URL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        /*
         location:下载的文件的保存地址（默认是存储在沙盒中tmp文件夹下面，随时会被删除）
         response：服务器响应信息，响应头
         error：该请求的错误信息
         */
    }];
    
    NSURLSessionDownloadTask *downloadTask1 = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    
    NSURLSessionDownloadTask *downloadTask2 = [session downloadTaskWithResumeData:nil completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    
    [downloadTask resume];
    [downloadTask1 resume];
    [downloadTask2 resume];
}

#pragma mark - 下载请求 DownloadTask：Delegate（下载进度，以及断点下载）

- (void)downLoadTask_delegate {
    //1.创建NSURLSession,并设置代理
    /*
     第一个参数：session对象的全局配置设置，一般使用默认配置就可以
     第二个参数：谁成为session对象的代理
     第三个参数：代理方法在哪个队列中执行（在哪个线程中调用）,如果是主队列那么在主线程中执行，如果是非主队列，那么在子线程中执行
     */
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //创建task
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_01.png"];
    
    //注意：如果要发送POST请求，那么请使用dataTaskWithRequest,设置一些请求头信息
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
}


- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    //在该方法中监听文件下载的进度;该方法会被调用多次
    BPLog(@"1-每次写入调用(会调用多次) 已经写入到文件中的数据大小 = %lld, 目前文件的总大小 = %ld, 本次下载的文件数据大小 = %lld",totalBytesWritten,totalBytesExpectedToWrite,bytesWritten);
}

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    BPLog(@"2-恢复下载,恢复之后，要从文件的%lld开发下载 该文件数据的总大小 = %lld",fileOffset,expectedTotalBytes);
}

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    BPLog(@"3-下载完成");
}

#pragma mark - 上传请求 UploadTask：Block

- (void)uploadTask_block {
    /*
     第一个参数：请求对象
     第二个参数：请求体（要上传的文件数据）
     block回调：
     NSData:响应体
     NSURLResponse：响应头
     NSError：请求的错误信息
     */
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    

    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromFile:nil completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    
    NSURLSessionUploadTask *uploadTask1 =  [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    
    [uploadTask resume];
    [uploadTask1 resume];
}

#pragma mark - 上传请求 UploadTask：Delegate（监听文件上传进度）
- (void)uploadTask_delegate {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [session uploadTaskWithRequest:request fromData:nil];
    [session uploadTaskWithRequest:request fromFile:nil];
    [session uploadTaskWithStreamedRequest:request];
}

- (void)URLSession:(nonnull NSURLSession *)session task:(nonnull NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    // 如果文件数据很大，那么该方法会被调用多次
    BPLog(@"1-开始上传文件数据 已经上传的文件数据的大小 = %ld, 文件的总大小 = %ld,",totalBytesSent,totalBytesExpectedToSend);
}


#pragma mark - 建立TCP/IP连接 StreamTask：Block

- (void)streamTask_block {
    NSURLSessionStreamTask *streamTask;
}

#pragma mark - 建立TCP/IP连接 StreamTask：Delegate

- (void)streamTask_delegate {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
