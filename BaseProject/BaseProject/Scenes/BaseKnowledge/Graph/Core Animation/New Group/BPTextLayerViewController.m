//
//  BPTextLayerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/9/14.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPTextLayerViewController.h"

@interface BPTextLayerViewController ()

@end

@implementation BPTextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATextLayer *textLayer =[CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale; // 注意，这个不能忘
    textLayer.string = @"CATextLayer 测试一下";
    textLayer.bounds = CGRectMake(0, 0, 300, 20);
    textLayer.fontSize = 14.f; //字体的大小
    textLayer.font = (__bridge CFTypeRef _Nullable)(@"HelveticaNeue-BoldItalic"); //字体的名字 不是 UIFont
    textLayer.alignmentMode = kCAAlignmentCenter; //字体的对齐方式
    textLayer.position = CGPointMake(100, 100);
    textLayer.foregroundColor =[UIColor redColor].CGColor; //字体的颜色
    [self.view.layer addSublayer:textLayer];
}

@end
