//
//  BPOutSideSubView.m
//  BaseProject
//
//  Created by Ryan on 2019/5/5.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPOutSideSubView.h"
#import "UIResponder+BPMsgSend.h"

@implementation BPOutSideSubView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BPLog(@"Sub");
    [self bp_routerEventWithName:@"" userInfo:nil];
}

@end
