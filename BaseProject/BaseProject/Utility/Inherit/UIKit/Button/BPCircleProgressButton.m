//
//  BPCircleProgressButton.m
//  BaseProject
//
//  Created by Ryan on 2018/8/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCircleProgressButton.h"

static CGFloat kLineWidth = 2;

@interface BPCircleProgressButton()
@property (nonatomic,strong) CAShapeLayer *borderLayer;
@property (nonatomic,strong) CAShapeLayer *progressLayer;
@property (nonatomic,strong) UIBezierPath *path;
@property (nonatomic,strong) CALayer *pointLayer;
@end

@implementation BPCircleProgressButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeLayer];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2.0, self.height/2.0)
                                                        radius:self.width/2.0 - kLineWidth/2
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI+M_PI_2
                                                     clockwise:YES];
    
    _path = path;
    _borderLayer.path = path.CGPath;
    _pointLayer.position = CGPointMake(self.width/2.0, self.height/2.0);
    _progressLayer.path = path.CGPath;
}

- (void)initializeLayer {
    [self layoutIfNeeded];
    self.backgroundColor = kWhiteColor;
    CGRect frame = self.frame;
    //frame = CGRectMake(0, 0, 35, 35);

    self.layer.cornerRadius = frame.size.width / 2;
    self.layer.masksToBounds = YES;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    self.borderLayer = borderLayer;
    
    _progressColor = kExplicitColor;
    _borderColor = [kExplicitColor colorWithAlphaComponent:0.2];
    
    CGRect rect = {kLineWidth / 2, kLineWidth / 2,frame.size.width - kLineWidth, frame.size.height - kLineWidth};
    //UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2.0, frame.size.height/2.0)
                                                        radius:frame.size.width/2.0 - kLineWidth/2
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI+M_PI_2
                                                     clockwise:YES];
    
    _path = path;
    self.borderLayer.strokeColor = _borderColor.CGColor;
    self.borderLayer.lineWidth = kLineWidth;
    self.borderLayer.fillColor =  [UIColor clearColor].CGColor;
    self.borderLayer.lineCap = kCALineCapRound;
    self.borderLayer.path = path.CGPath;
    [self.layer addSublayer:self.borderLayer];
    
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    self.progressLayer = progressLayer;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = _progressColor.CGColor;
    self.progressLayer.lineWidth = kLineWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.path = path.CGPath;
    [self.layer addSublayer:self.progressLayer];
    
    self.pointLayer = [[CALayer alloc] init];
    self.pointLayer.bounds = CGRectMake(0, 0, 6, 6);
    self.pointLayer.position = CGPointMake(self.width/2.0, self.height/2.0);
    self.pointLayer.cornerRadius = 3;
    //self.pointLayer.hidden = YES;
    self.pointLayer.backgroundColor = [kExplicitColor CGColor];
    [self.layer addSublayer:self.pointLayer];
    
    
    /* calyer变形后的锯齿和模糊问题：一般是对图片放大或者缩小或者旋转导致的
     self.layer.allowsEdgeAntialiasing = YES;// 反锯齿属性
     self.layer.shouldRasterize = YES;
     self.layer.rasterizationScale = [UIScreen mainScreen].scale;
     */
}

- (void)setProgressColor:(UIColor *)progressColor {
    if (_progressColor != progressColor) {
        _progressColor = progressColor;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.progressLayer.strokeColor = progressColor.CGColor;
        [CATransaction commit];
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (_borderColor != borderColor) {
        _borderColor = borderColor;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.borderLayer.strokeColor = borderColor.CGColor;
        [CATransaction commit];
    }
}

- (void)setProgressHidden:(BOOL)progressHidden {
    _progressHidden = progressHidden;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.progressLayer.hidden = progressHidden;
    [CATransaction commit];
}

- (void)setBorderHidden:(BOOL)borderHidden {
    _borderHidden = borderHidden;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.pointLayer.hidden = borderHidden;
    self.borderLayer.hidden = borderHidden;
    [CATransaction commit];
}

- (void)setProgress:(CGFloat)progress {
    //    [CATransaction begin];
    //    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    //    [CATransaction setAnimationDuration:0.25];
    //    self.progressLayer.strokeEnd = progress;
    //    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.progressLayer.strokeEnd = progress;
    [CATransaction commit];
}

@end
