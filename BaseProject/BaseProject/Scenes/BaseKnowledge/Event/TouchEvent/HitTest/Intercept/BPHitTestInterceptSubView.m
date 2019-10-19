//
//  BPHitTestInterceptSubView.m
//  BaseProject
//
//  Created by Ryan on 2019/4/23.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHitTestInterceptSubView.h"

@implementation BPHitTestInterceptSubView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"Sub");
    
    // 事件拦截第二种方法：（缺点：你需要重写所有的 touch 方法并且还要重写要拦截事件的 view 与顶级 view 之间的所有 view 的 touch 方法）
    
//    // 将事件传递给下一响应者
//    [self.nextResponder touchesBegan:touches withEvent:event];
//
//    // 调用父类的touch方法 和上面的方法效果一样 这两句只需要其中一句
//    [super touchesBegan:touches withEvent:event];
}

@end
