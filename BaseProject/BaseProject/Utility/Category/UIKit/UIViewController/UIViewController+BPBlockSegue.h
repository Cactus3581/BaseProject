//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIViewControllerBPSegueBlock) (id sender, id destinationVC, UIStoryboardSegue *segue);

@interface UIViewController (BPBlockSegue)

- (void)bp_configureSegue:(NSString *)identifier withBlock:(UIViewControllerBPSegueBlock)block;
- (void)bp_performSegueWithIdentifier:(NSString *)identifier sender:(id)sender withBlock:(UIViewControllerBPSegueBlock)block;

@end
