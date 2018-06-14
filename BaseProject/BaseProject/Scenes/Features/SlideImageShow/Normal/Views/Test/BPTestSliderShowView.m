//
//  BPTestSliderShowView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

//
//  BPTestSliderShowView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/10.
//  Copyright © 2018年 xiaruzhen. All rights reserved.
//

#import "BPTestSliderShowView.h"
#import "UIView+BPAdd.h"
#import "NSTimer+BPUnRetain.h"
#import "UIImageView+WebCache.h"

static CGFloat inset = 10;

@interface BPTestSliderShowView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *centerImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) NSUInteger currentImageIndex;
@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation BPTestSliderShowView

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
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.centerImageView];
    [self.scrollView addSubview:self.rightImageView];
    [self initializeSubViewsFrame];
    [self bringSubviewToFront:self.pageControl];
}

- (void)initialization {
    _autoScroll = YES;
    _autoScrollTimeInterval = 3.0;
    self.otherPageControlColor = kGrayColor;
    self.curPageControlColor = kWhiteColor;
    _showPageControl = YES;
    _hideWhenSinglePage = YES;
}

#pragma mark - view旋转
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imageSizeW = kScreenWidth - 4 * inset;
    CGFloat scrollWidth = kScreenWidth - 2 * inset;
    self.scrollView.contentSize = CGSizeMake(scrollWidth * 3, 0); //可以不写，因为下面的子view决定了大小
    [self.scrollView setContentOffset:CGPointMake(scrollWidth, 0.0) animated:NO];
}

- (void)updateConstraints {
    [super updateConstraints];
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
    CGFloat imageSizeW = kScreenWidth - 4 * inset;
    CGFloat scrollWidth = kScreenWidth - 2 * inset;
    if (BPValidateArray(self.imageArray).count <= 1) return;
    if(self.scrollView.scrollEnabled == NO) return;
    [self.scrollView setContentOffset:CGPointMake(scrollWidth*2, 0.0) animated:YES];
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
    CGFloat imageSizeW = kScreenWidth - 4 * inset;
    CGFloat scrollWidth = kScreenWidth - 2 * inset;
    CGFloat standardOffsetX = scrollWidth;
    if (scrollView.contentOffset.x < standardOffsetX) {
        [self willDisplayItemAtIndex:self.currentImageIndex-1];
    }else if (scrollView.contentOffset.x < standardOffsetX) {
        [self willDisplayItemAtIndex:self.currentImageIndex+1];
    }else {
        BPLog(@"没有偏移");
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BPLog(@"2 - 在滚动着");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    BPLog(@"3 - 将要结束拖拽");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    BPLog(@"4 - 已经结束拖拽");
    if (decelerate == NO) {
        BPLog(@"scrollView停止滚动，完全静止"); //不走这个log？
    } else {
        BPLog(@"4(end) - 用户停止拖拽，但是scrollView由于惯性，会继续滚动，并且减速");
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
    CGFloat imageSizeW = kScreenWidth - 4 * inset;
    CGFloat scrollWidth = kScreenWidth - 2 * inset;
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
    CGFloat imageSizeW = kScreenWidth - 4 * inset;
    CGFloat scrollWidth = kScreenWidth - 2 * inset;
    [self.scrollView setContentOffset:CGPointMake(scrollWidth, 0.0) animated:NO];
}

//图片赋值
- (void)reloadImageWithIndex:(NSUInteger)currentImageIndex {
    if (!BPValidateArray(self.imageArray).count) {
        return;
    }
    [self reviseCenterContentOffset];
    self.centerImageView.backgroundColor = self.imageArray[currentImageIndex];
    NSInteger leftIndex = (unsigned long)((_currentImageIndex - 1 + self.imageArray.count) % self.imageArray.count);
    self.leftImageView.backgroundColor = self.imageArray[leftIndex];
    NSInteger rightIndex = (unsigned long)((_currentImageIndex + 1) % self.imageArray.count);
    self.rightImageView.backgroundColor = self.imageArray[rightIndex];
    
    /*
     [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:KSValidateString(self.imageArray[currentImageIndex])] placeholderImage:self.placeHolderImage];
     
     [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:KSValidateString(self.imageArray[leftIndex])] placeholderImage:self.placeHolderImage];
     
     [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:KSValidateString(self.imageArray[rightIndex])] placeholderImage:self.placeHolderImage];
     */
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
        _leftImageView.contentMode = UIViewContentModeScaleToFill;
        _leftImageView.clipsToBounds = YES;
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
        _centerImageView.contentMode = UIViewContentModeScaleToFill;
        _centerImageView.clipsToBounds = YES;
        _centerImageView.userInteractionEnabled = YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapGes)]];
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeScaleToFill;
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
    
    //    CGFloat scrollWidth = imageSizeW+ inset*2;
    //    CGFloat kScreenWidth = imageSizeW + inset*4;

    //    CGFloat scrollWidth = kScreenWidth - inset*4 + inset*2;
    
    //    CGFloat scrollWidth = kScreenWidth - inset*2;


//    self.viewWidth = kScreenWidth - self.imageShowHead*2 - self.imagePadding*2;
    
    
    //    CGFloat scrollWidth = imageSizeW+ inset*2;
    //    CGFloat kScreenWidth = imageSizeW + inset*2;
    
    //    CGFloat scrollWidth = kScreenWidth  + inset*2 - inset*2;
    
    //    CGFloat scrollWidth = kScreenWidth ;
    

    CGFloat imageSizeW = kScreenWidth - 4 * inset;
    CGFloat scrollWidth = kScreenWidth - 2 * inset;
    
    //设置偏移量
    self.scrollView.contentSize = CGSizeMake(scrollWidth * 3, 0); //可以不写，因为下面的子view决定了大小
    [self.scrollView setContentOffset:CGPointMake(scrollWidth, 0.0) animated:NO];
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
        make.trailing.equalTo(self.scrollView).offset(-10);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.width.mas_equalTo(200);
        //make.height.mas_equalTo(30);
        make.bottom.equalTo(self).offset(-10);
        make.centerX.equalTo(self);
    }];
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _scrollView.delegate = nil;
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

