//
//  BPSliderShowView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/10.
//  Copyright © 2018年 xiaruzhen. All rights reserved.
//

#import "BPSliderShowView.h"
#import "UIView+BPAdd.h"
#import "NSTimer+BPUnRetain.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+YYWebImage.h"
#import "UIImage+YYWebImage.h"

static CGFloat inset = 0;

@interface BPSliderShowView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *centerImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) NSUInteger currentImageIndex;
@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) BOOL suspendTimer;
@end

@implementation BPSliderShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubViews];
        [self initialization];
    }
    return self;
}

#pragma mark - 创建布局及设置默认值
- (void)initializeSubViews {
    //self.clipsToBounds = YES; //阴影问题
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.centerImageView];
    [self.scrollView addSubview:self.rightImageView];
    [self initializeSubViewsFrame];
    [self bringSubviewToFront:self.pageControl];
}

- (void)setViewControllerInSide:(UIViewController *)viewControllerInSide {
    _viewControllerInSide = viewControllerInSide;
    [_viewControllerInSide addObserver:self forKeyPath:@"pauseTimer" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if(object == _viewControllerInSide && [keyPath isEqualToString:@"pauseTimer"]) {
        BOOL pauseTimer = [change[NSKeyValueChangeNewKey] boolValue];
        _suspendTimer = pauseTimer;
    }
}

- (void)initialization {
    _autoScroll = YES;
    _autoScrollTimeInterval = 5.0;
    self.otherPageControlColor = kGrayColor;
    self.curPageControlColor = kWhiteColor;
    _showPageControl = YES;
    _hideWhenSinglePage = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (willEnterForeground) name: UIApplicationWillEnterForegroundNotification object:nil];//注册程序进入前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (didEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];//注册程序进入后台通知
}

- (void)willEnterForeground {
    _suspendTimer = NO;
}

- (void)didEnterBackground {
    _suspendTimer = YES;
}

#pragma mark - view旋转
- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.contentSize = CGSizeMake(self.width * 3, 0); //可以不写，因为下面的子view决定了大小
    [self.scrollView setContentOffset:CGPointMake(self.width, 0.0) animated:NO];
    
    CGFloat imageSizeW = self.width - 2*inset;
    [self.leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageSizeW);
    }];
}

#pragma mark - 数据源
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = BPValidateArray(imageArray);
    self.currentImageIndex = 0;
    if (!_imageArray.count) {
        self.scrollView.scrollEnabled = NO;
        [self removeImage];
        return;
    }
    self.pageControl.numberOfPages = _imageArray.count;//默认显示
    [self setHideWhenSinglePage:_hideWhenSinglePage];//当数据为一条时，是否显示pageControl
    self.scrollView.scrollEnabled = YES;
    [self reloadImageWithIndex:0];
    [self setAutoScroll:_autoScroll];//开始加载计时器
}

- (void)removeImage {
    [self.centerImageView setImage:nil];
    [self.leftImageView setImage:nil];
    [self.rightImageView setImage:nil];
}

#pragma mark - Timer:auto life circles
- (void)createTimer {
    if (_timer) {
        return;
    }
    __weak typeof (self) weakSelf = self;
    NSTimer *timer = [NSTimer bp_scheduledTimerWithTimeInterval:self.autoScrollTimeInterval repeats:YES block:^(NSTimer *timer) {
        [weakSelf automaticScroll];
    }];
    _timer = timer;
}

- (void)invalidateTimer {
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)automaticScroll {
    
    // 当此view不在视野范围内时，计时器工作的时候直接返回
    
    //方法1：
    if (_suspendTimer) {
        return;
    }
    
    /*
     //方法2：这个方法虽然可以避免代码耦合，但是开销稍微有些大
     if ([self ks_currentViewController] != self.viewControllerInSide) {
     BPLog(@"判断此view不在当前控制器");
     return;
     }
     
     if (![self ks_isDisplayedInScreen]) {
     BPLog(@"判断此view不在屏幕上显示 = %@",NSStringFromCGRect(self.frame));
     return;
     }
     */
    
    if (BPValidateArray(self.imageArray).count <= 1) return;
    if(self.scrollView.scrollEnabled == NO) return;
    [self.scrollView setContentOffset:CGPointMake(self.width*2, 0.0) animated:YES];
    [self willDisplayItemAtIndex:self.currentImageIndex+1];
    //    [self reloadDataWithBlock:^{
    //        self.scrollView.contentOffset = CGPointMake(self.width*2, 0);
    //    }];
}

