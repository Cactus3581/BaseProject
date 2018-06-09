//
//  BPAddRoundedCornerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAddRoundedCornerViewController.h"
#import "UIView+BPRoundedCorner.h"
#import "YYWebImage.h"
#import "YYFPSLabel.h"

@interface BPTestRoundedCell : UITableViewCell

+ (BPTestRoundedCell *)bp_cellWithTableView:(__weak UITableView *)tableView imageURL:(NSString *)imageURL;

@end

@implementation BPTestRoundedCell{
    __weak UITableView *_tableView;
    UIView *_headerView;
    UIView *_nameLabel;
    UILabel *_aLabel;
    UIColor *_backColor;
    NSMutableArray<UIView *> *_circles;
}

+ (BPTestRoundedCell *)bp_cellWithTableView:(UITableView *__weak)tableView imageURL:(NSString *)imageURL{
    static NSString *identifier = @"BPTestRoundedCellIdentifier";
    BPTestRoundedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BPTestRoundedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell->_tableView = tableView;
        [cell _bp_initailizeUI];
    }
    [cell _bp_updateWithURL:imageURL];
    return cell;
}

- (void)_bp_initailizeUI{
    UIColor *backColor = [UIColor whiteColor];
    _backColor = backColor;
    self.contentView.backgroundColor = backColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.opaque = YES;
    _headerView = ({
        UIView *headerView = [UIView new];
        headerView.layer.opaque = YES;
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.bounds = BPRectMake(0, 0, 100, 100);
        headerView.center = BPPointMake(55, 60);
        headerView.layer.contentsGravity = kCAGravityResizeAspectFill;
        headerView.layer.masksToBounds = YES;
        [headerView bp_roundedCornerWithCornerRadii:BPSizeMake(40, 40) cornerColor:backColor corners:UIRectCornerAllCorners borderColor:[UIColor redColor] borderWidth:widthRatio(2)];
        [self.contentView addSubview:headerView];
        headerView;
    });
    
    _nameLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:widthRatio(9)];
        label.text = @"我是测试";
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.layer.opaque = YES;
        label.layer.masksToBounds = YES;
        label.bounds = BPRectMake(0, 0, 80, 20);
        label.center = BPPointMake(50, 90);
        [_headerView addSubview:label];
        label;
    });
    _aLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:widthRatio(14)];
        label.text = @"这是测试文字";
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = 1;
        label.layer.masksToBounds = YES;
        label.layer.opaque = YES;
        label.bounds = BPRectMake(0, 0, 150, 30);
        label.center = BPPointMake(200, 60);
        [label bp_roundedCornerWithRadius:widthRatio(15) cornerColor:backColor corners:UIRectCornerTopLeft | UIRectCornerBottomRight];
        [self.contentView addSubview:label];
        label;
    });
    
    _circles = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i ++) {
        UIView *littleCircle = [UIView new];
        littleCircle.layer.opaque = YES;
        littleCircle.backgroundColor = [UIColor blueColor];
        littleCircle.bounds = BPRectMake(0, 0, 15, 15);
        littleCircle.center = BPPointMake(110 + 7.5 + 20 * i, 30);
        [littleCircle bp_roundedCornerWithRadius:widthRatio(7.5) cornerColor:backColor];
        [self.contentView addSubview:littleCircle];
        [_circles addObject:littleCircle];
    }
}

- (void)_bp_updateWithURL:(NSString *)imageURL{
    [_headerView.layer yy_setImageWithURL:[NSURL URLWithString:imageURL] options:YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (self.selected == selected) return;
    [self _bp_colorWithSelectedorHighlighted:selected];
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (self.selected) return;
    if (self.highlighted == highlighted) return;
    [self _bp_colorWithSelectedorHighlighted:highlighted];
    [super setHighlighted:highlighted animated:animated];
}

- (void)_bp_colorWithSelectedorHighlighted:(BOOL)flag{
    UIColor *color = flag ? [UIColor lightGrayColor] : _backColor;
    self.contentView.backgroundColor = color;
    [_headerView bp_roundedCornerWithCornerRadii:BPSizeMake(40, 40) cornerColor:color corners:UIRectCornerAllCorners borderColor:[UIColor redColor] borderWidth:widthRatio(2)];
    [_aLabel bp_roundedCornerWithRadius:widthRatio(15) cornerColor:color corners:UIRectCornerTopLeft | UIRectCornerBottomRight];
    [_circles enumerateObjectsUsingBlock:^(UIView * _Nonnull littleCircle, NSUInteger idx, BOOL * _Nonnull stop) {
        [littleCircle bp_roundedCornerWithRadius:widthRatio(7.5) cornerColor:color];
    }];
}

@end

@interface BPAddRoundedCornerViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BPAddRoundedCornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [UITableView new];
    tableView.rowHeight = widthRatio(120);
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addFPSLabel];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [BPTestRoundedCell bp_cellWithTableView:tableView imageURL:[NSString stringWithFormat:@"https://oepjvpu5g.qnssl.com/avatar%zd.jpg", indexPath.row % 20]];
}

@end


