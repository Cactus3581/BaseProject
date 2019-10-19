//
//  BPTouchViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTouchViewController.h"

@interface BPTouchViewController ()

@end

@implementation BPTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - UIEvent

/*
UIView是UIResponder的子类，可以覆盖下列4个方法处理不同的触摸事件.提示：touches中存放的都是UITouch对象
 */

// 一根或者多根手指开始触摸view，系统会自动调用view的下面方法,
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     BPLog(@"touchesBegan");
 }

//一根或者多根手指在view上移动，系统会自动调用view的下面方法（随着手指的移动，会持续调用该方法）
 - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
     BPLog(@"touchesMoved");
 }

//一根或者多根手指离开view，系统会自动调用view的下面方法
 - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
     BPLog(@"touchesEnded");
 }

//触摸结束前，某个系统事件(例如电话呼入)会打断触摸过程，系统会自动调用view的下面方法
 - (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
     BPLog(@"touchesCancelled");
 }

#pragma mark - 事件响应方法
// 寻找处理事件最合适的View
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    return [self hitTest:point withEvent:event];
//}
//
//// 判断触摸点是否在自己身上
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return [self pointInside:point withEvent:event];
//}

#pragma mark - UITouch的方法
// 返回值表示触摸在view上的位置
// 这里返回的位置是针对view的坐标系的（以view的左上角为原点(0, 0)）
// 调用时传入的view参数为nil的话，返回的是触摸点在UIWindow的位置
//- (CGPoint)locationInView:(UIView *)view {
//    return [self locationInView:view];
//}
//
//// 该方法记录了前一个触摸点的位置
//- (CGPoint)previousLocationInView:(UIView *)view {
//    return [self previousLocationInView:view];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