#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        BPLog(@"1(开启自动滚动) - 将开始拖拽，并结束timer");
        [self invalidateTimer];
    }else {
        BPLog(@"1 - 将开始拖拽");
    }
    CGFloat standardOffsetX = self.width;
    if (scrollView.contentOffset.x < standardOffsetX) {
        [self willDisplayItemAtIndex:self.currentImageIndex-1];
    }else if (scrollView.contentOffset.x < standardOffsetX) {
        [self willDisplayItemAtIndex:self.currentImageIndex+1];
    }else {
        BPLog(@"没有偏移");
    }
}

// 关键执行操作时机；与下面的方法互斥：都是在彻底静止的时候回调，但是触发条件不一样，此方法是用户拖拽的最后回调，下面的方法是调用偏移动画完成（彻底静止的时候）的最后回调
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    /*
     0.展示当前center的下一张图片，offset为第三部分
     1. 修改当前索引
     2. 设置偏移量
     3. 赋值图片
     */
    [self updateCunrrentIndex];
    self.pageControl.currentPage = self.currentImageIndex;
    if (self.autoScroll) {
        BPLog(@"5(开启自动滚动) - 彻底停止滚动，并开启timer");
        [self createTimer];
    }else {
        BPLog(@"5 - 彻底停止滚动");
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    BPLog(@"非触摸拖拽 - 偏移动画完成时调用：彻底停止滚动");
    [self updateCunrrentIndex];
    self.pageControl.currentPage = self.currentImageIndex;
}

/*
 _currentImageIndex当前显示的图片，并且正面显示的永远是center
 */
// 校正当前显示的图片的索引
- (void)updateCunrrentIndex {
    if (!BPValidateArray(self.imageArray).count) {
        return;
    }
    CGFloat scrollWidth = self.width ;
    CGPoint contentOffset = [self.scrollView contentOffset];
    if (contentOffset.x > scrollWidth) {
        //向左滑动+1
        _currentImageIndex = (_currentImageIndex + 1) % self.imageArray.count;
    } else if (contentOffset.x < scrollWidth) {
        //向右滑动-1
        _currentImageIndex = (_currentImageIndex - 1 + self.imageArray.count) % self.imageArray.count;
    }
    [self reloadImageWithIndex:self.currentImageIndex];
    [self didEndDisplayingItemAtIndex:self.currentImageIndex];
}

#pragma mark - reviseCenterContentOffset和reloadImageWithIndex 调用时机可调换：因为操作所需时间很短
// 修正位置：（偷偷）始终把centerImageView放到正中间
- (void)reviseCenterContentOffset {
    [self.scrollView setContentOffset:CGPointMake(self.width, 0.0) animated:NO];
}

//图片赋值
- (void)reloadImageWithIndex:(NSUInteger)currentImageIndex {
    if (!BPValidateArray(self.imageArray).count) {
        return;
    }
    [self reviseCenterContentOffset];
    NSInteger leftIndex = (unsigned long)((_currentImageIndex - 1 + self.imageArray.count) % self.imageArray.count);
    NSInteger rightIndex = (unsigned long)((_currentImageIndex + 1) % self.imageArray.count);
    
    self.centerImageView.backgroundColor = self.imageArray[currentImageIndex];

    self.leftImageView.backgroundColor = self.imageArray[leftIndex];

    self.rightImageView.backgroundColor = self.imageArray[rightIndex];

    /*
     [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:BPValidateString(self.imageArray[currentImageIndex])] placeholderImage:self.placeHolderImage];
     [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:BPValidateString(self.imageArray[leftIndex])] placeholderImage:self.placeHolderImage];
     [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:BPValidateString(self.imageArray[rightIndex])] placeholderImage:self.placeHolderImage];
     */
    
    
    [self.centerImageView yy_setImageWithURL:[NSURL URLWithString:BPValidateString(self.imageArray[currentImageIndex])]
                                 placeholder:self.placeHolderImage
                                     options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur
                                    progress:nil
                                   transform:^UIImage *(UIImage *image, NSURL *url) {
                                       return [image yy_imageByRoundCornerRadius:4];
                                   }
                                  completion:nil];
    
    [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:BPValidateString(self.imageArray[leftIndex])]
                               placeholder:self.placeHolderImage
                                   options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur
                                  progress:nil
                                 transform:^UIImage *(UIImage *image, NSURL *url) {
                                     return [image yy_imageByRoundCornerRadius:4];
                                 }
                                completion:nil];
    
    [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:BPValidateString(self.imageArray[rightIndex])]
                                placeholder:self.placeHolderImage
                                    options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur
                                   progress:nil
                                  transform:^UIImage *(UIImage *image, NSURL *url) {
                                      return [image yy_imageByRoundCornerRadius:4];
                                  }
                                 completion:nil];
}

