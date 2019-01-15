//
//  BPEventBlk.h
//  PSSNotification
//
//  Created by 泡泡 on 2018/11/13.
//  Copyright © 2018 泡泡. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BPEventCallBlk)(id info);

@interface BPEventBlk : NSObject

@property (nonatomic, copy) BPEventCallBlk callBlk;

@end
