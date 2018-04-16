//
//  KSMultiLevelCatalogueModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSMultiLevelCatalogueModel : NSObject
@property (nonatomic, strong) NSArray *array;
@end

@interface KSMultiLevelCatalogueModel1st : NSObject //最外层的cell，tableview
@property (nonatomic, strong) NSString *title_1st;
@property (nonatomic, strong) NSArray *array_1st;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat headerHeight;
@end

@interface KSMultiLevelCatalogueModel2nd : NSObject//里层的header+cell
@property (nonatomic, strong) NSString *title_2nd;
@property (nonatomic, strong) NSString *brief_2nd;
@property (nonatomic, strong) NSArray *array_2nd;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@interface KSMultiLevelCatalogueModel3rd : NSObject//里层的cell
@property (nonatomic, strong) NSString *title_3rd;
@property (nonatomic, strong) NSString *brief_3rd;
@property (nonatomic, assign) CGFloat cellHeight;
@end
