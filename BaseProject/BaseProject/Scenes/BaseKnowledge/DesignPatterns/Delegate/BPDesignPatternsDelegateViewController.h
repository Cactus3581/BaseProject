//
//  BPDesignPatternsDelegateViewController.h
//  BaseProject
//
//  Created by Ryan on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"
#import "BPDesignPatternsProtocol.h"

@interface BPDesignPatternsDelegateViewController : BPBaseViewController

// 声明协议代理
@property(nonatomic,weak) id<BPDesignPatternsProtocol> delegate;

@end
