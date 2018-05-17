//
//  DHScrollTabbarView.m
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/14.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import "DHScrollTabbarView.h"
#import "DHColorChangeUtils.h"
#import "UIView+BPAdd.h"

//#define kTrackViewHeight 2

#define kLabelTagBase 1000
#define kViewTagBase 2000
#define kSelectedLabelTagBase 3000
#define kCoverImageViewTabBase 4000

@implementation DHScrollTabbarItem

+ (DHScrollTabbarItem *)itemWithTitle:(NSString *)title width:(CGFloat)width
{
    DHScrollTabbarItem *item = [[DHScrollTabbarItem alloc] init];
    item.title = title;
    item.width = width;
    return item;
}

@end

@interface DHScrollTabbarView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *trackView;
@property (nonatomic, strong) UIView *autoScrollBackView;
@end

@implementation DHScrollTabbarView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit
{
    _selectedIndex = -1;
    _trackViewHeight = 2;
    _trackViewWidthEqualToTextLength = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _trackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - _trackViewHeight, self.bounds.size.width, _trackViewHeight)];
    [_scrollView addSubview:_trackView];
    _trackViewCornerRadius = 2.0f;
    _trackView.layer.cornerRadius = _trackViewCornerRadius;
}

- (void)setScrollViewBackgroundColor:(UIColor *)color{
    self.scrollView.backgroundColor = color;
}

- (void)setShouldShowBottomSeparateLine:(BOOL)shouldShowBottomSeparateLine{
    if(self.bottomSeparateView){
        [self.bottomSeparateView removeFromSuperview];
    }
    if(shouldShowBottomSeparateLine){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, kOnePixel)];
        view.backgroundColor = kWhiteColor;
        [_scrollView addSubview:view];
        self.bottomSeparateView = view;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    _shouldShowBottomSeparateLine = shouldShowBottomSeparateLine;
}

- (void)setShouldBackViewAutoScroll:(BOOL)shouldBackViewAutoScroll{
    if(self.autoScrollBackView){
        [self.autoScrollBackView removeFromSuperview];
        self.autoScrollBackView = nil;
    }
    if(shouldBackViewAutoScroll){
        //添加会动的白块
        CGFloat width = MAX([UIScreen mainScreen].bounds.size.width/self.tabbarItems.count, 64);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((self.selectedIndex >= 0? self.selectedIndex*width:0), 0, width, self.bounds.size.height)];
        view.backgroundColor = kWhiteColor;
        [_scrollView addSubview:view];
        
        self.autoScrollBackView = view;
        self.scrollView.backgroundColor = kWhiteColor;
        [self.scrollView sendSubviewToBack:view];
    }
    _shouldBackViewAutoScroll = shouldBackViewAutoScroll;
}

- (void)setShouldHideTrackView:(BOOL)shouldHideTrackView{
    if(shouldHideTrackView){
        self.trackView.hidden = YES;
    }
    _shouldHideTrackView = shouldHideTrackView;
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        [self insertSubview:backgroundView atIndex:0];
        _backgroundView = backgroundView;
    }
}

- (void)setTabItemNormalColor:(UIColor *)tabItemNormalColor
{
    _tabItemNormalColor = tabItemNormalColor;
    
    for (int i = 0; i < [self tabbarCount]; i ++) {
        if (i == _selectedIndex) {
            continue;
        }
        UILabel *label = (UILabel *)[_scrollView viewWithTag:kLabelTagBase + i];
        label.textColor = tabItemNormalColor;
    }
    
}

- (void)resetTheme{
    if(self.shouldBackViewAutoScroll){
        self.autoScrollBackView.backgroundColor = kWhiteColor;
        self.scrollView.backgroundColor = kWhiteColor;
        if(self.selectedIndex >= 0){
            UILabel *toLabel = (UILabel *)[_scrollView viewWithTag:kLabelTagBase + self.selectedIndex];
            toLabel.textColor = kGreenColor;
            
        }
    }
}

- (void)resetThemeForSimpleTheme{
    self.scrollView.backgroundColor = kClearColor;
    if(self.selectedIndex >= 0){
        UILabel *toLabel = (UILabel *)[_scrollView viewWithTag:kLabelTagBase + self.selectedIndex];
        toLabel.textColor = kGreenColor;
    }
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackColor = trackColor;
    _trackView.backgroundColor = trackColor;
}

- (void)setTrackViewHeight:(CGFloat)trackViewHeight
{
    _trackViewHeight = trackViewHeight;
    _trackView.height = trackViewHeight;
    [self layoutSubviews];
}

