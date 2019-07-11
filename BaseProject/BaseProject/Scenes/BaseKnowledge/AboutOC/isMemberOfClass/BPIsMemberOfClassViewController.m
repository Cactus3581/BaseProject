//
//  BPIsMemberOfClassViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/2/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPIsMemberOfClassViewController.h"
#import "BPIsMemberOfClassModel.h"

@interface BPIsMemberOfClassViewController ()

@end

@implementation BPIsMemberOfClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     class：类和对象的；
     isKindOfClass；
     isMemberOfClass；
     */
    
    
    /*
     类对象的Class方法返回的是自身，也就是返回的是自身类。
     实例对象的Class方法返回的对象所属的类，也就是实例对象的类对象。
     isKindOfClass：第一个参数的isa是否指向第二个参数，也就是说，第一个参数是否是第二个参数的实例，isKindOfClass可以走superClass关系，也就是说第一个参数所属的类，派生自第二个参数指的类，就想等。

     isKindOfClass：
     [NSObject class]，返回的是自身，也就是NSObject；isKindOfClass，意思是NSObject是否派生自NSObject，也就是判断NSObject是否是NSObject的实例；因为NSObject的isa指向的是根元类，再走继承关系（superClass链条），根元类的superClass是NSObject，也就是说，所以相等
     
     isMemberOfClass：也就是判断NSObject是否是NSObject的实例；
     因为根类的isa指向的是根元类，使用isMemberOfClass，不能走继承关系（superClass链条），也就是说NSObject是根元类的实例，这句话是对的，但NSObject并不是由NSObject的实例，所以不相等
    */
    
    BPLog(@"NSObject %d,%d",[[NSObject class] isKindOfClass:[NSObject class]],[[NSObject class] isMemberOfClass:[NSObject class]]); // 1,0
    
    
    /*
     [UIViewController class]，返回的是自身，也就是UIViewController；isKindOfClass，意思是UIViewController是否派生自UIViewController，也就是判断UIViewController是否是UIViewController的实例；因为UIViewController的isa指向的是元类，再走继承关系（superClass链条），根元类的superClass是NSObject，也就是说，所以相等

     */
    BPLog(@"UIViewController %d,%d",[[UIViewController class] isKindOfClass:[UIViewController class]],[[UIViewController class] isMemberOfClass:[UIViewController class]]); // 0,0
    
    BPLog(@"BPIsMemberOfClassModel %d,%d",[[BPIsMemberOfClassModel class] isKindOfClass:[BPIsMemberOfClassModel class]],[[BPIsMemberOfClassModel class] isMemberOfClass:[BPIsMemberOfClassModel class]]); // 0,0
    
    BPLog(@"[self class] %d,%d",[[self class] isKindOfClass:[UIViewController class]],[[self class] isMemberOfClass:[UIViewController class]]); //
    
    BPLog(@"[super class] %d,%d",[[super class] isKindOfClass:[UIViewController class]],[[super class] isMemberOfClass:[UIViewController class]]); //
    
    // 对象的Class方法
    BPIsMemberOfClassModel *model = [[BPIsMemberOfClassModel alloc] init];
    BPLog(@"BPIsMemberOfClassModel %d,%d",[model isKindOfClass:[BPIsMemberOfClassModel class]],[model isMemberOfClass:[BPIsMemberOfClassModel class]]); // 1,1
    
    BPLog(@"BPIsMemberOfClassModel %d,%d",[self isKindOfClass:[UIViewController class]],[self isMemberOfClass:[UIViewController class]]); //
}

@end
