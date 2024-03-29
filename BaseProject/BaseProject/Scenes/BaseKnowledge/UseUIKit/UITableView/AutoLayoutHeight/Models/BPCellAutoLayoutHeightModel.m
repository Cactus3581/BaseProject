//
//  BPCellAutoLayoutHeightModel.m
//  BaseProject
//
//  Created by Ryan on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCellAutoLayoutHeightModel.h"
#import "BPCellAutoLayoutHeightTableViewCell.h"

@implementation BPCellAutoLayoutHeightModel

//手算-3 在model里计算
- (CGFloat)cell3rdHeight {
    if (!_cell3rdHeight) {
        // 文字的最大尺寸(设置内容label的最大size，这样才可以计算label的实际高度，需要设置最大宽度，但是最大高度不需要设置，只需要设置为最大浮点值即可)，53为内容label到cell左边的距离
        CGSize maxSize = CGSizeMake(kScreenWidth - (15+20+15+15), MAXFLOAT);
        // 计算内容label的高度
        CGFloat nameTextH = [self.name heightWithFont:[UIFont systemFontOfSize:17] width:maxSize.width];
        CGFloat textTextH = [self.text heightWithFont:[UIFont systemFontOfSize:17] width:maxSize.width];
        UIImage *image = [UIImage imageNamed:self.photoImage];
        CGFloat imageH = image.size.height;
        _cell3rdHeight = 10 + nameTextH + 10 + textTextH + 10 + imageH + 1 ;
    }
    return _cell3rdHeight;
}

//手算-4 : 在model里计算，利用autolayout layoutIfNeeded获取高度，弊端太多了，高度没有缓存，因为没利用好model的height
+ (CGFloat)height3rdWithModel1:(BPCellAutoLayoutHeightModel *)model {
    BPCellAutoLayoutHeightTableViewCell *cell = [[BPCellAutoLayoutHeightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BPCellAutoLayoutHeightTableViewCell"];
    [cell set3rdModel:model indexPath:nil];
    [cell layoutIfNeeded];
    CGRect frame = cell.contentView.frame;
    return frame.size.height;
}

@end
