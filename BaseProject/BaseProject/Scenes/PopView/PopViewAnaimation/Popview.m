//
//  Popview.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/3/25.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "Popview.h"
@interface Popview()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end
@implementation Popview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI
{
    [self addSubview:self.tableView];

}

- (void)setArray:(NSArray *)array
{
    _array = [array copy];
    if (_array) {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, 64+30, 375, 400);
            self.tableView.frame = CGRectMake(0, 0, 375, 400);
            
        }completion:^(BOOL finished) {
            [self.tableView reloadData];

        }];

        
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, 64+30, 375,0);
            self.tableView.frame = CGRectMake(0, 0, 375, 0);
            
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"BaseTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}
@end
