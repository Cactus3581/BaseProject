//
//  BPAsyncDrawTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/3.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SIZE_GAP_LEFT 15
#define SIZE_GAP_TOP 13
#define SIZE_AVATAR 40
#define SIZE_GAP_BIG 10
#define SIZE_GAP_IMG 5
#define SIZE_GAP_SMALL 5
#define SIZE_IMAGE 80
#define SIZE_FONT 17
#define SIZE_FONT_NAME (SIZE_FONT-3)
#define SIZE_FONT_SUBTITLE (SIZE_FONT-8)
#define FontWithSize(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]
#define SIZE_FONT_CONTENT 17
#define SIZE_FONT_SUBCONTENT (SIZE_FONT_CONTENT-1)


NS_ASSUME_NONNULL_BEGIN

@interface BPAsyncDrawTableViewCell : UITableViewCell

@property (nonatomic, weak) NSDictionary *data;

- (void)draw;
- (void)clear;
- (void)releaseMemory;

@end

NS_ASSUME_NONNULL_END
