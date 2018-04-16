//
//  BPNSDateViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSDateViewController.h"

@interface BPNSDateViewController ()

@end

@implementation BPNSDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)handle {
#pragma  mark - NSDate 日期类
    //        //获取当前时间 0时区
    //        NSDate *date = [NSDate date];
    //        BPLog(@"%@",date);
    //
    //        //获取东八区的当前时间
    //        NSDate *now = [NSDate dateWithTimeIntervalSinceNow:8*60*60];
    //        BPLog(@"%@",now);
    //
    //        //获取东八区昨天的时间
    //        NSDate *past = [NSDate dateWithTimeIntervalSinceNow:8*60*60-24*60*60];
    //        BPLog(@"%@",past);
    //
    //        //获取时间间隔
    //        //NSTimeInterVal   其实就是double，只不过专门用来表示时间间隔   单位：秒
    //        NSTimeInterval timeInterVal = [past timeIntervalSinceDate:now];
    //        BPLog(@"%.2f-------",timeInterVal/60/60);
    //
    //        //聊天过程
    //        BPLog(@"约么");
    //        NSDate *receiveTime = [NSDate date];
    //        BPLog(@"%@",receiveTime);
    //
    //        //回复
    //        char message[100] = {0};
    //        scanf("%s",message);
    //        //转化为oc字符串对象
    //        NSString *messageStr = [NSString stringWithUTF8String:message];
    //        BPLog(@"%@",messageStr);
    //
    //        //获取发送信息的时间
    //        NSDate *sendTime = [NSDate date];
    //
    //        //获取时间间隔
    //        NSTimeInterval interVal = [sendTime timeIntervalSinceDate:receiveTime];
    //
    //        //判断
    //        if (interVal<0) {
    //            BPLog(@"刚刚");
    //        }else if(interVal < 60)
    //        {
    //            BPLog(@"一分钟之内");
    //        }else if(interVal <10*60)
    //        {
    //            BPLog(@"几分钟之前");
    //        }else {
    //            BPLog(@"很久之前");
    //        }
    //
    //        //输出发送的消息
    //        BPLog(@"%@",messageStr);
    //
    
#pragma mark - NSDateFormatter 日期格式类
    
    //创建日期
    NSDate *date1 = [NSDate date];
    BPLog(@"------>>>>>>%@",date1);
    
    //1. 创建日期格式类对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //2.设置当前时区
    //        [formatter setTimeZone:[NSTimeZone localTimeZone]];
    //3. 设置日期风格
    [formatter setDateStyle:(NSDateFormatterFullStyle)];
    
    //4.设置时间的风格
    [formatter setTimeStyle:(NSDateFormatterFullStyle)];
    
    //5.使用设置好的格式进行转化
    NSString *dateStr = [formatter stringFromDate:date1];
    BPLog(@"%@",dateStr);
    
    // 自定义日期格式
    //1.创建日期格式对象
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc]init];
    //2.自定义格式（日期 时间）
    /*
     yyyy 代表年    MM代表月   dd代表天   hh（HH）代表小时 mm代表分钟 ss代表秒
     cccc或者eeee 代表星期    aaaa代表上午 OOOO（大写）代表时区
     */
    [myFormatter setDateFormat:@"GGGGyyyy年MM月dd日 HH:mm:ss OOOO aaaa cccc"];
    //3.转换
    NSString *dateStr1 = [myFormatter stringFromDate:date1];
    BPLog(@"%@",dateStr1);
    
    
    //使用日期格式类 将日期字符串对象转化为日期对象 2015-08-08 03:46:30
    NSString *datestr2 = @"2015-08-08 03:46:30";
    //        BPLog(@"%@",dateStr2);
    //1. 创建日期格式对象
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    //2.设置日期格式
    [fomatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //3.转化
    NSDate *date2 = [fomatter dateFromString:datestr2];
    BPLog(@"%@",date2);
    //    2014 0402 14 28 50
    NSString *date3 = @"2014-04-02 14:28:50";
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM--dd HH:mm:ss"];
    NSDate *date4 = [format dateFromString:date3];
    BPLog(@"%@",date4);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
