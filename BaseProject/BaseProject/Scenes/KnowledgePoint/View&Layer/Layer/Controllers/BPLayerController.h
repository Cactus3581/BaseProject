//
//  BPLayerController.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPBaseViewController.h"

@protocol BPLayerControllerDelegate <NSObject>

@optional
-(void) pushViewControllerWithModel;

@end

@interface BPLayerController : BPBaseViewController

@property (nonatomic, weak) id<BPLayerControllerDelegate> delegate;

@end
