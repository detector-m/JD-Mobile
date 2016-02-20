//
//  DZRegisterViewController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZRegisterViewController.h"
#import "DZUserDao.h"
#import "DZUserModel.h"

@interface DZRegisterViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIButton *radioButton;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation DZRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DZColor(240, 243, 245);
    //设置导航栏
    [self setupNavigationItem];
    //初始化视图
    [self initView];
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"手机快速注册";
}

- (void)initView {
    //账号框
    _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, 335, 40)];
    _phoneField.placeholder = @"请输入手机号";
    _phoneField.textColor = [UIColor blackColor];
    _phoneField.borderStyle = UITextBorderStyleRoundedRect; //外框类型
    _phoneField.keyboardType = UIKeyboardTypePhonePad;//设置键盘的样式
    _phoneField.delegate = self;//设置代理 用于实现协议
    _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;//UITextField 的一件清除按钮是否出现
    _phoneField.enablesReturnKeyAutomatically = YES;//这里设置为无文字就灰色不可点
    [_phoneField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneField];
    
    _radioButton = [UIButton createButtonWithTitle:@"同意京东用户注册协议" Image:@"charge_success_tip"  Target:self Selector:nil];
    [_radioButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_radioButton setTitleColor:DZColor(190, 190, 192) forState:UIControlStateNormal];
    _radioButton.frame = CGRectMake(5, 130, 200, 25);
    [self.view addSubview:_radioButton];
    
    //下一部按钮
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(20,170 , 335, 40)];
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_nextButton setBackgroundImage:[UIImage imageNamed:@"login_btn_gray"] forState:UIControlStateNormal];
    _nextButton.enabled = NO;
    [_nextButton addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

- (void)nextBtnClick {
    NSCharacterSet *whithNewUser = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *phone = [_phoneField.text stringByTrimmingCharactersInSet:whithNewUser];
    
    NSDate *senddate = [NSDate date];
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString * locationString = [dateformatter stringFromDate:senddate];
    
    DZUserModel *um = [[DZUserModel alloc]init];
    um.userId = [NSString stringWithFormat:@"%i",arc4random()%10000 + 1];
    um.userPhone = phone;
    um.userPwd = @"123456";
    um.time = locationString;
    um.userName = @"chars";
    um.commodity = [NSNumber numberWithInteger:13];
    um.shop = [NSNumber numberWithInteger:3];
    um.record = [NSNumber numberWithInteger:12];
    
    DZUserDao *ud = [[DZUserDao alloc]init];
    if ([ud insertUser:um]) {
        [MBProgressHUD showSuccess:@"注册成功"];
    }else{
        [MBProgressHUD showSuccess:@"该手机号已被使用"];
    }
}

- (void)returnOnKeyboard:(UITextField *)sender {
    if (_phoneField.text.length != 0 ) {
        _nextButton.enabled = YES;
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"login_btn_red"] forState:UIControlStateNormal];
    } else {
        _nextButton.enabled = NO;
        [_nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"login_btn_gray"] forState:UIControlStateNormal];
    }
}

#pragma mark - 键盘操作

- (void)hidenKeyboard {
    [_phoneField resignFirstResponder];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
