//
//  BPMasksToBoundsViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMasksToBoundsViewController.h"

static CGFloat corner = 40;

@interface BPMasksToBoundsViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *labelInScroll;
@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (weak, nonatomic) IBOutlet UILabel *labelInBottomView;
@end

@implementation BPMasksToBoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeSubViews];
    [self configMask];
}

- (void)initializeSubViews {
    self.topView.backgroundColor = kThemeColor;
    self.label.backgroundColor = kThemeColor;
    self.label.textColor = kWhiteColor;
    self.button.backgroundColor = kThemeColor;
    [self.button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.imageView.backgroundColor = kThemeColor;
    self.scrollView.backgroundColor = kThemeColor;
    
    self.labelInScroll.backgroundColor = kThemeColor;
    self.labelInScroll.textColor = kWhiteColor;
    self.bottomview.backgroundColor = kThemeColor;
    self.labelInBottomView.backgroundColor = kThemeColor;
    self.labelInBottomView.textColor = kWhiteColor;
    
    
}

- (void)configMask {
    self.topView.layer.cornerRadius = corner;
    
    self.label.layer.cornerRadius = corner;
    
    self.button.layer.cornerRadius = corner;
    
    self.imageView.layer.cornerRadius = corner;
    
    self.scrollView.layer.cornerRadius = corner;
    self.labelInScroll.layer.cornerRadius = corner;

    self.bottomview.layer.cornerRadius = corner;
    self.labelInBottomView.layer.cornerRadius = corner;

    self.label.layer.masksToBounds = YES;
    self.imageView.layer.masksToBounds = YES;
    
    self.labelInScroll.layer.masksToBounds = YES;
    self.labelInBottomView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
