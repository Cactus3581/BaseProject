//
//  BPSizeViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/8/20.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSizeViewController.h"

@interface BPSizeViewController()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation BPSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *text = nil;
    NSAttributedString *arrText = nil;
    
    _label.text = text;
    _label.preferredMaxLayoutWidth = 0;
    
    _textView.text = text;
    _imageView.image = [UIImage imageNamed:@""];
    
    CGFloat height1 = [_label sizeThatFits:CGSizeMake(0, 0)].height;
    CGFloat height2 = [_textView sizeThatFits:CGSizeMake(0, 0)].height;
    CGFloat height3 = [_imageView sizeThatFits:CGSizeMake(0, 0)].height;
    
    
    CGFloat height4 = [_label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGFloat height5 = [_textView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGFloat height6 = [_imageView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    CGFloat height7 = [_label intrinsicContentSize].height;
    CGFloat height8 = [_textView intrinsicContentSize].height;
    CGFloat height9 = [_imageView intrinsicContentSize].height;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSParagraphStyleAttributeName: paragraph
                                 };
    
    CGFloat height10 = [text boundingRectWithSize:CGSizeMake(0, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size.height;
    
    
}

@end
