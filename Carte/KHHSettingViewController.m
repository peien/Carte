//
//  KHHSettingViewController.m
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHSettingViewController.h"
#import "ModifyViewController.h"
#import "KHHWebView.h"
#import "KHHStartUpViewController.h"

@interface KHHSettingViewController ()
{
    UITableView *_table;
    NSMutableArray *_arrSettingStr;
}

@end

@implementation KHHSettingViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initArr];
    _table.frame =  CGRectMake(0, 0, 320, self.view.bounds.size.height-44-49);
    [self.view addSubview:_table];
	// Do any additional setup after loading the view.
}

- (void)initArr
{
    _arrSettingStr = [[NSMutableArray alloc]initWithCapacity:3];
    NSArray *arrSection1 = [[NSArray alloc]initWithObjects:@"修改密码",@"登出", nil];
    NSArray *arrSection2 = [[NSArray alloc]initWithObjects:@"检查更新",@"软件更新方式设置", nil];
    NSArray *arrSection3 = [[NSArray alloc]initWithObjects:@"使用指南",@"推荐给好友",@"联系我们",@"关于名片宝", nil];
    [_arrSettingStr addObject:arrSection1];
    [_arrSettingStr addObject:arrSection2];
    [_arrSettingStr addObject:arrSection3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrSettingStr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrSettingStr[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDZero = @"cellIDZero";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDZero];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _arrSettingStr[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ModifyViewController *modVC = [[ModifyViewController alloc] initWithNibName:@"ModifyViewController" bundle:nil];
            [self.navigationController pushViewController:modVC animated:YES];
        }else if (indexPath.row == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"登出", nil)
                                                            message:@"确定要登出吗"
                                                           delegate:self                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            KHHWebView *webView = [[KHHWebView alloc] initWithNibName:nil bundle:nil];
            //[webView initUrl: title:@"使用指南" rightBarName:nil rightBarBlock:nil];
            [self.navigationController pushViewController:webView animated:YES];
        }else if (indexPath.row == 1) {
//            RecomFridendsViewController *recomVC = [[RecomFridendsViewController alloc] initWithNibName:@"RecomFridendsViewController" bundle:nil];
//            [self.navigationController pushViewController:recomVC animated:YES];
        }else if (indexPath.row == 2) {
            //客户反馈
            KHHWebView *webView = [[KHHWebView alloc] initWithNibName:nil bundle:nil];
//            [webView initUrl:KHHURLContactUs title:@"客户反馈" rightBarName:nil rightBarBlock:nil];
            [self.navigationController pushViewController:webView animated:YES];
        }else if (indexPath.row == 3){
//            AboutController *aboutVC = [[AboutController alloc] initWithNibName:nil bundle:nil];
           // [self.navigationController pushViewController:aboutVC animated:YES];
        }
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
//    if (alertView.tag == KHHAlertMessage||alertView.tag == KHHAlertContact) {
//        return;
//    }
    
    if (buttonIndex == 1) {
         [((KHHStartUpViewController *)self.parentViewController.parentViewController.parentViewController) logout];
    }
    
}


@end
