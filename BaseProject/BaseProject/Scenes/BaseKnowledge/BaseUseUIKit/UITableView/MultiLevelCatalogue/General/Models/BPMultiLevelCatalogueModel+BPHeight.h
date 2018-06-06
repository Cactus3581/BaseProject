//
//  BPMultiLevelCatalogueModel+BPHeight.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMultiLevelCatalogueModel.h"

@interface BPMultiLevelCatalogueModel (BPCardHeight)

@end

@interface BPMultiLevelCatalogueModel1st (BPCardHeight)
@property (nonatomic, assign) CGFloat headerHeight;
@end

@interface BPMultiLevelCatalogueModel2nd (BPCardHeight)
@property (nonatomic, assign) CGFloat cellHeight;//(section+cell)
@property (nonatomic, assign) CGFloat headerHeight;
@end

@interface BPMultiLevelCatalogueModel3rd (BPCardHeight)
@property (nonatomic, assign) CGFloat cellHeight;
@end
