//
//  KHHRegisterViewController.m
//  Carte
//
//  Created by CJK on 13-3-22.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHRegisterViewController.h"
#import "KHHLoginCell.h"
#import "NSString+Validation.h"
#import "NetClient+Account.h"
#import "KHHUser.h"
#import "KHHStartUpViewController.h"
#import "KHHLoginViewController.h"

@interface KHHRegisterViewController ()
{
    UITableView *_table;
    UIView *viewFoot;
    
    NSMutableArray *_arrDicForCell;
}

@end

@implementation KHHRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(20, 0, 280, 460-44) style:UITableViewStyleGrouped];
        
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundView = nil;
        _table.backgroundColor = [UIColor clearColor];
        _table.showsVerticalScrollIndicator=NO;
        
        _arrDicForCell = [[NSMutableArray alloc]initWithCapacity:2];    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initArr];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!iPhone5) {
        [_table setContentInset:UIEdgeInsetsMake(0,0,250,0)];
    }
    [self.view addSubview:_table];
    
    self.barLeftStr = @"返回";
    KHHRegisterViewController *weakSelf = self;
    self.barLeftAction = ^(){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

- (void)initArr
{
    NSMutableDictionary *dicPhone = [[NSMutableDictionary alloc]init];
    dicPhone[@"title"] = @"手机号";
    dicPhone[@"placeholder"] = @"请输入手机号";
    dicPhone[@"tag"] = @"100";
    dicPhone[@"alert"] = @"";
    dicPhone[@"value"] = @"";
    dicPhone[@"keyboardType"] = @"number";
    dicPhone[@"secureTextEntry"] = @"NO";
    [_arrDicForCell addObject:dicPhone];
    
    NSMutableDictionary *dicSec = [[NSMutableDictionary alloc]init];
    dicSec[@"title"] = @"密码";
    dicSec[@"placeholder"] = @"请输入密码";
    dicSec[@"tag"] = @"101";
    dicSec[@"alertText"] = @"";
    dicSec[@"value"] = @"";
    dicSec[@"keyboardType"] = @"default";
    dicSec[@"secureTextEntry"] = @"YES";
    [_arrDicForCell addObject:dicSec];
    
    NSMutableDictionary *dicSec2 = [[NSMutableDictionary alloc]init];
    dicSec2[@"title"] = @"确认密码";
    dicSec2[@"placeholder"] = @"请确认密码";
    dicSec2[@"tag"] = @"102";
    dicSec2[@"alertText"] = @"";
    dicSec2[@"value"] = @"";
    dicSec2[@"keyboardType"] = @"default";
    dicSec2[@"secureTextEntry"] = @"YES";
    [_arrDicForCell addObject:dicSec2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrDicForCell count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDZero = @"userInfo";
    KHHLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDZero];
    if (!cell) {
        cell = [[KHHLoginCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.delegate = self;
    }
    
    cell.textLabel.text = _arrDicForCell[indexPath.row][@"title"];
    cell.value = _arrDicForCell[indexPath.row][@"value"];
    cell.placeholder = _arrDicForCell[indexPath.row][@"placeholder"];
    cell.keyboardType = [_arrDicForCell[indexPath.row][@"keyboardType"] isEqualToString:@"number"]?UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
    cell.tag = [_arrDicForCell[indexPath.row][@"tag"] integerValue];
    cell.alertText = _arrDicForCell[indexPath.row][@"alertText"];
    cell.secureTextEntry = [_arrDicForCell[indexPath.row][@"secureTextEntry"] isEqualToString:@"YES"]?YES:NO;
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!viewFoot) {
        viewFoot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
        UISwitch* isShowPwd;
        UIButton *loginBut;
//        UIButton *registerBut;
//        UIButton *findOutPwd;
        UILabel *showPwd;
        isShowPwd = [[UISwitch alloc]initWithFrame:CGRectMake(100, 5, 0, 0)];
        [isShowPwd addTarget:self action:@selector(isShowPwd:) forControlEvents:UIControlEventValueChanged];
        
        showPwd = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 30)];
        showPwd.font = [UIFont systemFontOfSize:14.0];
        showPwd.backgroundColor = [UIColor clearColor];
        showPwd.text = @"显示密码";
        
        loginBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [loginBut setTitle:@"提交" forState:UIControlStateNormal];
        loginBut.frame = CGRectMake(0, 40, 70, 30);
        [loginBut addTarget:self action:@selector(doRegist) forControlEvents:UIControlEventTouchUpInside];
//        registerBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [registerBut setTitle:@"注册" forState:UIControlStateNormal];
//        registerBut.frame = CGRectMake(100, 40, 70, 30);
//        
//        findOutPwd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [findOutPwd setTitle:@"找回密码" forState:UIControlStateNormal];
//        findOutPwd.frame = CGRectMake(200, 40, 80, 30);
        
        [viewFoot addSubview:isShowPwd];
        [viewFoot addSubview:loginBut];
//        [viewFoot addSubview:registerBut];
//        [viewFoot addSubview:findOutPwd];
        [viewFoot addSubview:showPwd];
        
    }
    return viewFoot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100.0f;
}

