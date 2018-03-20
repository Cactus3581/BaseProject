//
//  KSCellProgressTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSCellProgressTableViewCell.h"
#import "KSCellProgressSimulateDownloader.h"

@interface KSCellProgressTableViewCell()
@property (nonatomic, strong)   UILabel *lbRow;
@property (nonatomic, strong)   UIButton *btnPlay;
@property (nonatomic, strong)   KSCellProgressSimulateDownloader *downloader;

@end

/*
 下载器，cell，model；
 cell是重用的，其他不是；
 绑定，kvo（下载器与model绑定；cell监听model的progress属性；cell检测如果更新的model是自己的才更新UI；）
 */

@implementation KSCellProgressTableViewCell

- (void)setLabelIndex:(NSUInteger)index model:(KSCellProgressModel *)model {
    self.lbRow.text = [NSString stringWithFormat:@"%u",index];
    self.model = model;
    //这里根据model值来绘制UI
    if (model.progress > 0) {
        [_btnPlay setImage:nil forState:UIControlStateNormal];
    } else {
        [_btnPlay setImage:[UIImage imageNamed:@"ic_download_transfer"] forState:UIControlStateNormal];
    }
    //监听progress
    [self.model addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionOld context:nil];
}

//下载器也与model绑定，这样可以通知到准确的model更新
- (void)simulateDownloadProgress {
    [_btnPlay setImage:nil forState:UIControlStateNormal];
    [_downloader startDownload:self.model];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    KSCellProgressModel *model = (KSCellProgressModel *)object;
    //检查是否是自己的model更新，防止复用问题
    if (model.modelId != self.model.modelId) {
        return;
    }
    float from = 0, to = 0;
    
    if ([keyPath isEqualToString:@"progress"]) {
        if (change[NSKeyValueChangeOldKey]) {
            from = [change[NSKeyValueChangeOldKey] floatValue];
        }
        if (change[NSKeyValueChangeNewKey]) {
            to = [change[NSKeyValueChangeNewKey] floatValue];
        }
        [self setCircleProgressFrom:from To:to];
    }
}

- (void)setCircleProgressFrom:(CGFloat)from To:(CGFloat)to {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
