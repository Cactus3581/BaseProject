//
//  SUGoodsCell.m
//  SenbaUsed
//
//  Created by shiba_iOSRB on 16/7/26.
//  Copyright © 2016年 曾维俊. All rights reserved.
//


#import "SUGoodsCell.h"
#import <ReactiveObjC.h>

@interface SUGoodsCell()

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UIButton *thumbBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;

@end


@implementation SUGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addAction];
}

#pragma mark - bind data
- (void)setItemViewModel:(SUGoodsItemViewModel *)itemViewModel {
    _itemViewModel = itemViewModel;
    [self.thumbBtn setTitle:itemViewModel.goods.likes forState:UIControlStateNormal];
    self.thumbBtn.selected = itemViewModel.goods.isLike;
}

- (void)addAction {
    // 使用MVVM without RAC 的事件回调
    [self.thumbBtn addTarget:self action:@selector(thum) forControlEvents:UIControlEventTouchUpInside];

    // MVVM with RAC 的事件回调
    @weakify(self);
    // 头像
    // Fixed : 这个方法会导致上面的使用 MVC 或者 MVVM without RAC 情况的头像点击失效 但是理论上是绝对不会出现这两种模式共存的情况的 这里笔者只是为了做区分而已
    UITapGestureRecognizer *avatarTap = [[UITapGestureRecognizer alloc] init];
    [self.userHeadImageView addGestureRecognizer:avatarTap];
    [avatarTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.itemViewModel.didClickedAvatarSubject sendNext:self.itemViewModel];
        //MVVM without RAC 有效
        !self.avatarClickedHandler?:self.avatarClickedHandler(self);
    }];

    // 回复
    [[self.replyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *sender) {
         @strongify(self);
         [self.itemViewModel.didClickedReplySubject sendNext:self.itemViewModel];
     }];

    // 收藏按钮
    [[self.thumbBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *sender) {
         @strongify(self);
         // 执行
         self.thumbBtn.enabled = NO;
         @weakify(self)
         [[[self.itemViewModel.operationCommand execute:self.itemViewModel] deliverOnMainThread] subscribeCompleted:^{
              @strongify(self)
              self.thumbBtn.enabled = YES;
          }];
     }];
    
    // 以下为 MVVM With RAC 模式的的数据绑定
    // 按钮选中状态
    [RACObserve(self, itemViewModel.goods.isLike).deliverOnMainThread.distinctUntilChanged subscribeNext:^(NSNumber *isLike) {
        @strongify(self);
        self.thumbBtn.selected = isLike.boolValue;
        NSString *tips = (isLike.boolValue)?@"收藏商品成功":@"取消收藏商品";
    }];
    
    // 监听点赞数据
    [RACObserve(self, itemViewModel.goods.likes).deliverOnMainThread.distinctUntilChanged subscribeNext:^(NSString * likes) {
         @strongify(self);
         [self.thumbBtn setTitle:likes forState:UIControlStateNormal];
     }];
}

- (void)thum {
    !self.thumbClickedHandler?:self.thumbClickedHandler(self);
}

@end
