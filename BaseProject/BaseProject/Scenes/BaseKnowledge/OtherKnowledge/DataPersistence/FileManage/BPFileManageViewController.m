//
//  BPFileManageViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/11/3.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPFileManageViewController.h"

@interface BPFileManageViewController ()
@property (retain, nonatomic) IBOutlet UITextField *tf1;
@property (retain, nonatomic) IBOutlet UITextField *tf2;

@end

@implementation BPFileManageViewController

//写入
- (IBAction)write:(id)sender {
    //获取字符串
    NSString *str1 = _tf1.text;
    NSString *str2 = _tf2.text;
    
    //获documents 文件路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    
#pragma mark - 字符串写入本地
    //    //拼接文件路径
    //    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"test.TXT"];
    //
    //    //写入
    //    [str1 writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
#pragma mark - 数组写入本地
    //    //数组
    //    NSArray *arr = @[str1,str2];
    //    //拼接文件路径
    //    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"arr.plist"];
    //    //写入
    //    [arr writeToFile:filePath atomically:YES];
    
#pragma mark - 字典写入本地
    //    NSDictionary *dic = @{@"tf1":_tf1.text,@"tf2":_tf2.text};
    //    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"dic.plist"];
    //    //写入
    //    [dic writeToFile:filePath atomically:YES];
    
#pragma mark - data写入本地
    
    //data
    NSData *data = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"data.txt"];
    [data writeToFile:filePath atomically:YES];
    
    
    
}

//读取
- (IBAction)read:(id)sender {
    
    
    //获取文件路径
    //获documents 文件路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    
#pragma mark - 字符串读取
    //拼接文件路径
    //    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"test.TXT"];
    //
    //    //展示
    //    self.tf2.text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
#pragma mark - 数组读取
    //文件路径拼接
    //    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"arr.xml"];
    //    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    //    //展示
    //    self.tf1.text =arr[0];
    //    self.tf2.text =arr[1];
#pragma mark - 读取字典
    //文件拼接路径
    //    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"dic.plist"];
    //    // 读取
    //    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    //    //展示
    //    self.tf1.text = [dic valueForKey:@"tf1"];
    //    self.tf2.text = [dic valueForKey:@"tf2"];
    
    
#pragma mark - 读取data
    //文件拼接路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"data.txt"];
    //     读取
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //展示
    //    self.tf1.text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    self.tf2.text = str;
    
}

//创建文件
- (IBAction)creat:(id)sender {
    
    //获取documents 文件路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    
    //拼接文件夹路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"images"];
    
    //创建文件管理对像
    NSFileManager *mangager = [NSFileManager defaultManager];
    //创建
    [mangager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    
}

//移动文件
- (IBAction)move:(id)sender {
    //将images 移动到Caches中
    
    //获取老路径oldPath：tmp路径
    NSString *tempPath = NSTemporaryDirectory();
    //拼接
    NSString *oldPath = [tempPath stringByAppendingPathComponent:@"Images"];
    
    //获取新路径newPath:Caches文件路径
    NSString *cacherPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //拼接
    NSString *newPath = [cacherPath stringByAppendingPathComponent:@"Images"];
    
    //创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //移动
    [manager moveItemAtPath:oldPath toPath:newPath error:nil];
    
    
    
}

//复制文件
- (IBAction)copy:(id)sender {
    //1.获取tmp文件路径
    NSString *tmp =NSTemporaryDirectory();
    //    2.文件拼接
    NSString *newPath = [tmp stringByAppendingPathComponent:@"Images"];
    //获取documents文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    //文件拼接
    NSString *oldPath = [documentPath stringByAppendingPathComponent:@"Images"];
    //    3.创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    //复制
    [manager copyItemAtPath:oldPath toPath:newPath error:nil];
}


//删除／清除缓存
- (IBAction)delete:(id)sender {
    
    //获取Caches文件路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //拼接
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"Images"];
    //创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager removeItemAtPath:filePath error:nil];
    
}

//是否存在
- (IBAction)exist:(id)sender {
    //获取caches文件路径
    NSString *CachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //拼接
    NSString *filePath = [CachesPath stringByAppendingPathComponent:@"Images"];
    //创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //判断是否存在
    BOOL isExist = [manager fileExistsAtPath:filePath];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    if (isExist) {
        alertView.message = @" 文件存在";
    }else
    {
        alertView.message = @"文件不存在";
    }
    [alertView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)dealloc {

}
@end

