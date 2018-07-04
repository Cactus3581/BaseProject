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

@property (strong, nonatomic) BPAudioModel *model;
@property (assign, nonatomic) BPDownLoadItemStatus status;
@end

@implementation BPDownLoadGeneralView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.downLoadButton setImage:[UIImage imageNamed:@"module_startdownload"] forState:UIControlStateNormal];
    [self.downLoadButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [self.downLoadButton addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
}

- (void)download {
    if (_delegate && [_delegate respondsToSelector:@selector(downLoad:item:)]) {
        [_delegate downLoad:self item:self.model];
    }
}

- (void)setItem:(BPAudioModel *)item status:(BPDownLoadItemStatus)status {
    if (_model != item) {
        _model = item;
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:item.smallpic] placeholderImage:nil];
        self.titleLabel.text = item.title;
        _status = status;
        NSString *statusStr = @"下载";
        
        switch (status) {
                
            case BPDownLoadItemNone:
                break;
                
            case BPDownLoadItemPrepary:
                statusStr = @"正在等待";
                break;
            case BPDownLoadItemDowning:
                statusStr = @"正在下载";
                break;
            case BPDownLoadItemPause:
                statusStr = @"暂停下载";
                break;
            case BPDownLoadItemSuccess:
                statusStr = @"下载成功";
                break;
            case BPDownLoadItemFail:
                statusStr = @"下载失败";
                break;
        }
        
        self.statusLabel.text = statusStr;
    }    
}

@end
