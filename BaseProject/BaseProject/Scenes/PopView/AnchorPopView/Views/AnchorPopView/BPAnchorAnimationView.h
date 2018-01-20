//
//  BPAnchorAnimationView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger,BPAnchorViewAnimationType){
    NormalShowAnimation = 1 << 0,
    NormalRemoveAnimation = 1 << 1,
    SpringShowAnimation = 1 << 2,
    SpringRemoveAnimation = 1 << 3
};

@protocol BPAnchorAnimationViewDelegate <NSObject>
@optional
- (void)showAnimationCompletion;
- (void)removeAnimationCompletion;
@end

@interface BPAnchorAnimationView : UIView
@property (nonatomic,strong) NSDictionary  * _Nonnull dic;
@property (nonatomic,assign) BPAnchorViewAnimationType animationType;
@property (nonatomic,weak) id<BPAnchorAnimationViewDelegate> delegate;
@property (nonatomic,copy,nullable)  dispatch_block_t nextAction;
@property (nonatomic, copy, nullable) void (^examineBlock)(NSDictionary * _Nullable dic);

- (void)removeAletView;

- (void)startAnimation:(BPAnchorViewAnimationType)type;

- (void)startNormalAnimation;

- (void)startSpringAnimation;
@end
