//
//  BPTextFieldViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTextFieldViewController.h"

@interface BPTextFieldViewController ()<UITextFieldDelegate>

@end

@implementation BPTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)test {
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 200, 275, 50)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"请输入密码";
    textField.textAlignment = 1;
    textField.tag = 102;
    textField.delegate = self;
    [self.view addSubview:textField];
    
    //    2.配置属性
        textField.backgroundColor = kClearColor;
    //    (1)文字显示
    //       a.显示内容
        textField.text = @"Duang";
    //       b.设置文字颜色
        textField.textColor = kDarkGrayColor;
    //       c.对齐方式
        textField.textAlignment = 1;
    //       d.字体
        textField.font = [UIFont systemFontOfSize:20];
    //       e.设置 占位提示符
        textField.placeholder = @"请输入用户名...";
    //   （2）输入控制
    //      a.设置是否可以输入(可以控制输入框 输入的时机)
        textField.enabled = YES;
    //      b.设置当开始编辑时 是否进行清空
        textField.clearsOnBeginEditing = YES;
    //      c.设置键盘风格
        textField.keyboardType = UIKeyboardTypeNamePhonePad;
    //      d.设置return键的风格
        textField.returnKeyType = UIReturnKeyJoin;
    //      e.设置安全模式
        textField.secureTextEntry = YES;

    //      f.设置输入弹出视图（默认是键盘）
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 300)];
    view.backgroundColor = kRedColor;
    
    textField.inputView = view;
    //      g.设置辅助输入视图
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 75)];
    label.text = @"🐯💩🐶🐳💰18🈲";
    textField.inputAccessoryView = label;

//  （3）外观控制
//      a.设置输入框样式:圆角？直角？
    textField.borderStyle = UITextBorderStyleRoundedRect;
//      b.设置清除 按钮的模式
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//      c. 设置左视图
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 50)];
    nameLabel.textColor = kDarkTextColor;
    nameLabel.text = @"用户名:";
    nameLabel.textAlignment = 1;
    nameLabel.backgroundColor = kGrayColor;
//    nameLabel.backgroundColor = kRGBA(76/255.0,98/255.0,124/255.0,0.8);

    textField.leftView = nameLabel;
//    d.左视图模式
    textField.leftViewMode = UITextFieldViewModeAlways;
    
}

//当点击return键触发（代表着一个时机）
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    //通过tag值来获取UI控件对象 self.window的强大作用：让它下面的tag成为局部下的全局变量
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:102];
    [tf2 becomeFirstResponder];
    //如果是第二个输入框就回收键盘
    if ([textField isEqual:tf2]) {
        [tf2 resignFirstResponder];
    }
    //回收键盘
    //[textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
