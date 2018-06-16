//
//  BPPerson.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPerson.h"

/*
 1。 类的实现部分 :以@impementation开头，以@end结尾 只要符号这种形式，就可以完成类的实现。类的实现部分  主要进行 方法的实现。
*/

/*
 @synthesize:合成访问器,帮我们实现对应的setter和getter方法
 @synthesize 1.进行setter  getter方法实现  2.检测被操作的实例变量 是否存在

 @synthesize name = _name;
 @synthesize 是关键字
 name = _name name是属性名，_name是实例变量。
 
 1.实现了set get方法
 2.告知在set和get方法操作的实例变量是_name
 
 //当@synthesize 生成的set，get方法 操作实例变量时，会进行一个检测，如果实例变量存在，进行赋值取值，如果实例变量不存在，则会帮我们生成私有的实例变量（_属性名，例如，name属性自动生成的实例变量为_name）
 
 如果@synthesize 省略不写  系统会为我们做这一切，也就是说我们只需要声明属性
 */

/*
 1.属性
 @property   声明属性
 @synthesize 1.进行setter  getter方法实现  2.检测被操作的实例变量 是否存在
 
 2.属性的属性
 三大属性
 a.读写特性 readwrite  readonly
 b.原子特性 atomic  nonatomic
 c.语义特性 assign  retain  copy
 
 3.KVC
 //设置值
 setValue:forKey:
 setValue:forKeyPath:
 setValuesForKeysWithDictionary:
 //取值
 valueForKey:
 valueForKeyPath:
 
 */

@interface BPPerson ()
@property (nonatomic,strong) NSNumber *phoneNumber;
@end


@implementation BPPerson
//在.m文件中同时实现getter和setter时候需要@synthesize phoneNumber = _phoneNumber.
@synthesize phoneNumber = _phoneNumber;

- (instancetype)initWithName:(NSString *)name weight:(CGFloat)weight {
    self = [super init];
    if (self) {
        _name = name;
        _weight = weight;
    }
    return self;
}

/*便利构造器
 1、便利构造器是一种快速创建对象的方式。它本质上是把初始化方法做了一次封装，方便外界使用
 2、便利构造器是一个类方法（以+开头）
 
 语法形式 :
 + (当前类类型) 当前类名小写开头With各个参数;
 便利构造器内部就是封装了aclloc 和初始化方法（init）。
 */
+ (BPPerson *)personWithName:(NSString *)name weight:(CGFloat)weight {
    BPPerson *person = [[BPPerson alloc]initWithName:name weight:weight];
    return person;
}

- (instancetype)init {
    _name = @"joy";
    _sex = @"男";
    _age = 18;
    _weight = 140;
    BPLog(@"初始化方法:%p",self);
    return self;
}

- (void)sayHi {
    BPLog(@"name:%@ sex:%@ age: %ld,weight :%f",_name,_sex,_age,_weight);
}

#pragma mark - setter getter

- (void)writeEmail:(NSString *)email {
    // setter ＝ 方法名，getter ＝ 方法名  生成我们指定方法名的setter和getter
}

////retain||strong下
- (void)setPhoneNumber:(NSNumber *)phoneNumber {
    //如果传入的对象和之前持有的 不是一个对象
    if (_phoneNumber != phoneNumber) {
        /* MRC下
        释放之前对象的所有权
        [_number release]; //ARC下，省略
        对新的对象持有所有权
        _number = [number retain];
         */
        //ARC下
        _phoneNumber = phoneNumber;
    }
}

- (NSNumber *)phoneNumber {
    return _phoneNumber;
}

//copy
- (void)setName:(NSString *)name {
    if (_name != name) {
        //[_name release]; //ARC下，省略
        _name = [name copy];
    }
}

- (NSString *)name {
    return _name;
}

//assign
- (void)setAge:(NSInteger)age {
    _age = age;
}

- (NSInteger)age {
    return _age;
}

#pragma mark - KVC
//kvc 模式下：不用管 自己就会调用。触发使用
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    BPLog(@"没有发现key:%@",key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    BPLog(@"找不到key:%@",key);
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    //创建新的对象
    BPPerson *newPer = [[BPPerson alloc]init];
    //对应实例变量
    newPer.name = self.name;
    //newPer.sex = self.sex;//会报错
    newPer.age = self.age;
    // 返回新的对象
    return newPer;
}

//排序
- (NSComparisonResult)compareByAge:(BPPerson *)anotherPerson {
    //降序 注意self 与anothe的使用; 如果传对象用什么表示的思想；传两个对象怎么表示的思想；点语法；三个return的思想；NSOrderedDescending；两两比较，数组返回的思想
    if (self.weight> anotherPerson.weight) {
        return NSOrderedDescending;
        //升序
    }else if(self.weight < anotherPerson.weight){
        return NSOrderedAscending;
    }
    //相等
    return NSOrderedSame;
}

//升序
- (NSComparisonResult)compareByName:(BPPerson *)anotherStudent {
    return [self.name compare:anotherStudent.name];
}
//降序
- (NSComparisonResult)compareByName2:(BPPerson *)anotherStudent {
    return -[self.name compare:anotherStudent.name];
}

//重写desceiption
//desceiption:设置了当前类的输出字符串的格式
- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@ age:%ld",_name,_age];
}

@end
