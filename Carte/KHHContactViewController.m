//
//  CustomerListViewController.m
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHContactViewController.h"
#import "CustomerSearchBar.h"
#import "KHHShowGroupViewController.h"
#import "KHHEditCardViewController.h"
#import "myAlertView.h"
#import "Card.h"
#import "KHHCardViewController.h"
#import "KHHActionSheet.h"
#import "NetClient+Group.h"
#import "MBProgressHUD.h"
#import "KHHAlertView.h"
#import "Group+ForView.h"
#import "CardTemplate+ForView.h"
#import "KHHAddDelMemViewController.h"
#import "KHHSearchResCell.h"
#import "NSString+Contain.h"
#import "Card+Search.h"
#import "WEPopoverContainerView.h"
#import "KHHFloatBarController.h"
#import "NetClient+ToPaths.h"
#import "KHHData.h"

@interface KHHContactViewController ()
{
    GroupTable *_groupTable;
    AddGroupView *_addGroupView;
    CustomerTable *_customerTable;
    UISearchDisplayController *_searchDisplayController;
    CustomerSearchBar *_searchBar;
    
    MBProgressHUD *_hud;
    
    NSMutableArray *_arrSearchPro;
    NSArray *_resultArray;
    WEPopoverController *_popover;
    KHHFloatBarController *_floatBarViewCon;
}

@end

@implementation KHHContactViewController
{
    Group *_groupTemp;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _groupTable = [[GroupTable alloc]init];
        _groupTable.groupActionDelegate = self;
        
        
        _customerTable = [[CustomerTable alloc]init];
        _customerTable.isCoWorker = NO;
        _customerTable.customerCellDelegate = self;
        _customerTable.addCustomerCellDelegate = self;
        
        _searchBar = [[CustomerSearchBar alloc]init];
        _searchBar.delegate = self;
        KHHContactViewController *weakSelf = self;
        _searchBar.showGroup = ^(){
            KHHShowGroupViewController *showGroupViewConPro = [[KHHShowGroupViewController alloc]init];
            [weakSelf.navigationController pushViewController:showGroupViewConPro animated:YES];
        };
        _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        _searchDisplayController.delegate = self;
        _searchDisplayController.searchResultsDataSource = self;
        _searchDisplayController.searchResultsDelegate = self;
        
      //  _groupTable.arrGroupList = [Group allGroups];
//        for (int i=0; i<10; i++) {            
//            
//            InterCustomer *interCustomer = [[InterCustomer alloc]init];
//            interCustomer.id = [NSString stringWithFormat:@"%d",i];
//            interCustomer.name = @"jone";
//            interCustomer.roleType = @"毒品调剂师";
//            interCustomer.mobileList = @"13645457885|13556894578";
//            interCustomer.companyName = @"金山角毒品交易集团";
//            [_customerTable.arrCustomerList addObject:interCustomer];
//        }
        
    }
     return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _groupTable = [[GroupTable alloc]init];
        _groupTable.groupActionDelegate = self;
        
        
        _customerTable = [[CustomerTable alloc]init];
        _customerTable.isCoWorker = NO;
        _customerTable.customerCellDelegate = self;
        _customerTable.addCustomerCellDelegate = self;
        
        _searchBar = [[CustomerSearchBar alloc]init];
        _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        _searchDisplayController.searchResultsDataSource = self;
        _searchDisplayController.searchResultsDelegate = self;
        
        
//        for (int i=0; i<10; i++) {            
//            
//            InterCustomer *interCustomer = [[InterCustomer alloc]init];
//            interCustomer.id = [NSString stringWithFormat:@"%d",i];
//            interCustomer.name = @"jone";
//            interCustomer.roleType = @"毒品调剂师";
//            interCustomer.mobileList = @"13645457885|13556894578";
//            interCustomer.companyName = @"金山角毒品交易集团";
//            [_customerTable.arrCustomerList addObject:interCustomer];
//        }
        
    }
    return self;
}

- (void)doInitWithUser
{
    _groupTable.selectGroupId = -2;
    _groupTable.arrGroupList = [Group allGroups];
    [_groupTable reloadData];
    [_groupTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self oneTouchGroup:[Group createGroupAll]];
    [_groupTable showNewContactsNum];
}

- (void)groudReload
{
    _groupTable.arrGroupList = [Group allGroups];
    NSLog(@"%d",_groupTable.selectGroupId);
    
    [self doInselfGroupTempRefresh];
    [self oneTouchGroup:_groupTemp];
    [_groupTable reloadData];
    [_groupTable showNewContactsNum];
}

- (void)doInselfGroupTempRefresh
{
    for (Group *group in _groupTable.arrGroupList) {
        if (group.idValue == _groupTable.selectGroupId) {
            _groupTemp = group;
            return;
        }
    }
    _groupTemp = [Group createGroupAll];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _groupTable.frame = CGRectMake(0, 44, 75, self.view.frame.size.height-44-44-60-50);
    
    _addGroupView = [[AddGroupView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44-60-50, 75, 60)];
    _addGroupView.delegate = self;
    
    _customerTable.frame = CGRectMake(76,44,245,self.view.frame.size.height-44-44-50);
    
    [self.view addSubview:_searchBar];
	[self.view addSubview:_groupTable];
    [self.view addSubview:_addGroupView];
    [self.view addSubview:_customerTable];
    
}


