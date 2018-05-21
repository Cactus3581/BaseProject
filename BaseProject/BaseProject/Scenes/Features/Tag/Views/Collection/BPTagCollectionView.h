//
//  BPTagCollectionView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BPTagCollectionView;

@protocol BPTagCollectionViewDelegate<NSObject>
@optional
- (void)getHeight:(CGFloat)height;
- (void)tagCollectionView:(BPTagCollectionView *)tagCollectionView didSelectRowAtIndex:(NSInteger)index;
@end

@interface BPTagCollectionView : UIView
@property(nonatomic,weak) id<BPTagCollectionViewDelegate> delegate;
@property (nonatomic,strong) NSArray <NSString *>*titlesArray;
@property (nonatomic,assign,readonly,getter = getHeight) CGFloat cardHeight;
@end
