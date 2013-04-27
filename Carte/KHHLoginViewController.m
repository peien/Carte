//
//  KHHLoginViewController.m
//  Carte
//
//  Created by CJK on 13-3-21.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHLoginViewController.h"
#import "KHHLoginCell.h"
#import "NSString+Validation.h"
#import "KHHRegisterViewController.h"
#import "KHHMainTabViewController.h"
#import "KHHUser.h"
#import "NetClient+Account.h"
#import "KHHStartUpViewController.h"
#import "MBProgressHUD.h"
#import "NetClient+Template.h"

@interface KHHLoginViewController ()
{
    UITableView *_table;
    UIView *viewFoot;
    
    NSMutableArray *_arrDicForCell;
    MBProgressHUD *_hud;
}

@end

@implementation KHHLoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(20, 0, 280, 460-44) style:UITableViewStyleGrouped];
        
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundView = nil;
        _table.backgroundColor = [UIColor clearColor];
        _table.showsVerticalScrollIndicator=NO;
        //_table.scrollEnabled = NO;
        _arrDicForCell = [[NSMutableArray alloc]initWithCapacity:2];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(20, 0, 280, 460-44) style:UITableViewStyleGrouped];
        
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundView = nil;
        _table.showsVerticalScrollIndicator=NO;
        //_table.scrollEnabled = NO;
        _arrDicForCell = [[NSMutableArray alloc]initWithCapacity:2];
        //Initializing PopOver
        //        _popOver = [[UIPopoverController alloc] initWithContentViewController:self];
        //        _popOver.popoverContentSize = CGSizeMake(250, 25);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initArr];
    //    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Carte"
    //                                                             bundle: nil];
    //
    ////    KHHMainTabViewController *controller = (KHHMainTabViewController*)[mainStoryboard
    ////                                                       instantiateViewControllerWithIdentifier: @"MainTab"];
    //    [self.navigationController performSegueWithIdentifier:@"segueMainTab" sender:self];
    //    NSLog(@"%d",[self.navigationController.childViewControllers count]);
    self.view.backgroundColor = [UIColor whiteColor];
    if (!iPhone5) {
        [_table setContentInset:UIEdgeInsetsMake(0,0,250,0)];
    }
    [self.view addSubview:_table];
    
	// Do any additional setup after loading the view.
}

- (void)initArr
{
    NSMutableDictionary *dicPhone = [[NSMutableDictionary alloc]init];
    dicPhone[@"title"] = @"手机号";
    dicPhone[@"placeholder"] = @"请输入手机号";
    dicPhone[@"tag"] = @"100";
    dicPhone[@"alert"] = @"";
    if ([KHHUser shareInstance].username) {
        dicPhone[@"value"] = [KHHUser shareInstance].username;
    }else{
        dicPhone[@"value"] = @"";
    }
    
    dicPhone[@"keyboardType"] = @"number";
    dicPhone[@"secureTextEntry"] = @"NO";
    [_arrDicForCell addObject:dicPhone];
    
    NSMutableDictionary *dicSec = [[NSMutableDictionary alloc]init];
    dicSec[@"title"] = @"密码";
    dicSec[@"placeholder"] = @"请输入密码";
    dicSec[@"tag"] = @"101";
    dicSec[@"alertText"] = @"";
    if ([KHHUser shareInstance].password) {
        dicSec[@"value"] = [KHHUser shareInstance].password;
    }else{
        dicSec[@"value"] = @"";
    }
    
    dicSec[@"keyboardType"] = @"default";
    dicSec[@"secureTextEntry"] = @"YES";
    [_arrDicForCell addObject:dicSec];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
        UIButton *registerBut;
        UIButton *findOutPwd;
        UILabel *showPwd;
        isShowPwd = [[UISwitch alloc]initWithFrame:CGRectMake(100, 5, 0, 0)];
        [isShowPwd addTarget:self action:@selector(isShowPwd:) forControlEvents:UIControlEventValueChanged];
        
        showPwd = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 30)];
        showPwd.font = [UIFont systemFontOfSize:14.0];
        showPwd.backgroundColor = [UIColor clearColor];
        showPwd.text = @"显示密码";
        
        loginBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [loginBut setTitle:@"登录" forState:UIControlStateNormal];
        loginBut.frame = CGRectMake(0, 40, 70, 30);
        [loginBut addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        
        registerBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [registerBut setTitle:@"注册" forState:UIControlStateNormal];
        registerBut.frame = CGRectMake(100, 40, 70, 30);
        [registerBut addTarget:self action:@selector(gotoRegist) forControlEvents:UIControlEventTouchUpInside];
        
        findOutPwd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [findOutPwd setTitle:@"找回密码" forState:UIControlStateNormal];
        findOutPwd.frame = CGRectMake(200, 40, 80, 30);
        [findOutPwd addTarget:self action:@selector(findOutPwd) forControlEvents:UIControlEventTouchUpInside];
        
        [viewFoot addSubview:isShowPwd];
        [viewFoot addSubview:loginBut];
        [viewFoot addSubview:registerBut];
        [viewFoot addSubview:findOutPwd];
        [viewFoot addSubview:showPwd];
        
    }
    return viewFoot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100.0f;
}


