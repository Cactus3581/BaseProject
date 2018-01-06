//
//  BPAdaptiveHeightTableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAdaptiveHeightTableViewController.h"
#import "Masonry.h"
#import "BPAdaptiveHeightCell.h"

@interface BPAdaptiveHeightTableViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;

@end

@implementation BPAdaptiveHeightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTable];
}

- (void)configureTable {
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView reloadData];
}

//下划线 循环引用
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[BPAdaptiveHeightCell class] forCellReuseIdentifier:@"BPAdaptiveHeightCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.contentInset = UIEdgeInsetsMake(50, 50, -50, -50);
        
        _tableView.backgroundColor = kGreenColor;
        //        _tableView.estimatedRowHeight = 44.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        //        iOS11下不想使用Self-Sizing的话，可以通过以下方式关闭：（前言中提到的问题也是通过这种方式解决的）
        //        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        //        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row+1)*10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPAdaptiveHeightCell";
    BPAdaptiveHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.content = self.array[indexPath.row];
    return cell;
}

#pragma mark -懒加载
- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithObjects:@"晚饭之余，边啃着玉米边酝酿一些文字。没有大块的时间拿来写长篇的文章，写的短了不尽兴，每每看到之前写的文章总觉得差强人意。若不是停留在屏幕上的文字，真真要把它们撕了、烧了、毁了去。",@"你是无意穿堂风，却偏偏引山洪",@"一直都知道那么多的牵挂、想念、纠结、妥协、逃避.都是不该存在的情愫.原来 我控制不了自己.睁开眼睛是你 闭上眼睛是你.明媚的阳光是你 清冷的雨滴是你.热闹时的欢乐是你 孤寂时的落寞是你.好像 你已经无处不在了",@"你不在眼前时等待、期盼、望眼欲穿.好像世界再怎么鲜活落在眼眸都失了色彩.你在眼前时.躲闪、逃避、无所适从.偶然的靠近和眼神的交汇都像是一记响雷.炸开了花儿 那般绚烂美好.荡漾的是无法收放的上扬的嘴角.我想 那一定是幸福的模样",@"我却只能够 将这些细腻敏感的心思藏于枕下的那些梦里.飘散于明朗晴空的微风里.坠落于寒凉雨夜的泪水里.可是 越是想要驱逐.那些情感就越是紧紧地团在一起.愈发的厚重、浓烈、挥散不去",@"风动荷花水殿香，姑苏台上宴吴王。西施醉舞娇无力，笑倚东窗白玉床。",@"过眼溪山，怪都似、旧时相识。还记得、梦中行遍，江南江北。佳处径须携杖去，能消几緉平生屐。笑尘劳、三十九年非、长为客。吴楚地，东南坼。英雄事，曹刘敌。被西风吹尽，了无尘迹。楼观才成人已去，旌旗未卷头先白。叹人间、哀乐转相寻，今犹昔",@"何物能令公怒喜？山要人来，人要山无意。恰似哀筝弦下齿，千情万意无时已。自要溪堂韩作记，今代机云，好语花难比。老眼狂花空处起，银钩未见心先醉。",@"",@"白景归西山，碧华上迢迢。今古何处尽，千岁随风飘。海沙变成石，鱼沫吹秦桥。空光远流浪，铜柱从年消。",@"草暖云昏万里春，宫花拂面送行人。", nil];
    }
    return _array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

