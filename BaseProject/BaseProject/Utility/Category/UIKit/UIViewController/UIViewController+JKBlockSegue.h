//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

//https://github.com/patoroco/UIViewController-BlockSegue

#import <UIKit/UIKit.h>

typedef void (^UIViewControllerJKSegueBlock) (id sender, id destinationVC, UIStoryboardSegue *segue);

@interface UIViewController (JKBlockSegue)

-(void)bp_configureSegue:(NSString *)identifier withBlock:(UIViewControllerJKSegueBlock)block;
-(void)bp_performSegueWithIdentifier:(NSString *)identifier sender:(id)sender withBlock:(UIViewControllerJKSegueBlock)block;

@end