#pragma mark - GroupCellDelegate
- (void)oneTouchGroup:(Group *)group
{    
    self.navigationItem.title = group.name;
    _groupTable.selectGroupId = group.idValue;
    _groupTemp = group;
    [_customerTable.arrCustomerList removeAllObjects];
    if (group.typeValue == type_group_all) {
        [_customerTable.arrCustomerList addObjectsFromArray:[Group allGroupCard]];
    }else{
        [_customerTable.arrCustomerList addObjectsFromArray:[group allCard]];
    }
    [_customerTable reloadData];
}

- (void)towTouchGroup:(Group *)group
{
    _groupTemp = group;
    if (group.typeValue == type_group_all||group.typeValue == type_group_unpage) {
        return;
    }
    KHHActionSheet *actSheet = [[KHHActionSheet alloc] initWithTitle:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"添加组员",@"移除组员",@"修改组名",@"删除分组", nil];
    [actSheet.dic setValue:group forKey:@"group"];
    [actSheet showInView:self.navigationController.tabBarController.view];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    Group *group = [((KHHActionSheet *)actionSheet).dic objectForKey:@"group"];
    if (buttonIndex == 0) {
        KHHAddDelMemViewController *addDelViewConPro = [[KHHAddDelMemViewController alloc]init];
        addDelViewConPro.group = [Group objectByKey:@"type" value:[NSNumber numberWithInt:type_group_unpage] createIfNone:NO];
        addDelViewConPro.toGroup = _groupTemp;
        addDelViewConPro.editSave = ^(){
            [self refresh];            
        };
        [self.navigationController pushViewController:addDelViewConPro animated:YES];
    }
    if (buttonIndex == 1) {
        KHHAddDelMemViewController *addDelViewConPro = [[KHHAddDelMemViewController alloc]init];
        addDelViewConPro.group = _groupTemp;
        addDelViewConPro.editSave = ^(){[self refresh];};
        [self.navigationController pushViewController:addDelViewConPro animated:YES];
    }
    if (buttonIndex == 2) {        
        myAlertView *_alert = [[myAlertView alloc] initWithTitle:@"修改组名"
                                                         message:nil
                                                        delegate:self
                                                           style:kMyAlertStyleTextField
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:@"取消",nil];
        _alert.Tf.text = group.name;
        _alert.tag = 302;
        [_alert show];
    }
    
    if (buttonIndex == 3) {
        KHHAlertView *alert = [[KHHAlertView alloc] initWithTitle:NSLocalizedString(@"删除", nil)
                                                        message:NSLocalizedString(@"将会删除该组", nil)
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:@"取消",nil];
        [alert.dic setValue:group forKey:@"group"];
        alert.tag = 301;
        [alert show];
        return;
    }
   
}

#pragma mark - actionCustomer delegate

- (void)showPopVp:(CustomerCell *)customerCell
{
    if(!_floatBarViewCon){
        _floatBarViewCon = [[KHHFloatBarController alloc] initWithNibName:nil bundle:nil];
        _floatBarViewCon.viewController = self;
    }
    _floatBarViewCon.card = customerCell.card;
    if (!_popover) {
        _popover = [[WEPopoverController alloc] initWithContentViewController:_floatBarViewCon];
    }
    if (!_floatBarViewCon.popover) {
        _floatBarViewCon.popover = _popover;
    }
    CGRect cellRect = customerCell.frame;
    // cellRect.origin.x = 0;
    CGRect rect = [_customerTable convertRect:cellRect toView:self.view];
    rect.origin.x = 20;
    UIPopoverArrowDirection arrowDirection = rect.origin.y < self.view.bounds.size.height/2?UIPopoverArrowDirectionUp:UIPopoverArrowDirectionDown;
    [_popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:arrowDirection animated:YES];
//    // NSLog(@"showPopVp%@",interCustomer.id);
    
}

- (void)showDetail:(CustomerCell *)customerCell
{
    KHHCardViewController *cardViewConPro = [[KHHCardViewController alloc]init];
    cardViewConPro.card = customerCell.card;
    if (!cardViewConPro.card.viewedValue) {
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:1];
        dicParam[@"cardId"] = cardViewConPro.card.id;
        [[NetClient sharedClient] doInselfPath:@"post" methodPath:@"mobile/contact/viewed" parameters:dicParam success:^(NSMutableDictionary *responseDict) {
            cardViewConPro.card.viewedValue = YES;
            [[KHHData sharedData] saveContext];
            [self refresh];
        } failure:^(NSMutableDictionary *responseDict) {
             cardViewConPro.card.viewedValue = NO;
        }];
    }
    cardViewConPro.editSave = ^(){[self refresh];};
    [self.navigationController pushViewController:cardViewConPro animated:YES];
}

