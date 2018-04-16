//
//  BPTextCompositionViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/10.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTextCompositionViewController.h"

@interface BPTextCompositionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation BPTextCompositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *str = @"在北京时间3 月 10 日凌晨的苹果发布活动上，HBO 宣布推出与苹果独家合作的 HBO Now 服务，并播出了万众期待的第五季《权力的游戏》预告片。\n2015年3月11日，HBO 正式宣布了《权力的游戏》第五季将在全球同步播出的决定，通过 HBO 旗下的全球各个电视网播出，该剧首播将在美国东部时间 4 月 12 日晚 9 点（北京时间 4 月13 日早 9 点）进行，包括 HBO 亚洲，HBO 加拿大，HBO 欧洲，HBO 拉美，HBO 荷兰，HBO 北欧各个电视网将于同一时间播出。\n2015年3月11日，HBO 正式宣布了《权力的游戏》第五季将在全球同步播出的决定，通过 HBO 旗下的全球各个电视网播出，该剧首播将在美国东部时间 4 月 12 日晚 9 点（北京时间 4 月13 日早 9 点）进行，包括 HBO 亚洲，HBO 加拿大，HBO 欧洲，HBO 拉美，HBO 荷兰，HBO 北欧各个电视网将于同一时间播出。";
    _textLabel.numberOfLines = 0;
    _textLabel.attributedText = [self configText:str];
}

- (NSMutableAttributedString *)configText:(NSString *)str {
    NSMutableAttributedString *testStr = [[NSMutableAttributedString alloc] initWithString:str];
    //1，设置指定范围内的 字体大小
    [testStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(5, 30)];
    //2，设置指定范围内 字体颜色
    [testStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 10)];
    //3，设置字体所在区域的背景颜色
    [testStr addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(40, 30)];
    //4，设置连体属性，取值为NSNumber 对象(整数)
    [testStr addAttribute:NSLigatureAttributeName value:@1 range:NSMakeRange(40, 30)];
    //5，设置指定范围内  字符间距
    [testStr addAttribute:NSKernAttributeName value:@10 range:NSMakeRange(70, 30)];
    //6，设置删除线
    [testStr addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(120, 20)];
    //7，设置删除线的颜色
    [testStr addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(120, 10)];
    //8，设置下划线
    [testStr addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(140, 20)];
    //9，设置下划线颜色
    [testStr addAttribute:NSUnderlineColorAttributeName value:[UIColor greenColor] range:NSMakeRange(140, 10)];
    //10，设置字体倾斜度，负值向左，正值向右
    [testStr addAttribute:NSObliquenessAttributeName value:@-0.5 range:NSMakeRange(160, 30)];
    //11，设置字体拉伸压缩，正值拉伸，负值压缩
    [testStr addAttribute:NSExpansionAttributeName value:@-0.5 range:NSMakeRange(190, 20)];
    // 设置文字书写方向，从左向右书写或者从右向左书写
    //    [testStr addAttribute:NSWritingDirectionAttributeName value:@1 range:NSMakeRange(220, 20)];
    //12，设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
    [testStr addAttribute:NSVerticalGlyphFormAttributeName value:@1 range:NSMakeRange(0, testStr.length)];
    //13，设置链接属性，点击后调用浏览器打开指定URL地址
    [testStr addAttribute:NSLinkAttributeName value:@"http://baidu.com" range:NSMakeRange(220, 20)];
    //14，设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
    [testStr addAttribute:NSStrokeWidthAttributeName value:@0.5 range:NSMakeRange(240, 30)];
    //15，填充部分颜色，不是字体颜色，取值为 UIColor 对象
    [testStr addAttribute:NSStrokeColorAttributeName value:[UIColor blueColor] range:NSMakeRange(240, 30)];
    //16,设置阴影属性，取值为 NSShadow 对象
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor redColor]; //设置阴影的颜色
    shadow.shadowOffset = CGSizeMake(2, 1);//设置阴影的偏移方向，x：左右，负左正右；y：上下，负上正下
    shadow.shadowBlurRadius = 5;
    [testStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(270, 30)];
    //17,设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
    [testStr addAttribute:NSBaselineOffsetAttributeName value:@10 range:NSMakeRange(300, 30)];
    
    //18,设置文本段落排版格式，取值为 NSParagraphStyle 对象
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;//1,设置行间距
    paragraph.paragraphSpacing = 10; //2,设置段间距
    paragraph.alignment = NSTextAlignmentLeft;//3,设置对齐方式
    paragraph.firstLineHeadIndent = 50;//4,首行缩进距离
    paragraph.headIndent = 10;//5，除首行之外其他行缩进
    paragraph.tailIndent = 1000;//6,每行容纳字符的宽度
    paragraph.minimumLineHeight = 0;//7,每行最小高度
    paragraph.maximumLineHeight = 100;//8,每行最大高度
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;//9,换行方式
    //lineBreakMode 属性的可选项
    {
//    NSLineBreakByWordWrapping = 0,        // Wrap at word boundaries, default */
//    NSLineBreakByCharWrapping,        /* Wrap at character boundaries */
//    NSLineBreakByClipping,        /* Simply clip */
//    NSLineBreakByTruncatingHead,  /* Truncate at head of line: "...wxyz" */
//    NSLineBreakByTruncatingTail,  /* Truncate at tail of line: "abcd..." */
//    NSLineBreakByTruncatingMiddle /* Truncate middle of line:  "ab...yz" */
    }
//    [testStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(70, 30)];
    [testStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, str.length)];
    return testStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
