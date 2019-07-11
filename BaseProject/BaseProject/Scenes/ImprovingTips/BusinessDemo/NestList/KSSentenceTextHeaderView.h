//
//  KSSentenceTextHeaderView.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSDailySentenceModel.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN  CGFloat const KSSentenceTextHeaderViewHeight;

@interface KSSentenceTextHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) KSDailySentenceContentModel *model;

@end

NS_ASSUME_NONNULL_END
