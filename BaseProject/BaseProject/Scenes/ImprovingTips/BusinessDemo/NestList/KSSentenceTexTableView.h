//
//  KSSentenceTexTableView.h
//  BaseProject
//
//  Created by Ryan on 2019/4/30.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSDailySentenceModel.h"

NS_ASSUME_NONNULL_BEGIN

@class KSSentenceTexTableView;

@protocol KSSentenceTexTableViewDelegate <NSObject>

@optional

- (void)sentenceTextFooterView:(KSSentenceTexTableView *)footer height:(CGFloat)height;

@end

@interface KSSentenceTexTableView : UIView

@property (nonatomic, strong) KSDailySentenceModel *model;
@property(nonatomic, weak) id<KSSentenceTexTableViewDelegate> delegate;

- (CGFloat)getListHeight;

@end

NS_ASSUME_NONNULL_END
