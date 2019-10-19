//
//  BPNSDictionaryViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSDictionaryViewController.h"

@interface BPNSDictionaryViewController ()

@end

@implementation BPNSDictionaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)handle {
#pragma mark - NSDictionary - 不可变字典 －它是一个类
    
    /*
     创建字典对象  描述一个人
     initWithObjectsAndKeys : 在初始化时，一次性存储多个键值对（条目）。
     谨记，value在前 key紧跟在后。
     key － Value 之间用逗号隔开。
     通过key 获取Value
     key value  不会单独的。如果value 没有，key就没意义。
     */
    NSDictionary *xiaoming =[[NSDictionary alloc]initWithObjectsAndKeys:@"xiaoming",@"name",@"男",@"sex",@14, @"age",nil];
    BPLog(@"%@",xiaoming);
    
    //通过key 获取Value
    NSString *sex = [xiaoming valueForKey:@"sex"];
    BPLog(@"%@",sex);
    
    NSString *name = [xiaoming valueForKey:@"name"];
    BPLog(@"%@",name);
    
    NSNumber *age = [xiaoming valueForKey:@"age"];  //注意类型转换问题！！！
    BPLog(@"%@",age);
    
    //获取所有的key
    NSArray *allKey = [xiaoming allKeys];
    BPLog(@"%@",allKey);
    
    //获取所有的value
    NSArray *values = [xiaoming allValues];
    BPLog(@"%@",values);
    
    //遍历字典  当成数组来做
    //遍历所有的key
    for (int i = 0; i<allKey.count; i++) {
        //获取对应的key
        NSString *key = [allKey objectAtIndex:i];
        //通过key 获取对应的value
        NSString *value = [xiaoming valueForKey:key];
        BPLog(@"%@",key);
        BPLog(@"%@",value);
    }
    BPLog(@"=======================");
    //快速枚举
    //快速得到字典中的每一个key值（对于字典，只能枚举到key 想要获取value 还需要使用 valueForKey：方法）
    for (NSString *key in xiaoming) {
        BPLog(@"%@",key);
        //通过key获取对象的value
        BPLog(@"value = %@",[xiaoming valueForKey:key]);
    }
    BPLog(@"=======================");
    
    
    
    
#pragma mark - NSMutableDictionary 可变字典
    NSMutableDictionary *xiaoDing = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"丁岩",@"name",@"男",@"sex",@18,@"age",@"think",@"hobby",nil];
    BPLog(@"@%@",xiaoDing);;
    BPLog(@"=======================");
    
    //添加
    //setObject:forkey:  和 setValue:forkey: 都可以添加键值对，但是前者不允许添加的object为空。
    //setObject:forkey: 除了可以添加键值对 也可以修改 甚至可以删除。
    //如果键值对存在，则修改value的值
    //如果键值对不存在，则添加新的键值对
    //如果给予value参数为nil，则会删除对应键值对
    
    
    //添加
    [xiaoDing setValue:@50 forKey:@"weight"];
    // [xiaoDing setValue:nil forKey:@"weight"]; 说明没有value，也就没有他们。
    BPLog(@"%@",xiaoDing);
    BPLog(@"－－－－－－－－－－－－－－－");
    
    //更改内容
    [xiaoDing setValue:@19 forKey:@"age"];
    BPLog(@"%@",xiaoDing);
    
    //删除
    [xiaoDing setValue:nil forKey:@"hobby"];
    BPLog(@"%@",xiaoDing);
    
    //通过给定key 删除对应键值对
    [xiaoDing removeObjectForKey:@"sex"];
    BPLog(@"%@",xiaoDing);
    
    //删除所有键值对
    [xiaoDing removeAllObjects];
    BPLog(@"%@",xiaoDing);
    
    
    /*
     使用数组，字典 表示省 市 区。
     
     海淀区   431   211万
     朝阳区   465   183万
     */
    //海淀区 朝阳区 字典
    NSDictionary *haiDian = [NSDictionary dictionaryWithObjectsAndKeys: @"海淀区",@"areName",@211,@"population", nil];
    NSDictionary *chaoYang = [NSDictionary dictionaryWithObjectsAndKeys: @"朝阳区",@"areName",@183,@"population", nil];
    //区 数组
    NSArray *ares1 = [NSArray arrayWithObjects:haiDian,chaoYang,nil];
    //北京市 字典
    NSDictionary *beijing = [NSDictionary dictionaryWithObjectsAndKeys:@"北京",@"cityName",ares1,@"areArr",nil];
    
    //二七区 金水区 字典
    NSDictionary *erQi = [NSDictionary dictionaryWithObjectsAndKeys: @"二七区",@"areName",@54,@"population", nil];
    NSDictionary *jinShui = [NSDictionary dictionaryWithObjectsAndKeys: @"金水区",@"areName",@81,@"population", nil];
    //区 数组
    NSArray *ares2 = [NSArray arrayWithObjects:erQi,jinShui,nil];
    //郑州市 字典
    NSDictionary *zhengzhou = [NSDictionary dictionaryWithObjectsAndKeys:@"政治",@"cityName",ares2,@"areArr",nil];
    
    //创建城市数组
    NSArray *cities = [NSArray arrayWithObjects:beijing,zhengzhou, nil];
    
    //创建省  字典
    NSDictionary *provinceDic = [NSDictionary dictionaryWithObjectsAndKeys:@"河南省",@"provinceName",cities,@"cityArr", nil];
    BPLog(@"%@",provinceDic);
    
    //获取海淀区的人数－》海淀区－》区数组（北京）－》北京市－》市数组
    //获取城市数组
    
    NSArray *cities1 = [provinceDic valueForKey:@"cityArr"];
    NSDictionary *beijing1 = [cities1 objectAtIndex:0];
    NSArray *ares3 = [beijing1 valueForKey:@"areArr"];
    NSDictionary *haidian1 = [ares3 objectAtIndex:0];
    NSNumber *population = [haidian1 valueForKey:@"population"];
    BPLog(@"%@",population);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
