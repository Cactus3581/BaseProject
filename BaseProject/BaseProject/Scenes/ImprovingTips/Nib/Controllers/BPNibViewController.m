//
//  BPNibViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/8/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNibViewController.h"
#import "BPNibView.h"

@interface BPNibViewController ()
@property (weak, nonatomic) IBOutlet UILabel *firstLabelInVC;
@property (strong, nonatomic) IBOutlet UIView *secondBackViewInVC;
@property (weak, nonatomic) IBOutlet BPNibView *nibView;
@property (weak, nonatomic) IBOutlet UILabel *secondLabelInVC;
@end

@implementation BPNibViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nibView.backgroundColor = kYellowColor;
    
    // vc中的xib的第二个平行view
    self.secondBackViewInVC.frame = CGRectMake(0, 220, 375, 100);
    self.secondBackViewInVC.backgroundColor = kRedColor;
    [self.view addSubview:self.secondBackViewInVC];
    
    //xibview
    BPNibView *view = [BPNibView bp_loadInstanceFromNib];
    view.backgroundColor = kGreenColor;
    view.frame = CGRectMake(0, 350, 375, 100);
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
