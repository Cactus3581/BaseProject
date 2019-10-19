//
//  BPTableViewModel.h
//  BaseProject
//
//  Created by Ryan on 2019/8/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPTableViewModel : NSObject

@property (copy, nonatomic) NSString *sectionHeaderText;
@property (copy, nonatomic) NSString *sectionFooterText;
@property (copy, nonatomic) NSString *indexName;

@property (strong, nonatomic) NSMutableArray *array;
@property (assign, nonatomic) BOOL isSelected;

@end


@interface BPTableViewItemModel : NSObject

@property (copy, nonatomic) NSString *text;
@property (assign, nonatomic) BOOL isSelected;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *imagrUrl;

@end

NS_ASSUME_NONNULL_END
