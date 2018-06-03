//
//  KSPhraseCardHeaderView.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSDictionaryPhrase.h"

@interface KSPhraseCardHeaderView : UITableViewHeaderFooterView
- (void)setModel:(KSDictionarySubItemPhrase *)model section:(NSInteger)indexPath;
@end
