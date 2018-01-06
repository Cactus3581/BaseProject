//
//  Sub_B_ViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPBaseViewController.h"

@protocol Sub_B_ViewControllerDelegate <NSObject>
@optional

-(void) pushViewControllerWithModel;
@end

@interface Sub_B_ViewController : BPBaseViewController
@property (nonatomic,strong) NSString *titleName;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic, weak) id<Sub_B_ViewControllerDelegate> delegate;

@end