- (void)addNew
{
    KHHEditCardViewController *editCardViewConPro = [[KHHEditCardViewController alloc]init];
    editCardViewConPro.card = [Card newObject];
    if (_groupTemp.typeValue == type_group_all) {
        editCardViewConPro.card.group = [Group createGroupUnPacket];
    }else{
        editCardViewConPro.card.group = _groupTemp;
    }
    editCardViewConPro.card.address = [Address newObject];
    editCardViewConPro.card.cardTemplate = [CardTemplate defaultTemplate];
    editCardViewConPro.editSave = ^(){[self refresh];};
    [self.navigationController pushViewController:editCardViewConPro animated:YES];//    [self.navigationController pushViewController:[[KHHNewEdit_ecardViewController alloc]init] animated:YES];
    NSLog(@"addNew");
}

- (void)refresh
{
    _arrSearchPro = nil;
    [self groudReload];
    
}
#pragma mark - addGroupAction

- (void)addGroupAction
{
    myAlertView *_alert = [[myAlertView alloc] initWithTitle:@"新建分组"
                                                     message:nil
                                                    delegate:self
                                                       style:kMyAlertStyleTextField
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:@"取消"];
    _alert.tag = 300;
    [_alert show];
}

#pragma mark - searBar tableview dataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_resultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"searchCell";
    KHHSearchResCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[KHHSearchResCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.card = _resultArray[indexPath.row];
    return cell;
    
}

//- (void)refreshSearch
//{
//    _searchDisplayController 
//}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KHHCardViewController *cardViewConPro = [[KHHCardViewController alloc]init];
    cardViewConPro.card = _resultArray[indexPath.row];
    cardViewConPro.editSave = ^(){
        [self refresh];
        [tableView reloadData];
    };
    [self.navigationController pushViewController:cardViewConPro animated:YES];
}

#pragma mark - UISearchDisplayDelegate

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (!_resultArray) {
        _resultArray = [[NSArray alloc] init];
    }
    
    NSPredicate *predicateCard = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind){
        Card *card = (Card *)obj;        
        return [card searchRes:searchString];
    }];   
    _resultArray = [[Group allGroupCard] filteredArrayUsingPredicate:predicateCard];
    return YES;
}



#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - alert delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 300) {       
        if (buttonIndex == 0) {
            myAlertView *alertPro = (myAlertView *)alertView;            
            if (alertPro.Tf.text.length==0) {
                return;
            }
            if ([self isInGroupNameDefault:alertPro.Tf.text]||[Group objectByKey:@"name" value:alertPro.Tf.text createIfNone:NO]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不能创建同名分组"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                return;
            }
            NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:2];
            dicParam[@"name"] = alertPro.Tf.text;
            dicParam[@"idx"] = @"0";
            _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            _hud.labelText = @"创建分组";
            [[NetClient sharedClient]doAddGroup:dicParam success:^(NSMutableDictionary *responseDict) {
                [_hud hide:YES];
                [self groudReload];
               // [_groupTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:_groupTable.currentIndexPath] withRowAnimation:UITableViewRowAnimationNone ];
               // [_groupTable selectRowAtIndexPath:_groupTable.currentIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
            } failure:^(NSMutableDictionary *responseDict) {
                [_hud hide:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"创建分组失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }];
        }
    }
    
    if (alertView.tag == 301) {
        if (buttonIndex == 0) {
            KHHAlertView *alertPro = (KHHAlertView *)alertView;
            _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            _hud.labelText = @"删除分组";
            [[NetClient sharedClient]doDeleteGroup:[NSString stringWithFormat:@"%@",((Group *)alertPro.dic[@"group"]).id] success:^(NSMutableDictionary *responseDict) {
                [_hud hide:YES];
                [self groudReload];
               // NSLog(@"%d",[_groupTable.arrGroupList indexOfObject:_groupTemp]); //_groupTemp
               // [_groupTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            } failure:^(NSMutableDictionary *responseDict) {
                [_hud hide:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除分组失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }];
        }
    }
    
    if (alertView.tag == 302) {
        if (buttonIndex == 0) {
            myAlertView *alertPro = (myAlertView *)alertView; 
            _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            _hud.labelText = @"修改分组名称";
            NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:2];
            dicParam[@"id"] = _groupTemp.id;
            dicParam[@"name"] = alertPro.Tf.text;
            dicParam[@"idx"] = @"0";
            [[NetClient sharedClient]doModifyGroup:dicParam  success:^(NSMutableDictionary *responseDict) {
                [_hud hide:YES];
                
                [self groudReload];
              //  [_groupTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:_groupTable.currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
              //  [_groupTable selectRowAtIndexPath:_groupTable.currentIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                //:_groupTable.currentIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
            } failure:^(NSMutableDictionary *responseDict) {
                [_hud hide:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改组名失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }];
        }
    }
    
}

- (Boolean)isInGroupNameDefault:(NSString *)name{
    NSArray *arrPro =[NSArray arrayWithObjects:@"所有",@"未分组",@"同事",@"手机",nil];
    for (NSString *strPro in arrPro) {
        if([name isEqualToString:strPro]){
            return YES;
        }
    }
    return NO;
}



@end
