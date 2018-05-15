//
//  BPTagViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagViewController.h"
#import "Masonry.h"

#import "BPTagCollectionView.h"
#import "BPTagCell.h"
#import "BPTagModel.h"

@interface BPTagViewController () <UICollectionViewDataSource,UIGestureRecognizerDelegate, LPSwitchTagDelegate,LPSwitchTagDelegate>

@end

@implementation BPTagViewController {
    BPTagCollectionView *_tagCollectionView;
    NSArray *_tagArray;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"选择标签";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)loadView {
    [super loadView];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i ++) {
        BPTagModel *model = [[BPTagModel alloc] init];
        model.name = [NSString stringWithFormat:@"Tag %li", i];
        model.isChoose = NO;
        [array addObject:model];
    }
    _tagArray = array.copy;
    
    
    
    _tagCollectionView = [[BPTagCollectionView alloc] init];
    _tagCollectionView.tagArray = _tagArray;
    _tagCollectionView.tagDelegate = self;
    [self.view addSubview:_tagCollectionView];

    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}
- (void)updateViewConstraints {
    [super updateViewConstraints];
    _tagCollectionView.backgroundColor = [UIColor redColor];
    [_tagCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(_tagCollectionView.contentSize.height);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tagArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BPTagCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.type = BPTagCellTypeSelected1;
    cell.model = _tagArray[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegateLeftAlignedLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _tagArray.count) {
        CGSize size = [((BPTagModel *)_tagArray[indexPath.row]).name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        return CGSizeMake(size.width + 16, 30);
    }
    return CGSizeMake(100, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(6, 12, 6, 12);
}

//旋转事件，需要重新计算cell高度
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [_tagCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(_tagCollectionView.contentSize.height);
        }];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
