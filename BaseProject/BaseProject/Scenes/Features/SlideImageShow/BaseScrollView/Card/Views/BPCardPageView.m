//
//  BPCardPageView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCardPageView.h"
#import "UIView+BPAdd.h"
#import "NSTimer+BPUnRetain.h"
#import "UIImageView+WebCache.h"
#import "UIView+BPRoundedCorner.h"

@interface BPCardPageView ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *imageViewArray;
@property (nonatomic,assign) NSUInteger currentImageIndex;
@property (nonatomic,weak) NSTimer *timer;
@end

/*
 位置：暂不处理
 旋转：改变size（已处理），计时器停止工作（待处理）：旋转前：停止计时器；旋转后：开始计时器：方法1:vc传过来viewWillTransitionToSize；方法二 view内部监听通知
 代理：代理的存在性+正确性（已处理）
 hitTest：（已处理）
 */

@implementation BPCardPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        self.scrollView.scrollEnabled = NO;
    }
    return self;
}

#pragma mark - 默认属性
- (void)initialization {
    self.clipsToBounds = YES;
    self.backgroundColor = kWhiteColor;
    _padding = 7;
    _imageInset = 8;
    _pageControlBottom = 0;
    _autoScroll = YES;
    _autoScrollTimeInterval = 3.0;
    _otherPageControlColor = kLightGrayColor;
    _curPageControlColor = kWhiteColor;
    _showPageControl = YES;
    _hideWhenSinglePage = YES;
}

#pragma mark - view旋转
- (void)layoutSubviews {
    [super layoutSubviews];
    //[self invalidateTimer]; //旋转时，timer停止

    // self.width = kScreenWidth = imageinset + padding + imageW + padding + imageinset
    //scrollW = imageW + padding;
    CGFloat imageViewWidth = self.width-self.imageInset-self.padding-self.padding-self.imageInset;
    CGFloat scrollWidth = imageViewWidth + self.padding;
    _scrollView.contentSize = CGSizeMake(scrollWidth * self.imageArray.count, 0);//可以不写，因为下面的子view决定了大小
    [_scrollView setContentOffset:CGPointMake(_currentImageIndex * _scrollView.width, 0.0) animated:NO]; //位移归位
}

- (void)resert {
    [self invalidateTimer];
    [self.imageViewArray removeAllObjects];
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_scrollView setContentOffset:CGPointZero animated:NO]; //位移归位
    self.currentImageIndex = 0;
    self.pageControl.numberOfPages = _imageArray.count;//默认显示
    [self setHideWhenSinglePage:_hideWhenSinglePage];//当数据为一条时，是否显示pageControl
    self.pageControl.currentPage = self.currentImageIndex;
}

#pragma mark - 数据源
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = BPValidateArray(imageArray);
    
    [self resert];//恢复
    
    if (!_imageArray.count) {
        _scrollView.scrollEnabled = NO;
        [self removeImage];
        return;
    }
    
    for (int i = 0; i<imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:BPValidateString(imageArray[i])] placeholderImage:self.placeHolderImage];
        [self.imageViewArray addObject:imageView];
        [_scrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapGes)]];
        
        if (i == 0) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(_scrollView);
                make.leading.equalTo(_scrollView);
                make.height.equalTo(_scrollView);
                make.width.equalTo(self.scrollView).mas_offset(-self.padding);
            }];
        }else {
            UIImageView *lastImageView = self.imageViewArray[i-1];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(lastImageView);
                make.leading.equalTo(lastImageView.mas_trailing).offset(self.padding);
                make.height.width.equalTo(lastImageView);
            }];
        }
        
        if (i == self.imageArray.count-1) {
            UIImageView *lastImageView = self.imageViewArray.lastObject;
            [lastImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(_scrollView).offset(-self.padding);
            }];
        }
    }
    _scrollView.scrollEnabled = YES;
    [self setAutoScroll:_autoScroll];//开始加载计时器
}

