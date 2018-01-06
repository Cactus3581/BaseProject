//
//  ArchiverModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/17.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "ArchiverModel.h"

@implementation ArchiverModel

- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age
{
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
    }
    
    return self;
}

/**
 *  每次从文件中恢复(解码)对象时，都会调用这个方法。
 *  一般在这个方法里面指定如何解码文件中的数据为对象的实例变量，
 *  可以使用decodeObject:forKey:方法解码实例变量
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];


    }
    
    return self;
}
/**
 *  编码归档
 *  每次归档对象时，都会调用这个方法。
 *  一般在这个方法里面指定如何归档对象中的每个实例变量，
 *  可以使用encodeObject:forKey:方法归档实例变量
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInteger:_age forKey:@"age"];

}






        
@end
