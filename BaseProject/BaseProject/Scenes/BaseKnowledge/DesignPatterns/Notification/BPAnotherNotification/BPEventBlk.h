//
//  BPEventBlk.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BPEventCallBlk)(id info);

@interface BPEventBlk : NSObject

@property (nonatomic, copy) BPEventCallBlk callBlk;

@end
