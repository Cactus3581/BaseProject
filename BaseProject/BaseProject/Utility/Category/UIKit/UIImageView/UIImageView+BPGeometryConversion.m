//
//  UIImageView+GeometryConversion.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIImageView+BPGeometryConversion.h"

@implementation UIImageView (BPGeometryConversion)

- (CGPoint)bp_convertPointFromImage:(CGPoint)imagePoint {
    CGPoint viewPoint = imagePoint;
    
    CGSize imageSize = self.image.size;
    CGSize viewSize  = self.bounds.size;
    
    CGFloat ratioX = viewSize.width / imageSize.width;
    CGFloat ratioY = viewSize.height / imageSize.height;
    
    UIViewContentMode contentMode = self.contentMode;
    
    switch (contentMode) {
        case UIViewContentModeScaleToFill:
        case UIViewContentModeRedraw:
        {
            viewPoint.x *= ratioX;
            viewPoint.y *= ratioY;
            break;
        }
            
        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill:
        {
            CGFloat scale;
            
            if (contentMode == UIViewContentModeScaleAspectFit) {
                scale = MIN(ratioX, ratioY);
            }
            else /*if (contentMode == UIViewContentModeScaleAspectFill)*/ {
                scale = MAX(ratioX, ratioY);
            }
            
            viewPoint.x *= scale;
            viewPoint.y *= scale;
            
            viewPoint.x += (viewSize.width  - imageSize.width  * scale) / 2.0f;
            viewPoint.y += (viewSize.height - imageSize.height * scale) / 2.0f;
            
            break;
        }
            
        case UIViewContentModeCenter:
        {
            viewPoint.x += viewSize.width / 2.0  - imageSize.width  / 2.0f;
            viewPoint.y += viewSize.height / 2.0 - imageSize.height / 2.0f;
            
            break;
        }
            
        case UIViewContentModeTop:
        {
            viewPoint.x += viewSize.width / 2.0 - imageSize.width / 2.0f;
            
            break;
        }
            
        case UIViewContentModeBottom:
        {
            viewPoint.x += viewSize.width / 2.0 - imageSize.width / 2.0f;
            viewPoint.y += viewSize.height - imageSize.height;
            
            break;
        }
            
        case UIViewContentModeLeft:
        {
            viewPoint.y += viewSize.height / 2.0 - imageSize.height / 2.0f;
            
            break;
        }
            
        case UIViewContentModeRight:
        {
            viewPoint.x += viewSize.width - imageSize.width;
            viewPoint.y += viewSize.height / 2.0 - imageSize.height / 2.0f;
            
            break;
        }
            
        case UIViewContentModeTopRight:
        {
            viewPoint.x += viewSize.width - imageSize.width;
            
            break;
        }
            
            
        case UIViewContentModeBottomLeft:
        {
            viewPoint.y += viewSize.height - imageSize.height;
            
            break;
        }
            
            
        case UIViewContentModeBottomRight:
        {
            viewPoint.x += viewSize.width  - imageSize.width;
            viewPoint.y += viewSize.height - imageSize.height;
            
            break;
        }
            
        case UIViewContentModeTopLeft:
        default:
        {
            break;
        }
    }
    
    return viewPoint;
}

- (CGRect)bp_convertRectFromImage:(CGRect)imageRect {
    CGPoint imageTopLeft     = imageRect.origin;
    CGPoint imageBottomRight = CGPointMake(CGRectGetMaxX(imageRect),
                                          CGRectGetMaxY(imageRect));
    
    CGPoint viewTopLeft     = [self bp_convertPointFromImage:imageTopLeft];
    CGPoint viewBottomRight = [self bp_convertPointFromImage:imageBottomRight];
    
    CGRect viewRect;
    viewRect.origin = viewTopLeft;
    viewRect.size   = CGSizeMake(ABS(viewBottomRight.x - viewTopLeft.x),
                                 ABS(viewBottomRight.y - viewTopLeft.y));
    
    return viewRect;
}

- (CGPoint)bp_convertPointFromView:(CGPoint)viewPoint {
    CGPoint imagePoint = viewPoint;
    
    CGSize imageSize = self.image.size;
    CGSize viewSize  = self.bounds.size;
    
    CGFloat ratioX = viewSize.width / imageSize.width;
    CGFloat ratioY = viewSize.height / imageSize.height;
    
    UIViewContentMode contentMode = self.contentMode;
    
    switch (contentMode) {
        case UIViewContentModeScaleToFill:
        case UIViewContentModeRedraw:
        {
            imagePoint.x /= ratioX;
            imagePoint.y /= ratioY;
            break;
        }
            
        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill:
        {
            CGFloat scale;
            
            if (contentMode == UIViewContentModeScaleAspectFit) {
                scale = MIN(ratioX, ratioY);
            }
            else /*if (contentMode == UIViewContentModeScaleAspectFill)*/ {
                scale = MAX(ratioX, ratioY);
            }
            
            // Remove the x or y margin added in FitMode
            imagePoint.x -= (viewSize.width  - imageSize.width  * scale) / 2.0f;
            imagePoint.y -= (viewSize.height - imageSize.height * scale) / 2.0f;

            imagePoint.x /= scale;
            imagePoint.y /= scale;

            break;
        }
            
        case UIViewContentModeCenter:
        {
            imagePoint.x -= (viewSize.width - imageSize.width)  / 2.0f;
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0f;
            
            break;
        }
            
        case UIViewContentModeTop:
        {
            imagePoint.x -= (viewSize.width - imageSize.width)  / 2.0f;
            
            break;
        }
            
        case UIViewContentModeBottom:
        {
            imagePoint.x -= (viewSize.width - imageSize.width)  / 2.0f;
            imagePoint.y -= (viewSize.height - imageSize.height);
            
            break;
        }
            
        case UIViewContentModeLeft:
        {
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0f;
            
            break;
        }
            
        case UIViewContentModeRight:
        {
            imagePoint.x -= (viewSize.width - imageSize.width);
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0f;

            break;
        }
            
        case UIViewContentModeTopRight:
        {
            imagePoint.x -= (viewSize.width - imageSize.width);
            
            break;
        }
            
            
        case UIViewContentModeBottomLeft:
        {
            imagePoint.y -= (viewSize.height - imageSize.height);
            
            break;
        }
            
            
        case UIViewContentModeBottomRight:
        {
            imagePoint.x -= (viewSize.width - imageSize.width);
            imagePoint.y -= (viewSize.height - imageSize.height);
            
            break;
        }
            
        case UIViewContentModeTopLeft:
        default:
        {
            break;
        }
    }
    
    return imagePoint;
}

- (CGRect)bp_convertRectFromView:(CGRect)viewRect {
    CGPoint viewTopLeft = viewRect.origin;
    CGPoint viewBottomRight = CGPointMake(CGRectGetMaxX(viewRect), 
                                          CGRectGetMaxY(viewRect));
    
    CGPoint imageTopLeft = [self bp_convertPointFromView:viewTopLeft];
    CGPoint imageBottomRight = [self bp_convertPointFromView:viewBottomRight];
    
    CGRect imageRect;
    imageRect.origin = imageTopLeft;
    imageRect.size = CGSizeMake(ABS(imageBottomRight.x - imageTopLeft.x),
                                ABS(imageBottomRight.y - imageTopLeft.y));
    
    return imageRect;
}

@end
