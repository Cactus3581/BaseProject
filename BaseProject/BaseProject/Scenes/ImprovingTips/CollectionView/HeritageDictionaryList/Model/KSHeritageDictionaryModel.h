//
//  KSHeritageDictionaryModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSHeritageDictionaryModel.h"

@class KSWordBookAuthorityDictionaryThirdCategoryModel;
@class KSWordBookAuthorityDictionaryThirdCategoryUpperModel;

typedef NS_ENUM(NSInteger, HeritageDictionaryExecuteType) {
    HeritageDictionaryExecuteUnKnown,//未添加
    HeritageDictionaryExecuteDownLoading,//正在下载文件
    HeritageDictionaryExecuteWriteing,//正在写入数据库
    HeritageDictionaryExecuteFail,//下载或者写入数据库失败，不分下载文件失败和写入数据库失败，在UI层都是需要显示"添加",需要弹toast提示用户
    HeritageDictionaryExecuteSuccuss,//下载并且写入数据库成功，在UI层显示"已添加"
    HeritageDictionaryExecuteCancel//取消操作
};

//生词本权威词典分类第一层模型
@interface KSWordBookAuthorityDictionaryFirstCategoryModel : NSObject
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *sub;
//以下为自定义的属性
@property (nonatomic, strong) KSWordBookAuthorityDictionaryThirdCategoryUpperModel *thirdCategoryModel;
@property (nonatomic,assign) NSInteger defaultShowIndex;//默认优先显示的下标
@property (nonatomic,assign) CGFloat tagHeight;//高度
@end

//生词本权威词典分类第二层模型
@interface KSWordBookAuthorityDictionarySecondCategoryModel : NSObject
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *name;
//以下三个为自定义的属性
@property (nonatomic, strong) KSWordBookAuthorityDictionaryThirdCategoryUpperModel *thirdCategoryModel;
@property (nonatomic,assign) NSInteger defaultShowIndex;//默认优先显示的下标
@property (nonatomic,assign) BOOL isSelected;//是否被选中
@end

@interface KSWordBookAuthorityDictionaryThirdCategoryUpperModel : NSObject
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,copy) NSString *msg;
@end

//生词本权威词典分类第三层模型
@interface KSWordBookAuthorityDictionaryThirdCategoryModel : NSObject
@property (nonatomic,strong) NSNumber *classId;
@property (nonatomic,strong) NSNumber *pId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *bigImage;
@property (nonatomic,copy) NSString *downLoadUrl;
@property (nonatomic,strong) NSNumber *wordCount;
@property (nonatomic,strong) NSNumber *joinCount;
//以下两个为自己的定义的属性
@property (nonatomic,copy) NSString *path;//本地文件路径
@property (nonatomic,assign) CGFloat downLoadProgress;//下载文件进度
@property (nonatomic,assign) CGFloat writeDBProgress;//写数据库进度
@property (nonatomic,assign) HeritageDictionaryExecuteType dictionaryExecuteType; //词典下载情况
@end

@interface KSHeritageDictionaryModel : NSObject
@end
