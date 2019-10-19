//
//  BPTransformViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTransformViewController.h"

@interface BPTransformViewController ()
@property (weak, nonatomic) IBOutlet UIView *TemplateView;
@property (weak, nonatomic) IBOutlet UIView *templateView2;

@end

@implementation BPTransformViewController

/*
当一个view的transform被更改了，即不为CGAffineTransformIdentity。

frame属性可能会更改，view的bounds，center不会变，layer的position不会变。这个很重要，这样保持了在transform后，view的frame虽然改变了，但是内部参考系是不变的，可以继续进行其他变换，只要不更改frame或center或layer的position。
 
 视图的frame没有和约束条件同步，也将导致怪异的行为。

*/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"transform";
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    BPLog(@"%@",NSStringFromCGRect(self.TemplateView.frame));
    BPLog(@"%@",NSStringFromCGRect(self.templateView2.frame));
    BPLog(@"%@",NSStringFromCGRect(self.TemplateView.bounds));
    BPLog(@"%@",NSStringFromCGRect(self.templateView2.bounds));
    [UIView animateWithDuration:1 animations:^{
        self.TemplateView.transform = CGAffineTransformMakeScale(.5, .5);
    }];
    [UIView animateWithDuration:1 animations:^{
        self.templateView2.transform = CGAffineTransformMakeScale(.5, .5);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
