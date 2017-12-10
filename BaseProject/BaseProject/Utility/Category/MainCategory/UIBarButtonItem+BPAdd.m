//
//  UIBarButtonItem+BPAdd.m
//  WxSelected
//
//  Created by wazrx on 15/12/20.
//  Copyright © 2015年 wazrx. All rights reserved.
//

#import "UIBarButtonItem+BPAdd.h"
#import "UIControl+BPAdd.h"
#import "NSObject+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UIBarButtonItem_BPAdd)

@interface _BPBarButtonItemTargetObject : NSObject
@property (nonatomic, weak) UIBarButtonItem *item;
@property (nonatomic, copy) void(^clickedConfg)(UIBarButtonItem *item);

@end

@implementation _BPBarButtonItemTargetObject

- (void)_bp_itemClicked{
    if (!_item || !_clickedConfg) {
        return;
    }
    _clickedConfg(_item);
}

@end

@implementation UIBarButtonItem (BPAdd)

+ (UIBarButtonItem *)bp_itemWithTitle:(NSString *)title clickedHandle:(void(^)(UIBarButtonItem *barButtonItem))clickedConfg {
    _BPBarButtonItemTargetObject *target = [_BPBarButtonItemTargetObject new];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:@selector(_bp_itemClicked)];
    target.item = item;
    target.clickedConfg = clickedConfg;
    [item bp_setAssociateValue:target withKey:_cmd];
    return item;
}

+ (UIBarButtonItem *)bp_itemWithImage:(NSString *)image highImage:(NSString *)highImage clickedHandle:(void(^)(UIBarButtonItem *barButtonItem))clickedConfg {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    UIImage *img = [UIImage imageNamed:image];
    [btn setImage:img forState:UIControlStateNormal];
    if (highImage) {
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    // 设置尺寸
    btn.bounds = CGRectMake(0, 0, 21 / img.size.height * img.size.width + 24, 21);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    weakify(item);
    [btn bp_addConfig:^(UIControl *control) {
        strongify(item);
        doBlock(clickedConfg, item);
    } forControlEvents:UIControlEventTouchUpInside];
    return item;
}

@end
