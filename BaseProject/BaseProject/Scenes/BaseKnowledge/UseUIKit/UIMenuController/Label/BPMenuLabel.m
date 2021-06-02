//
//  BPmenuLabel.m
//  BaseProject
//
//  Created by 夏汝震 on 2020/4/1.
//  Copyright © 2020 cactus. All rights reserved.
//

#import "BPMenuLabel.h"

@implementation BPMenuLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
   if(self){
      [self setUp];
   }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp {
    // 设置label可以交互
    self.userInteractionEnabled = YES;
    // 添加点击手势
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClick)]];
}

- (void)lableClick {
    // 设置label为第一响应者,只有成为响应者才能够将MenuController显示在其上面
    [self becomeFirstResponder];
    // 初始化UIMenuController
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    // 设置菜单内容，显示中文，所以要手动设置app支持中文
    menuController.menuItems = @[
        [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)]
    ];
    // 设置UIMenuController显示的位置
    // targetRect: 将要显示所在label的frame;
    // view: targetRect所在的坐标系参照物(父view或self)
    [menuController setTargetRect:self.frame inView:self.superview];
    //[menuController setTargetRect:self.bounds inView:self];
    // 显示
    [menuController setMenuVisible:YES animated:YES];
}

#pragma mark - UIMenuController相关
//让Label具备成为第一响应者的资格
- (BOOL)canBecomeFirstResponder {
    return YES;
}

//通过第一响应者的这个方法告诉UIMenuController可以显示什么内容
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ( action == @selector(copy:) && self.text)  {
        // 需要有文字才能支持复制
         return YES;
    }
    return NO;
}

#pragma mark - 监听MenuItem的点击事件
- (void)copy:(UIMenuController *)menu {
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
}

@end
