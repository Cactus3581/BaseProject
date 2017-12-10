//
//  UITextView+PinchZoom.m
//
//  Created by Stan Serebryakov <cfr@gmx.us> on 04.12.12.
//

#import "UITextView+BPPinchZoom.h"
#import "objc/runtime.h"

static int bp_minFontSizeKey;
static int bp_maxFontSizeKey;
static int bp_zoomEnabledKey;

@implementation UITextView (BPPinchZoom)

- (void)setBp_maxFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &bp_maxFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)bp_maxFontSize
{
    return [objc_getAssociatedObject(self, &bp_maxFontSizeKey) floatValue];
}

- (void)setBp_minFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &bp_minFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)bp_minFontSize
{
    return [objc_getAssociatedObject(self, &bp_minFontSizeKey) floatValue];
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    if (!self.isBp_zoomEnabled) return;

    CGFloat pointSize = (gestureRecognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;

    pointSize = MAX(MIN(pointSize, self.bp_maxFontSize), self.bp_minFontSize);

    self.font = [UIFont fontWithName:self.font.fontName size:pointSize];
}


- (void)setBp_zoomEnabled:(BOOL)zoomEnabled
{
    objc_setAssociatedObject(self, &bp_zoomEnabledKey, [NSNumber numberWithBool:zoomEnabled],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) // initialized already
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) return;

        self.bp_minFontSize = self.bp_minFontSize ?: 8.0f;
        self.bp_maxFontSize = self.bp_maxFontSize ?: 42.0f;
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
#if !__has_feature(objc_arc)
        [pinchRecognizer release];
#endif
    }
}

- (BOOL)isBp_zoomEnabled
{
    return [objc_getAssociatedObject(self, &bp_zoomEnabledKey) boolValue];
}

@end