- (void)setTrackViewBottomSpace:(CGFloat)trackViewBottomSpace{
    _trackView.frame = CGRectMake(0, self.bounds.size.height - _trackView.height - trackViewBottomSpace, self.bounds.size.width, _trackView.height);
    [self layoutSubviews];
}

- (void)setTrackViewWidth:(CGFloat)trackViewWidth{
    _trackViewWidth = trackViewWidth;
    [self layoutSubviews];
}

- (void)setTrackViewCornerRadius:(CGFloat)trackViewCornerRadius
{
    _trackViewCornerRadius = trackViewCornerRadius;
    _trackView.layer.cornerRadius = trackViewCornerRadius;
}

- (void)setTrackViewWidthEqualToTextLength:(BOOL)trackViewWidthEqualToTextLength
{
    _trackViewWidthEqualToTextLength = trackViewWidthEqualToTextLength;
    [self layoutSubviews];
}

- (void)setTabbarItems:(NSArray *)tabbarItems
{
    for (int index = 0; index < tabbarItems.count; index++) {
        UIView *view = [_scrollView viewWithTag:kViewTagBase + index];
        [view removeFromSuperview];
    }
    _scrollView.frame = self.bounds;
    if (_tabbarItems != tabbarItems) {
        _tabbarItems = tabbarItems;
        float height = CGRectGetHeight(self.bounds);
        float x = 0.0f;
        NSInteger i = 0;
        for (DHScrollTabbarItem *item in tabbarItems) {
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, item.width, height)];
            backView.backgroundColor = [UIColor clearColor];
            backView.tag = kViewTagBase + i;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, item.width, height)];
            
            if(_selectedIndex == i && self.shouldChangeFontWhenSelected){
                label.font = [UIFont systemFontOfSize:_tabItemNormalFontSize+0 weight:_itemsLabelNeedBold ? UIFontWeightMedium:UIFontWeightRegular];
                CGAffineTransform  transform;
                transform=CGAffineTransformScale(label.transform, 1.1, 1.1);
                label.transform=transform;
            }else{
                label.font = [UIFont systemFontOfSize:_tabItemNormalFontSize weight:_itemsLabelNeedBold ? UIFontWeightMedium:UIFontWeightRegular];
            }
            
            if(self.subTitleArray.count > 0){
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",item.title]];
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(0, attributedString.length)];
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.paragraphSpacing = 4;
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
                NSMutableAttributedString *subTitleString = [[NSMutableAttributedString alloc] initWithString:self.subTitleArray[i]];
                [subTitleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, subTitleString.length)];
                [attributedString appendAttributedString:subTitleString];
                label.attributedText = attributedString;
                label.numberOfLines = 2;
            }else{
                label.text = item.title;
            }
            
            if (self.isDivideEqually) {
                [label sizeToFit];
            }
            
                
            
            label.textColor = _tabItemNormalColor;
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = kLabelTagBase + i;
            label.frame = CGRectMake((item.width - CGRectGetWidth(label.bounds))/2.0f, (height - CGRectGetHeight(label.bounds))/2.0f, CGRectGetWidth(label.bounds), CGRectGetHeight(label.bounds));
            [backView addSubview:label];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [backView addGestureRecognizer:tap];
            if(self.shouldChangeBackViewColor){
                backView.backgroundColor = _selectedIndex == i? kWhiteColor : kWhiteColor;
            }
            
            //加select的标识
            if(self.shouldHideTrackView){
                backView.backgroundColor = _selectedIndex == i? kWhiteColor : kWhiteColor;
                UILabel *selectLabel = [[UILabel alloc] initWithFrame:CGRectMake((item.width - CGRectGetWidth(label.bounds))/2.0f, height - 18, CGRectGetWidth(label.bounds), 18)];
                selectLabel.font = [UIFont systemFontOfSize:_tabItemNormalFontSize/2 weight:_itemsLabelNeedBold ? UIFontWeightMedium:UIFontWeightRegular];
                selectLabel.textColor = [_tabItemSelectedColor colorWithAlphaComponent:0.5];
                selectLabel.textAlignment = NSTextAlignmentCenter;
                selectLabel.tag = kSelectedLabelTagBase + i;
                selectLabel.hidden = _selectedIndex == i? NO : YES;
                selectLabel.text = @"SELECT";
                [backView addSubview:selectLabel];
            }
            
            [_scrollView addSubview:backView];
            x += item.width;
            i++;
        }
        _scrollView.contentSize = CGSizeMake(x, height);
    }
    [self.scrollView bringSubviewToFront:self.trackView];
    self.selectedIndex = _selectedIndex;
    if(self.bottomSeparateView){
        [self.scrollView bringSubviewToFront:self.bottomSeparateView];
    }
}

