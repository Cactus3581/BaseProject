//
//  BPKVCViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/4/7.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPKVCViewController.h"
#import "BPKVCModel.h"

@interface BPKVCViewController ()

@end

@implementation BPKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = kBlackColor;
    bt.titleLabel.font = [UIFont systemFontOfSize:13];
    [bt setTitle:@"我要反馈" forState:UIControlStateNormal];
    bt.titleLabel.backgroundColor = kGreenColor;
    bt.imageView.backgroundColor = kLightGrayColor;
    [bt setImage:[UIImage imageNamed:@"circle_money"] forState:UIControlStateNormal];
    CGSize strSize = [@"我要反馈" sizeWithFont:bt.titleLabel.font];
    UIImage *image = [UIImage imageNamed:@"circle_money"];
    CGFloat imageWidth = image.size.width; //20
    CGFloat titleWidth = strSize.width;//54
    //100-74 = 26;
 /*
    [bt setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];   //40 * 40

     [bt setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, -8)];
  */
    /*

    [bt setImageEdgeInsets:UIEdgeInsetsMake(0, -13, 0, 13)];
    
   [bt setTitleEdgeInsets:UIEdgeInsetsMake(0, 13, 0, -13)];
     */

    [self.view addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        //
       // make.center.equalTo(self.view);

        make.centerY.equalTo(self.view);
     //   make.centerX.mas_equalTo(kScreenWidth/2);

        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(kScreenWidth-100);
    }];
    
    //[self testKVC];
    
    //[self testCompare_Str];
    //[self testCompare_Array];
    
    
    //UIImageView *imageView = [[UIImageView alloc]init];
    /*
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    imageView.center = self.view.center;

    imageView.image = [UIImage imageNamed:@"layerTest"];
    imageView.backgroundColor = kRedColor;
    //imageView.layer.backgroundColor = kRedColor.CGColor;
    //imageView.contentMode = UIViewContentModeScaleAspectFit;//这个可以考虑
   //imageView.contentMode = UIViewContentModeCenter;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES; //跟以下语句一样

    [self.view addSubview:imageView];
     */

    
    /*
    UIViewContentModeTop,
    UIViewContentModeBottom,
    UIViewContentModeLeft,
    UIViewContentModeRight,
    UIViewContentModeTopLeft,
    UIViewContentModeTopRight,
    UIViewContentModeBottomLeft,
    UIViewContentModeBottomRight,

    //imageView.contentMode = UIViewContentModeTopLeft;

    //imageView.clipsToBounds = YES; //跟以下语句一样
    //imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.view);
        make.width.mas_equalTo(50);
        make.width.mas_equalTo(100);

    }];
*/
    
    





}

- (void)testCompare_Str
{
    NSString *str = @"abcdef";
    NSString *str1 = @"wxyz";

    
    int result = [str compare:str1];
    if (result == NSOrderedSame) {
        BPLog(@"same");
        
    }else if (result == NSOrderedAscending)
    {
        BPLog(@"Ascend");

    }else if (result == NSOrderedDescending)
    {
        BPLog(@"Descend");

    }
    
    NSString *str2 = @"18";
    NSString *str3 = @"6";
    int result1 = [str2 compare:str3 options:NSNumericSearch];
    if (result1 == NSOrderedSame) {
        BPLog(@"same");
        
    }else if (result1 == NSOrderedAscending)
    {
        BPLog(@"Ascend");
        
    }else if (result1 == NSOrderedDescending)
    {
        BPLog(@"Descend");
        
    }
    


}
- (void)testCompare_Array
{
    
}
- (void)testKVC
{
    //    如何取出数组中的最大值或者最小值？
    BPKVCModel *model = [[BPKVCModel alloc]init];
    model.name = @"iMac";
    model.price = @18888;
    BPKVCModel *model1 = [[BPKVCModel alloc]init];
    model1.name = @"iphone";
    model1.price = @6999;
    
    NSArray *array = @[model,model1];
    
    
    //简单类型的集合操作符，返回 strings, numbers, dates,
    //    简单集合操作符作用于 array 或者 set 中相对于集合操作符右侧的属性。包括 @avg, @count, @max, @min, @sum.
    NSString *name = [array valueForKeyPath:@"@count"];//回集合中对象总数的 NSNumber 对象。操作符右边没有键路径。
    NSNumber  *price_max = [array valueForKeyPath:@"@max.price"];//比较由操作符右边的键路径指定的属性值，并返回比较结果的最大值。最大值由指定的键路径所指对象的 compare: 方法决定
    NSString *price_min = [array valueForKeyPath:@"@min.price"];//返回的是集合中的最小值
    NSNumber  *price_sum = [array valueForKeyPath:@"@sum.price"];//属性值的总和
    NSNumber  *price_avg = [array valueForKeyPath:@"@avg.price"];//转换为 double, 计算其平均值，返回该平均值的 NSNumber 对象。当均值为 nil 的时候，返回 0.
    
    //    提示：你可以简单的通过把 self 作为操作符后面的 key path 来获取一个由 NSNumber 组成的数组或者集合的总值，例如对于数组 @[@(1), @(2), @(3)] 可使用 valueForKeyPath:@"@max.self" 来获取最大值。
    
    
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
    
    //    注意: 如果操作符右侧 key path 指定的对象为 nil，那么返回的数组中会包含 NSNull 对象.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
