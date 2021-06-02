//
//  BPMenuController.m
//  BaseProject
//
//  Created by 夏汝震 on 2020/4/1.
//  Copyright © 2020 cactus. All rights reserved.
//

#import "BPTextViewMenuController.h"

@interface BPTextViewMenuController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end


@implementation BPTextViewMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"白日依山尽，www.baidu.com"];
    self.textView.attributedText = str.copy;
//    self.textView.backgroundColor = UIColor.lightGrayColor;
//    self.textView.layoutManager.allowsNonContiguousLayout = NO;
//    self.textView.editable = NO;
//    self.textView.scrollEnabled = NO;
//    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyClick:)];
//    UIMenuController *menuController = [UIMenuController sharedMenuController];
//    [menuController setMenuItems:@[copyItem]];
}

//- (BOOL)canBecomeFirstResponder {
//    return YES;
//}
//
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    if (action == @selector(copyClick:)) {
//        return YES;
//    }
//    return NO;
//}
//
//- (void)copyClick:(id)sender {
//    NSLog(@"复制");
//}


@end

