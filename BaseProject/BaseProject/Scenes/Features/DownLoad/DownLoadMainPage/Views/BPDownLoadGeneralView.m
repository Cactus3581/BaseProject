//
//  BPDownLoadGeneralView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDownLoadGeneralView.h"
#import "UIImageView+WebCache.h"

@interface BPDownLoadGeneralView ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *buttonBackView;
@property (weak, nonatomic) IBOutlet UIButton *startDownLoad;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *resume;
@property (weak, nonatomic) IBOutlet UIButton *stop;
@property (strong, nonatomic) BPAudioModel *model;
@property (strong, nonatomic) BPDownLoadItem *item;

@end

@implementation BPDownLoadGeneralView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.downLoadButton.hidden = YES;
    [self.downLoadButton setImage:[UIImage imageNamed:@"module_startdownload"] forState:UIControlStateNormal];
    [self.downLoadButton setImage:[UIImage imageNamed:@"module_stopDownLoad"] forState:UIControlStateSelected];
    [self.downLoadButton addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    self.startDownLoad.backgroundColor = kThemeColor;
    [self.startDownLoad setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.pause.backgroundColor = kThemeColor;
    [self.pause setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.resume.backgroundColor = kThemeColor;
    [self.resume setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.stop.backgroundColor = kThemeColor;
    [self.stop setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.progressView.progress = 0;
    self.statusLabel.text = kPlacedString;
    self.sizeLabel.text = kPlacedString;
    self.titleLabel.text = kPlacedString;
}

- (void)setItem:(BPDownLoadItem *)item {
    _item = item;
    
    if (![item.downLoadUrl isEqualToString:self.model.mediaUrl]) {
        return;
    }
    NSString *statusStr = @"下载";
    self.downLoadButton.selected = NO;
    switch (item.status) {
            
        case BPDownLoadItemNone:
            break;
            
        case BPDownLoadItemWait:
            self.downLoadButton.selected = YES;
            statusStr = @"等待下载";
            break;
        case BPDownLoadItemDowning:
            self.downLoadButton.selected = YES;
            statusStr = @"正在下载";
            break;
        case BPDownLoadItemPause:
            statusStr = @"暂停下载";
            break;
        case BPDownLoadItemSuccess:
            self.downLoadButton.selected = YES;
            statusStr = @"下载成功";
            break;
        case BPDownLoadItemFail:
            statusStr = @"下载失败";
            break;
    }
    
    self.statusLabel.text = statusStr;
    self.progressView.progress = [item.progress floatValue];
    self.sizeLabel.text = [NSString stringWithFormat:@"%@/%@",item.completedUnitCount,item.totalUnitCount];
}

- (IBAction)dowLoad:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(downLoad:item:)]) {
        [_delegate downLoad:self item:self.model];
    }
}

- (IBAction)pause:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(pause:item:)]) {
        [_delegate pause:self item:self.model];
    }
}

- (IBAction)resume:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(resume:item:)]) {
        [_delegate resume:self item:self.model];
    }
}

- (IBAction)stop:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(stop:item:)]) {
        [_delegate stop:self item:self.model];
    }
}

- (void)downloadAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(downLoad:item:)]) {
        [_delegate downLoad:self item:self.model];
    }
}

- (void)setModel:(BPAudioModel *)model {
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"cactus_ rect_steady"]];
    self.titleLabel.text = model.title;
}

@end
