//
//  BPTableView.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/8/20.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPTableView.h"
#import "BPCustomTableViewCell.h"

@interface BPTableView()<UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableSet <BPCustomTableViewCell *>*reusePool;// 重用池：复用的cell
@property (strong, nonatomic) Class cellClass; // 注册创建cell对象

@end


@implementation BPTableView

//初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = kWhiteColor;
    self.delegate = self;
    _reusePool = [[NSMutableSet alloc] init];
}

//更新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [self refreshView];
}

- (void)refreshView {
    
    // 设置contentSize的高度 = 行数 * 行高
    
    NSInteger cellCount = [_dataSource tableView:self numberOfRowsInSection:0];
    
    for (int i = 0; i<cellCount; i++) {
//        self.contentSize = CGSizeMake(self.bounds.size.width, self.contentSize.height + [self p_rowHeightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]);
    }
    
    CGFloat cellHeight = [self p_rowHeightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    self.contentSize = CGSizeMake(self.bounds.size.width, cellCount * cellHeight);
    
    // 根据偏移量和cell.y值判断，将划出屏幕的cell添加到重用池，并从父视图中移除
    for (BPCustomTableViewCell * cell in self.visibleCells) {
        
        //包括：滑出顶部的cell
        if (cell.frame.origin.y + cell.frame.size.height < self.contentOffset.y) {
            [self p_addReusePoolWithLeaveCell:cell];
        }
        
        //包括：底部没有出现的cell
        if (cell.frame.origin.y > self.contentOffset.y + self.frame.size.height) {
            [self p_addReusePoolWithLeaveCell:cell];
        }
    }
    
    // 找出当前屏幕第一个和最后一个cell的index
    NSInteger firstVisibleIndex = MAX(0, floor(self.contentOffset.y / cellHeight));
    
    NSInteger lastVisibleIndex = MIN(cellCount, firstVisibleIndex + ceil(self.frame.size.height / cellHeight) + 1);
    
    // 获取 cell
    for (NSInteger row = firstVisibleIndex; row < lastVisibleIndex; row++) {
        
        // 先从重用池里获取cell
        BPCustomTableViewCell *cell = [self p_getCellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        
        if (!cell) {
            
            //如果cell不存在（没有复用的cell），则创建一个新的cell添加到scrollView中
            cell = [_dataSource tableView:self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            
            // 计算cell的frame值
            CGFloat cellHeight = [self p_rowHeightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            CGFloat cellY = row * cellHeight;
            cell.frame = CGRectMake(0, cellY, self.frame.size.width, cellHeight);
            [self insertSubview:cell atIndex:0];
        }
    }
}

#pragma mark - private methods

// 返回当前屏幕里可见的所有cell
- (NSArray *)visibleCells {
    NSMutableArray * cells = [[NSMutableArray alloc] init];
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:[BPCustomTableViewCell class]]) {
            [cells addObject:subView];
        }
    }
    return cells;
}

// 将滑出屏幕的cell 添加到重用池，并从父视图中删除
- (void)p_addReusePoolWithLeaveCell:(BPCustomTableViewCell *)cell {
    [_reusePool addObject:cell];
    [cell removeFromSuperview];
}

// 返回给定的cell，如果不存在则返回nil
- (BPCustomTableViewCell *)p_getCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = [self p_rowHeightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat cellY = indexPath.row * cellHeight;
    for (BPCustomTableViewCell * cell in self.visibleCells) {
        if (cell.frame.origin.y == cellY) {
            return cell;
        }
    }
    return nil;
}

// 返回 cell 高度
- (CGFloat)p_rowHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat rowHeight = 50.0f;//默认高度
    if ([_dataSource respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) { //自定义的高度
        rowHeight = [_dataSource tableView:self heightForRowAtIndexPath:indexPath];
    }
    return rowHeight;
}

#pragma mark - public methods

- (void)reloadData {
    [_reusePool removeAllObjects];
    [self refreshView];
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    _cellClass = cellClass;
}

- (BPCustomTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    
    //首先从复用池获取一个cell
    BPCustomTableViewCell *cell = [_reusePool anyObject];
    
    if (cell) {
        BPLog(@"从重用池中取回cell");
        [_reusePool removeObject:cell]; // 从池中返回cell，并从重用池子中移除
    }
    
    if (!cell) {
        BPLog(@"创建新cell");
        cell = [[_cellClass alloc] initWithReuseIdentifier:@""];
    }
    return cell;
}

#pragma mark - property setters

- (void)setDataSource:(id<BPTableViewDelegate>)dataSource {
    _dataSource = dataSource;
    [self refreshView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self refreshView];
}

@end
