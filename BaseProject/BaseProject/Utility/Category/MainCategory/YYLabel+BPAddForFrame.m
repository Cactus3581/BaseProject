//
//  YYLabel+BPAddForFrame.m
//  TryCenter
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "YYLabel+BPAddForFrame.h"
#import "UIView+BPAddForFrame.h"
#import "NSString+BPAdd.h"

@implementation YYLabel (BPAddForFrame)

- (CGSize)bp_contentSize{
    return [self.text  bp_sizeWithfont:self.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

@end
