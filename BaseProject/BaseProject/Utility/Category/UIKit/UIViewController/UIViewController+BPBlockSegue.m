//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIViewController+BPBlockSegue.h"
#import <objc/runtime.h>

static const void *UIViewControllerDictionaryBlockKey = &UIViewControllerDictionaryBlockKey;

@implementation UIViewController (BPBlockSegue)

__attribute__((constructor))
void BPBlockSegue(void) {
    Class currentClass = [UIViewController class];

    SEL originalSel = @selector(prepareForSegue:sender:);
    SEL swizzledSel = @selector(bp_prepareForSegue:sender:);

    Method originalMethod = class_getInstanceMethod(currentClass, originalSel);
    IMP swizzledImplementation = class_getMethodImplementation(currentClass, swizzledSel);

    method_setImplementation(originalMethod, swizzledImplementation);
}


-(void)bp_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (segue.identifier == nil) {
        return;
    }

    if (!self.jmg_dictionaryBlock || !self.jmg_dictionaryBlock[segue.identifier]) {
        BPLog(@"Segue identifier '%@' doesn't exist", segue.identifier);
        return;
    }

    UIViewControllerBPSegueBlock segueBlock = self.jmg_dictionaryBlock[segue.identifier];
    segueBlock(sender, segue.destinationViewController, segue);
}

-(NSMutableDictionary *)jmg_dictionaryBlock {
    return objc_getAssociatedObject(self, UIViewControllerDictionaryBlockKey);
}

-(NSMutableDictionary *)jmg_createDictionaryBlock {
    if (!self.jmg_dictionaryBlock) {
        objc_setAssociatedObject(self, UIViewControllerDictionaryBlockKey, [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN);
    }

    return self.jmg_dictionaryBlock;
}

#pragma mark - Public interface
-(void)bp_configureSegue:(NSString *)identifier withBlock:(UIViewControllerBPSegueBlock)block {
    if (!identifier) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Segue identifier can not be nil" userInfo:nil];
    }

    if (!block) {
        return ;
    }

    NSMutableDictionary *dBlocks = self.jmg_dictionaryBlock ?: [self jmg_createDictionaryBlock];
    [dBlocks setObject:block forKey:identifier];
}

-(void)bp_performSegueWithIdentifier:(NSString *)identifier sender:(id)sender withBlock:(UIViewControllerBPSegueBlock)block {
    if (!identifier) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Segue identifier can not be nil" userInfo:nil];
    }

    if (!block) {
        return ;
    }

    [self bp_configureSegue:identifier withBlock:block];
    [self performSegueWithIdentifier:identifier sender:sender];
}

@end
