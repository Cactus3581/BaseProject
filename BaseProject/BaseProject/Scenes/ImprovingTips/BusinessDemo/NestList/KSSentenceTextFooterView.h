//
//  KSSentenceTextFooterView.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/30.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN  CGFloat const KSSentenceTextFooterViewHeight;

@class KSSentenceTextFooterView;

@protocol KSSentenceTextFooterViewDelegate <NSObject>

@optional

- (void)sentenceTextFooterView:(KSSentenceTextFooterView *)footer isExpansion:(BOOL)isExpansion;

@end


@interface KSSentenceTextFooterView : UIView

@property(nonatomic, weak) id<KSSentenceTextFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
