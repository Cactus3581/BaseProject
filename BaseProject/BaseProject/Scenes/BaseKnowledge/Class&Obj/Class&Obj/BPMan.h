//
//  BPMan.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPPerson.h"

/*
 1.继承:子类继承于父类 意味着 拥有了父亲所有的 实例变量 和方法（当前子类自身的实例变量和方法）;子类可以重写从父亲继承的方法 
 */
@interface BPMan : BPPerson

//重写从父类继承过来的方法
- (void)sayHi;

@end
