//
//  BPPopCollectionViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BPPopCollectionViewCellDelegate <NSObject>
@optional
- (void)nextAction:(id)cell;
@end

@interface BPPopCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic)  UIButton *button;
@property (nonatomic, weak) id<BPPopCollectionViewCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *path;
@end
