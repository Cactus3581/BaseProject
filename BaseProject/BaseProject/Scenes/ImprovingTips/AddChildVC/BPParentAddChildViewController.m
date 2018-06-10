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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"add" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(44));
    }];
    
    BPSubAddChildViewController *vc = [[BPSubAddChildViewController alloc] init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
//    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(200);
//        make.leading.trailing.bottom.equalTo(self.view);
//    }];
    vc.view.frame = CGRectMake(0, 200, self.view.bounds.size.width, 200);

    vc.view.backgroundColor = kGreenColor;

    self.subVc = vc;
    [self.array addObject:self.subVc];
}

- (void)test {
    //使用addChildViewController的三个步骤
    
    //1.addChildViewController:的同时调用addSubView：
    BPSubAddChildViewController *vc = [[BPSubAddChildViewController alloc] init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
 
    //2.设置子视图的位置，并显示出来
    vc.view.frame = CGRectMake(0, 300, 1, 1);
    [vc didMoveToParentViewController:self];

    //3.移除子视图
    [vc willMoveToParentViewController:nil];
    [vc removeFromParentViewController];
    [vc.view removeFromSuperview];
}

- (void)didClickHeadButtonAction:(UIButton *)button {
    BPSubAddChildViewController *vc1 = [[BPSubAddChildViewController alloc] init];
    vc1.view.backgroundColor = kRandomColor;
    
    [self replaceController:self.array.lastObject willDisplayController:vc1];
    [self.array addObject:vc1];
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
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
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