#pragma mark - 告知给外界的事件
- (void)willDisplayItemAtIndex:(NSInteger)index {
    if (_delegate && [_delegate respondsToSelector:@selector(sliderShowView:willDisplayItemAtIndex:)]) {
        [_delegate sliderShowView:self willDisplayItemAtIndex:index];
    }
}

- (void)didEndDisplayingItemAtIndex:(NSInteger)index {
    if (_delegate && [_delegate respondsToSelector:@selector(sliderShowView:didEndDisplayingItemAtIndex:)]) {
        [_delegate sliderShowView:self didEndDisplayingItemAtIndex:index];
    }
}

- (void)centerTapGes {
    if (_delegate && [_delegate respondsToSelector:@selector(sliderShowView:didSelectItemAtIndex:)]) {
        [_delegate sliderShowView:self didSelectItemAtIndex:self.currentImageIndex];
    }
    if (self.clickImageBlock) {
        self.clickImageBlock(self.currentImageIndex);
    }
}

#pragma mark -- Properties

- (void)setRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    _leftImageView.layer.cornerRadius = radius;
    _centerImageView.layer.cornerRadius = radius;
    _rightImageView.layer.cornerRadius = radius;
}

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    if (_autoScroll) {
        [self createTimer];
    }else {
        [self invalidateTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    if (_autoScroll) {
        _autoScrollTimeInterval = autoScrollTimeInterval;
        [self setAutoScroll:self.autoScroll];
    }
}

- (void)setPlaceHolderImage:(UIImage *)placeHolderImage {
    _placeHolderImage = placeHolderImage;
    self.centerImageView.image = placeHolderImage;
    self.leftImageView.image = placeHolderImage;
    self.rightImageView.image = placeHolderImage;
}

- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    self.pageControl.hidden = !_showPageControl;
}

- (void)setHideWhenSinglePage:(BOOL)hideWhenSinglePage {
    _hideWhenSinglePage = hideWhenSinglePage;
    if (self.imageArray.count <= 1 && hideWhenSinglePage) {
        self.pageControl.hidden = hideWhenSinglePage;
    }
}

- (void)setCurPageControlColor:(UIColor *)curPageControlColor {
    _curPageControlColor = curPageControlColor;
    self.pageControl.currentPageIndicatorTintColor = curPageControlColor;
}

- (void)setOtherPageControlColor:(UIColor *)otherPageControlColor {
    _otherPageControlColor = otherPageControlColor;
    self.pageControl.pageIndicatorTintColor = otherPageControlColor;
}

#pragma mark - lazy methods
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageView.clipsToBounds = YES;
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _centerImageView.clipsToBounds = YES;
        _centerImageView.userInteractionEnabled = YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapGes)]];
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightImageView.clipsToBounds = YES;
    }
    return _rightImageView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.imageArray.count;
        _pageControl.pageIndicatorTintColor = self.otherPageControlColor;
        _pageControl.currentPageIndicatorTintColor = self.curPageControlColor;
    }
    return _pageControl;
}

- (void)initializeSubViewsFrame {
    CGFloat imageSizeW = self.width - 2*inset ;
    //设置偏移量
    self.scrollView.contentSize = CGSizeMake(self.width * 3, 0); //可以不写，因为下面的子view决定了大小
    [self.scrollView setContentOffset:CGPointMake(self.width, 0.0) animated:NO];
    self.scrollView.scrollEnabled = NO;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.scrollView);
        make.leading.equalTo(self.scrollView).offset(inset);
        make.height.equalTo(self.scrollView);
        make.width.mas_equalTo(imageSizeW);
    }];
    
    [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftImageView);
        make.leading.equalTo(self.leftImageView.mas_trailing).offset(inset*2);
        make.height.width.equalTo(self.leftImageView);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftImageView);
        make.leading.equalTo(self.centerImageView.mas_trailing).offset(inset*2);
        make.height.width.equalTo(self.leftImageView);
        make.trailing.equalTo(self.scrollView).offset(-inset);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(5);
        make.centerX.equalTo(self);
    }];
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _scrollView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_viewControllerInSide removeObserver:self forKeyPath:@"pauseTimer"];
    [self invalidateTimer];
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

- (void)reloadDataWithBlock:(void (^)())block {
    // 0.动画（头部-开始动画）
    [UIView beginAnimations:nil context:nil];
    // 设置动画的执行时间
    [UIView setAnimationDuration:1.0];
    block();
    // 1.动画（尾部-提交动画-执行动画）
    [UIView commitAnimations];
}

@end