- (void)removeCoverImage:(UITapGestureRecognizer *)recognizer{
    [recognizer.view removeFromSuperview];
}

- (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (void)configItem:(DHScrollTabbarItem *)item  backgroundView:(UIView *)backView label:(UILabel *)label index:(NSUInteger) index{
    float height = CGRectGetHeight(self.bounds);
    float width = CGRectGetWidth(self.bounds) / MAX(1, self.tabbarItems.count);
    float x = index * width;
    backView.frame = CGRectMake(x, 0, width, height);
    if(!self.shouldChangeFontWhenSelected){
        label.frame = CGRectMake(label.frame.origin.x, (height - CGRectGetHeight(label.bounds))/2.0f,width, CGRectGetHeight(backView.bounds));
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _backgroundView.frame = self.bounds;
    _scrollView.frame = self.bounds;
    for (NSUInteger i = 0; i < self.tabbarItems.count; i++) {
        UIView *backView = [_scrollView viewWithTag:kViewTagBase + i] ;
        UILabel *label = [backView viewWithTag:kLabelTagBase + i];
        [self configItem:self.tabbarItems[i] backgroundView:backView label:label index:i];
        if (i == self.selectedIndex) {
            if(self.shouldHideTrackView){
                label.y -= 5;
            }
            //                float width = CGRectGetWidth(self.bounds) / MAX(1, self.tabbarItems.count);
            CGRect trackRect = [_scrollView convertRect:label.bounds fromView:label];
            
            if(self.trackViewWidthEqualToTextLength) {
                NSString *titleString = label.text;
                CGSize size = [titleString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, label.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.tabItemNormalFontSize weight:_itemsLabelNeedBold ? UIFontWeightMedium:UIFontWeightRegular]} context:nil].size;
                if (self.trackViewWidth > 0){
                    _trackView.frame = CGRectMake(trackRect.origin.x+(CGRectGetWidth(trackRect)-self.trackViewWidth)/2.0, _trackView.frame.origin.y, self.trackViewWidth, CGRectGetHeight(_trackView.bounds));
                }else if(self.shouldTrackViewAutoScroll){
                    _trackView.frame = CGRectMake(trackRect.origin.x+(CGRectGetWidth(trackRect)-47)/2.0, _trackView.frame.origin.y, 47, CGRectGetHeight(_trackView.bounds));
                }else{
                    _trackView.frame = CGRectMake(trackRect.origin.x+(CGRectGetWidth(trackRect)-size.width)/2.0, _trackView.frame.origin.y, size.width, CGRectGetHeight(_trackView.bounds));
                }
                
            } else {
                _trackView.frame = CGRectMake(trackRect.origin.x, _trackView.frame.origin.y,
                                              CGRectGetWidth(trackRect), CGRectGetHeight(_trackView.bounds));
            }
            
        }
    }
    [self.scrollView bringSubviewToFront:self.trackView];
}



- (NSInteger)tabbarCount
{
    return _tabbarItems.count;
}