#pragma mark - button actions

- (void)isShowPwd:(id)sender
{
    UISwitch* isShowPwd = (UISwitch*)sender;
    if (isShowPwd.on) {
        _arrDicForCell[1][@"secureTextEntry"] = @"NO";
        _arrDicForCell[2][@"secureTextEntry"] = @"NO";
    }else{
        _arrDicForCell[1][@"secureTextEntry"] = @"YES";
        _arrDicForCell[2][@"secureTextEntry"] = @"YES";
    }
    [_table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0], nil]  withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)doRegist
{
     [self hiddenKeyboard];
    
    NSString *phone = _arrDicForCell[0][@"value"];
    if (!phone||phone.length==0) {
        [self warnAlertMessage:@"请输入手机号"];
        return;
    }
    if (phone.length > 0 && ![phone isValidMobilePhoneNumber]) {
        [self warnAlertMessage:@"手机格式错误"];
        return;
    }
    
    NSString *pwd = _arrDicForCell[1][@"value"];
    if (!pwd||pwd.length==0) {
        [self warnAlertMessage:@"请输入密码"];
        return;
    }
    if (pwd.length<6) {
        [self warnAlertMessage:@"密码至少6位，最多12位"];
        return;
    }
    
    if([_arrDicForCell[2][@"value"] isEqualToString:@""]){
        [self warnAlertMessage:@"请输入确认密码"];
        return;
    }

    if(![_arrDicForCell[2][@"value"] isEqualToString:_arrDicForCell[1][@"value"]]){
        [self warnAlertMessage:@"两次密码输入不一致"];
        return;
    }
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:2];
    dicParam[@"accountNo"] = phone;
    dicParam[@"password"] = pwd;
    
    [((KHHStartUpViewController *)self.parentViewController.parentViewController)changeFromView:1 toView:0 isLeft:YES];
    [((KHHStartUpViewController *)self.parentViewController.parentViewController) activityText:@"正在注册..."];
   
    
    [[NetClient sharedClient] doRegister:dicParam success:^(NSMutableDictionary *responseDict) {
        [KHHUser shareInstance].username = phone;
        [KHHUser shareInstance].password = pwd;
        [((KHHLoginViewController *)self.parentViewController.childViewControllers[0]) letMeAotu];
        [((KHHStartUpViewController *)self.parentViewController.parentViewController) activityText:@"正在登录..."];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSMutableDictionary *responseDict) {
        [((KHHStartUpViewController *)self.parentViewController.parentViewController)changeFromView:0 toView:1 isLeft:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}


- (void)hiddenKeyboard
{
    for (int i=100; i<103; i++) {
        UIView *viewPro = [self.view viewWithTag:i];
        if ([viewPro isFirstResponder]) {
            [viewPro resignFirstResponder];
            return;
        }
    }
}


#pragma mark - textField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 102) {
        textField.returnKeyType = UIReturnKeyDone;
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        _arrDicForCell[0][@"value"] = textField.text;
        if (textField.text.length > 0 && ![textField.text isValidMobilePhoneNumber]) {
            _arrDicForCell[0][@"alertText"] = @"手机格式错误";
        }else{
            _arrDicForCell[0][@"alertText"] = @"";
        }
        [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]  withRowAnimation:UITableViewRowAnimationNone];
    }
    if (textField.tag == 101) {
        _arrDicForCell[1][@"value"] = textField.text;
        if (textField.text.length > 0 && textField.text.length<6) {
            _arrDicForCell[1][@"alertText"] = @"密码长度最少6位，最多12位";
        }else{
            _arrDicForCell[1][@"alertText"] = @"";
        }
        [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]]  withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if (textField.tag == 102) {
        _arrDicForCell[2][@"value"] = textField.text;
        if (textField.text.length > 0 && ![textField.text isEqualToString:_arrDicForCell[1][@"value"]]) {
            _arrDicForCell[2][@"alertText"] = @"两次密码输入不一致";
        }else{
            _arrDicForCell[2][@"alertText"] = @"";
        }
        [_table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0], nil]  withRowAnimation:UITableViewRowAnimationNone];
    }
    
    // [self showPopOverListFor:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 100) {
        if (textField.text.length>=11&&![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField.tag == 101||textField.tag == 102) {
        if (textField.text.length>=12&&![string isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (textField.tag == 102) {
        //_arrDicForCell[2][@"value"] = textField.text;
        [self doRegist];
    }
    return YES;
}

- (void)warnAlertMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}


@end
