//
//  UIViewController+RecursiveDescription.m
//  HLiPad
//
//  Created by Richard Turton on 07/01/2013.
//
//

#import "UIViewController+BPRecursiveDescription.h"

@implementation UIViewController (BPRecursiveDescription)
/**
 *  @brief  视图层级
 *
 *  @return 视图层级字符串
 */
-(NSString*)bp_recursiveDescription
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
    [self bp_addDescriptionToString:description indentLevel:0];
    return description;
}

-(void)bp_addDescriptionToString:(NSMutableString*)string indentLevel:(NSInteger)indentLevel
{
    NSString *padding = [@"" stringByPaddingToLength:indentLevel withString:@" " startingAtIndex:0];
    [string appendString:padding];
    [string appendFormat:@"%@, %@",[self debugDescription],NSStringFromCGRect(self.view.frame)];

    for (UIViewController *childController in self.childViewControllers)
    {
        [string appendFormat:@"\n%@>",padding];
        [childController bp_addDescriptionToString:string indentLevel:indentLevel + 1];
    }
}

@end
