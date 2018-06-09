//
//  BPCellAutoLayoutHeightDataSource.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCellAutoLayoutHeightDataSource.h"
#import "BPCellAutoLayoutHeightModel.h"

@implementation BPCellAutoLayoutHeightDataSource

+ (NSArray *)array {
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:10];
    NSArray *textArray = @[@"1. 一流国家是棋手，二流国家是棋子，三流国家是棋盘。",@"2. 你们为什么要攻打叙利亚？美英法：“我们怀疑他有大规模杀伤性武器。“那为什么不打俄罗斯？”美英法：“他真有大规模杀伤性武器。”",@"3. A：“看新闻上说特朗普在白宫成立了一个神秘的‘中央圣经学习小组’，你怎么看？”B：“是呀，看当下这形势，估计也就封皮是圣经，内容应该是我国十九大报告吧。。。”",@"4. 看到新闻上美英法像饿狼一样扑向叙利亚，我的心一下子就紧绷了起来。。。七年了，叙利亚的苦难什么时间是个头啊？？？我觉得我们应该去安慰安慰叙利亚，我们能做的就是让国足和叙利亚踢一场球赛吧！",@"5. 德国谚语：世界上最难的事情是什么？在法国投降前打进巴黎。",@"6. 一流国家是棋手，二流国家是棋子，三流国家是棋盘。",@"7. 你们为什么要攻打叙利亚？美英法：“我们怀疑他有大规模杀伤性武器。“那为什么不打俄罗斯？”美英法：“他真有大规模杀伤性武器。”",@"8. A：“看新闻上说特朗普在白宫成立了一个神秘的‘中央圣经学习小组’，你怎么看？”B：“是呀，看当下这形势，估计也就封皮是圣经，内容应该是我国十九大报告吧。。。”",@"9. 看到新闻上美英法像饿狼一样扑向叙利亚，我的心一下子就紧绷了起来。。。七年了，叙利亚的苦难什么时间是个头啊？？？我觉得我们应该去安慰安慰叙利亚，我们能做的就是让国足和叙利亚踢一场球赛吧！",@"10. 德国谚语：世界上最难的事情是什么？在法国投降前打进巴黎。"];
    NSArray *photoImageArray = @[@"cell_autoLayoutHeight00",@"cell_autoLayoutHeight01",@"cell_autoLayoutHeight02",@"cell_autoLayoutHeight03",@"cell_autoLayoutHeight04",@"cell_autoLayoutHeight00",@"cell_autoLayoutHeight01",@"cell_autoLayoutHeight02",@"cell_autoLayoutHeight03",@"cell_autoLayoutHeight04"];
    NSArray *nameArray = @[@"cell_autoLayoutHeight00",@"cell_autoLayoutHeight01",@"cell_autoLayoutHeight02",@"cell_autoLayoutHeight03",@"cell_autoLayoutHeight04",@"cell_autoLayoutHeight00",@"cell_autoLayoutHeight01",@"cell_autoLayoutHeight02",@"cell_autoLayoutHeight03",@"cell_autoLayoutHeight04"];
//    NSArray *descArray = @[@"程序已经进入到后台执行的方法",@"程序已经进入到后台执行的方法，程序已经进入到后台执行的方法",@"程序已经进入到后台执行的方法",@"程序已经进入到后台执行的方法，程序已经进入到后台执行的方法",@"程序已经进入到后台执行的方法",];
    NSArray *descArray = @[@"cell_autoLayoutHeight00",@"cell_autoLayoutHeight01",@"cell_autoLayoutHeight02",@"cell_autoLayoutHeight03",@"cell_autoLayoutHeight04",@"cell_autoLayoutHeight00",@"cell_autoLayoutHeight01",@"cell_autoLayoutHeight02",@"cell_autoLayoutHeight03",@"cell_autoLayoutHeight04"];

    for (int i = 0; i<10; i++) {
        BPCellAutoLayoutHeightModel *model = [[BPCellAutoLayoutHeightModel alloc] init];
        model.headImage = @"";
        model.text = textArray[i];
        model.name = nameArray[i];
        model.desc = descArray[i];
        model.photoImage = photoImageArray[i];
        [array addObject:model];
    }
    return array.copy;
}

@end
