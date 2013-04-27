//
//  KHHAddDelMemViewController.m
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHAddDelMemViewController.h"
#import "KHHAddDeleteTable.h"
#import "MBProgressHUD.h"
#import "NetClient+Card.h"
#import "Card+Search.h"
#import "KHHSearchResCell.h"

@interface KHHAddDelMemViewController ()
{
    KHHAddDeleteTable *_addDeleteTable;
   // NSMutableArray *arrCardDic;
    
    UISearchBar *_searchBar;
    KHHSearDisplayController *_searchDisplayController;
    
    UIView *_footView;
    UILabel *_labelNum;
    UIButton *_sureBtn;    
    UIButton *_cancelBtn;
    MBProgressHUD *_hud;
    
    //for search
    NSArray *_resultArray;
    NSMutableArray *_checkArr;
    Boolean _searching;
    
    NSString *_strType;
    NSString *_strTitlePro;
    
}

@end

@implementation KHHAddDelMemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //arrCardDic = [[NSMutableArray alloc]init];
        _addDeleteTable = [[KHHAddDeleteTable alloc]initWithFrame:CGRectZero];
        
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        _searchBar.backgroundImage = [UIImage imageNamed:@"searchbar_bg_normal"];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入姓名、电话或者公司";
        _searchDisplayController = [[KHHSearDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        _searchDisplayController.searchResultsDataSource = self;
        _searchDisplayController.searchResultsDelegate = self;
        _searchDisplayController.delegate = self;
        
        
        [_cancelBtn setBackgroundImage:[[UIImage imageNamed:@"tongbu_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)] forState:UIControlStateNormal];
       
      //  [self initSubs];
    }
    return self;
}


- (void)initSubs
{
    _footView = [[UIView alloc]init];
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 13, 111, 37)];
    _cancelBtn= [[UIButton alloc]initWithFrame:CGRectMake(183, 13, 111, 37)];
    
    [_sureBtn setBackgroundImage:[[UIImage imageNamed:@"tongbu_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)] forState:UIControlStateNormal];
    [_sureBtn setTitle:_group.typeValue == type_group_unpage?@"添加":@"移除" forState:UIControlStateNormal];
    [_sureBtn setTitle:type_group_unpage?@"添加":@"移除" forState:UIControlStateHighlighted];
    [_sureBtn addTarget:self action:@selector(addDeleNet) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setBackgroundImage:[[UIImage imageNamed:@"tongbu_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)] forState:UIControlStateNormal];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
    [_cancelBtn addTarget:self action:@selector(cancelPop) forControlEvents:UIControlEventTouchUpInside];
    _labelNum = [[UILabel alloc]initWithFrame:CGRectMake(96, 19, 33, 21)];
    _labelNum.backgroundColor = [UIColor clearColor];
    _labelNum.font = [UIFont systemFontOfSize:10.0];
    
}

- (void)setGroup:(Group *)group
{
    _group = group;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barLeftStr = @"返回";
    _strTitlePro = _toGroup?@"添加":@"移除";
    self.barRightStr = _strTitlePro;
    KHHAddDelMemViewController *weakSelf = self;
    self.barRightAction = ^(){[weakSelf addDeleNet];};
	_addDeleteTable.frame = CGRectMake(0,44,320,self.view.frame.size.height-44-44);
    _addDeleteTable.group = _group;
    NSString *weakStr = _strTitlePro;
    KHHAddDeleteTable *weakTable = _addDeleteTable;
    _addDeleteTable.changeNum = ^(){
        weakSelf.barRightStr = [NSString stringWithFormat:@"%@(%d)",weakStr,[weakTable.arrSelectCard count]];
    };
    
//    _footView.frame = CGRectMake(0, self.view.frame.size.height-44-80, 320, 70);
//    [_footView addSubview:_sureBtn];
//    [_footView addSubview:_cancelBtn];
//    [_footView addSubview:_labelNum];
    //[_searchDisplayController.searchContentsController.view addSubview:_sureBtn];
    [self.view addSubview:_addDeleteTable];
    //[self.navigationController.navigationBar addSubview:_searchBar];
    [self.view addSubview:_searchBar];
   // [self.view addSubview:_footView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action
- (void)cancelPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addDeleNet
{
    NSArray *_arrPro = _searching?_checkArr:_addDeleteTable.arrSelectCard;  
    
    if ([_arrPro count] == 0) {
       // [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.labelText = _group.typeValue == type_group_unpage?@"添加组员":@"移除组员";
   _strType  = _toGroup?@"add":@"del";
    NSString *groupId = [NSString stringWithFormat:@"%@",_toGroup?_toGroup.id:_group.id];
    NSMutableString *cardIds = [[NSMutableString alloc]initWithCapacity:[_arrPro count]];
    for (int i=0; i<[_arrPro count]; i++) {
        Card *card = _arrPro[i];
        if (i == 0) {
            [cardIds appendFormat:@"%@",card.id];
            continue;
        }
        [cardIds appendFormat:@"|%@",card.id];
    }
    
    [[NetClient sharedClient] doMoveCard:_strType cardIds:cardIds groupId:groupId success:^(NSMutableDictionary *responseDict) {
        [_hud hide:YES];
        if (_editSave) {
            _editSave();
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSMutableDictionary *responseDict) {
        [_hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_toGroup?@"添加组员失败":@"删除组员失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
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
        cell.type_search = type_search_check;
    }
    cell.card = _resultArray[indexPath.row];
    if ([_checkArr containsObject:_resultArray[indexPath.row]]) {
        cell.checkon = YES;
    }else{
        cell.checkon = NO;
    }
    return cell;
    
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_checkArr containsObject:_resultArray[indexPath.row]]) {
        [_checkArr removeObject:_resultArray[indexPath.row]];
    }else{
        [_checkArr addObject:_resultArray[indexPath.row]];
    }
   self.barRightStr = [NSString stringWithFormat:@"%@(%d)",_strTitlePro,[_checkArr count]];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - UISearchDisplayDelegate

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (!_resultArray) {
        _resultArray = [[NSArray alloc] init];
    }
    
    NSPredicate *findFutureDates = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind){
        Card *card = (Card *)obj;
        return [card searchRes:searchString];
    }];
    _resultArray = [[_group.cardSet allObjects] filteredArrayUsingPredicate:findFutureDates];
    
    if (!_checkArr) {
        _checkArr = [[NSMutableArray alloc]init];
    }
    [_checkArr removeAllObjects];
    self.barRightStr = [NSString stringWithFormat:@"%@(%d)",_strTitlePro,[_checkArr count]];
    return YES;
}

- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{    
    _searching = YES;
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
     _searching = NO;
    self.barRightStr = [NSString stringWithFormat:@"%@(%d)",_strTitlePro,[_addDeleteTable.arrSelectCard count]];
}



- (void)initSureBtn
{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 111, 37)];
        [_sureBtn setBackgroundImage:[[UIImage imageNamed:@"tongbu_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)] forState:UIControlStateNormal];
        [_sureBtn setTitle:_group.typeValue == type_group_unpage?@"添加":@"移除" forState:UIControlStateNormal];
        [_sureBtn setTitle:type_group_unpage?@"添加":@"移除" forState:UIControlStateHighlighted];
        [_sureBtn addTarget:self action:@selector(addDeleNet) forControlEvents:UIControlEventTouchUpInside];
    }
        
}

@end
