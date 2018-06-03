//
//  KSPhraseCardInsideTableViewCell.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSDictionaryPhrase.h"
#import "KSDictionaryPhrase.h"

@interface KSPhraseCardInsideTableViewCell : UITableViewCell
@property (nonatomic,strong) NSArray *wordExchangeArray;
- (void)setModel:(KSDictionarySubItemPhraseJxLj *)model indexPath:(NSIndexPath *)indexPath;

@end
