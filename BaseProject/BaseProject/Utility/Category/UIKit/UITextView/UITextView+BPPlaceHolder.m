//
//  UITextView+PlaceHolder.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UITextView+BPPlaceHolder.h"
static const char *bp_placeHolderTextView = "bp_placeHolderTextView";

@implementation UITextView (BPPlaceHolder)
- (UITextView *)bp_placeHolderTextView {
    return objc_getAssociatedObject(self, bp_placeHolderTextView);
}
- (void)setBp_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, bp_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)bp_addPlaceHolder:(NSString *)placeHolder {
    if (![self bp_placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = kClearColor;
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setBp_placeHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];

    }
    self.bp_placeHolderTextView.text = placeHolder;
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.bp_placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.bp_placeHolderTextView.hidden = NO;
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
