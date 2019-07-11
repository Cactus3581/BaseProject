//
//  BPDesignPatternsKVCViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsKVCViewController.h"
#import "BPKVCModel.h"

@interface BPDesignPatternsKVCViewController ()

@end

@implementation BPDesignPatternsKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self kvc_base]; // 基础使用
                break;
            }
                
            case 1:{
                [self kvc_dictToModel]; // 模型转换
                break;
            }
                
            case 2:{
                [self kvc_collectionOperator];//集合操作符/对象操作符

                break;
            }
                
            case 3:{
                [self kvc_kvo];// kvc和kvo
                break;
            }
        }
    }
}

#pragma mark - KVC的查找及调用顺序 - 看BPKVCModel 里面的调用顺序
- (void)kvc_base {
    BPKVCModel *model = [[BPKVCModel alloc] init];
    
    // 私有实例变量
    [model setValue:@"macbook" forKey:@"macbook"];
    BPLog(@"%@",[model valueForKey:@"macbook"]);
    
    // KVC也可以设置value为自定义对象
    BPKVCSubModel *subModel = [[BPKVCSubModel alloc] init];
    [model setValue:subModel forKey:@"subModel"];
    
    [model setValue:@"lastName" forKeyPath:@"subModel.lastName"];
    BPLog(@"%@",[model valueForKeyPath:@"subModel.lastName"]);
}


#pragma mark - kvc：dict和model转换
- (void)kvc_dictToModel {
    NSDictionary *dict = @{@"name":@"name",@"price":@99,@"subModel":@{@"lastName":@"lastName"}};// 嵌套了模型，但是貌似崩溃了

    BPKVCModel *model = [[BPKVCModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    if ([model.subModel isKindOfClass:[NSDictionary class]]) {
        BPLog(@"model.name = %@,model.price = %@,model.subModel.lastName = %@",model.name,model.price,[model.subModel  valueForKey:@"lastName"]);
    }

    NSArray* array = @[@"name",@"price",@"subModel"];
    NSDictionary* dic = [model dictionaryWithValuesForKeys:array]; //把对应key所有的属性全部取出来
    BPLog(@"%@",dic);
}

#pragma mark - KVO的基础不是KVC，要弄清楚这点，它俩的关系仅限于KVC可以通过setter方法触发KVO
- (void)kvc_kvo {

}

#pragma mark -  集合操作符/对象操作符
- (void)kvc_collectionOperator {
    //    如何取出数组中的最大值或者最小值？
    BPKVCModel *model = [[BPKVCModel alloc]init];
    model.name = @"iMac";
    model.price = @18888;
    
    BPKVCModel *model1 = [[BPKVCModel alloc]init];
    model1.name = @"iphone";
    model1.price = @6999;
    
    NSArray *array = @[model,model1];
    
    //简单类型的集合操作符，返回 strings, numbers, dates,
    //简单集合操作符作用于 array 或者 set 中相对于集合操作符右侧的属性。包括 @avg, @count, @max, @min, @sum.
    NSString *name = [array valueForKeyPath:@"@count"];//回集合中对象总数的 NSNumber 对象。操作符右边没有键路径。
    NSNumber *price_max = [array valueForKeyPath:@"@max.price"];//比较由操作符右边的键路径指定的属性值，并返回比较结果的最大值。最大值由指定的键路径所指对象的 compare: 方法决定
    NSString *price_min = [array valueForKeyPath:@"@min.price"];//返回的是集合中的最小值
    NSNumber *price_sum = [array valueForKeyPath:@"@sum.price"];//属性值的总和
    NSNumber *price_avg = [array valueForKeyPath:@"@avg.price"];//转换为 double, 计算其平均值，返回该平均值的 NSNumber 对象。当均值为 nil 的时候，返回 0.
    
    //提示：你可以简单的通过把 self 作为操作符后面的 key path 来获取一个由 NSNumber 组成的数组或者集合的总值，例如对于数组 @[@(1), @(2), @(3)] 可使用 valueForKeyPath:@"@max.self" 来获取最大值。
    
    BPLog(@"%@,%@,%@,%@,%@",name,price_max,price_min,price_sum,price_avg);
    
    //对象操作符，返回 NSArray 对象实例:对象操作符包括 @distinctUnionOfObjects 和 @unionOfObjects, 返回一个由操作符右边的 key path 所指定的对象属性组成的数组。其中 @distinctUnionOfObjects 会对数组去重，而 @unionOfObjects 不会。
    
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.name"]; // 1.
    NSArray *distinctUnionObjects = [array valueForKeyPath:@"@distinctUnionOfObjects.name"];  //2.
    BPLog(@"%@,%@",unionOfObjects,distinctUnionObjects);
    
    /*数组和集合操作符，返回的是一个 array 或者 set 对象
     数组和集合操作符作用对象是嵌套的集合，也就是说，是一个集合且其内部每个元素是一个集合。数组和集合操作符包括 @distinctUnionOfArrays，@unionOfArrays，@distinctUnionOfSets:
     @distinctUnionOfArrays / @unionOfArrays 返回一个数组，其中包含这个集合中每个数组对于这个操作符右面指定的 key path 进行操作之后的值。 distinct 版本会移除重复的值。
     @distinctUnionOfSets 和 @distinctUnionOfArrays 差不多, 但是它期望的是一个包含着 NSSet 对象的 NSSet ，并且会返回一个 NSSet 对象。因为集合不能包含重复的值，所以它只有 distinct 操作。
     */
    NSArray *array1 = @[model,model1];
    NSArray *totalArray = @[array,array1];
    
    NSArray *distinctUnionOfArrays = [totalArray valueForKeyPath:@"@distinctUnionOfArrays.name"];
    NSArray *unionOfArrays = [totalArray valueForKeyPath:@"@unionOfArrays.name"];
    
    BPLog(@"%@,%@",distinctUnionOfArrays,unionOfArrays);
    
    //注意: 如果操作符右侧 key path 指定的对象为 nil，那么返回的数组中会包含 NSNull 对象.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
