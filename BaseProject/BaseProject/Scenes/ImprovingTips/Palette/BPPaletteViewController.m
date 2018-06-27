//
//  BPPaletteViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/3.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPaletteViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Palette.h"
#import "UIImage+Palette.h"
#import "UIColor+BPAdd.h"
#import "BPPaletteCell.h"
#import "UIColor+Hex.h"
#import "BPPaletteView.h"

@interface BPPaletteViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIButton *chooseImageBtn;
@property (nonatomic,strong) UIImageView *chooseImageView;
@property (nonatomic,strong) UILabel *showColorLabel;
@property (nonatomic,strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,copy) NSDictionary *allModeColorDic;
@property (nonatomic,strong) BPPaletteView *paletteView;
@end

static CGFloat paletteViewHeight = 100.0f;

@implementation BPPaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initUI];
    [self initializeImageView];
}

- (void)initializeImageView {
    UIImage *image = [UIImage imageNamed:@"Palette.jpeg"];
    _chooseImageView = [[UIImageView alloc]initWithImage:image];
    _chooseImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_chooseImageView];
    [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self imageLoadFinishWithImage:image];
}

- (void)imageLoadFinishWithImage:(UIImage *)image {
    [self.view addSubview:self.paletteView];
    if (kiOS11) {
        [self.paletteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(paletteViewHeight);
            make.leading.equalTo(self.view);
            make.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }else {
        [self.paletteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(paletteViewHeight);
            make.leading.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
    [self.paletteView handleColorWithImage:image];
}

- (BPPaletteView *)paletteView {
    if (!_paletteView) {
        _paletteView = [[BPPaletteView alloc]init];
    }
    return _paletteView;
}

- (void)initUI{
    
    _chooseImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_chooseImageBtn setTitle:@"选择照片" forState:UIControlStateNormal];
    [_chooseImageBtn sizeToFit];
    
    [_chooseImageBtn addTarget:self action:@selector(goToChooseImage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_chooseImageBtn];
    
    _chooseImageView = [[UIImageView alloc]init];
    _chooseImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_chooseImageView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing      = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_collectionView registerClass:[BPPaletteCell class] forCellWithReuseIdentifier:@"BPPaletteCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = kWhiteColor;
    [self.view addSubview:_collectionView];
    
    [_chooseImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.view).offset(80);
        make.centerX.equalTo(self.view);
    }];
    
    [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.top.equalTo(_chooseImageBtn).offset(50);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(_chooseImageView.mas_bottom).offset(50);
    }];
}

- (void)goToChooseImage{
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:^{
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = [info objectForKey:@"UIImagePickerControllerMediaType"];
    if (![type isEqualToString:@"public.image"]){
        BPLog(@"请选择图片格式");
    }
    NSURL *assetUrl = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    if (!assetUrl){
        BPLog(@"出现未知错误");
    }
    
    __weak typeof (self) weakSelf = self;
    [self.assetLibrary assetForURL:assetUrl resultBlock:^(ALAsset *asset) {
        CGImageRef fullRef = asset.defaultRepresentation.fullResolutionImage;
        UIImage *image =  [UIImage imageWithCGImage:fullRef];
        weakSelf.chooseImageView.image = image;
        
        [image getPaletteImageColorWithMode:ALL_MODE_PALETTE withCallBack:^(PaletteColorModel *recommendColor, NSDictionary *allModeColorDic,NSError *error) {
            
            if (!recommendColor) {
                BPLog(@"识别失败");
                return;
            }
            
            weakSelf.allModeColorDic = allModeColorDic;
            [weakSelf.collectionView reloadData];
        }];
        
    } failureBlock:^(NSError *error) {
        BPLog(@"出错了");
    }];
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BPPaletteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPPaletteCell" forIndexPath:indexPath];
    
    if (!cell){
        cell = [[BPPaletteCell alloc]init];
    }
    PaletteColorModel *colorModel;
    NSString *modeKey;
    switch (indexPath.row) {
        case 0:
            colorModel = [self.allModeColorDic objectForKey:@"vibrant"];
            modeKey = @"vibrant";
            break;
        case 1:
            colorModel = [self.allModeColorDic objectForKey:@"muted"];
            modeKey = @"muted";
            break;
        case 2:
            colorModel = [self.allModeColorDic objectForKey:@"light_vibrant"];
            modeKey = @"light_vibrant";
            break;
        case 3:
            colorModel = [self.allModeColorDic objectForKey:@"light_muted"];
            modeKey = @"light_muted";
            break;
        case 4:
            colorModel = [self.allModeColorDic objectForKey:@"dark_vibrant"];
            modeKey = @"dark_vibrant";
            break;
        case 5:
            colorModel = [self.allModeColorDic objectForKey:@"dark_muted"];
            modeKey = @"dark_muted";
            break;
            
        default:
            break;
    }
    [cell configureData:colorModel andKey:modeKey];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth / 2 , _collectionView.bounds.size.height/3);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _allModeColorDic.count;
}

#pragma mark - lazyinit
- (ALAssetsLibrary*)assetLibrary{
    if (!_assetLibrary){
        _assetLibrary = [[ALAssetsLibrary alloc]init];
    }
    return _assetLibrary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

