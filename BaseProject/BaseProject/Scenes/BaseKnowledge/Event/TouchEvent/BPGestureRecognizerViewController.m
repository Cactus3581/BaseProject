//
//  BPGestureRecognizerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPGestureRecognizerViewController.h"

@interface BPGestureRecognizerViewController ()
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)NSMutableArray *images; //图片名字数组
@property(nonatomic,assign)NSInteger index;//下标
@end

@implementation BPGestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.images = [NSMutableArray array];
    
    for (int i = 0; i<8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"h%d.jpeg",i];
        [_images addObject:imageName];
    }
    //    将下标置为0
    _index = 0;
    
    //    布局imageView；
    [self layoutImageView];
    
    //    创建手势
    [self creatrecognizers];
    
}

//布局imageView
-(void)layoutImageView
{
    //    1.创建对象
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //    2.配置属性
    imageView.backgroundColor = [UIColor purpleColor];
    //    2.1设置图片
    //    创建UIImage对象
    imageView.image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"h0"ofType:@"jpeg"]];
    
    //    3.添加父视图
    [self.view addSubview:imageView];
    

    
    //将创建的图片赋值
    //    self.imageView = imageView;
    
    //   打开照片的用户交互
    self.imageView.userInteractionEnabled = YES;
    
}
//创建手势
-(void)creatrecognizers
{
    //    七大手势
    //    1.轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //    配置属性
    //    轻拍次数
    tap.numberOfTapsRequired = 1;
    //    轻拍 手指的个数
    tap.numberOfTouchesRequired = 1;
    //    将手势添加到指定视图上
    [_imageView addGestureRecognizer:tap];
    
    
    //    移除手势！！！！！！！！！！
    [_imageView removeGestureRecognizer:tap];
    
    //    2.清扫手势
    
    //    创建手势对象
    UISwipeGestureRecognizer *swipe= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    //    配置属性:一个清扫手势 只能有两个方向（上和下）或者（左和右）
    //    如果想支持上下左右清扫，那么一个手势不能实现 需要创建两个清扫手势
    
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    //
    //    BPLog(@"left = %ld",UISwipeGestureRecognizerDirectionLeft);
    //    BPLog(@"right = %ld",UISwipeGestureRecognizerDirectionRight);
    
    
    //    添加到指定视图
    [_imageView addGestureRecognizer:swipe];

    
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    
    //    设置清扫方向
    swipe2.direction = UISwipeGestureRecognizerDirectionRight;
    
    //    添加到指定视图
    [_imageView addGestureRecognizer:swipe2];

    
    //    移除手势
    //    [_imageView removeGestureRecognizer:swipe];
    //    [_imageView removeGestureRecognizer:swipe2];
    
    //    3.长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    
    //    配置属性
    //最短长按时间
    longPress.minimumPressDuration = 0.5;
    //允许移动的最大距离
    longPress.allowableMovement = 10;
    
    
    //    添加到指定视图
    [_imageView addGestureRecognizer:longPress];

    
    //    移除手势
    [_imageView removeGestureRecognizer:longPress];
    
    //    4.平移手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    
    //    添加到指定地图
    [_imageView addGestureRecognizer:pan];
    
    [_imageView removeGestureRecognizer:pan];
    
    //    5.捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    
    //    添加到指定视图
    [_imageView addGestureRecognizer:pinch];
    

    
    [_imageView removeGestureRecognizer:pinch];
    
    //    6.旋转手势
    UIRotationGestureRecognizer *rota = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotaAction:)];
    
    //添加到指定视图
    [_imageView addGestureRecognizer:rota];
    
    [_imageView removeGestureRecognizer:rota];
    
    //    屏幕边缘手势
    UIScreenEdgePanGestureRecognizer *screen = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenAction:)];
    //    属性：设置边缘手势 的位置
    screen.edges = UIRectCornerTopLeft;
    
    [_imageView addGestureRecognizer:screen];
    
    
}

#pragma mark - 手势触发事件
//轻拍事件
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    BPLog(@"轻拍");
    //    图片的切换
    _index++;
    if (_index == 8) {
        _index =0;
    }
    self.imageView.image = [UIImage imageNamed:_images[_index]];
}

//轻扫事件
-(void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    ////    判断当前是左清扫 还是右清扫
    //    if ((swipe.direction^UISwipeGestureRecognizerDirectionRight) == UISwipeGestureRecognizerDirectionLeft) {
    //        BPLog(@"左轻扫");
    //    } else if ((swipe.direction^UISwipeGestureRecognizerDirectionLeft) == UISwipeGestureRecognizerDirectionRight)
    //    {
    //        BPLog(@"右轻扫");
    //    }
    //    BPLog(@"%ld",swipe.direction);
    //    通过清扫方向，进行判定
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        BPLog(@"右清扫上一张");
        _index--;
        if (_index<0) {
            _index = 7 ;
        }
        _imageView.image = [UIImage imageNamed:_images[_index]];
    }else if(swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        BPLog(@"左清扫下一张");
        _index++;
        if (_index ==8) {
            _index = 0 ;
        }
        _imageView.image = [UIImage imageNamed:_images[_index]];
    }
}

// 长按事件
-(void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    //    BPLog(@"长按");
    //    对于长按手势有开始和结束状态
    if (longPress.state == UIGestureRecognizerStateBegan) {
        BPLog(@"长按开始");
    }
    //    将图片保存到相册
    //    UIImageWriteToSavedPhotosAlbum(<#UIImage *image#>, <#id completionTarget#>, <#SEL completionSelector#>, <#void *contextInfo#>)
}

//平移事件
-(void)panAction:(UIPanGestureRecognizer *)pan
{
    //    获取手势的位置
    CGPoint position = [pan translationInView:_imageView];
    //    通过transform 进行平移变换：它会自动帮我们实现的。
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, position.x, position.y);
    //    将手势增量置为0；
    [pan setTranslation:CGPointZero inView:_imageView];
}

//捏合
-(void)pinchAction:(UIPinchGestureRecognizer *)pinch
{
    //    BPLog(@"w");
    //    通过transform进行视图的捏合
    _imageView.transform = CGAffineTransformScale(_imageView.transform,pinch.scale ,pinch.scale );
    //    设置比例
    pinch.scale = 1;
}

//添加旋转事件
-(void)rotaAction:(UIRotationGestureRecognizer *)rota
{
    //    通过transform进行旋转变化
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, rota.rotation);
    //    将旋转角度 置为零
    rota.rotation = 0 ;
}

-(void)screenAction:(UIScreenEdgePanGestureRecognizer *)screen
{
    BPLog(@"d");
}

//屏幕边缘
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