- (void)switchFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex percent:(float)percent
{
    UILabel *fromLabel = (UILabel *)[_scrollView viewWithTag:kLabelTagBase + fromIndex];
    fromLabel.textColor = [DHColorChangeUtils getColorOfPercent:percent betweenColor:_tabItemNormalColor andColor:_tabItemSelectedColor];
    
    UILabel *toLabel = nil;
    if (toIndex >= 0 && toIndex < [self tabbarCount]) {
        toLabel = (UILabel *)[_scrollView viewWithTag:kLabelTagBase + toIndex];
        toLabel.textColor = [DHColorChangeUtils getColorOfPercent:percent betweenColor:_tabItemSelectedColor andColor:_tabItemNormalColor];
    }
    // 计算track view位置和宽度
    CGRect fromRect = [_scrollView convertRect:fromLabel.bounds fromView:fromLabel];
    CGFloat fromWidth = fromLabel.frame.size.width;
    
    CGSize fromSize = [fromLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, fromLabel.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.tabItemNormalFontSize weight:_itemsLabelNeedBold ? UIFontWeightMedium:UIFontWeightRegular]} context:nil].size;
    if (self.trackViewWidth > 0) {
        fromSize.width = self.trackViewWidth;
    }
    CGFloat fromX = fromRect.origin.x + (fromRect.size.width - fromSize.width)/2;
    CGFloat toX;
    CGFloat toWidth;
    CGFloat trackViewWidth = 47;
    if (self.trackViewWidth > 0) {
        trackViewWidth = self.trackViewWidth;
    }
    if (toLabel) {
         CGSize toSize = [toLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, toLabel.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.tabItemNormalFontSize+2 weight:_itemsLabelNeedBold ? UIFontWeightMedium:UIFontWeightRegular]} context:nil].size;
        
        CGRect toRect = [_scrollView convertRect:toLabel.bounds fromView:toLabel];
        toWidth = toRect.size.width;
        toX = toRect.origin.x + (toWidth - trackViewWidth)/2;//+ (toRect.size.width - toSize.width)/2;
    }
    else{
        toWidth = fromWidth;
        if (toIndex > fromIndex) {
            toX = fromX + fromWidth;
        } else{
            toX = fromX - fromWidth;
        }
    }
    CGFloat width = toWidth * percent + fromWidth * (1 - percent);
    CGFloat x = fromX + (toX - fromX) * percent;
    //如果跟着手势走松手的时候有点不自然 先做成和安卓一样
    if(self.shouldTrackViewAutoScroll){
        _trackView.frame = CGRectMake(x, _trackView.frame.origin.y, _trackView.frame.size.width, CGRectGetHeight(_trackView.bounds));
    }
    
    if(self.shouldBackViewAutoScroll && toLabel){
        CGRect autoToRect = [_scrollView convertRect:toLabel.bounds fromView:toLabel];
        CGFloat autoX = fromRect.origin.x + (autoToRect.origin.x-fromRect.origin.x)*percent;
        CGFloat width = MAX([UIScreen mainScreen].bounds.size.width/self.tabbarItems.count, 64);
        self.autoScrollBackView.frame = CGRectMake(autoX, 0, width, CGRectGetHeight(self.scrollView.bounds));
    }
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex >= 0) {
        UIView *backView = [_scrollView viewWithTag:kViewTagBase + _selectedIndex];
        UILabel *fromLabel = (UILabel *)[_scrollView viewWithTag:kLabelTagBase + _selectedIndex];
        fromLabel.textColor = _tabItemNormalColor;
        float height = CGRectGetHeight(self.bounds);
        
        if(selectedIndex != _selectedIndex && self.shouldChangeBackViewColor){
            [UIView animateWithDuration:0.3 animations:^{
                backView.backgroundColor = kWhiteColor;
            }];
        }
        if(self.shouldChangeFontWhenSelected && selectedIndex != _selectedIndex){
//            [UIView animateWithDuration:0.3 animations:^{
//                fromLabel.font = [UIFont systemFontOfSize:self.tabItemNormalFontSize];
//            }];
//            [UIView animateWithDuration:0.2 animations:^{
//                CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//                aniScale.fromValue = [NSNumber numberWithFloat:1.05];
//                aniScale.toValue = [NSNumber numberWithFloat:0.99];
//                aniScale.duration = 0.2;
//                //                aniScale.delegate = self;
//                aniScale.removedOnCompletion = YES;
//                aniScale.repeatCount = 1;
//                [fromLabel.layer addAnimation:aniScale forKey:@"babyCoin_scale"];
//            } completion:^(BOOL finished) {
//                fromLabel.font = [UIFont systemFontOfSize:self.tabItemNormalFontSize];
//            }];
            [UIView animateWithDuration:0.1 animations:^{
                CGAffineTransform  transform;
                //有参照
                fromLabel.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
        
        if(self.shouldHideTrackView && selectedIndex != _selectedIndex){
            UILabel *selectLabel = (UILabel *)[_scrollView viewWithTag:kSelectedLabelTagBase + _selectedIndex];
            selectLabel.hidden = YES;
            [UIView animateWithDuration:0.3 animations:^{
                fromLabel.y = (height - CGRectGetHeight(fromLabel.bounds))/2.0f;
                backView.backgroundColor = kWhiteColor;
            }];
        }
    }
    if (selectedIndex >= 0 && selectedIndex < [self tabbarCount]) {
        UILabel *toLabel = (UILabel *)[_scrollView viewWithTag:kLabelTagBase + selectedIndex];
        toLabel.textColor = _tabItemSelectedColor;
        
        UIView *selectView = [_scrollView viewWithTag:kViewTagBase + selectedIndex];
        CGRect selectViewFrom = selectView.frame;
        selectViewFrom = CGRectMake(self.isDivideEqually ? 0 : CGRectGetMidX(selectViewFrom) - _scrollView.bounds.size.width/2.0f,
                                    selectViewFrom.origin.y,
                                    _scrollView.bounds.size.width, selectViewFrom.size.height);
        [_scrollView scrollRectToVisible:selectViewFrom animated:YES];
        
        CGRect trackRect = [_scrollView convertRect:toLabel.bounds fromView:toLabel];
        
        
        if(self.trackViewWidthEqualToTextLength) {
            NSString *titleString = toLabel.text;
            CGSize size = [titleString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, toLabel.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.tabItemNormalFontSize weight:_itemsLabelNeedBold ? UIFontWeightMedium:UIFontWeightRegular]} context:nil].size;
            [UIView animateWithDuration:0.3 animations:^{
                if (self.trackViewWidth > 0){
                    _trackView.frame = CGRectMake(trackRect.origin.x+(CGRectGetWidth(trackRect)-self.trackViewWidth)/2.0, _trackView.frame.origin.y, self.trackViewWidth, CGRectGetHeight(_trackView.bounds));
                }else if(self.shouldTrackViewAutoScroll){
                    _trackView.frame = CGRectMake(trackRect.origin.x+(CGRectGetWidth(trackRect)-47)/2.0, _trackView.frame.origin.y, 47, CGRectGetHeight(_trackView.bounds));
                }else{
                    _trackView.frame = CGRectMake(trackRect.origin.x+(CGRectGetWidth(trackRect)-size.width)/2.0, _trackView.frame.origin.y, size.width, CGRectGetHeight(_trackView.bounds));
                }
                
            }];
            
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                _trackView.frame = CGRectMake(trackRect.origin.x, _trackView.frame.origin.y, trackRect.size.width, CGRectGetHeight(_trackView.bounds));
            }];
        }
        
        if(self.shouldBackViewAutoScroll && selectedIndex != _selectedIndex){
            CGFloat width = MAX([UIScreen mainScreen].bounds.size.width/self.tabbarItems.count, 64);
            self.autoScrollBackView.frame = CGRectMake(trackRect.origin.x, 0, width, CGRectGetHeight(self.scrollView.bounds));
        }
        
        if(selectedIndex != _selectedIndex && self.shouldChangeBackViewColor){
            UIView *backView = [_scrollView viewWithTag:kViewTagBase + selectedIndex];
            [UIView animateWithDuration:0.3 animations:^{
                backView.backgroundColor = kWhiteColor;
            }];
        }
        
        if(self.shouldHideTrackView && selectedIndex != _selectedIndex) {
            //title上移   加selected标识
            UIView *backView = [_scrollView viewWithTag:kViewTagBase + selectedIndex];
            UILabel *selectLabel = (UILabel *)[_scrollView viewWithTag:kSelectedLabelTagBase + selectedIndex];
            
            [UIView animateWithDuration:0.3 animations:^{
                selectLabel.hidden = NO;
                toLabel.y -= 5;
                backView.backgroundColor = kWhiteColor;
            }];
        }
        
        if(self.shouldChangeFontWhenSelected && selectedIndex != _selectedIndex){
//            [UIView animateWithDuration:0.3 animations:^{
//                toLabel.font = [UIFont systemFontOfSize:self.tabItemNormalFontSize+1];
//            }];
//            [UIView animateWithDuration:0.2 animations:^{
//                CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//                aniScale.fromValue = [NSNumber numberWithFloat:0.95];
//                aniScale.toValue = [NSNumber numberWithFloat:1.01];
//                aniScale.duration = 0.2;
//                //                aniScale.delegate = self;
//                aniScale.removedOnCompletion = YES;
//                aniScale.repeatCount = 1;
//                [toLabel.layer addAnimation:aniScale forKey:@"babyCoin_scale"];
//            } completion:^(BOOL finished) {
//                toLabel.font = [UIFont systemFontOfSize:self.tabItemNormalFontSize+2];
//            }];
    
            [UIView animateWithDuration:0.1 animations:^{
                CGAffineTransform  transform;
                //有参照
                transform=CGAffineTransformScale(toLabel.transform, 1.1, 1.1);
                toLabel.transform=transform;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    _selectedIndex = selectedIndex;
}

- (void)tapAction:(UITapGestureRecognizer *)recognizer
{
    self.selectedIndex = recognizer.view.tag - kViewTagBase;
    if (_delegate && [_delegate respondsToSelector:@selector(DHSlideTabbar:selectAtIndex:)]) {
        [_delegate DHSlideTabbar:self selectAtIndex:_selectedIndex];
    }
}

@end
