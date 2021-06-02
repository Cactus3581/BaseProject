//
//  BPTextViewHeightViewController.m
//  BaseProject
//
//  Created by 夏汝震 on 2020/4/8.
//  Copyright © 2020 cactus. All rights reserved.
//

#import "BPTextViewHeightViewController.h"
#import "BPTextViewHeightTableViewCell.h"

@interface BPTextViewHeightViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSArray *array;

@end

@implementation BPTextViewHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"数据大卡司觉得快撒加到拉萨简单快乐撒点就开始倒计时看得见数据大卡司觉得快撒加到拉萨简单快乐撒点就开始倒计时看得见",@"数据大卡司觉得快撒加到拉萨简单快乐撒点就开始倒计时看得见数据大卡司觉得快撒加到拉萨简单快乐撒点就开始倒计时看得见数据大卡司觉得快撒加到拉萨简单快乐撒点就开始倒计时看得见数据大卡司觉得快撒加到拉萨简单快乐撒点就开始倒计时看得见"];
    [_tableView registerNib:[BPTextViewHeightTableViewCell bp_loadNib] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPTextViewHeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textView.text = self.array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static BPTextViewHeightTableViewCell *cell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    });

    cell.textView.text = self.array[indexPath.row];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGFloat textViewHeight = [cell.textView sizeThatFits:CGSizeMake(tableView.width-32, MAXFLOAT)].height;
    CGFloat cellHeight = ceil([cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    BPLog(@"%.2f,%.2f,%.2f",tableView.width,textViewHeight,cellHeight)
    return cellHeight + textViewHeight ;
}

@end
