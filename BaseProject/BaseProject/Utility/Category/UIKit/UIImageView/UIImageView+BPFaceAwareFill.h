//
//  UIImageView+UIImageView_FaceAwareFill.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BPFaceAwareFill)

//Ask the image to perform an "Aspect Fill" but centering the image to the detected faces
//Not the simple center of the image
- (void)bp_faceAwareFill;

@end
