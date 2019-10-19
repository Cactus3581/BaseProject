//
//  BPDesignPatternsKVCViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/2/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsKVCViewController.h"
#import "BPKVCModel.h"
#import "NSObject+BPCustomKVC.h"

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
                [self searchKey]; // 查找key
                break;
            }
                
            case 2:{
                [self modelAndDict]; // 模型字典转换
                break;
            }
                
            case 3:{
                [self collectionOperator];//集合操作符/对象操作符

                break;
            }
                
            case 4:{
                [self customKVC];// 自定义实现KVC
                break;
            }
        }
    }
}


#pragma mark - 基础API使用（别忘了看看 model 里重写的方法）
- (void)kvc_base {
    BPKVCModel *model = [[BPKVCModel alloc] init];
    
    // 访问私有实例变量
    [model setValue:@"privateIvar" forKey:@"privateIvar"];
    BPLog(@"%@",[model valueForKey:@"privateIvar"]);
    
    // KVC对基础数据类型和结构体型属性的支持。KVC可以自动的将数值或结构体型的数据打包或解包成NSNumber或NSValue对象，以达到适配的目的。
    [model setValue:@(1) forKey:@"intKey"]; // KVC会自动的将NSNumber对象转换成NSInteger对象
    BPLog(@"%@",[model valueForKey:@"intKey"]);

    // 用于测试异常处理：当通过setValue给某个非对象的属性赋值为nil时，会触发异常方法
    [model setValue:nil forKey:@"intKey"];
    
    // value为自定义对象
    BPKVCSubModel *subModel = [[BPKVCSubModel alloc] init];
    [model setValue:subModel forKey:@"subModel"];
    
    // 使用键路径
    [model setValue:@"sublKey" forKeyPath:@"subModel.sublKey"];
    BPLog(@"%@",[model valueForKeyPath:@"subModel.sublKey"]);
    
    BPKVCModel *model1 = [[BPKVCModel alloc]init];
    [model setValue:@"normalKey" forKey:@"normalKey"];

    NSArray *array = @[model,model1];
    NSArray *values = [array valueForKeyPath:@"normalKey"];
    BPLog(@"values = %@",values);
    
    // 验证value是否正确：验证方法需要我们手动调用，并不会在进行KVC的过程中自动调用。验证方法默认实现返回YES，可以通过重写对应的方法修改验证逻辑。
    NSError* error;
    id value = @"numberKey";
    NSString *key = @"normalKey";
    BOOL result = [model validateValue:&value forKey:key error:&error]; // 注意是二级指针
    if (result) {
        NSLog(@"键值匹配");
        [model setValue:value forKey:key];
    }
    else{
        NSLog(@"键值不匹配"); //不能设为日本，基他国家都行
    }
    NSString *normalKey = [model valueForKey:@"normalKey"];
    NSLog(@"normalKey:%@",normalKey);
}

#pragma mark - model 字典互相转换（特别是当类型不匹配、嵌套的情况）
- (void)modelAndDict {
    BPKVCModel *model = [[BPKVCModel alloc] init];

    NSDictionary *dict = @{@"normalKey":@"normalKey",@"numberKey":@99,@"subModel":@{@"sublKey":@"sublKey"}};
    
    [model setValuesForKeysWithDictionary:dict];// 嵌套了模型，但是貌似崩溃了
    
    if ([model.subModel isKindOfClass:[NSDictionary class]]) {
        BPLog(@"model.name = %@,model.price = %@,model.subModel.lastName = %@",model.normalKey,model.numberKey,[model.subModel  valueForKey:@"sublKey"]);
    }
    
    NSArray *keys = @[@"normalKey",@"numberKey",@"subModel"];
    NSDictionary* dic = [model dictionaryWithValuesForKeys:keys]; //把对应key所有的属性全部取出来
    BPLog(@"%@",dic);
}

#pragma mark - 集合操作符：keypath方法，@开头

