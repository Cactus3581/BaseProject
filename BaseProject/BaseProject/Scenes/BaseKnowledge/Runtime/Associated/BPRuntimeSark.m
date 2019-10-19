//
//  BPRuntimeSark.m
//  BaseProject
//
//  Created by Ryan on 2019/1/13.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPRuntimeSark.h"

@implementation BPRuntimeSark

- (void)speak {
    BPLog(@"my name's %@", self.name); //  有时候会崩溃
}

@end
