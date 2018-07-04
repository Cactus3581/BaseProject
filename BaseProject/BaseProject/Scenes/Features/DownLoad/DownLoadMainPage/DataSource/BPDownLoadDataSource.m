//
//  BPDownLoadDataSource.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDownLoadDataSource.h"
#import "MJExtension.h"

@implementation BPDownLoadDataSource

+ (NSArray *)downLoadMoreDataSource {
    NSArray *data = [BPDownLoadDataSource dataSource];
    NSMutableArray *muArray = @[].mutableCopy;
    for (NSDictionary *dict in data) {
        BPAudioModel *model = [BPAudioModel mj_objectWithKeyValues:dict];
        [muArray addObject:model];
    }
    return muArray.copy;
}

+ (BPAudioModel *)downLoadOneDataSourceWithIndex:(NSInteger)index {
    NSArray *array = [BPDownLoadDataSource downLoadMoreDataSource];
    return array[index];
}

+ (BPAudioModel *)downLoadRanDomOneDataSource {
    NSArray *array = [BPDownLoadDataSource downLoadMoreDataSource];
    return array[kRandomNumber(0,array.count-1)];
}

+ (NSArray *)dataSource {
    NSArray *array = @[];
    array = @[
              @{
                  @"id":@"8780",
                  @"title":@"Trump’s Party Makes Gains With U.S. Supreme Court",
                  @"smallpic":@"http://listen.cache.iciba.com/listening/image/voice/small/2018-06-29/08-01-01/61860617ffd779cedb9d67974f7edff8.jpg",
                  @"mediaUrl":@"http://listen.cache.iciba.com/listening/audio/voice/2018-06-29/08-01-01/3035e763c83e7b5bcf398bee3d03c605.mp3",
                  @"mediaSize":@"2.04"
                  },
              @{
                  @"id":@"8779",
                  @"title":@"What Happened to General Electric?",
                  @"smallpic":@"http://listen.cache.iciba.com/listening/image/voice/small/2018-06-29/06-01-01/eadf46debe88becf85bdbe4b1ba3c660.jpg",
                  @"mediaUrl":@"http://listen.cache.iciba.com/listening/audio/voice/2018-06-29/06-01-01/0d72b718d74490af08c41aac8205c1f2.mp3",
                  @"mediaSize":@"3.15"
                  },
              @{
                  @"id":@"8768",
                  @"title":@"EU, China Discuss Reforming the World Trade Organization",
                  @"smallpic":@"http://listen.cache.iciba.com/listening/image/voice/small/2018-06-27/06-01-02/d83841cbb18f6395e87bec1fb1243b38.jpg",
                  @"mediaUrl":@"http://listen.cache.iciba.com/listening/audio/voice/2018-06-27/06-01-02/1a9ecc8a69b31e6fb8f9fbbbbc42ede6.mp3",
                  @"mediaSize":@"2.33"
                  },
              @{
                  @"id":@"8773",
                  @"title":@"Separation Stress May Permanently Hurt Migrant Children",
                  @"smallpic":@"http://listen.cache.iciba.com/listening/image/voice/small/2018-06-28/06-01-01/3c65bf4660dcc72aebadcd12bb82f0c0.jpg",
                  @"mediaUrl":@"http://listen.cache.iciba.com/listening/audio/voice/2018-06-28/06-01-01/5b4ee5d76b8038e0856ddfd06a5450c0.mp3",
                  @"mediaSize":@"3.12"
                  },
              @{
                  @"id":@"8770",
                  @"title":@"俄罗斯火力全开",
                  @"smallpic":@"http://voice.iciba.com/upload/voa/smallpic_url18181818-06-27-10-59-07.jpg",
                  @"mediaUrl":@"http://voice.iciba.com/upload/voa/mp318181818-06-27-10-59-07.mp3",
                  @"mediaSize":@"2.19"
                  },
              @{
                  @"id":@"8775",
                  @"title":@"智能装置让业余运动员可与专业人士比肩",
                  @"smallpic":@"http://voice.iciba.com/upload/voa/smallpic_url18181818-06-28-09-22-30.jpg",
                  @"mediaUrl":@"http://voice.iciba.com/upload/voa/mp318181818-06-28-09-22-30.mp3",
                  @"mediaSize":@"1.7"
                  },
              @{
                  @"id":@"8778",
                  @"title":@"In Small Numbers, Visitors Are Returning to Fukushima",
                  @"smallpic":@"http://listen.cache.iciba.com/listening/image/voice/small/2018-06-29/06-01-01/ce27f4a0cfccebcde35ad8a3910b009e.jpg",
                  @"mediaUrl":@"http://listen.cache.iciba.com/listening/audio/voice/2018-06-29/06-01-01/0b781c109888cef90038c9989bb97556.mp3",
                  @"mediaSize":@"3.39"
                  },
              @{
                  @"id":@"8787",
                  @"title":@"美国指责中俄两国为美国带来了机遇和挑战",
                  @"smallpic":@"http://voice.iciba.com/upload/voa/smallpic_url18181818-06-30-08-53-58.jpg",
                  @"mediaUrl":@"http://voice.iciba.com/upload/voa/mp318181818-06-30-08-53-58.mp3",
                  @"mediaSize":@"2.63"
                  },
              ];
    
    return array;
}

@end
