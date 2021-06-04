//
//  BPTextMenuView.m
//  BaseProject
//
//  Created by Ryan on 2020/4/1.
//  Copyright © 2020 cactus. All rights reserved.
//

#import "BPTextMenuView.h"

@implementation BPTextMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = UIColor.lightGrayColor;
    self.layoutManager.allowsNonContiguousLayout = YES;
    self.editable = NO;
    self.scrollEnabled = NO;
    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyClick:)];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    [menuController setMenuItems:@[copyItem]];
    menuController.menuVisible = NO;  // default is NO

    if (@available(iOS 13.0, *)) {
//        [menuController showMenuFromView:self.superview rect:CGRectMake(50, 50, 100, 100)];
    } else {
        // Fallback on earlier versions
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyClick:)) {
        [UIMenuController sharedMenuController].menuVisible = YES;
        return YES;
    }
    return NO;
}

- (void)copyClick:(id)sender {
    NSLog(@"复制");
    BPLog(@"%@", self.text);
    BPLog(@"%@", NSStringFromRange(self.selectedRange));
    BPLog(@"%@", NSStringFromRange(self.selectedRange));
    BPLog(@"%@,%d",self.selectedTextRange.start,self.selectedTextRange.end);
}

@end
