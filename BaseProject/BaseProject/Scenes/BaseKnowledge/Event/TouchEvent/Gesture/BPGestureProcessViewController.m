//
//  BPGestureProcessViewController.m
//  BaseProject
//
//  Created by Ryan on 2021/5/31.
//  Copyright © 2021 cactus. All rights reserved.
//

#import "BPGestureProcessViewController.h"
//https://cloud.tencent.com/developer/article/1129288
//https://www.jianshu.com/p/4f83db7e3e31

@interface BPGestureProcessViewController ()<UIGestureRecognizerDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UITapGestureRecognizer *tap;
@property (nonatomic, weak) UIView *view1;
@property (nonatomic, weak) UITapGestureRecognizer *tap1;
@property (nonatomic, strong) UICollectionView *collectionView;

@end


@implementation BPGestureProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showGesSlidePopupView];
}

- (void)showGesSlidePopupView {

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.tap = tap;
    tap.delegate = self;
    [self.view addGestureRecognizer: tap];

    UIView *view1 = [UIView new];
    self.view1 = view1;
    view1.backgroundColor = kRedColor;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.tap1 = tap1;
    tap1.delegate = self;
    [view1 addGestureRecognizer: tap1];

    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(50);
        make.leading.equalTo(self.view);
    }];

    UIView *contentView = self.collectionView;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.top.equalTo(view1.mas_bottom).offset(50);
    }];
}

#pragma mark - UIGestureRecognizerDelegate，按执行顺序排序

/*
 在touchesBegan:withEvent:方法之前调用，如果返回NO，则gesture recognizer不会看到此触摸事件。(默认情况下为YES)
 会先于ShouldBegin之前被调用
 控制当前view接不接受touch，如果返回true，则下一步ShouldBegin方法会被调用，如果返回false，ShouldBegin()不会被调用
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.tap) {
        NSLog(@"shouldReceiveTouch: tap");
    } else if (gestureRecognizer == self.tap1) {
        NSLog(@"shouldReceiveTouch: tap1");
    }
    return YES;
}

// 控制Gesture是否接受press，
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press {
//    return true;
//}

/*
 开始进行手势识别时调用的方法，返回NO则结束识别，不再触发手势
 是否允许手势识别器进行识别，这个方法控制gestureRecognizer状态中的.possible 是变成.began还是.failed
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.tap) {
        NSLog(@"ShouldBegin: tap");
    } else if (gestureRecognizer == self.tap1) {
        NSLog(@"ShouldBegin: tap1");
    }
    return YES;
}

/*

用于同时识别多个gesture，是否与其他手势共存；
defalult返回值为false，也就是说同时只有1个手势被激活，只能执行这个手势对应的事件

 比如viewController的view上有一个scrollView的这种情况，按理来说，会识别最上面那一层的view，所以scrollView里内置的gesture会被识别，而被加到viewController，view的自定义gesture不会被识别。在这种情况下,如果利用shouldRecognizeSimultaneouslyWith这个回调方法, 如果设置同时识别两种gesture, 加载viewController.view上的自定义的gesture也会被识别.
 使用方法很简单, 想同时识别的两种gesture, 则返回true, 反之返回false.


 是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
 是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    if (gestureRecognizer == self.tap) {
        NSLog(@"Simultaneously-gestureRecognizer: tap");
    } else if (gestureRecognizer == self.tap1) {
        NSLog(@"Simultaneously-gestureRecognizer: tap1");
    }

    if (otherGestureRecognizer == self.tap) {
        NSLog(@"Simultaneously-otherGestureRecognizer: tap");
    } else if (otherGestureRecognizer == self.tap1) {
        NSLog(@"Simultaneously-otherGestureRecognizer: tap1");
    }
    return true;
}

///  下面这个两个方法也是用来控制手势的互斥执行的，控制自身的Gesture和其他Gesture的失败
// 这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return true;
//}

// 这个方法返回YES，第一个和第二个互斥时，第二个会失效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return true;
//}

- (void)tap:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture == self.tap) {
        NSLog(@"用户侧接收到事件: tap");
    } else if (tapGesture == self.tap1) {
        NSLog(@"用户侧接收到事件: tap1");
    }

    // 获取手势触摸的View视图
    UIView *view = tapGesture.view;
    // 手势识别是否可用
    BOOL isEnabled = tapGesture.enabled;

    /*
     是否取消touchBegn的回调，默认为YES
     cancelsTouchesInView = true，让touchBegn失效
     cancelsTouchesInView = false，让touchBegn依然可以回调
     */
    BOOL cancelsTouchesInView = tapGesture.cancelsTouchesInView;


    /*
     指定一个手势需要另一个手势执行失败才会执行，同时触发多个手势使用其中一个手势的解决办法，该方法可以指定某一个 手势，即便自己已经满足条件了，也不会立刻触发，会等到该指定的手势确定失败之后才触发
     */
    // 关键在这一行，如果双击确定检测失败才會触发单击
//    [singleRecognizer requireGestureRecognizerToFail:doubleRecognizer];

    // 获取当前触摸在指定视图上的点
    [self.tap locationInView:self.view1];

    // 获取触摸手指数
    [self.tap numberOfTouches];

    switch (tapGesture.state) {
        case UIGestureRecognizerStatePossible:
            // 尚未识别是何种手势操作（但可能已经触发了触摸事件），默认状态
            break;
        case UIGestureRecognizerStateBegan:
            // 手势已经开始，此时已经被识别，但是这个过程中可能发生变化，手势操作尚未完成
            break;
        case UIGestureRecognizerStateChanged:
            // 手势状态发生改变
            break;
        case UIGestureRecognizerStateEnded:
            // 手势识别操作完成（此时已经松开手指）
            break;
        case UIGestureRecognizerStateCancelled:
            // 手势被取消，恢复到默认状态
            break;
        case UIGestureRecognizerStateFailed:
            // 手势识别失败，恢复到默认状态
            break;
    }
}

#pragma mark - 布局collectionview
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.minimumInteritemSpacing = 30;
        flowLayout.minimumLineSpacing = 20;
        flowLayout.itemSize = CGSizeMake(50, 50);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.backgroundColor = kRedColor;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = kGreenColor;
    return cell;
}

@end

