//
//  BPDesignPatternsProtocolModel.m
//  BaseProject
//
//  Created by Ryan on 2019/7/25.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDesignPatternsProtocolModel.h"

@implementation BPDesignPatternsProtocolModel

- (void)requiredMethod{
    NSLog(@"requiredMethod——必须实现的方法");
}

- (void)optionalMethod{
    NSLog(@"optionalMethod——选择实现的方法");
}

@end
