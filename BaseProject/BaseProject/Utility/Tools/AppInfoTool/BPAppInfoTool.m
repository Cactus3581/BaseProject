//
//  BPAppInfoTool.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/26.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAppInfoTool.h"
#import "SAMKeychain.h"

@implementation BPAppInfoTool

- (NSString *)uuid {
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:@"com.cactus.BaseProject"account:@"BaseProject"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""]) {
        NSUUID *currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        //currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        //currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SAMKeychain setPassword: currentDeviceUUIDStr forService:@"com.cactus.BaseProject"account:@"BaseProject"];
    }
    return currentDeviceUUIDStr;
}

- (void)getInternetDate {
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    __block NSDate *localeDate;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:
                                      ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                          //要把网络数据强转 不然用不了下面那个方法获取不到内容（个人感觉，不知道对不）
                                          NSHTTPURLResponse *responsee = (NSHTTPURLResponse *)response;
                                          NSString *date = [[responsee allHeaderFields] objectForKey:@"Date"];
                                          date = [date substringFromIndex:5];
                                          date = [date substringToIndex:[date length]-4];
                                          
                                          NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
                                          dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                                          [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
                                          // NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8]; //这个获取时间是正常时间，但是转化后会快8个小时，所以取的没有处理8小时的时间
                                          NSDate *netDate = [dMatter dateFromString:date];
                                          NSTimeZone *zone = [NSTimeZone systemTimeZone];
                                          NSInteger interval = [zone secondsFromGMTForDate: netDate];
                                          localeDate = [netDate dateByAddingTimeInterval: interval];
                                          
                                          NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                          [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                                          NSString *nowtimeStr = [formatter stringFromDate:localeDate];
                                          NSLog(@"nowtimeStr = %@",nowtimeStr);
                                      }];
    [dataTask resume];
}

@end
