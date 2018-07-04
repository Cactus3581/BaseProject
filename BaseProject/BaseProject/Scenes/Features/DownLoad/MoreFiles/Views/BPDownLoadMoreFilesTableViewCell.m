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
    _downLoadView.delegate = self;
    _downLoadView = downLoadView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.downLoadBackView addSubview:self.downLoadView];
    [self.downLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.downLoadBackView);
    }];
}

- (void)downLoad:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)item {
    if (_delegate && [_delegate respondsToSelector:@selector(downLoad:item:indexPath:)]) {
        [_delegate downLoad:self item:self.model indexPath:self.indexPath];
    }
}

- (void)setItem:(BPAudioModel *)item indexPath:(NSIndexPath *)indexPath {
    _model = item;
    _indexPath = indexPath;
    [self.downLoadView setItem:item status:BPDownLoadItemNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
