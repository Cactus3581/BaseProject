//
//  KSHeritageDictionaryListCollectionViewCell.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/5/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSHeritageDictionaryListCollectionViewCell.h"
#import "KSHeritageDictionaryMacro.h"
#import "UIImageView+WebCache.h"
#import "UIButton+BPImagePosition.h"

@interface KSHeritageDictionaryListCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desclabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downloadButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downloadButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downLoadButtonBottomConstraint;
@property (nonatomic,strong) KSWordBookAuthorityDictionaryThirdCategoryModel *model;
@end

@implementation KSHeritageDictionaryListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configViews];
    [self initGesture];
}

- (void)initGesture {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesCallback:)];
    [self addGestureRecognizer:tap];
}

- (void)tapGesCallback:(UIGestureRecognizer *)gestureRecognizer {
    [self enterDetailVC];
    if(_delegate && [_delegate respondsToSelector:@selector(heritageDictionaryListTableViewCell:didClickCellWithModel:)]) {
        [_delegate heritageDictionaryListTableViewCell:self didClickCellWithModel:self.model];
    }
}

- (void)enterDetailVC {

}

#pragma mark - 初始化赋值
- (void)setModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;

        self.desclabel.hidden = NO;
        self.downLoadButton.hidden = NO;
        //首页有数据 或者 不是首页的情况
        self.titleLabel.text = model.name;
        [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"wordBookHomeNoRRecommendDictionary"]];
        self.desclabel.text = [NSString stringWithFormat:@"单词数%@  参加人数%@",model.wordCount,model.joinCount];
        //如果数据库没有数据,显示添加
        self.model.dictionaryExecuteType = HeritageDictionaryExecuteUnKnown;
        self.model.downLoadProgress = 0;
        self.model.writeDBProgress = 0;
        [self configDownLoadButtonWithText:@"添加" titleColor:kGreenColor backgroundColor:[kGreenColor colorWithAlphaComponent:0.08]];
}

#pragma mark - 下载事件
- (void)downLoad  {

}

#pragma mark - 根据状态 配置添加按钮颜色
- (void)configDownLoadButtonWithText:(NSString *)text titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.downLoadButton setTitle:text forState:UIControlStateNormal];
        [self.downLoadButton setTitleColor:titleColor forState:UIControlStateNormal];
        [self.downLoadButton setBackgroundColor:backgroundColor];
        
        if (self.model.dictionaryExecuteType != HeritageDictionaryExecuteSuccuss) {
            self.downLoadButton.layer.borderColor = nil;
            self.downLoadButton.layer.borderWidth = 0.f;
            NSString *imageName = self.showOnHomePage ? @"heritageDictionaryAddSmall" : @"heritageDictionaryAdd";
            NSInteger space = self.showOnHomePage ? 4 : 7;
//            [self.downLoadButton ks_setImagePosition:KSImagePositionLeft spacing:space];
            [self.downLoadButton addTarget:self action:@selector(downLoad) forControlEvents:UIControlEventTouchUpInside];
        }else {
            [self.downLoadButton setImage:nil forState:UIControlStateNormal];
            [self.downLoadButton addTarget:self action:@selector(enterDetailVC) forControlEvents:UIControlEventTouchUpInside];
            self.downLoadButton.layer.borderColor = kGreenColor.CGColor;
            self.downLoadButton.layer.borderWidth = kOnePixel;
        }
    });
}

- (void)configViews {
    self.contentView.backgroundColor = kWhiteColor;
    self.coverImageView.layer.cornerRadius = 4;
    [self.coverImageView.layer setMasksToBounds:YES];
    self.downLoadButton.adjustsImageWhenHighlighted = NO;
    [self.downLoadButton.layer setCornerRadius:35/2.0];
    [self.downLoadButton.layer setMasksToBounds:YES];
    self.lineViewHeightConstraint.constant = kOnePixel;
    self.coverImageView.contentMode =UIViewContentModeScaleAspectFill;
    self.coverImageView.clipsToBounds = YES;
    self.desclabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setHiddenLine:(BOOL)hiddenLine {
    self.lineView.hidden = hiddenLine;
}

#pragma mark - KSHeritageDownloadViewControllerDelegate
- (void)downloadFinishedWithSuccess:(BOOL)isSuccess {
    if(isSuccess) {
        [self configDownLoadButtonWithText:@"立即学习" titleColor:kGreenColor backgroundColor:kWhiteColor];
    } else {
        [self configDownLoadButtonWithText:@"添加" titleColor:kGreenColor backgroundColor:[kGreenColor colorWithAlphaComponent:0.08]];
    }
}

//写入数据库结果
- (void)didReceiveWriteDBResultWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model {
    if(_delegate && [_delegate respondsToSelector:@selector(heritageDictionaryListTableViewCell:didReceiveWriteDBResultNotificationWithModel:)]) {
        [_delegate heritageDictionaryListTableViewCell:self didReceiveWriteDBResultNotificationWithModel:model];
    }
}

- (void)configHomePageViews {
    self.contentView.backgroundColor = kClearColor;
    self.backgroundColor = kClearColor;
    self.coverImageView.layer.cornerRadius = 3;
    self.lineView.hidden = YES;
    self.coverImageViewWidthConstraint.constant = 84;
    self.coverImageViewHeightConstraint.constant = 112;
    self.coverImageViewLeftConstraint.constant = 0;
    self.titleLabelTopConstraint.constant = 6;
    self.desclabelTopConstraint.constant = 7;
    self.downloadButtonWidthConstraint.constant = 90;
    self.downloadButtonHeightConstraint.constant = 30;
    self.downLoadButton.layer.cornerRadius = 30.0/2.0;
    self.downLoadButtonBottomConstraint.constant = -10;
    self.downLoadButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    self.desclabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setShowOnHomePage:(BOOL)showOnHomePage {
    _showOnHomePage = showOnHomePage;
    [self configHomePageViews];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

