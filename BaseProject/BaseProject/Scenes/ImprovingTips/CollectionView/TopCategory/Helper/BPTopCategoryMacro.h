//
//  BPTopCategoryMacro.h
//  BaseProject
//
//  Created by Ryan on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryMacro.h"

#ifndef BPTopCategoryMacro_h
#define BPTopCategoryMacro_h

#define kHeritageDictionaryPath                         @"HeritageDictionary"//下载权威文件路径
#define kHeritageDictionaryStartDownLoadNotification   @"kHeritageDictionaryStartDownLoadNotification"//开始下载
#define kHeritageDictionaryDownLoadProgressNotification @"kHeritageDictionaryDownLoadProgressNotification"//文件下载时的通知
#define kHeritageDictionaryDownLoadResultNotification @"kHeritageDictionaryDownLoadResultNotification"//文件下载成功失败的通知

#define kHeritageDictionaryWriteDBProgressNotification @"kHeritageDictionaryWriteDBProgressNotification"//文件写进数据库进度的通知
#define kHeritageDictionaryWriteDBResultNotification @"kHeritageDictionaryWriteDBResultNotification"//文件写进数据库成功失败的通知


#define kMessage                    @"退出将取消所有正在创建的生词本，确定要退出吗？"
#define kMessageTitle               @"温馨提示"
#define kWordBookName_CE4           @"四级生词本"
#define kWordBookName_CE6           @"六级生词本"
#define kWordBookName_kaoyan        @"考研必备"
#define kWordBookName_Lelts1        @"雅思必备-上"
#define kWordBookName_Lelts2        @"雅思必备-下"
#define KWordAddMessage             @"%@(词霸推荐)"
#define kTitleName                  @"生词本"
#define kEmptyWithTextFlied         @"请输入生词本名称"
#define kHaveWithWordBook           @"该生词本已经存在"
#define kHistoryWordBook            @"查词历史"
#define kAddingWordBook             @"正在创建生词本，请稍候"
#define kStringCheckTip             @"生词本名称不允许出现中文 英文 数字  — _ 之外的符号"
#define kCET4WordCount              @"2182"
#define kCET6WordCount              @"3416"
#define kGraduateWordCount          @"5195"
#define kLelts1WordCount            @"3600"
#define kLelts2WordCount            @"3411"
#define kProgressBeginValue         0.01f

#define kAddWordBookOperationQueueName @"com.cactus.newWordBookAdd"

#endif /* BPTopCategoryMacro_h */
