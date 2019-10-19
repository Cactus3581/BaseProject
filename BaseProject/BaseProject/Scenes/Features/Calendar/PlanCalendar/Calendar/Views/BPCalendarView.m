//
//  BPCalendarView.m
//  BaseProject
//
//  Created by Ryan on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendarView.h"
#import "BPCalendarWeekCell.h"
#import "BPCalendarDayCell.h"
#import "BPCalendarMonthSectionView.h"
#import "Masonry.h"
#import "BPCalendarConst.h"
#import "BPCalendarModel.h"
#import "BPCalendar.h"
#import "BPCalendarAppearance.h"

static NSString * weekCell_ide = @"BPCalendarWeekCell";
static NSString * dayCell_ide = @"BPCalendarDayCell";
static NSString * monthSection_ide = @"BPCalendarMonthSectionView";

@interface BPCalendarView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation BPCalendarView

@synthesize calendar = _calendar;

#pragma mark - init
+ (instancetype)calendarViewWithCalendar:(BPCalendar *)calendar {
    BPCalendarView *calendarView = [[self alloc] initWithCalendar:calendar];
    return calendarView;
}

- (instancetype)initWithCalendar:(BPCalendar *)calendar {
    self = [super init];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self initCollectionView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCollectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - setter
- (void)setCalendar:(BPCalendar *)calendar {
    _calendar = calendar;
}

#pragma mark - collectionview delegate
- (void)initCollectionView {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self register_collectionView_cell];
    [self register_collectionView_sectionView];
}

- (void)register_collectionView_sectionView {
    [self.collectionView registerClass:[BPCalendarMonthSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:monthSection_ide];
}

- (void)register_collectionView_cell {
    [self.collectionView registerClass:[BPCalendarWeekCell class] forCellWithReuseIdentifier:weekCell_ide];
    [self.collectionView registerClass:[BPCalendarDayCell class] forCellWithReuseIdentifier:dayCell_ide];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.calendar.model.weekArray.count && self.calendar.model.dayArray.count) {
        return 2;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (section) {
            
        case 0:
            if (self.calendar.show_weekView) {
                return self.calendar.model.weekArray.count;
            }
            return 0;
            break;
            
        case 1:
            return self.calendar.model.dayArray.count;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BPCalendarWeekCell * weekCell = [collectionView dequeueReusableCellWithReuseIdentifier:weekCell_ide forIndexPath:indexPath];
        weekCell.model = self.calendar.model.weekArray[indexPath.row];
        return weekCell;
    }
    BPCalendarDayCell * dayCell = [collectionView dequeueReusableCellWithReuseIdentifier:dayCell_ide forIndexPath:indexPath];
    dayCell.model = self.calendar.model.dayArray[indexPath.row];
    return dayCell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (!self.calendar.show_weekView) {
                return CGSizeMake(0,0);
            }
            if ((indexPath.row+1) % BPCalenarWeeBPeven) { // == 0 最后一个cell
                return CGSizeMake([self cellBehindWidth], self.calendar.weekHight);
            }
            return CGSizeMake([self cellFrontWidth], self.calendar.weekHight);
            break;
           
        case 1:
            if ((indexPath.row+1) % BPCalenarWeeBPeven) {
                return CGSizeMake([self cellBehindWidth], self.calendar.dayHight);
            }
            return CGSizeMake([self cellFrontWidth], self.calendar.dayHight);
            break;
            
        default:
            break;
    }
    return CGSizeMake(0, 0);
}

- (int)cellFrontWidth {
    return (kScreenWidth - (int)(kScreenWidth / BPCalenarWeeBPeven) * (BPCalenarWeeBPeven-1));
}

- (int)cellBehindWidth {
    return (int)(kScreenWidth / BPCalenarWeeBPeven);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        if (self.calendar.show_ymView) {
            return CGSizeMake(kScreenWidth, self.calendar.yearMonthHeight);
        }
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (!self.calendar.show_ymView) {
            return nil;
        }
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            BPCalendarMonthSectionView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:monthSection_ide forIndexPath:indexPath];
            sectionView.model = self.calendar.model;
            return sectionView;
        }
    }
    return nil;
}

#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(didSelected:)]) {
            BPCalendarDayModel *model = self.calendar.model.dayArray[indexPath.row];
            [_delegate didSelected:model];
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - view Transition methods
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView reloadData];
}

#pragma mark - lazy load methods
- (BPCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[BPCalendar alloc] init];
    }
    return _calendar;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

- (void)dealloc {

}

@end
