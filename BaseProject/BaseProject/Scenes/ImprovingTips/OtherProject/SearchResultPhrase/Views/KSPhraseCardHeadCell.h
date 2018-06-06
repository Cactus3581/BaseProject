//
//  KSPhraseCardHeadCell.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSDictionaryPhrase.h"

@interface KSPhraseCardHeadCell : UITableViewCell
@property (weak, nonatomic)  UITableView *tableView;

@property (nonatomic,strong) NSArray *wordExchangeArray;
- (void)setModel:(KSDictionarySubItemPhraseJx *)model indexPath:(NSIndexPath *)indexPath showAll:(BOOL)showAll;
@end
