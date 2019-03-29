//
//  BPMasonryAutoLayoutProcessViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"

@interface BPMasonryAutoLayoutProcessViewController : BPBaseViewController

/*
 
 执行顺序：

 viewDidLoad
 initWithFrame
 
 viewWillAppear
 
 updateConstraints //其从下向上(from subview to super view),为下一步layout准备信息
 
 updateViewConstraints
 viewWillLayoutSubviews
 viewDidLayoutSubviews
 
 layoutSubviews //其从上向下(from super view to subview)，此步主要应用上一步(updateConstraints)的信息去设置view的center和bounds
 drawRect
 
 viewDidAppear

 */

@end
