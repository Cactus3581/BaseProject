//
//  BPSliderShowView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/10.
//  Copyright © 2018年 xiaruzhen. All rights reserved.
//

#import "BPSliderShowView.h"
#import "UIView+BPAdd.h"

@interface BPSliderShowView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *centerImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) NSUInteger currentImageIndex;
@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation BPSliderShowView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeSubViews];
        [self initialization];
    }
    return self;
}

- (void)initializeSubViews {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.centerImageView];
    [self.scrollView addSubview:self.rightImageView];
    [self initializeSubViewsFrame];
}

- (void)initialization{
    _autoScrollTimeInterval = 2.0;
    self.otherPageControlColor = kGrayColor;
    self.curPageControlColor = kWhiteColor;
    _showPageControl = YES;
    _hideWhenSinglePage = YES;
    _autoScroll = YES;
}

- (void)initializeSubViewsFrame {
    //设置偏移量
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight); //可以不写，因为下面的子view决定了大小
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0.0) animated:NO];
    self.scrollView.scrollEnabled = NO;

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.scrollView);
        make.leading.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];

    [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftImageView);
        make.leading.equalTo(self.leftImageView.mas_trailing);
        make.height.width.equalTo(self.leftImageView);
    }];

    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftImageView);
        make.leading.equalTo(self.centerImageView.mas_trailing);
        make.height.width.equalTo(self.leftImageView);
        make.trailing.equalTo(self.scrollView);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self).offset(-30);
        make.centerX.equalTo(self);
    }];
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.currentImageIndex = 0;
    if (!imageArray.count) {
        self.scrollView.scrollEnabled = NO;
        [self removeImage];
        return;
    }
    self.scrollView.scrollEnabled = YES;
    [self reloadImageWithIndex:0];
}

- (void)removeImage {
    [self.centerImageView setImage:nil];
    [self.leftImageView setImage:nil];
    [self.rightImageView setImage:nil];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = YES;
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
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
        _centerImageView.contentMode = UIViewContentModeScaleToFill;
        _centerImageView.userInteractionEnabled = YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapGes)]];
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _rightImageView;
}

- (void)centerTapGes {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    BPLog(@"1 - 将开始拖拽");
    if (self.autoScroll) {
        [self invalidateTimer];
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
        BPLog(@"scrollView停止滚动，完全静止");
    } else {
        BPLog(@"用户停止拖拽，但是scrollView由于惯性，会继续滚动，并且减速");
    }
}

// 关键执行操作时机
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BPLog(@"5 - 停止");
    /*
     0.展示当前center的下一张图片，offset为第三部分
     1. 修改当前索引
     2. 设置偏移量
     3. 赋值图片
     */
    [self updateCunrrentIndex];
    self.pageControl.currentPage = self.currentImageIndex;
    if (self.clickImageBlock) {
        self.clickImageBlock(self.currentImageIndex);
    }
}

/*
 
 _currentImageIndex当前显示的图片，并且正面显示的永远是center
 
 */

// 校正当前显示的图片的索引
- (void)updateCunrrentIndex {
    if (!BPValidateArray(self.imageArray).count) {
        return;
    }
    CGPoint contentOffset = [self.scrollView contentOffset];
    if (contentOffset.x > kScreenWidth) {
        //向左滑动+1
        _currentImageIndex = (_currentImageIndex + 1) % self.imageArray.count;
    } else if (contentOffset.x < kScreenWidth) {
        //向右滑动-1
        _currentImageIndex = (_currentImageIndex - 1 + self.imageArray.count) % self.imageArray.count;
    }
    [self reloadImageWithIndex:self.currentImageIndex];
}

#pragma mark - reviseCenterContentOffset和reloadImageWithIndex 调用时机可调换：因为操作所需时间很短
// 修正位置：（偷偷）始终把centerImageView放到正中间
- (void)reviseCenterContentOffset {
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0.0) animated:NO];
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
}

#pragma mark - life circles
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

- (void)createTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer {
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)automaticScroll {
    if (BPValidateArray(self.imageArray).count <= 1) return;
    if(self.scrollView.scrollEnabled == NO) return;
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0.0) animated:YES];
}

#pragma mark -- properties
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
    _pageControl.hidden = !_showPageControl;
}

- (void)setHideWhenSinglePage:(BOOL)hideWhenSinglePage {
    _hideWhenSinglePage = hideWhenSinglePage;
    if (self.imageArray.count <= 1 && hideWhenSinglePage) {
        _pageControl.hidden = hideWhenSinglePage;
    }
}

- (void)setCurPageControlColor:(UIColor *)curPageControlColor {
    _curPageControlColor = curPageControlColor;
    _pageControl.currentPageIndicatorTintColor = curPageControlColor;
}

- (void)setOtherPageControlColor:(UIColor *)otherPageControlColor {
    _otherPageControlColor = otherPageControlColor;
    _pageControl.pageIndicatorTintColor = otherPageControlColor;
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _scrollView.delegate = nil;
    [self invalidateTimer];
}

#pragma mark - view旋转

@end
