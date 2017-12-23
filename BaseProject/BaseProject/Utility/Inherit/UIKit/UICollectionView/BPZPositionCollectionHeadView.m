//
//  BPZPositionCollectionHeadView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/10/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPZPositionCollectionHeadView.h"

//iOS11下，sectionView的zPosition被collectionview重新设置。确保zPosition值为0。

#ifdef __IPHONE_11_0
@implementation HeadViewLayer
- (CGFloat) zPosition {
    return 0;
}
@end
#endif


@implementation BPZPositionCollectionHeadView

#ifdef __IPHONE_11_0
+ (Class)layerClass {
    return [HeadViewLayer class];
}
#endif

@end
