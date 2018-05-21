//
//  BPCalendarMonthSectionView.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BPCalendarModel;

@interface BPCalendarMonthSectionView : UICollectionReusableView

@property (nonatomic,copy) NSString *str;
@property (nonatomic,strong) BPCalendarModel *model;

@end
