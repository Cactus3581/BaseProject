//
//  BPPopViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPopViewController.h"
#import "BPPopCollectionViewCell.h"
#import "BPArrowPopView.h"
#import "BPAnchorPopView.h"
#import "Masonry.h"

@interface BPPopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,BPPopCollectionViewCellDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) BPAnchorPopView *anchorPopView;
@property (nonatomic,strong) BPArrowPopView *arrowPopView;
@property (nonatomic,strong) UIView *taobaoView;
@end

@implementation BPPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self configureImageView];//image 切割
//    [self layoutTaobao];//淘宝购物车动画
//    [self testAnchorPoint];//测试锚点
    [self configArrowPopView];//箭头popView
//    [self configCollectionView];
    
//    [self configureButton];
}

#pragma mark - 锚点动画 - 普通button
- (void)showPopView:(UIButton *)bt {
    [self.view addSubview:self.anchorPopView];
    self.anchorPopView.targetView = bt;
    [_anchorPopView showPopView];
}

- (BPAnchorPopView *)anchorPopView {
    if (!_anchorPopView) {
        _anchorPopView = [BPAnchorPopView arrowPopViewWithHeight:80 targetView:nil superView:self.view];
        _anchorPopView.backgroundColor = kClearColor;
        //_anchorPopView.limitH = 49.0f;
        //_anchorPopView.offset = 20;
    }
    return _anchorPopView;
}

#pragma mark - 锚点动画 - 列表 showPopView
#pragma mark -cell - delegate
- (void)nextAction:(NSIndexPath *)indexpath {
    BPPopCollectionViewCell *cell = (BPPopCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
    [self.view addSubview:self.anchorPopView];
    self.anchorPopView.targetView = cell.button;
    [_anchorPopView showPopView];
}

#pragma mark - 箭头popView
- (void)configArrowPopView {
    [self.arrowPopView setBackgroundColor:kOrangeColor];
    [self.view addSubview:self.arrowPopView ];
    [self.arrowPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
}

- (BPArrowPopView *)arrowPopView {
    if (!_arrowPopView) {
        _arrowPopView = [[BPArrowPopView alloc]init];
        
        [_arrowPopView setBackgroundColor:kOrangeColor];
    }
    return _arrowPopView;
}

#pragma mark - 测试锚点
- (void)testAnchorPoint {
    self.view.backgroundColor = kGreenColor;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kRedColor;
    [rightButton setTitle:@"push" forState:UIControlStateNormal];
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [rightButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.view addSubview:rightButton];
    rightButton.layer.anchorPoint = CGPointMake(1, 0);
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
        make.centerX.mas_equalTo(-180);
        make.centerY.mas_equalTo(0);
        //        make.centerX.mas_equalTo(10);
        //        make.centerY.mas_equalTo(10);
    }];
    
    UIButton *rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton1.backgroundColor = kPurpleColor;
    [rightButton1 setTitle:@"standard" forState:UIControlStateNormal];
    [rightButton1 setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [rightButton1.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.view addSubview:rightButton1];
    [rightButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(20);
    }];
}

#pragma mark image 切割
- (void)configureImageView {
    UIImageView *view = [[UIImageView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(32);
    }];
    UIImage *image;
    image = [[UIImage imageNamed:@"close"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    image = [[UIImage imageNamed:@"user"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    view.image =  image;
    view.backgroundColor = kGreenColor;
    
    UIImageView *view1 = [[UIImageView alloc]init];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(30);
        make.centerX.equalTo(view);
        make.size.equalTo(view);
    }];
    
    UIImage *image1;
    //    image1 = [[UIImage imageNamed:@"user"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    image1 = [UIImage imageNamed:@"close"];
    //    image = [[UIImage imageNamed:@"user"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    view1.image =  image1;
    view1.backgroundColor = kGreenColor;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.anchorPopView removePopView];
}

#pragma mark - button详细及淘宝动画
- (void)layoutTaobao {
    [self.view addSubview:self.taobaoView];
    [self.taobaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@400);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
    }];
}

- (UIView *)taobaoView {
    if (!_taobaoView) {
        _taobaoView = [[UIView alloc]init];
        _taobaoView.backgroundColor = kPurpleColor;
    }
    return _taobaoView;
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
    
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [rightButton addGestureRecognizer:longPress];
    
    
    if (@available(iOS 11,*)) {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(-30);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-200);
        }];
    }else {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.right.equalTo(self.view).offset(-30);
            make.bottom.equalTo(self.view).offset(-200);
        }];
    }
}

- (void)buttonAct:(UIButton *)bt {
    [self showPopView:bt];
}


- (void)btnLong:(UILongPressGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        BPLog(@"长按事件");
        self.navigationController.navigationBarHidden = YES;
        [self.taobaoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset((-(CGRectGetHeight(self.taobaoView.bounds))));
            //make.height.mas_equalTo(400);
            
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
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
