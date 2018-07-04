//
//  BPDownLoadMoreFilesTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPDownLoadMacro.h"
#import "BPAudioModel.h"

@interface BPDownLoadMoreFilesTableViewCell : UITableViewCell

- (void)setItem:(BPAudioModel *)item indexPath:(NSIndexPath *)indexPath;

@end
