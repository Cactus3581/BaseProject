//
//  KSSlideCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/5/19.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSSlideCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) NSString *nameText;
@property (nonatomic,assign) NSInteger selectedColor;
@property (nonatomic,assign) NSInteger unselectedColor;
@property (nonatomic,assign) NSInteger cornus;
@property (nonatomic,assign) NSInteger labelFont;
@property (nonatomic,assign) BOOL isSelected;


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView Identifier:(NSString *)identifier IndexPath:(NSIndexPath *)indexPath SelectedColor:(NSInteger)selectedColor UnselectedColor:(NSInteger)unselectedColor Cornus:(NSInteger)cornus LabelFont:(NSInteger)labelFont;
@end