#pragma mark - button actions

- (void)findOutPwd
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
    
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:1];
    dicParam[@"accountNo"] = phone;
    
    [[NetClient sharedClient] doFindPwd:dicParam success:^(NSMutableDictionary *responseDict) {
        [_hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"找回密码" message:[NSString  stringWithFormat:@"密码已发送至%@",phone] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } failure:^(NSMutableDictionary *responseDict) {
        [_hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"找回密码失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
    
}

- (void)isShowPwd:(id)sender
{
    UISwitch* isShowPwd = (UISwitch*)sender;
    if (isShowPwd.on) {
        _arrDicForCell[1][@"secureTextEntry"] = @"NO";
    }else{
        _arrDicForCell[1][@"secureTextEntry"] = @"YES";
    }
    [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]]  withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)gotoRegist
{
    KHHRegisterViewController *registerViewConPro = [[KHHRegisterViewController alloc]init];
    
    [self.navigationController pushViewController:registerViewConPro animated:YES];
}

- (void)login
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
    
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:2];
    dicParam[@"accountNo"] = phone;
    dicParam[@"password"] = pwd;
    
    [((KHHStartUpViewController *)self.parentViewController.parentViewController)changeFromView:1 toView:0 isLeft:YES];
    [((KHHStartUpViewController *)self.parentViewController.parentViewController) activityText:@"正在登录..."];
    
    [[NetClient sharedClient] doLogin:dicParam success:^(NSMutableDictionary *responseDict) {
        [KHHUser shareInstance].username = phone;
        [KHHUser shareInstance].password = pwd;
        
        if (![Card mycard]) {
            [((KHHStartUpViewController *)self.parentViewController.parentViewController) activityText:@"加载我的名片"];
            [self getMyCard];
            return;
        }
        [((KHHStartUpViewController *)self.parentViewController.parentViewController) changeToMain];
    } failure:^(NSMutableDictionary *responseDict) {
        [((KHHStartUpViewController *)self.parentViewController.parentViewController)changeFromView:0 toView:1 isLeft:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
    
    //    if (_loginSuccess) {
    //        _loginSuccess();
    //    }
    
}

- (void)getMyCard
{
    [[NetClient sharedClient] doGetMyCard:^(NSMutableDictionary *responseDict){
        if (![CardTemplate objectByKey:@"type" value:[NSNumber numberWithInt:type_template_default] createIfNone:NO]) {
            [((KHHStartUpViewController *)self.parentViewController.parentViewController) activityText:@"加载模板"];
            [self getTemplates];
            return;
        }
        [((KHHStartUpViewController *)self.parentViewController.parentViewController) changeToMain];
    } failure:^(NSMutableDictionary *responseDict){
        [((KHHStartUpViewController *)self.parentViewController.parentViewController)changeFromView:0 toView:1 isLeft:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加载我的名片失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)getTemplates
{
    [[NetClient sharedClient] doSyncTemplate:^(NSMutableDictionary *responseDict){        
        [((KHHStartUpViewController *)self.parentViewController.parentViewController) changeToMain];
    } failure:^(NSMutableDictionary *responseDict){
        [((KHHStartUpViewController *)self.parentViewController.parentViewController)changeFromView:0 toView:1 isLeft:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加载我的名片失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)letMeAotu
{
    _arrDicForCell[0][@"value"] = [KHHUser shareInstance].username;
    _arrDicForCell[1][@"value"] = [KHHUser shareInstance].password;
    [_table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:1 inSection:0], nil]  withRowAnimation:UITableViewRowAnimationNone];
    
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:2];
    dicParam[@"accountNo"] = _arrDicForCell[0][@"value"];
    dicParam[@"password"] = _arrDicForCell[1][@"value"];
    [[NetClient sharedClient] doLogin:dicParam success:^(NSMutableDictionary *responseDict) {        
        [KHHUser shareInstance].username = _arrDicForCell[0][@"value"];
        [KHHUser shareInstance].password = _arrDicForCell[1][@"value"];
        if (![Card mycard]) {
            [((KHHStartUpViewController *)self.parentViewController.parentViewController) activityText:@"加载我的名片"];
            [self getMyCard];
            return;
        }
        [((KHHStartUpViewController *)self.parentViewController.parentViewController) changeToMain];
    } failure:^(NSMutableDictionary *responseDict) {
        [((KHHStartUpViewController *)self.parentViewController.parentViewController)changeFromView:0 toView:1 isLeft:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - textField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
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
    // [self showPopOverListFor:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 100) {
        _arrDicForCell[0][@"value"] = textField.text;
        if (textField.text.length>=11&&![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField.tag == 101) {
        _arrDicForCell[1][@"value"] = textField.text;
        if (textField.text.length>=12&&![string isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (textField.tag == 101) {
        
        [self login];
    }
    return YES;
}

- (void)hiddenKeyboard
{
    for (int i=100; i<102; i++) {
        UIView *viewPro = [self.view viewWithTag:i];
        if ([viewPro isFirstResponder]) {
            [viewPro resignFirstResponder];
            return;
        }
    }
}

- (void)warnAlertMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}


@end
