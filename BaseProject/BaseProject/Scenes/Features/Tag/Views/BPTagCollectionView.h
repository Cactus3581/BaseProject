//
//  BPTagCollectionView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BPTagModel.h"

@protocol LPSwitchTagDelegate <NSObject>
/**
 *  返回选择的标签
 *
 *  @param tagModel 选择的标签
 */
- (void)switchTag:(BPTagModel *)tagModel;
/**
 *  取消选择的标签
 *
 *  @param tagModel 标签
 */
- (void)disSwitchTag:(BPTagModel *)tagModel;
@end

@interface BPTagCollectionView : UICollectionView

@property (nonatomic, assign) NSInteger maximumNumber;/**<最多选项数,默认不限制*/
@property (nonatomic, strong) NSArray *tagArray;/**<标签数组,数组里存放BPTagModel*/
@property (nonatomic, strong) id <LPSwitchTagDelegate> tagDelegate;

@end

