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

+ (BPMultiLevelCatalogueModel *)handleData {
    NSDictionary *dic = @{
                          @"array":@[
                                  @{
                                      @"title_1st":@"i go",
                                      @"array_1st":@[
                                              @{
                                                  @"title_2nd":@"我要去的意思",
                                                  @"array_2nd":@[
                                                          @{
                                                              @"title_3rd":@"i go to zoo",
                                                              @"brief_3rd":@"我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，",
                                                              },
                                                          @{
                                                              @"title_3rd":@"i go to home",
                                                              @"brief_3rd":@"我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，",
                                                              },
                                                          ],
                                                  },
                                              @{
                                                  @"title_2nd":@"我不要去的意思",
                                                  @"array_2nd":@[
                                                          @{
                                                              @"title_3rd":@"i not go to zoo",
                                                              @"brief_3rd":@"我不要去公园",
                                                              },
                                                          @{
                                                              @"title_3rd":@"i not go to home",
                                                              @"brief_3rd":@"我不要回家",
                                                              },
                                                          ],
                                                  },
                                              ],
                                      },
                                  @{
                                      @"title_1st":@"you go",
                                      @"array_1st":@[
                                              @{
                                                  @"title_2nd":@"你要去的意思",
                                                  @"array_2nd":@[
                                                          @{
                                                              @"title_3rd":@"you go to zoo",
                                                              @"brief_3rd":@"你要去公园",
                                                              },
                                                          @{
                                                              @"title_3rd":@"you go to home",
                                                              @"brief_3rd":@"你要回家",
                                                              },
                                                          ],
                                                  },
                                              ],
                                      },
                                  ],
                          };
    BPMultiLevelCatalogueModel *model = [BPMultiLevelCatalogueModel yy_modelWithDictionary:dic];
    return model;
}

@end
