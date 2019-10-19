//
//  BPStatisticsLogView.m
//  BaseProject
//
//  Created by Ryan on 2018/8/2.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPStatisticsLogView.h"
#import "BPAppDelegate.h"

@interface BPStatisticsLogView()
@property (weak, nonatomic) IBOutlet UIView *bottomBackView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanTextButton;
@property (weak, nonatomic) IBOutlet UIView *hLineView;
@property (weak, nonatomic) IBOutlet UIView *vLineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) UIWindow *window;
@end

@implementation BPStatisticsLogView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bounds = CGRectMake(0, 0, 250, 400);
    BPAppDelegate *delegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
    self.window = delegate.window;
    self.center = self.window.center;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.textView.backgroundColor = kClearColor;
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    self.textView.editable = NO;
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewMoved:)]];
}

- (void)setLogText:(NSString *)text {
    self.hidden = NO;
    if (!BPValidateString(text).length) {
        return;
    }
    
    if (!self.textView.text.length) {
        self.textView.text = text;
    }else {
        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"\n\n%@",text]];
    }
    [self.textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
}

- (IBAction)cleanAction:(id)sender {
    self.textView.text = kPlacedString;
}

- (IBAction)removeSelfAction:(id)sender {
    self.hidden = YES;
}

- (void)dragViewMoved:(UIPanGestureRecognizer *)rec {
    CGPoint point = [rec translationInView:self.window];
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    [rec setTranslation:CGPointMake(0, 0) inView:self.window];
}

@end
