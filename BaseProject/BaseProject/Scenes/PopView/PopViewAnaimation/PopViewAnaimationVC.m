//
//  PopViewAnaimationVC.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/3/25.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "PopViewAnaimationVC.h"
#import "Popview.h"

@interface PopViewAnaimationVC ()
@property (nonatomic,strong) Popview *popView;
@property (nonatomic,strong) UIButton *clictBt;

@end

@implementation PopViewAnaimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGreenColor;
    [self.view addSubview:self.clictBt];
    
    // Do any additional setup after loading the view.
}

- (UIButton *)clictBt
{
    if (!_clictBt) {
        _clictBt = [UIButton buttonWithType:UIButtonTypeSystem];
        _clictBt.frame = CGRectMake(0, 600, 40, 40);
        [_clictBt setTitle:@"push" forState:UIControlStateNormal];
        [_clictBt addTarget:self action:@selector(clict:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _clictBt;
}
- (void)clict:(UIButton *)bt
{
    if (bt.selected) {
        _popView.array = nil;
        
    }else
    {
        self.popView.frame = CGRectMake(0, 64+30, self.view.frame.size.width, 0);

        [self.view addSubview:self.popView];

        _popView.array = @[@"211",@"211",@"211",@"211",@"211",@"211",@"211",@"211",@"211",@"211",@"211",@"211",@"211",@"211",@"211"];
    }
    bt.selected =!bt.selected;

    
    /*
    [UIView animateWithDuration:0.25 animations:^{
        self.popView.frame = CGRectMake(0, 64+30, 375, 400);
        _popView.array = @[@"211",@"211",@"211"];
     

        [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@500);
        }];
     
    }completion:^(BOOL finished) {
        

        [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@500);
        }];
         

    }];
*/

}

- (Popview *)popView
{
    if (!_popView) {
       // _popView = [[UIView alloc]init];
        _popView = [[Popview alloc]initWithFrame:CGRectMake(0, 64+30, self.view.frame.size.width, 0)];

        _popView.backgroundColor = kRedColor;
        /*
        [_popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@64);
            make.width.equalTo(self.view.mas_width);
            make.centerX.equalTo(self.view.mas_centerX);
            make.height.equalTo(@0);
        }];
         */
    }
    return _popView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
