//
//  BPMultiLevelCatalogueModel.h
//  BaseProject
//
//  Created by Ryan on 2018/4/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BPMultiLevelCatalogueModel : NSObject
@property (nonatomic, strong) NSArray *array;
@end

@interface BPMultiLevelCatalogueModel1st : NSObject //最外层的cell，tableview
@property (nonatomic, strong) NSString *title_1st;
@property (nonatomic, strong) NSArray *array_1st;
@end

@interface BPMultiLevelCatalogueModel2nd : NSObject//里层的header+cell
@property (nonatomic, strong) NSString *title_2nd;
@property (nonatomic, strong) NSArray *array_2nd;
@end

@interface BPMultiLevelCatalogueModel3rd : NSObject//里层的cell
@property (nonatomic, strong) NSString *title_3rd;
@property (nonatomic, strong) NSString *brief_3rd;
@end
