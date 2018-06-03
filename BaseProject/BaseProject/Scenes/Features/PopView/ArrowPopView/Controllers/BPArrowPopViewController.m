//
//  BPArrowPopViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPArrowPopViewController.h"
#import "BPArrowPopView.h"
#import "Masonry.h"
#import "BPPopCollectionViewCell.h"

@interface BPArrowPopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,BPPopCollectionViewCellDelegate,UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) BPArrowPopView *arrowPopView;
@end

@implementation BPArrowPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self configCollectionView];
    [self configureButton];
}

#pragma mark - 系统方法
- (void)system:(UIView *)sender {
    UIPopoverController;//废弃
    //UIPopoverPresentationController
    BPArrowPopViewController * testVC = [BPArrowPopViewController new];
    // 设置大小
    testVC.preferredContentSize = CGSizeMake(300, 400);
    // 设置 Sytle
    testVC.modalPresentationStyle = UIModalPresentationPopover;
    testVC.view.backgroundColor = [UIColor redColor];
    testVC.popoverPresentationController.backgroundColor = [UIColor redColor];


    // 需要通过 sourceView 来判断位置的
    testVC.popoverPresentationController.sourceView = sender;//确定位置，确定参照视图
    // 指定箭头所指区域的矩形框范围（位置和尺寸）,以sourceView的左上角为坐标原点
    // 这个可以 通过 Point 或  Size 调试位置
    testVC.popoverPresentationController.sourceRect = sender.bounds;//弹框大小
    // 箭头方向
    testVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    // 设置代理
    testVC.popoverPresentationController.delegate = self;
    [self presentViewController:testVC animated:YES completion:nil];
}

#pragma mark --  实现代理方法
//默认返回的是覆盖整个屏幕，需设置成UIModalPresentationNone。
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

//点击蒙版是否消失，默认为yes；
-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

//弹框消失时调用的方法
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    BPLog(@"弹框已经消失");
}

#pragma mark -cell - delegate
- (void)nextAction:(NSIndexPath *)indexpath {
//    [self showPopView:nil];
//    BPPopCollectionViewCell *cell = (BPPopCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
}

#pragma mark - 自定义popView
- (void)showPopView:(UIView *)view {
    [self.arrowPopView setBackgroundColor:kOrangeColor];
    [self.view addSubview:self.arrowPopView ];
    [self.arrowPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.leading.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
    }];
}

- (BPArrowPopView *)arrowPopView {
    if (!_arrowPopView) {
        _arrowPopView = [[BPArrowPopView alloc]init];
        
        [_arrowPopView setBackgroundColor:kOrangeColor];
    }
    return _arrowPopView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.arrowPopView removeFromSuperview];
}

- (void)configureButton {
    self.view.backgroundColor = kGreenColor;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kRedColor;
    
    // 只有在title时设置对其方式。无用：rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //但是问题又出来，此时文字会紧贴到做边框，我们可以设置    使文字距离做边框保持10个像素的距离。
    //rightButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    
    
    /*
     setBackgroundImage:跟button一样大
     setImage:也会被拉伸
     */
    //    [rightButton setBackgroundImage:[UIImage imageNamed:@"headImage"] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"headImage"] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"headimage1"] forState:UIControlStateSelected];
    //    [rightButton setImage:[UIImage imageNamed:@"headimage2"] forState:UIControlStateHighlighted];
    
    //rightButton.imageView.layer.masksToBounds = YES;//无用
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [rightButton setTitle:@"push" forState:UIControlStateNormal];
    
    /*
     设置UIButton上字体的颜色设置UIButton上字体的颜色，不是用：
     [btn.titleLabel setTextColor:[UIColorblackColor]];
     btn.titleLabel.textColor=kRedColor;
     而是用：
     */
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    
    [rightButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    //[rightButton.titleLabel sizeToFit];//无用
    
    [rightButton addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
    //    rightButton.backgroundColor = kGreenColor;
    [self.view addSubview:rightButton];
    [[rightButton layer] setCornerRadius:25.0f];
    
    rightButton.showsTouchWhenHighlighted = YES;

    
    if (@available(iOS 11,*)) {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.trailing.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(-30);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20);
        }];
    }else {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.trailing.equalTo(self.view).offset(-30);
            make.bottom.equalTo(self.view).offset(-20);
        }];
    }
}

- (void)buttonAct:(UIButton *)bt {
//    [self showPopView:bt];
    [self system:bt];
}

- (void)configCollectionView {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        if (kiOS9) {
            flowLayout.sectionHeadersPinToVisibleBounds = YES;//悬停
            flowLayout.sectionFootersPinToVisibleBounds = YES;
        }
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.backgroundColor = kLightGrayColor;
        [_collectionView registerClass:[BPPopCollectionViewCell class] forCellWithReuseIdentifier:@"BPPopCollectionViewCell"];
    }
    return _collectionView;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 30;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPPopCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPPopCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.path = indexPath;
    return cell;
}

//设定Cell尺寸，定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, 50);
}

//设定Cell间距，设定指定区内Cell的最小间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView reloadData];
}

//设定行间距，设定指定区内Cell的最小行距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//设定区内边距，设定指定区的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

