//
//  BPCellAutoLayoutHeightModel.h
//  BaseProject
//
//  Created by Ryan on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPCellAutoLayoutHeightModel : NSObject
@property (nonatomic,copy) NSString *headImage;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *photoImage;

@property (assign, nonatomic)CGFloat cell1stHeight;//iOS8
@property (assign, nonatomic)CGFloat cell2ndHeight;//iOS6
@property (assign, nonatomic)CGFloat cell3rdHeight;//手算用的

@end
