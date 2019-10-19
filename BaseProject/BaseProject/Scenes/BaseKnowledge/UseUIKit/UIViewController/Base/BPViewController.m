//
//  BPViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPViewController.h"

@interface BPViewController ()

@end

@implementation BPViewController

//初始化方法--指定初始化方法：调用任何初始化方法 都会执行该方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

//当视图控制器 需要view的时候，该方法调用 创建view并给self.view赋值。
//当我们需要自定义视图控制器的view，我们需要重写loadView方法,进行自定义视图的创建，并给self.view赋值（注意：此时不能调用［super loadView］）。
- (void)loadView {
    // 将视图指定为当前视图控制器的view
    self.view = [[UIView alloc] init];
}

//当loadView执行完，该方法会立即调用，进行视图的布局。
//self.view 是视图控制器的属性  默认会为我们自动创建一个视图 也就是说，视图控制器会自带一个视图 就是self.view.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    BPLog(@"内存警告%s %d",__FUNCTION__,__LINE__);
    //将加载过 并且不在window上显示的视图 进行销毁 回收空间
    if ([self isViewLoaded] && !self.view.window) {
        //销毁
        self.view = nil;
    }
}

@end
