//
//  BPTopCategoryModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BPTopCategoryModel;

@class BPTopCategoryThirdCategoryModel;
@class BPTopCategoryThirdCategoryUpperModel;

typedef NS_ENUM(NSInteger, BPTopCategoryExecuteType) {
    BPTopCategoryExecuteUnKnown,//未添加
    BPTopCategoryExecuteDownLoading,//正在下载文件
    BPTopCategoryExecuteWriteing,//正在写入数据库
    BPTopCategoryExecuteFail,//下载或者写入数据库失败，不分下载文件失败和写入数据库失败，在UI层都是需要显示"添加",需要弹toast提示用户
    BPTopCategoryExecuteSuccuss,//下载并且写入数据库成功，在UI层显示"已添加"
    BPTopCategoryExecuteCancel//取消操作
};

@interface BPTopCategoryModel : NSObject
@end

//生词本权威词典分类第一层模型
@interface BPTopCategoryFirstCategoryModel : NSObject
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *sub;
//以下为自定义的属性
@property (nonatomic, strong) BPTopCategoryThirdCategoryUpperModel *thirdCategoryModel;
@property (nonatomic,assign) NSInteger defaultShowIndex;//默认优先显示的下标
@property (nonatomic,assign) CGFloat tagHeight;//高度
@end

//生词本权威词典分类第二层模型
@interface BPTopCategorySecondCategoryModel : NSObject
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *name;
//以下三个为自定义的属性
@property (nonatomic, strong) BPTopCategoryThirdCategoryUpperModel *thirdCategoryModel;
@property (nonatomic,assign) NSInteger defaultShowIndex;//默认优先显示的下标
@property (nonatomic,assign) BOOL isSelected;//是否被选中
@end

@interface BPTopCategoryThirdCategoryUpperModel : NSObject
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,copy) NSString *msg;
@end

//生词本权威词典分类第三层模型
@interface BPTopCategoryThirdCategoryModel : NSObject
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
@property (nonatomic,assign) BPTopCategoryExecuteType dictionaryExecuteType; //词典下载情况
@end


