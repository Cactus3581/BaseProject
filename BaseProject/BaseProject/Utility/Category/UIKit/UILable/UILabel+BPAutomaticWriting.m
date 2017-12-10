//
//  UILabel+AutomaticWriting.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UILabel+BPAutomaticWriting.h"
#import <objc/runtime.h>

NSTimeInterval const UILabelAWDefaultDuration = 0.4f;

unichar const UILabelAWDefaultCharacter = 124;

static inline void bp_AutomaticWritingSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static char kAutomaticWritingOperationQueueKey;
static char kAutomaticWritingEdgeInsetsKey;


@implementation UILabel (BPAutomaticWriting)

@dynamic bp_automaticWritingOperationQueue, bp_edgeInsets;

#pragma mark - Public Methods

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bp_AutomaticWritingSwizzleSelector([self class], @selector(textRectForBounds:limitedToNumberOfLines:), @selector(bp_automaticWritingTextRectForBounds:limitedToNumberOfLines:));
        bp_AutomaticWritingSwizzleSelector([self class], @selector(drawTextInRect:), @selector(bp_drawAutomaticWritingTextInRect:));
    });
}

-(void)bp_drawAutomaticWritingTextInRect:(CGRect)rect
{
    [self bp_drawAutomaticWritingTextInRect:UIEdgeInsetsInsetRect(rect, self.bp_edgeInsets)];
}

- (CGRect)bp_automaticWritingTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [self bp_automaticWritingTextRectForBounds:UIEdgeInsetsInsetRect(bounds, self.bp_edgeInsets) limitedToNumberOfLines:numberOfLines];
    return textRect;
}

- (void)setBp_edgeInsets:(UIEdgeInsets)edgeInsets
{
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, [NSValue valueWithUIEdgeInsets:edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)bp_edgeInsets
{
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey);
    
    if (edgeInsetsValue)
    {
        return edgeInsetsValue.UIEdgeInsetsValue;
    }
    
    edgeInsetsValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
    
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, edgeInsetsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return edgeInsetsValue.UIEdgeInsetsValue;
}

- (void)setBp_automaticWritingOperationQueue:(NSOperationQueue *)automaticWritingOperationQueue
{
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, automaticWritingOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)bp_automaticWritingOperationQueue
{
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, &kAutomaticWritingOperationQueueKey);
    
    if (operationQueue)
    {
        return operationQueue;
    }
    
    operationQueue = NSOperationQueue.new;
    operationQueue.name = @"Automatic Writing Operation Queue";
    operationQueue.maxConcurrentOperationCount = 1;
    
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return operationQueue;
}

- (void)bp_setTextWithAutomaticWritingAnimation:(NSString *)text
{
    [self bp_setText:text automaticWritingAnimationWithBlinkingMode:UILabelBPlinkingModeNone];
}

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelBPlinkingMode)blinkingMode
{
    [self bp_setText:text automaticWritingAnimationWithDuration:UILabelAWDefaultDuration blinkingMode:blinkingMode];
}

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration
{
    [self bp_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:UILabelBPlinkingModeNone];
}

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelBPlinkingMode)blinkingMode
{
    [self bp_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:UILabelAWDefaultCharacter];
}

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelBPlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter
{
    [self bp_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:blinkingCharacter completion:nil];
}

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelBPlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion
{
    self.bp_automaticWritingOperationQueue.suspended = YES;
    self.bp_automaticWritingOperationQueue = nil;
    
    self.text = @"";
    
    NSMutableString *automaticWritingText = NSMutableString.new;
    
    if (text)
    {
        [automaticWritingText appendString:text];
    }
    
    [self.bp_automaticWritingOperationQueue addOperationWithBlock:^{
        [self bp_automaticWriting:automaticWritingText duration:duration mode:blinkingMode character:blinkingCharacter completion:completion];
    }];
}

#pragma mark - Private Methods

- (void)bp_automaticWriting:(NSMutableString *)text duration:(NSTimeInterval)duration mode:(UILabelBPlinkingMode)mode character:(unichar)character completion:(void (^)(void))completion
{
    NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
    if ((text.length || mode >= UILabelBPlinkingModeWhenFinish) && !currentQueue.isSuspended)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (mode != UILabelBPlinkingModeNone)
            {
                if ([self bp_isLastCharacter:character])
                {
                    [self bp_deleteLastCharacter];
                }
                else if (mode != UILabelBPlinkingModeWhenFinish || !text.length)
                {
                    [text insertString:[self bp_stringWithCharacter:character] atIndex:0];
                }
            }
            
            if (text.length)
            {
                [self bp_appendCharacter:[text characterAtIndex:0]];
                [text deleteCharactersInRange:NSMakeRange(0, 1)];
                if ((![self bp_isLastCharacter:character] && mode == UILabelBPlinkingModeWhenFinishShowing) || (!text.length && mode == UILabelBPlinkingModeUntilFinishKeeping))
                {
                    [self bp_appendCharacter:character];
                }
            }
            
            if (!currentQueue.isSuspended)
            {
                [currentQueue addOperationWithBlock:^{
                    [self bp_automaticWriting:text duration:duration mode:mode character:character completion:completion];
                }];
            }
            else if (completion)
            {
                completion();
            }
        });
    }
    else if (completion)
    {
        completion();
    }
}

- (NSString *)bp_stringWithCharacter:(unichar)character
{
    return [self bp_stringWithCharacters:@[@(character)]];
}

- (NSString *)bp_stringWithCharacters:(NSArray *)characters
{
    NSMutableString *string = NSMutableString.new;
    
    for (NSNumber *character in characters)
    {
        [string appendFormat:@"%C", character.unsignedShortValue];
    }
    
    return string.copy;
}

- (void)bp_appendCharacter:(unichar)character
{
    [self bp_appendCharacters:@[@(character)]];
}

- (void)bp_appendCharacters:(NSArray *)characters
{
    self.text = [self.text stringByAppendingString:[self bp_stringWithCharacters:characters]];
}

- (BOOL)bp_isLastCharacters:(NSArray *)characters
{
    if (self.text.length >= characters.count)
    {
        return [self.text hasSuffix:[self bp_stringWithCharacters:characters]];
    }
    return NO;
}

- (BOOL)bp_isLastCharacter:(unichar)character
{
    return [self bp_isLastCharacters:@[@(character)]];
}

- (BOOL)bp_deleteLastCharacters:(NSUInteger)characters
{
    if (self.text.length >= characters)
    {
        self.text = [self.text substringToIndex:self.text.length-characters];
        return YES;
    }
    return NO;
}

- (BOOL)bp_deleteLastCharacter
{
    return [self bp_deleteLastCharacters:1];
}

@end
