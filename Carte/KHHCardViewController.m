//
//  KHHCardViewController.m
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHCardViewController.h"
#import "KHHUser.h"
#import "KHHCardDetailCell.h"
#import "KHHCardDetailHeadCell.h"
#import "KHHEditCardViewController.h"
#import "MBProgressHUD.h"
#import "NetClient+Card.h"
#import "UIImageView+WebCache.h"
#import "KHHCardImageFullLanc.h"
#import "KHHCardFullWithImageView.h"

@interface KHHCardViewController ()
{
    UITableView *_table;
    
    //for head
    KHHCardImageView *_cardView;
    KHHCardImageFullLanc *_cardFull;
    KHHCardFullWithImageView *_cardImage;
    UIView *viewPro;
    UIView *viewProFoot;
    UIImage *_headImg;
    
    //for net
    MBProgressHUD *_hud;
    
    UIImageView *_getImageUtil;
    UIImageView *_getImageUtil2;
}

@end

@implementation KHHCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        _getImageUtil = [[UIImageView alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.barLeftStr = @"返回";
    
   
    
//    self.barLeftAction = ^(){
////        [weakSelf hiddenKeyboard];
////        [[[KHHData sharedData] context] rollback];
////        weakSelf.card.arrForCardView = nil;
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    };
    
    self.barRightStr = @"编辑";
   
   
    
    
    self.view.backgroundColor = [UIColor colorWithRed:241 green:238 blue:232 alpha:1.0];
    _table.frame =  CGRectMake(0, 0, 320, self.view.bounds.size.height-44);
    [self.view addSubview:_table];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_card.arrForCardView count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return [[_card.arrForCardView objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDZero = @"cellIDZero";
    static NSString *cellIDOne = @"cellIDOne";
    
    if (indexPath.section == 0) {
        KHHCardDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDZero];
        if (cell == nil) {
            cell = [[KHHCardDetailHeadCell alloc]init];
        }
        cell.textName = ((ParamUnitDetail *)_card.arrForCardView[0][0]).value;
        cell.textJob =  ((ParamUnitDetail *)_card.arrForCardView[0][1]).value;
        if(_card.logoUrl){
            [_getImageUtil setImageWithURL:[NSURL URLWithString:_card.logoUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                cell.headLogoImage = image;
            }];
        }else if (_getImageUtil.image) {
            cell.headLogoImage = _getImageUtil.image;
        } 
        return cell;
    }
    KHHCardDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDOne];
    ParamUnitDetail *paramPro = (ParamUnitDetail *)[[_card.arrForCardView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[KHHCardDetailCell alloc]init];
        cell.name = paramPro.title;       
    }   
    cell.value = paramPro.value;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        //头像
        return 60;
    }
    return 44;
}


#pragma mark - headImage
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (viewPro) {
            return viewPro;
        }
        viewPro = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 230)];
        _cardImage = [[KHHCardFullWithImageView alloc]initWithFrame:CGRectMake(20, 37, 280, 168)];
        _cardImage.card = _card;
        _cardImage.detail = _card.cardTemplate.detail;
        _cardImage.strUrl = _card.cardTemplate.imageUrl;
        KHHCardFullWithImageView *weakCardImage = _cardImage;
        
        Card *weakCard = _card;
        KHHCardViewController *weakSelf = self;
        _getImageUtil2 = [[UIImageView alloc]init];
      
        self.barRightAction = ^(){
            KHHEditCardViewController *editCardViewConPro = [[KHHEditCardViewController alloc]init];
            editCardViewConPro.card = weakCard;
            editCardViewConPro.editSave = ^(){
                weakSelf.card = [Card objectByID:weakCard.id createIfNone:NO];
                weakCardImage.card = weakSelf.card;
                weakCardImage.detail = weakSelf.card.cardTemplate.detail;
                weakCardImage.strUrl = weakSelf.card.cardTemplate.imageUrl;
               
                [tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:editCardViewConPro animated:YES];
            if (weakSelf.editSave) {
                weakSelf.editSave();
            }
        };
        
      
        
        [viewPro addSubview:_cardImage];
//        UIButton *xJButton = [[UIButton alloc]initWithFrame:CGRectMake(250, 50, 45, 45)];
//        [xJButton setImage:[UIImage imageNamed:@"xiangJ.jpg"] forState:UIControlStateNormal];
//        [xJButton setImage:[UIImage imageNamed:@"xiangJ.jpg"] forState:UIControlStateHighlighted];
//        [xJButton addTarget:self action:@selector(getImage) forControlEvents:UIControlEventTouchUpInside];
//        [viewPro addSubview:xJButton];
        return viewPro;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 230;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == [_card.arrForCardView count]-1) {
        if (viewProFoot ) {
            return viewProFoot;
        }
        viewProFoot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 230)];
        UIButton *toAddressButton = [[UIButton alloc]initWithFrame:CGRectMake(60.0f, 5.0f, 200, 37)];
        toAddressButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [toAddressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [toAddressButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [toAddressButton setBackgroundImage:[[UIImage imageNamed:@"tongbu_normal.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forState:UIControlStateNormal];
        [toAddressButton setTitle:@"保存至手机通讯录" forState:UIControlStateNormal];
        [toAddressButton setTitle:@"保存至手机通讯录"  forState:UIControlStateHighlighted];
        [toAddressButton addTarget:self action:@selector(saveToAddress) forControlEvents:UIControlEventTouchUpInside];
        
        [viewProFoot addSubview:toAddressButton];
        
        UIButton *deleteCard = [[UIButton alloc]initWithFrame:CGRectMake(60.0f, 55.0f, 200, 37)];
        deleteCard.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [deleteCard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [deleteCard setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [deleteCard setBackgroundImage:[[UIImage imageNamed:@"tongbu_normal.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forState:UIControlStateNormal];
        [deleteCard setTitle:@"删除联系人" forState:UIControlStateNormal];
        [deleteCard setTitle:@"删除联系人"  forState:UIControlStateHighlighted];
        
        [deleteCard addTarget:self action:@selector(deleteCard) forControlEvents:UIControlEventTouchUpInside];
        [viewProFoot addSubview:deleteCard];
        return viewProFoot;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == [_card.arrForCardView count]-1){     
         return 230;
     }
    return 0;
}

- (void)saveToAddress
{
    
}

- (void)deleteCard
{
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.labelText = @"删除名片";
    [[NetClient sharedClient] doDelete:_card success:^(NSMutableDictionary *responseDict) {
         [_hud hide:YES];
        if (_editSave) {
            _editSave();
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSMutableDictionary *responseDict) {
        [_hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除失败" message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

@end
