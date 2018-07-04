//
//  BPAudioModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPDownLoadMacro.h"

@interface BPAudioModel: NSObject

@property (nonatomic, assign) NSInteger catid;
@property (nonatomic, copy) NSString *mediaUrl;
@property (nonatomic, assign) CGFloat mediaSize;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, assign) NSInteger mediaType;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, assign) NSInteger onlineTime;
@property (nonatomic, assign) NSInteger identify;
@property (nonatomic, assign) NSInteger views;
@property (nonatomic, copy) NSString *smallpic;
@property (nonatomic, copy) NSString *cidTitle;
@property (nonatomic, copy) NSString *catname;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger mediaTime;
@property (nonatomic, copy) NSString *mediaLrc;
@property (nonatomic, assign) NSInteger dataType;

@end
