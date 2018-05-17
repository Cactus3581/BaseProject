//
//  DHSlideTabbarProtocol.h
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/14.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHSlideTabbarDelegate <NSObject>

- (void)DHSlideTabbar:(id)slideTabbar selectAtIndex:(NSInteger)index;

@end

@protocol DHSlideTabbarProtocol <NSObject>

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<DHSlideTabbarDelegate> delegate;
@property(nonatomic, getter=isDivideEqually) BOOL divideEqually;

- (void)switchFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex percent:(float)percent;

@end