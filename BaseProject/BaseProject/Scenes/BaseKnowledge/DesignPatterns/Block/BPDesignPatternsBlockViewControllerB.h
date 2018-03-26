//
//  BPDesignPatternsBlockViewControllerB.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"
//注意事项；1.用copy；2.用__block。

//1.重新起个名字
typedef void(^PassValueBlock)(NSString *);

@interface BPDesignPatternsBlockViewControllerB : BPBaseViewController
//2.声明block属性
@property(nonatomic,copy)PassValueBlock  passValueBlock;
@end
