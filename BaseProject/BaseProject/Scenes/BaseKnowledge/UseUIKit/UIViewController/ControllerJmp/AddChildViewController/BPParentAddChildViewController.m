//
//  BPParentAddChildViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPParentAddChildViewController.h"
#import "BPSubAddChildViewController.h"

@interface BPParentAddChildViewController ()
@property (nonatomic,strong) BPSubAddChildViewController *subVc;
@property (nonatomic,strong) NSMutableArray *array;
@end

@implementation BPParentAddChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"add";
    
    BPSubAddChildViewController *vc = [[BPSubAddChildViewController alloc] init];
    _subVc = vc;
    
    // 先添加子控制器，然后才能添加view
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    //    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.view).offset(200);
    //        make.leading.trailing.bottom.equalTo(self.view);
    //    }];
    
    vc.view.frame = CGRectMake(0, 200, self.view.bounds.size.width, 200);
    vc.view.backgroundColor = kExplicitColor;
    [vc didMoveToParentViewController:self];
    [self.array addObject:self.subVc];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self didClickHeadButtonAction:nil];
}

- (void)didClickHeadButtonAction:(UIButton *)button {
    BPSubAddChildViewController *vc1 = [[BPSubAddChildViewController alloc] init];
    vc1.view.backgroundColor = kRandomColor;
    [self replaceController:self.array.lastObject willDisplayController:vc1];
    [self.array addObject:vc1];
}

//切换各个标签内容
- (void)replaceController:(UIViewController *)oldVC willDisplayController:(UIViewController *)newVC {
    /**
     *着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    newVC.view.frame = CGRectMake(self.view.bounds.size.width, 200, self.view.bounds.size.width, 200);
    
    [self addChildViewController:newVC];
    
    [self transitionFromViewController:oldVC toViewController:newVC duration:0.25 options:UIViewAnimationOptionLayoutSubviews animations:^{
        newVC.view.frame = CGRectMake(0, 200, self.view.bounds.size.width, 200);
        oldVC.view.frame = CGRectMake(-self.view.bounds.size.width, 200, self.view.bounds.size.width, 200);
    } completion:^(BOOL finished) {
        if (finished) {
            [newVC didMoveToParentViewController:self];
            [oldVC willMoveToParentViewController:nil];
            [oldVC removeFromParentViewController];
            [oldVC.view removeFromSuperview];
        }
    }];
}

#pragma mark - 正常使用
- (void)addChildVC {
    BPSubAddChildViewController *vc = [[BPSubAddChildViewController alloc] init];
    _subVc = vc;
    
    //[vc willMoveToParentViewController:self]; //不需要写：调用addChildViewController方法系统会自动调用willMoveToParentViewController:方法。
    [self addChildViewController:vc];//addChildViewController:的同时调用addSubView：
    [self.view addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 300, 1, 1);
    [vc didMoveToParentViewController:self];//最后通知child，完成了父子关系的建立。
}

//移除子视图
- (void)removeChildVC {
    [_subVc willMoveToParentViewController:nil];//需要显示调用：通知child，即将解除父子关系，设置 child的parent即将为nil。
    [_subVc.view removeFromSuperview];
    [_subVc removeFromParentViewController];
    //[_subVc didMoveToParentViewController:nil];//不需要显示调用
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
