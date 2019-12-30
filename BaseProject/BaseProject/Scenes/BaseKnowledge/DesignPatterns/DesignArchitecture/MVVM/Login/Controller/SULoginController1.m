//
//  SULoginController1.m
//  MHDevelopExample
//
//  Created by senba on 2017/6/14.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "SULoginController1.h"
#import "SULoginInputView.h"
#import "SULoginViewModel1.h"

@interface SULoginController1 ()

@property (weak, nonatomic) UIImageView *userAvatar;
@property (weak, nonatomic) UIView *inputBaseView;
@property (weak, nonatomic) UIButton *loginBtn;

@property (nonatomic, weak) SULoginInputView *inputView;
@property (nonatomic, strong) SULoginViewModel1 *viewModel;

@end


@implementation SULoginController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupSubViews];
    [self _bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.inputView.phoneTextField becomeFirstResponder];
}

#pragma mark - 事件处理
// 登录按钮的点击事件

- (IBAction)_loginbtnDidClicked:(id)sender {
    // 数据验证的在Controller中处理 否则的话 viewModel 中就引用了 view了
    // 验证手机号码 正确的手机号码
    if (!self.inputView.phoneTextField.text.length){
        return;
    }
    // 验证验证码 四位数字
    if (!self.inputView.verifyTextField.text.length){
        return;
    }
    // 键盘掉下
    [self.view endEditing:YES];
    weakify(self);
    [self.viewModel loginSuccess:^(id json) {
        strongify(self);
        // 跳转
    } failure:nil];
}

// textField的数据改变
- (void)_textFieldValueDidChanged:(UITextField *)sender {
    // bind data
    self.viewModel.mobilePhone = self.inputView.phoneTextField.text;
    self.viewModel.verifyCode = self.inputView.verifyTextField.text;
}

#pragma mark - BindModel
- (void)_bindViewModel {
    [self.viewModel addObserver:self forKeyPath:@"avatarUrlString" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"avatarUrlString"]) {
        self.userAvatar.image = [UIImage imageNamed:change[NSKeyValueChangeNewKey]];
    }
}

#pragma mark - 初始化UI
- (void)_setupSubViews {

    UIImageView *userAvatar = [[UIImageView alloc] init];
    _userAvatar = userAvatar;
    userAvatar.backgroundColor = kThemeColor;
    [self.view addSubview:userAvatar];
    [userAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.width.height.equalTo(@(50));
        make.centerX.equalTo(self.view);
    }];

    SULoginInputView *inputView = [SULoginInputView bp_instantiateFromNib];
    _inputView = inputView;
    [self.view addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userAvatar.mas_bottom).offset(60);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(200));
    }];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn = loginBtn;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = kThemeColor;
    [loginBtn addTarget:self action:@selector(_loginbtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputView.mas_bottom).offset(60);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(40));
        make.width.equalTo(@(100));
    }];

    // 登录按钮
    // 验证登录按钮的有效性
    [self _textFieldValueDidChanged:nil];
    
    // 添加事件
    [inputView.phoneTextField addTarget:self action:@selector(_textFieldValueDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [inputView.verifyTextField addTarget:self action:@selector(_textFieldValueDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [_viewModel removeObserver:self forKeyPath:@"avatarUrlString"];
}

@end