- (void)collectionOperator {
    
    BPKVCModel *model = [[BPKVCModel alloc] init];
    model.numberKey = @(1);
    
    BPKVCModel *model1 = [[BPKVCModel alloc]init];
    model1.numberKey = @(2);
    
    NSArray *array = @[model,model1];
    
    // 集合操作符：作用于 array 或者 set 中相对于集合操作符右侧的属性

    // @count返回集合中的元素个数
    NSString *count = [array valueForKeyPath:@"@count"];
    
    // @max用来查找集合中right keyPath指定的属性的最大值。比较操作由属性的compare: 方法决定
    NSNumber *maxNumber = [array valueForKeyPath:@"@max.numberKey"];
    
    // @min用来查找集合中right keyPath指定的属性的最小值。
    NSString *minNumber = [array valueForKeyPath:@"@min.numberKey"];
    
    // @sum用来计算集合中right keyPath指定的属性的总和。
    NSNumber *sum = [array valueForKeyPath:@"@sum.numberKey"];
    
    //@avg用来计算集合中right keyPath指定的属性的平均值。当均值为 nil 的时候，返回 0
    NSNumber *avg = [array valueForKeyPath:@"@avg.numberKey"];
    
    BPLog(@"count = %@, maxNumber = %@, minNumber = %@, sum = %@, avg = %@",count,maxNumber,minNumber,sum,avg);
    
    // 数组操作符：将集合中的所有对象的同一个属性放在数组中，并返回相对的value的数组。注意以下四个方法，如果操作的属性为nil，则在添加到数组中时会导致crash。

    // @unionOfObjects 不会对数组去重
    NSArray *numberValueArray1 = [array valueForKeyPath:@"@unionOfObjects.numberKey"];
    // @distinctUnionOfObjects 会对数组去重
    NSArray *numberValueArray2 = [array valueForKeyPath:@"@distinctUnionOfObjects.numberKey"];
    BPLog(@"numberValueArray1 = %@",numberValueArray1);
    BPLog(@"numberValueArray2 = %@",numberValueArray2);


    // 嵌套操作符：集合内部的每个元素又是一个小集合。嵌套操作符是对嵌套的集合进行操作：将嵌套集合中的所有对象的同一个属性放在数组中返回。

    NSArray *array1 = array.copy;
    NSArray *totalArray = @[array,array1];
    
    // @unionOfArrays 用来操作集合内部的集合对象，将所有right keyPath对应的对象放在一个数组中返回。不会对数组去重
    NSArray *numberValueArray3 = [totalArray valueForKeyPath:@"@unionOfArrays.numberKey"];
    
    // @distinctUnionOfArrays 用来操作集合内部的集合对象，将所有right keyPath对应的对象放在一个数组中，并进行排重。
    NSArray *numberValueArray4 = [totalArray valueForKeyPath:@"@distinctUnionOfArrays.numberKey"];
    
    // @distinctUnionOfSets 用来操作集合内部的集合对象，将所有right keyPath对应的对象放在一个set中，并进行排重。
    NSSet *set = [NSSet setWithObjects:model,model1, nil];
    NSSet *set1 = [NSSet setWithObjects:set, nil];
    NSSet *numberValueSet = [set1 valueForKeyPath:@"@distinctUnionOfSets.numberKey"];
    
    BPLog(@"numberValueArray3 = %@",numberValueArray3);
    BPLog(@"numberValueArray4 = %@",numberValueArray4);
    BPLog(@"numberValueSet = %@",numberValueSet);

    // 对属性为集合类型的操作
    [model addObserver:self forKeyPath:@"muArray" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    NSMutableArray *muArray = @[@"item1",@"item2"].mutableCopy;
    [model setValue:muArray forKey:@"muArray"];
    
    [muArray insertObject:@"item3" atIndex:2];
    
    NSMutableArray *muArray1 = [model valueForKey:@"muArray"];
    
    BPLog(@"muArray = %@",muArray1)
}

#pragma mark - KVC的查找顺序
- (void)searchKey {
    // 实例变量匹配：setter方法，key，_key, isKey, _isKey 同名的实例变量，直接赋值。
    
    BPKVCModel *model = [[BPKVCModel alloc] init];
    
    // 最终找到了_isnormalKey
    [model setValue:@"noSetter" forKey:@"noSetter"];
    NSString *noSetter = [model valueForKeyPath:@"noSetter"];
    BPLog(@"value:%@",noSetter);
    
    //kvc 不存在的属性
    [model setValue:@"noExistKey" forKeyPath:@"noExistKey"];
    BPLog(@"value:%@",[model valueForKey:@"noExistKey"]);
}

#pragma mark - 自定义KVC
- (void)customKVC {
    BPKVCModel *model = [BPKVCModel new];
    model.normalKey = @"normalKey";
    //    [model bp_setValue:nil forKey:@"normalKey"]; //测试设置 nil value
    [model bp_setValue:@"normalKey" forKey:@"normalKey"];
    NSLog(@"normalKey:%@",model.normalKey);
    
    NSString *normalKey = [model bp_valueforKey:@"normalKey"];
    NSLog(@"normalKey:%@",normalKey);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"muArray"]) {
        NSMutableArray *old = change[NSKeyValueChangeOldKey];
        NSMutableArray *new = change[NSKeyValueChangeNewKey];
        BPLog(@"old = %@,new = %@",old,new);
    } 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
