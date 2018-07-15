//
//  BPDownLoadMoreFilesTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDownLoadMoreFilesTableViewCell.h"
#import "BPDownLoadMacro.h"
#import "BPDownLoadGeneralView.h"

#import "BPDownloader.h"
#import "BPDownLoad.h"

@interface BPDownLoadMoreFilesTableViewCell ()<BPDownLoadGeneralViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *downLoadBackView;
@property (weak, nonatomic) BPDownLoadGeneralView *downLoadView;
@property (strong, nonatomic) BPAudioModel *model;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation BPDownLoadMoreFilesTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    BPDownLoadGeneralView *downLoadView = [[[NSBundle mainBundle] loadNibNamed:@"BPDownLoadGeneralView" owner:self options:nil] lastObject];
    _downLoadView = downLoadView;
    _downLoadView.delegate = self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusNotification:) name:kDownloadStatusNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeProgressNotification:) name:kDownloadDownLoadProgressNotification object:nil];
    [self.downLoadBackView addSubview:self.downLoadView];
    [self.downLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.downLoadBackView);
    }];
}

- (void)downLoad:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model {
    
    BPDownLoadItem *item = [[BPDownLoadItem alloc] init];
    item.identify = model.identify;
    item.downLoadUrl = model.mediaUrl;
    item.title = model.title;
    item.filepath = @"";
    [[BPDownloader shareDownloader] downloadItem:item];
    
//    if (_delegate && [_delegate respondsToSelector:@selector(downLoad:item:indexPath:)]) {
//        [_delegate downLoad:self item:model indexPath:self.indexPath];
//    }
}

- (void)pause:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model {
    [[BPDownloader shareDownloader] pauseDownloadForItem:model.mediaUrl];

}

- (void)resume:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model {
    [[BPDownloader shareDownloader] resumeDownloadForItem:model.mediaUrl];
}

- (void)stop:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model {
//    [[BPDownloader shareDownloader] st:item];

}

- (void)setModel:(BPAudioModel *)model indexPath:(NSIndexPath *)indexPath {
    /*
     下载进度
     当前的下载数量
     完全的下载数量
     下载状态
     下载速度
     */
    _model = model;
    _indexPath = indexPath;
    [self.downLoadView setModel:model];
    

    [self.downLoadView setItem:nil];
}

- (void)changeStatusNotification:(NSNotification *)notification {
    BPDownLoadItem *item = [notification valueForKey:@"object"];
    if (![item.downLoadUrl isEqualToString:self.model.mediaUrl]) {
        return;
    }
    [self.downLoadView setItem:item];
}

- (void)changeProgressNotification:(NSNotification *)notification {
    BPDownLoadItem *item = [notification valueForKey:@"object"];
    if (![item.downLoadUrl isEqualToString:self.model.mediaUrl]) {
        return;
    }
    [self.downLoadView setItem:item];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
