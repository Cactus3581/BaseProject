//
//  SUGoodsCell.m
//  SenbaUsed
//
//  Created by shiba_iOSRB on 16/7/26.
//  Copyright © 2016年 曾维俊. All rights reserved.
//


#import "SUGoodsCell.h"
#import <ReactiveObjC.h>
#import "SUGoodsItemViewModel.h"

@interface SUGoodsCell()

// 位置按钮
@property (weak, nonatomic) IBOutlet UIButton *thumbBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;


// 以下 MVVM使用的场景，如果使用MVC的请自行ignore
// viewModle
@property (nonatomic, readwrite, strong) SUGoodsItemViewModel *viewModel;
// 以上 MVVM使用的场景，如果使用MVC的请自行ignore

@end


@implementation SUGoodsCell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)awakeFromNib {
    [super awakeFromNib];

    // --- add Action ---
    // 使用MVC 和 MVVM without RAC 的事件回调
    [self _addActionDealForMVCOrMVVMWithoutRAC];
    
    // MVVM with RAC 的事件回调
    [self _addActionDealForMVVMWithRAC];
    
    // 以下 MVVM With RAC 模式的的数据绑定 如果使用其他的模式的请自行ignore
    @weakify(self);
    // 按钮选中状态
    [RACObserve(self, viewModel.goods.isLike).deliverOnMainThread.distinctUntilChanged subscribeNext:^(NSNumber *isLike) {
        @strongify(self);
        self.thumbBtn.selected = isLike.boolValue;
        NSString *tips = (isLike.boolValue)?@"收藏商品成功":@"取消收藏商品";
    }];
    
    // 监听点赞数据
    [RACObserve(self, viewModel.goods.likes).deliverOnMainThread.distinctUntilChanged subscribeNext:^(NSString * likes) {
         @strongify(self);
         [self.thumbBtn setTitle:likes forState:UIControlStateNormal];
     }];
}

#pragma mark - bind data
- (void)bindViewModel:(SUGoodsItemViewModel *)viewModel {
    self.viewModel = viewModel;
    // 点赞数
    [self.thumbBtn setTitle:viewModel.goods.likes forState:UIControlStateNormal];
    self.thumbBtn.selected = viewModel.goods.isLike;
}

#pragma mark - 事件处理
// 以下 MVC 和 MVVM without RAC 的事件回调的使用的场景，如果使用MVVM With RAC的请自行ignore
// 事件处理 我这里使用 block 来回调事件 （PS：大家可以自行决定）
- (void)_addActionDealForMVCOrMVVMWithoutRAC {
    [self.thumbBtn addTarget:self action:@selector(thum) forControlEvents:UIControlEventTouchUpInside];
}

- (void)thum {
    !self.thumbClickedHandler?:self.thumbClickedHandler(self);
}

// 以下 MVVM With RAC 的事件回调的使用的场景，如果使用其他的模式的请自行ignore
// 事件处理 我这里使用 block 来回调事件 （PS：大家可以自行决定）
- (void)_addActionDealForMVVMWithRAC {
    @weakify(self);
    // 头像
    // Fixed : 这个方法会导致上面的使用 MVC 或者 MVVM without RAC 情况的头像点击失效 但是理论上是绝对不会出现这两种模式共存的情况的 这里笔者只是为了做区分而已
    UITapGestureRecognizer *avatarTapGr = [[UITapGestureRecognizer alloc] init];
    [self.userHeadImageView addGestureRecognizer:avatarTapGr];
    [avatarTapGr.rac_gestureSignal
    subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.didClickedAvatarSubject sendNext:self.viewModel];
        //  MVC 或者 MVVM without RAC 有效
        !self.avatarClickedHandler?:self.avatarClickedHandler(self);
    }];

    // 回复
    [[self.replyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *sender) {
         @strongify(self);
         [self.viewModel.didClickedReplySubject sendNext:self.viewModel];
     }];

    // 收藏按钮
    [[self.thumbBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *sender) {
         @strongify(self);
         // 执行
         self.thumbBtn.enabled = NO;
         @weakify(self)
         [[[self.viewModel.operationCommand
            execute:self.viewModel]
           deliverOnMainThread]
          subscribeCompleted:^{
              @strongify(self)
              self.thumbBtn.enabled = YES;
          }];
         
     }];
}

@end
