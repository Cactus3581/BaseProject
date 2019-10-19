//
//  BPTableViewCell.h
//  BaseProject
//
//  Created by Ryan on 2018/5/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

- (void)setText:(NSString *)text indexPath:(NSIndexPath *)indexPath;

@end
