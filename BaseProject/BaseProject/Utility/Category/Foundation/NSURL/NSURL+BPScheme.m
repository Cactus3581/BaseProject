//
//  NSURL+BPScheme.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/9/22.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSURL+BPScheme.h"

@implementation NSURL (BPScheme)
- (NSURL *)customSchemeURL {
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:NO];
    components.scheme = @"streaming";
    return [components URL];
}

- (NSURL *)originalSchemeURL {
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:NO];
    components.scheme = @"http";
    return [components URL];
}

@end