- (NSMutableArray *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (void)removeImage {
    for (UIImageView *imageView in self.imageViewArray) {
        [imageView setImage:nil];
    }
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
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)automaticScroll {
    if (BPValidateArray(self.imageArray).count <= 1) return;
    if(_scrollView.scrollEnabled == NO) return;
    if (self.currentImageIndex == self.imageArray.count-1) {
        self.currentImageIndex = 0;
        [_scrollView setContentOffset:CGPointZero animated:YES];
        self.pageControl.currentPage = self.currentImageIndex;
        [self willDisplayItemAtIndex:self.currentImageIndex];
    }else {
        [_scrollView setContentOffset:CGPointMake((self.currentImageIndex+1)*_scrollView.width, 0.0) animated:YES];
        [self willDisplayItemAtIndex:self.currentImageIndex+1];
    }
}

#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        [self invalidateTimer];
    }
    CGFloat standardOffsetX = scrollView.width * self.currentImageIndex;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    if (currentOffsetX < standardOffsetX) {
        [self willDisplayItemAtIndex:self.currentImageIndex-1];
    }else if (currentOffsetX > standardOffsetX) {
        [self willDisplayItemAtIndex:self.currentImageIndex+1];
    }else {
        BPLog(@"没有偏移");
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateCunrrentIndex];
    if (self.autoScroll) {
        [self createTimer];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateCunrrentIndex];
}

/*
 _currentImageIndex当前显示的图片，并且正面显示的永远是center
 */
// 校正当前显示的图片的索引
- (void)updateCunrrentIndex {
    if (!BPValidateArray(self.imageArray).count) {
        return;
    }
    CGPoint contentOffset = [_scrollView contentOffset];
    _currentImageIndex = contentOffset.x / _scrollView.width;
    self.pageControl.currentPage = self.currentImageIndex;
    [self didEndDisplayingItemAtIndex:self.currentImageIndex];
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

- (void)setPadding:(CGFloat)padding {
    _padding = padding;
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(_padding + self.imageInset);
        make.trailing.equalTo(self).offset(- self.imageInset);
    }];
}

- (void)setImageInset:(CGFloat)imageInset {
    _imageInset = imageInset;
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(self.padding + _imageInset);
        make.trailing.equalTo(self).offset(-_imageInset);
    }];
}

- (void)setPageControlBottom:(CGFloat)pageControlBottom {
    _pageControlBottom = pageControlBottom;
    [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-_pageControlBottom);
    }];
}

- (void)setRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    for (UIImageView *imageView in self.imageViewArray) {
        [imageView bp_roundedCornerWithRadius:radius cornerColor:color];
    }
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
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        _scrollView = scrollView;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        [self bringSubviewToFront:self.pageControl];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.equalTo(self);
            make.leading.equalTo(self).offset(self.padding+self.imageInset);
            make.trailing.equalTo(self).offset(-self.imageInset);
        }];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        _pageControl = pageControl;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.imageArray.count;
        _pageControl.pageIndicatorTintColor = _otherPageControlColor;
        _pageControl.currentPageIndicatorTintColor = _curPageControlColor;
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-self.pageControlBottom);
            make.centerX.equalTo(self);
        }];
        //[_pageControl setValue:[UIImage imageNamed:@""] forKeyPath:@"_currentPageImage"];
        //[_pageControl setValue:[UIImage imageNamed:@""] forKeyPath:@"_pageImage"];
    }
    [self bringSubviewToFront:_pageControl];
    return _pageControl;
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

#pragma mark---修改hitTest方法
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if ([view isEqual:self]){
//        for (UIView *subview in _scrollView.subviews){
//            CGPoint offset = CGPointMake(point.x - _scrollView.frame.origin.x + _scrollView.contentOffset.x - subview.frame.origin.x, point.y - _scrollView.frame.origin.y + _scrollView.contentOffset.y - subview.frame.origin.y);
//
//            if ((view = [subview hitTest:offset withEvent:event])){
//                return view;
//            }
//        }
//        return _scrollView;
//    }
//    return view;
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 如果交互未打开，或者透明度小于0.05 或者 视图被隐藏
    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES) {
        return nil;
    }
    // 如果touch的point在self的bounds内
    if ([self pointInside:point withEvent:event]) {
        CGPoint newPoint = CGPointZero;
        newPoint.x = point.x - _scrollView.frame.origin.x + _scrollView.contentOffset.x;
        newPoint.y = point.y - _scrollView.frame.origin.y + _scrollView.contentOffset.y;
        // 如果touch的point在_scrollView的bounds内
        if ([_scrollView pointInside:newPoint withEvent:event]) {
            // 调用子视图的hitTest重复上面的步骤。找到了，返回hitTest view ,没找到返回有自身处理
            return [_scrollView hitTest:newPoint withEvent:event];
        }
        return _scrollView;
    }
    return nil;
}

@end
