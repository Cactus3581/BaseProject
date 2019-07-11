//
//  KSSentenceTextTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSDailySentenceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSSentenceTextTableViewCell : UITableViewCell

@property (nonatomic, strong) KSDailySentenceContentItemDetailModel *model;

@end

NS_ASSUME_NONNULL_END
