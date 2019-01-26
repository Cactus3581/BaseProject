//
//  BPSwizzlingChild.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSwizzlingChild.h"

@implementation BPSwizzlingChild

+ (void)load{
    NSLog(@"%s",__func__);
}

//+ (void)initialize{
//    NSLog(@"%s %@",__func__,[self class]);
//}

//- (void)foo {
////    [super foo];
//    NSLog(@"chaild foo = %@",[self class]);
//}

@end
