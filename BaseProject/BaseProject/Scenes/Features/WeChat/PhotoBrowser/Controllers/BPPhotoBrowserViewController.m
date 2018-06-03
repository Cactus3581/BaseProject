//
//  BPPhotoBrowserViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPhotoBrowserViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>

@interface BPPhotoBrowserViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIButton *chooseImageBtn;
@property (nonatomic,strong) UIImageView *chooseImageView;
@property (nonatomic,strong) ALAssetsLibrary *assetLibrary;
@end

@implementation BPPhotoBrowserViewController

/*
 1. 获取媒体:从相机、相册、图库.
 2. 定制相机界面.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 从相机中获取
- (void)getMediaFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 实例化UIImagePickerController控制器
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        // 设置资源来源
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
        imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
        // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
        imagePickerVC.delegate = self;
        // 是否允许编辑
        imagePickerVC.allowsEditing = YES;
        // 如果选择的是视屏，允许的视屏时长为20秒
        //imagePickerVC.videoMaximumDuration = 20;
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        //imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        // 相机获取媒体的类型（照相、录制视屏）
        imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 使用前置还是后置摄像头
        imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 是否看起闪光灯
        imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        imagePickerVC.showsCameraControls = NO;
        // model出控制器
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
}

- (void)configImagePickerController:(UIImagePickerController *)imagePickerController {
//    //设置导航栏背景颜色
//    imagePickerController.navigationBar.barTintColor = [UIColor colorWithRed:20.f/255.0 green:24.0/255.0 blue:38.0/255.0 alpha:1];
//    //设置右侧取消按钮的字体颜色
//    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bp_naviItem_backImage"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    
    imagePickerController.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"11" forState:(UIControlStateNormal)];
    [cancelBtn setTintColor:kWhiteColor];
    cancelBtn.titleLabel.font  = BPFont(16);
    [cancelBtn setTitleColor:kRedColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(leftBarButtonItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
}

#pragma mark - 从相册获取媒体
- (void)getMediaFromPhotoLibrary {
    // 判断当前的sourceType是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        // 实例化UIImagePickerController控制器
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        // 设置资源来源（相册、相机、图库之一）
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
        // 如果选择的是视频，允许的视频时长为20秒
        imagePickerVC.videoMaximumDuration = 20;
        // 允许的视频质量（如果质量选取的质量过高，会自动降低质量）
        imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
        // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
        imagePickerVC.delegate = self;
        // 是否允许编辑（YES：图片选择完成进入编辑模式）
        imagePickerVC.allowsEditing = YES;
        [self configImagePickerController:imagePickerVC];
        // model出控制器
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
}

- (void)initUI {
    _chooseImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_chooseImageBtn setTitle:@"选择照片" forState:UIControlStateNormal];
    [_chooseImageBtn sizeToFit];
    _chooseImageBtn.backgroundColor = kGreenColor;
    [_chooseImageBtn addTarget:self action:@selector(getMediaFromPhotoLibrary) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_chooseImageBtn];
    
    _chooseImageView = [[UIImageView alloc]init];
    _chooseImageView.contentMode = UIViewContentModeScaleAspectFit;
    _chooseImageView.backgroundColor = kGreenColor;
    [self.view addSubview:_chooseImageView];
    
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
}

// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];

    /*
     选择的图片信息存储于info字典中,info中可能包含的key的含义
     UIImagePickerControllerCropRect // 编辑裁剪区域
     UIImagePickerControllerEditedImage // 编辑后的UIImage
     UIImagePickerControllerMediaType // 返回媒体的媒体类型
     UIImagePickerControllerOriginalImage // 原始的UIImage
     UIImagePickerControllerReferenceURL // 图片地址
     
     从图库获取与从相册获取一样，只不过 sourceType 换成 UIImagePickerControllerSourceTypeSavedPhotosAlbum
     
     */
    
    BPLog(@"%@", info);
    [self handleMediaWithInfo:info];
}

// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleMediaWithInfo:(NSDictionary<NSString *,id> *)info {
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
    } failureBlock:^(NSError *error) {
        BPLog(@"出错了");
    }];
}

#pragma mark - lazyinit
- (ALAssetsLibrary*)assetLibrary{
    if (!_assetLibrary){
        _assetLibrary = [[ALAssetsLibrary alloc]init];
    }
    return _assetLibrary;
}

- (void)saveCurrentImageClick{
    __weak typeof(self) weakSelf = self;
    UIImage *image = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        req = nil;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                BPLog(@"保存成功!");
            }else{
                if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
                     BPLog(@"保存成功!");
                }else{
                    // 处理第三种情况,监听用户第一次授权情况
                    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
                        //请求允许访问允许访问的机会
                        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                            if (status == PHAuthorizationStatusAuthorized) {
                                BPLog(@"用户同意授权相册");
                                // 递归处理一次 , 因为系统框只弹出这一次
                                [weakSelf saveCurrentImageClick];
                                return ;
                            }else {
                                BPLog(@"用户拒绝授权相册");
                            }
                        }];
                    } else{
                         BPLog(@"暂无权限访问您的相册!");
                    }
                }
            }
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
