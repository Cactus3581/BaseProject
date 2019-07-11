//
//  BPDownLoadViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/5/18.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDownLoadViewController.h"
#import "BPDownloadManager.h"
#import "BPDownLoadItem.h"
#import "NSString+BPAdd.h"

@interface BPDownLoadViewController ()<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startDownLoadButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end


// 下载->downloadTase+cancel->断点下载->离线下载->队列下载->tableView结合。最后换成dateTask下载
@implementation BPDownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initlalizeViews];
    [self registerDownloadNotification];
}

- (IBAction)startAction:(UIButton *)sender {
    
    BPDownLoadItem *item = [[BPDownLoadItem alloc] init];
    item.downLoadUrl = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg";
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    item.filepath = [documentsPath stringByAppendingPathComponent:@"Download"];

    
    BPDownLoadItem *downloadItem = [[BPDownloadManager shareManager] getInitializeValues:item];
    if (downloadItem) {
        switch (downloadItem.status) {
                
            case BPDownLoadItemNone: {
                [[BPDownloadManager shareManager] downloadWithItem:downloadItem];
            }
                break;
                
            case BPDownLoadItemWait: {

            }
                break;
                
            case BPDownLoadItemDowning: {
                [[BPDownloadManager shareManager] cancelWithItem:downloadItem cancelBlk:^(NSData * _Nonnull resumeData) {
                    
                }];
            }
                break;
                
            case BPDownLoadItemPause: {
                [[BPDownloadManager shareManager] downloadWithItem:downloadItem];
            }
                break;
                
            case BPDownLoadItemFinish: {

            }
                break;
                
            case BPDownLoadItemFail: {
                [[BPDownloadManager shareManager] downloadWithItem:downloadItem];
            }
                break;
                
            case BPDownLoadItemCancel: {

            }
                break;
        }
    } else {
        [[BPDownloadManager shareManager] downloadWithItem:item];
    }
}

- (IBAction)caccelAction:(UIButton *)sender {
    
    BPDownLoadItem *item = [[BPDownLoadItem alloc] init];
    item.downLoadUrl = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg";
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    item.filepath = [documentsPath stringByAppendingPathComponent:@"Download"];
    
    [[BPDownloadManager shareManager] deleteFileWithItem:item];
}

#pragma mark - 下载通知
- (void)registerDownloadNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgress:) name:BPDownloadManagerProgressNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadFinish:) name:BPDownloadManagerFinishNotification object:nil];
}

- (void)updateProgress:(NSNotification *)notification {
    BPDownLoadItem *item = notification.object;
    _progressView.progress = item.progress;
    _progressLabel.text = [NSString stringWithFormat:@"当前下载进度:%.2f%%",100.0 * item.progress];
}

- (void)downLoadFinish:(NSNotification *)notification {
    BPDownLoadItem *item = notification.object;
    _progressLabel.text = @"下载完成";
}

- (void)getDownloadInfo {
    
    BPDownLoadItem *item = [[BPDownLoadItem alloc] init];
    item.downLoadUrl = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg";
    
    BPDownLoadItem *downLoadtem = [[BPDownloadManager shareManager] getInitializeValues:item];
    
    if (downLoadtem) {
        switch (downLoadtem.status) {
                
            case BPDownLoadItemNone: {
                _progressView.progress = 0;
                _progressLabel.text = @"当前下载进度:0%";
                _startDownLoadButton.selected = NO;
            }
                break;
                
            case BPDownLoadItemWait: {
                _progressView.progress = 0;
                _progressLabel.text = @"当前下载进度:0%";
                _startDownLoadButton.selected = YES;
            }
                break;
                
            case BPDownLoadItemDowning: {
                _progressView.progress = downLoadtem.progress;
                _progressLabel.text = [NSString stringWithFormat:@"当前下载进度:%.2f%%",100.0 * downLoadtem.progress];
                _startDownLoadButton.selected = YES;
            }
                break;
                
            case BPDownLoadItemPause: {
                _progressView.progress = downLoadtem.progress;
                _progressLabel.text = [NSString stringWithFormat:@"当前下载进度:%.2f%%",100.0 * downLoadtem.progress];
                _startDownLoadButton.selected = YES;
            }
                break;
                
            case BPDownLoadItemFinish: {
                _progressView.progress = 1;
                _progressLabel.text = @"100%";
                _startDownLoadButton.selected = NO;
            }
                break;
                
            case BPDownLoadItemFail: {
                _progressView.progress = 0;
                _progressLabel.text = @"0%";
                _startDownLoadButton.selected = NO;
            }
                break;
                
            case BPDownLoadItemCancel: {
                _progressView.progress = 0;
                _progressLabel.text = @"0%";
                _startDownLoadButton.selected = NO;
            }
                break;
        }
        
    } else {
        _progressView.progress = 0;
        _progressLabel.text = @"0%";
        [_startDownLoadButton setTitle:@"开始" forState:UIControlStateNormal];
        [_startDownLoadButton setTitle:@"暂停" forState:UIControlStateSelected];
    }
}

- (void)initlalizeViews {
    [self getDownloadInfo];
}

@end
