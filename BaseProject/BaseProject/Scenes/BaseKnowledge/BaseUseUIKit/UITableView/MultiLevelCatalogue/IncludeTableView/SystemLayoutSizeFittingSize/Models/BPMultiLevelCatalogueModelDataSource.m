//
//  BPMultiLevelCatalogueModelDataSource.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMultiLevelCatalogueModelDataSource.h"
#import <YYModel.h>

@implementation BPMultiLevelCatalogueModelDataSource

+ (BPMultiLevelCatalogueModel *)getData {
    BPMultiLevelCatalogueModel *dictionaryPhrase = [[BPMultiLevelCatalogueModel alloc] init];
    
    NSArray *array1 = @[@"all the go",@"as fra as it goes",@"as go",@"from the word go",@"get someone going",@"go figure!"];
    NSArray *array2 = @[@"考虑到它的局限性(在找理由表扬某事物时)",@"与一般的相比"];
    NSArray *array3 = @[@"to travel or move to a place that is away from where you are or where you live",@"There’s nothing more we can do here. Let’s go home "];
    
    NSArray *array4 = @[@"十英里路我们用了一个多小时。",@"这车开得太快了。"];

    NSMutableArray *muArray1 = @[].mutableCopy;
    [array1 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx1, BOOL * _Nonnull stop) {
        BPMultiLevelCatalogueModel1st *model = [[BPMultiLevelCatalogueModel1st alloc] init];
        model.title_1st = title;
        NSMutableArray *tagArray = @[].mutableCopy;
        [array2 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx2, BOOL * _Nonnull stop) {
            BPMultiLevelCatalogueModel2nd *tagModel = [[BPMultiLevelCatalogueModel2nd alloc] init];
            tagModel.title_2nd = title;
            tagModel.title_2nd = title;
            NSMutableArray *cellArray = @[].mutableCopy;
            [array3 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx3, BOOL * _Nonnull stop) {
                BPMultiLevelCatalogueModel3rd *cellModel = [[BPMultiLevelCatalogueModel3rd alloc] init];
                cellModel.title_3rd = title;
                cellModel.brief_3rd = array4[idx3];
                [cellArray addObject:cellModel];
            }];
            tagModel.array_2nd = cellArray;
            [tagArray addObject:tagModel];
        }];
        model.array_1st = tagArray;
        [muArray1 addObject:model];
    }];
    
    dictionaryPhrase.array = muArray1.copy;
    return dictionaryPhrase;
}

+ (BPMultiLevelCatalogueModel *)handleData {
    NSDictionary *dic = @{
                          @"array":@[
                                  @{
                                      @"title_1st":@"MOVE/TRAVEL 移动/旅行",
                                      @"array_1st":@[
                                              @{
                                                  @"title_2nd":@"走，去",
                                                  @"array_2nd":@[
                                                          @{
                                                              @"title_3rd":@"There’s nothing more we can do here. Let’s go home .",
                                                              @"brief_3rd":@"这里没有我们的事了，咱们回家吧。",
                                                              },
                                                          @{
                                                              @"title_3rd":@"(= have you ever travelled to ) Japan?",
                                                              @"brief_3rd":@"你去过日本吗？",
                                                              },
                                                          @{
                                                              @"title_3rd":@"I have been to (= have travelled to ) Germany several times.",
                                                              @"brief_3rd":@"我去过德国几次。",
                                                              },
                                                          ],
                                                  
                                                  },
                                              @{
                                                  @"title_2nd":@"行走，旅行",
                                                  @"array_2nd":@[
                                                          @{
                                                              @"title_3rd":@"It took us over an hour to go ten miles.",
                                                              @"brief_3rd":@"十英里路我们用了一个多小时。",
                                                              },
                                                          @{
                                                              @"title_3rd":@"The car was going much too fast.",
                                                              @"brief_3rd":@"这车开得太快了",
                                                              },
                                                          ],
                                                  },
                                              ],
                                      },
                                  @{
                                      @"title_1st":@"go flying/laughing/rushing etc",
                                      @"array_1st":@[
                                              @{
                                                  @"title_2nd":@"飞过/边走边笑/奔过去等",
                                                  @"array_2nd":@[
                                                          @{
                                                              @"title_3rd":@"The plate went crashing to the floor.",
                                                              @"brief_3rd":@"盘子哗啦一声掉在地板上。",
                                                              },
                                                          @{
                                                              @"title_3rd":@"The bullet went flying over my head.",
                                                              @"brief_3rd":@"你要回家",
                                                              },
                                                          @{
                                                              @"title_3rd":@"John went rushing off down the corridor.",
                                                              @"brief_3rd":@"约翰沿走廊飞奔而去。",
                                                              },
                                                          ],
                                                  },
                                              @{
                                                  @"title_2nd":@"ATTEND 参加",
                                                  @"array_2nd":@[
                                                          @{
                                                              @"title_3rd":@"to be at a concert, party, meeting etc",
                                                              @"brief_3rd":@"参加〔音乐会、聚会、会议等〕",
                                                              },
                                                          @{
                                                              @"title_3rd":@"Are you going to Manuela’s party?",
                                                              @"brief_3rd":@"你去参加曼纽拉的派对吗？",
                                                              },
                                                          @{
                                                              @"title_3rd":@"I first went to a rock concert when I was 15.",
                                                              @"brief_3rd":@"我15岁时第一次去听了摇滚音乐会。",
                                                              },
                                                          @{
                                                              @"title_3rd":@"He doesn’t go to the synagogue these days.",
                                                              @"brief_3rd":@"他最近不去犹太教堂做礼拜了。",
                                                              },

                                                          ],
                                                  },
                                              ],
                                      },
                                  @{
                                      @"title_1st":@"HAPPEN 发生",
                                      @"array_1st":@[
                                              @{
                                                  @"title_2nd":@"进行，进展",
                                                  @"array_2nd":@[
                                                          @{
                                                              @"title_3rd":@"Many industries have been forced to cut jobs and it looks like the electronics industry is going the same way .",
                                                              @"brief_3rd":@"许多行业被迫裁员，电子产业看来也是如此。",
                                                              },
                                                          @{
                                                              @"title_3rd":@"I feel very encouraged by the way things are going .",
                                                              @"brief_3rd":@"事情的发展让我很有信心。",
                                                              },
                                                          @{
                                                              @"title_3rd":@"if what someone says goes, that person is in authority and what they say should be obeyed",
                                                              @"brief_3rd":@"如果有人说了什么，那个人就有权力，他们说什么就应该遵守",
                                                              },
                                                          ],
                                                  },
                                              ],
                                      }
                                  ],
                          };
    BPMultiLevelCatalogueModel *model = [BPMultiLevelCatalogueModel yy_modelWithDictionary:dic];
    return model;
}

@end
