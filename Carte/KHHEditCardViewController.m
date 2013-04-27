//
//  KHHEditCardViewController.m
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHEditCardViewController.h"
#import "KHHInputTableView.h"
#import "ParamForEditecard.h"
#import "KHHLocalForCardCell.h"
#import "HZAreaPickerView.h"
#import "KHHEditCardCell.h"
#import "NSString+Validation.h"
#import "KHHMemoPicker.h"
#import "KHHBrowseTemplateViewController.h"
#import "KHHBrowseTemplateSrcollViewController.h"
#import "KHHUser.h"
#import "AGViewController.h"
#import "AGHeadImageViewController.h"
#import "NetClient+Card.h"
#import "Card+NetParam.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "KHHCardImageFullLanc.h"
#import "KHHBrowseTemplateSameImage.h"
#import "KHHAlertSelectDetail.h"
#import "KHHCardFullWithImageView.h"

@interface KHHEditCardViewController ()
{
    __block KHHInputTableView *_table;
    
    //forInitView
    NSMutableDictionary *_dicCardItemFromTag;
    
    //for head
    __block KHHCardImageView *_cardView;
    KHHCardImageFullLanc * _cardFull;
    KHHCardFullWithImageView *_cardImage;
    UIView *viewPro;
    //for location
    NSString *locationStr;
    HZAreaPickerView *areaPicker;
    
    //for picker
    KHHMemoPicker *sectionPicker;
    NSIndexPath *indexPathForEditPicker;
    ParamForEditecard *editingParamPorPicker;
    
    //for imagePicker;
    int typePickerGoTo;
    int _currentTag;
    UIImage *_headImg;
    
    //for net
    MBProgressHUD *_hud;
    
    UIImageView *_getImageUtil;
    UIImageView *_getImageUtil2;
    Boolean reloadCell;
}
@end

@implementation KHHEditCardViewController

- (void)initWith2Method
{
    _table = [[KHHInputTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _table.editing = YES;
    //_card = [KHHUser shareInstance].card;
    _getImageUtil = [[UIImageView alloc]init];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initWith2Method];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initWith2Method];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barLeftStr = @"返回";
    
    KHHEditCardViewController *weakSelf = self;
    
    self.barLeftAction = ^(){
        [weakSelf hiddenKeyboard];
        [[[KHHData sharedData] context] rollback];
        weakSelf.card.arrForEditView = nil;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.barRightStr = @"保存";
    self.barRightAction = ^(){
        [weakSelf hiddenKeyboard];
        [weakSelf reloadTable];
        [weakSelf saveCardNet:!weakSelf.isForMyCard];
    };
    
    self.view.backgroundColor = [UIColor colorWithRed:241 green:238 blue:232 alpha:1.0];
    _table.frame =  CGRectMake(0, 0, 320, self.view.bounds.size.height-44-(_isForMyCard?50:0));
    [self.view addSubview:_table];
    //[self addImg];
	// Do any additional setup after loading the view.
}

- (void)reloadTable
{
    [_card save];
    _card.arrForEditView = nil;
    [_table reloadData];
}

- (void)saveCardNet:(Boolean)isPop
{
    
    KHHEditCardViewController *weakSelf = self;
    
    NSDictionary *dicParam = _card.idValue!=0?[_card netParam0ForEdit]:[_card netParam1ForNew];
    __block NSString *strReturn = _card.idValue!=0?@"修改名片失败":@"创建名片失败";
    if (![self validate:dicParam]) {
        return;
    }
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.labelText = _card.idValue!=0?@"修改名片":@"创建名片";
    
    NSMutableArray *arrImageDic = [[NSMutableArray alloc]initWithCapacity:2];
    if (_headImg) {
        NSDictionary *imageDic = [[NSDictionary alloc]initWithObjectsAndKeys:_headImg,@"logoImg", nil];
        [arrImageDic addObject:imageDic];
    }
    NSMutableDictionary *dicProDetail;
    if (_bgImg) {
        NSDictionary *imageDic = [[NSDictionary alloc]initWithObjectsAndKeys:_bgImg,@"templateBackImg", nil];
        [arrImageDic addObject:imageDic];
        dicProDetail = [[NSMutableDictionary alloc]initWithCapacity:2];
        dicProDetail[@"detailId"] = _cardImage.detail.id;
    }
    
    [[NetClient sharedClient] doUpCreateCard:_card dicDetail:dicProDetail success:^(NSMutableDictionary *responseDict) {
        _hud.labelText = [NSString stringWithFormat:@"%@成功",_hud.labelText];
        [_hud hide:YES];
        weakSelf.card.arrForEditView = nil;
        if (isPop) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        
        if (weakSelf.editSave) {
            weakSelf.editSave();
        }
    } failure:^(NSMutableDictionary *responseDict) {
        [_hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strReturn message:responseDict[@"note"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } arrImageDic:arrImageDic];
}

#pragma mark - head
- (void)addImg
{
    //    if (_card) {
    //        UIView *viewPro = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    //        _cardView = [[KHHCardImageView alloc]initWithFrame:CGRectMake(20, 37, 280, 180)];
    //        [viewPro addSubview:_cardView];
    //        _table.tableHeaderView = viewPro;
    //    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_table showNormal];
    if (sectionPicker) {
        [sectionPicker cancelPicker:YES];
    }
    if (areaPicker) {
        [areaPicker cancelPicker:YES];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

//
//- (void)init3ArrPro:(NSMutableArray *)arrPro sectionArr:(NSMutableArray *)sectionArr section:(int)section
//{
//    for (int i=0; i<[arrPro count]; i++) {
//        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:arrPro[i] placeholder:[NSString stringWithFormat:@"请输入%@",arrPro[i]]];
//        paramPro.boardType = UIKeyboardTypeNamePhonePad;
//        paramPro.tag = 2400 +section*100 +i;
//        [sectionArr addObject:paramPro];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return [[_card.arrForEditView objectAtIndex:section] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDZero = @"cellIDZero";
    static NSString *cellIDOne = @"cellIDOne";
    static NSString *cellLocal = @"cellLocal";
    if (indexPath.section == 0) {
        KHHHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDZero];
        if (!cell) {
            cell = [[KHHHeadCell alloc]init];
            cell.delegate = self;
            cell.tagName = ((ParamForEditecard *)_card.arrForEditView[0][0]).tag;
            cell.tagJob = ((ParamForEditecard *)_card.arrForEditView[0][1]).tag;
            cell.pickDelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // [cell becameFirstRes];
        }
        
        cell.textName = ((ParamForEditecard *)_card.arrForEditView[0][0]).value;
        cell.textJob = ((ParamForEditecard *)_card.arrForEditView[0][1]).value;
        if (_headImg) {
            cell.headImg = _headImg;
            return cell;
        }
        
        if (_getImageUtil.image) {
            cell.headImg = _getImageUtil.image;
            return cell;
        }
        if (_card.logoUrl) {
            [_getImageUtil setImageWithURL:[NSURL URLWithString:_card.logoUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                cell.headImg = image;
            }];
        }
        return cell;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        KHHLocalForCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellLocal];
        if (!cell) {
            cell = [[KHHLocalForCardCell alloc]init];
            cell.localTip = ^(){[self showLocalPicker:indexPath];};
        }
        ParamForEditecard *paramPro = (ParamForEditecard *)_card.arrForEditView[2][1];
        ((KHHLocalForCardCell *)cell).headStr = @"地址";
        ((KHHLocalForCardCell *)cell).field.delegate = self;
        ((KHHLocalForCardCell *)cell).field.tag = paramPro.tag;
        ((KHHLocalForCardCell *)cell).field.text = paramPro.value;
        //  NSLog(@"tag%d",cell.field.tag);
        if (paramPro.city) {
            ((KHHLocalForCardCell *)cell).locationStr = [NSString stringWithFormat:@"%@ %@",paramPro.province,paramPro.city];
        }else{
            ((KHHLocalForCardCell *)cell).locationStr = @"请选择省市";
        }
        return cell;
    }
    KHHEditCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDOne];
    ParamForEditecard *paramPro = (ParamForEditecard *)[[_card.arrForEditView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (!cell) {
        cell = [[KHHEditCardCell alloc]init];
        cell.name = paramPro.title;
        cell.tagValue = paramPro.tag;
        cell.placeholder = paramPro.placeholder;
        cell.delegate = self;
        cell.boardType = paramPro.boardType;
    }
    if (paramPro.editingStyle == UITableViewCellEditingStyleInsert) {
        cell.name = paramPro.title;
        cell.valueEnable = NO;
        return cell;
    }
    cell.value = paramPro.value;
    cell.worn = paramPro.worn;
    if (!paramPro.indexPath) {
        paramPro.indexPath = indexPath;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        //头像
        return 60;
    }else if (indexPath.section == 2 && indexPath.row == 1)
    {
        //地址编辑框
        return 70;
    }
    return 44;
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParamForEditecard *paramPro = (ParamForEditecard *)[[_card.arrForEditView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return paramPro.editingStyle;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (editingStyle == UITableViewCellEditingStyleInsert ) {
        [self hiddenKeyboard];
        if (!sectionPicker) {
            sectionPicker = [[ KHHMemoPicker alloc] initWithFrame:CGRectMake(0.0,H460-200.0,320.0,200.0)];
            sectionPicker.hidden = YES;
            
            
            __block KHHEditCardViewController *weakself = self;
            sectionPicker.showTitle = ^(NSString *title, int tag){
                [weakself addToExternArrayFromPick:title];
            };
            
        }
        
        ParamForEditecard *paramPro = (ParamForEditecard *)[[_card.arrForEditView objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        
        sectionPicker.memoArr = paramPro.toPicker;
        if (sectionPicker.hidden) {
            CGRect rectForKey = [tableView cellForRowAtIndexPath:indexPath].frame;
            rectForKey = CGRectMake(rectForKey.origin.x, rectForKey.origin.y+30, rectForKey.size.width, rectForKey.size.height);
            [_table goToInsetForKeyboard:rectForKey];
            [sectionPicker showInView:self.view ];
        }else{
            [_table showNormal];
        }
        
        
        editingParamPorPicker = paramPro;
        indexPathForEditPicker = indexPath;
        // [self.navigationController pushViewController:sectionPicker animated:YES];
        
        
    }else if (editingStyle == UITableViewCellEditingStyleDelete){
        
        [self hiddenKeyboard];
        [_table showNormal];
        
        ParamForEditecard * paramPro = (ParamForEditecard *)[[_card.arrForEditView objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        if (indexPath.section == 1) {
            [_card doDeleteParamSection1:paramPro reloadSection:^{
                [_table reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        if (indexPath.section == 2) {
            [_card doDeleteParamSection2:paramPro reloadSection:^{
                [_table reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        if (indexPath.section == 3) {
            [_card doDeleteParamSection3:paramPro reloadSection:^{
                [_table reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        
        //        NSMutableArray *sectionPro = [_card.arrForEditView objectAtIndex:indexPath.section];
        //
        //        ParamForEditecard * paramPro2;
        //
        //        if (!((ParamForEditecard *)[[_card.arrForEditView objectAtIndex:indexPath.section]lastObject]).toPicker) {
        //            NSString *title = @"添加";
        //            if (indexPath.section == 3) {
        //                title = @"添加更多";
        //            }
        //            paramPro2 = [[ParamForEditecard alloc]init];
        //            paramPro2.editingStyle = UITableViewCellEditingStyleInsert;
        //            paramPro2.title = title;
        //            paramPro2.toPicker = [[NSMutableArray alloc]initWithObjects:paramPro.title, nil];
        //            paramPro2.forPickerToDel = YES;
        //        }else{
        //            paramPro2 = [sectionPro objectAtIndex:sectionPro.count-1];
        //            if (paramPro2.forPickerToDel) {
        //                [paramPro2.toPicker addObject:paramPro.title];
        //            }
        //
        //
        //        }
        //        [sectionPro removeObject:paramPro];
        //        [_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
        //        if (![sectionPro containsObject:paramPro2]) {
        //            [sectionPro addObject:paramPro2];
        //
        //            [_table insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:sectionPro.count-1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
        //        }
        
    }
}
#pragma mark - headImage
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (viewPro ) {
            return viewPro;
        }
        viewPro = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 230)];

        _cardImage = [[KHHCardFullWithImageView alloc]initWithFrame:CGRectMake(20, 37, 280, 168)];
        _cardImage.card = _card;
        _cardImage.detail = _card.cardTemplate.detail;
        _cardImage.strUrl = _card.cardTemplate.imageUrl;
        KHHCardFullWithImageView *weakCardImage = _cardImage;
        Card *weakCard = _card;
       
        KHHEditCardViewController *weakSelf = self;
        _cardImage.touchAction = ^(){
            KHHBrowseTemplateViewController *tempBrowseViewConPro = [[KHHBrowseTemplateViewController alloc]init];
            tempBrowseViewConPro.card = weakCard;
            
            tempBrowseViewConPro.selectOne = ^(CardTemplate *templateSelect){
                weakCardImage.detail = templateSelect.detail;
                weakCardImage.strUrl = templateSelect.imageUrl;
                weakSelf.bgImg = nil;
                weakCard.cardTemplate = templateSelect;
                               
            };
            [weakSelf.navigationController pushViewController:tempBrowseViewConPro animated:YES];
        };
        [viewPro addSubview:_cardImage];
        UIButton *xJButton = [[UIButton alloc]initWithFrame:CGRectMake(250, 150, 45, 45)];
        [xJButton setImage:[UIImage imageNamed:@"ic_photo"] forState:UIControlStateNormal];
        [xJButton setImage:[UIImage imageNamed:@"ic_photo_selected"] forState:UIControlStateHighlighted];
        [xJButton sizeToFit];
        [xJButton addTarget:self action:@selector(getImage) forControlEvents:UIControlEventTouchUpInside];
        [viewPro addSubview:xJButton];
        return viewPro;
    }
    return nil;
}

#pragma mark - addImage

- (void)pickImage
{
    
    typePickerGoTo = 1;
    [self getImage];
}

- (void)getImage
{
    
    [_table showNormal];
    [self hiddenKeyboard];
    if (typePickerGoTo ==1&& (!((ParamForEditecard *)_card.arrForEditView[0][0]).value || [((ParamForEditecard *)_card.arrForEditView[0][0]).value isEqualToString:@""]) ) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先输入姓名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return;
    }
    
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:nil, nil];
    
    [actSheet addButtonWithTitle:@"本地相册"];
    [actSheet addButtonWithTitle:@"拍照"];
    actSheet.tag = 10010;
    [actSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 2 ){
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"不支持拍照" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else{
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self.navigationController.tabBarController presentModalViewController:picker animated:YES];
        }
    }
    if (buttonIndex == 1) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
        
    }
}

#pragma mark - imagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (typePickerGoTo == 1) {
        //        AGHeadImageViewController *agViewConPro = [[AGHeadImageViewController alloc]init];
        //        agViewConPro.image = image;
        //        agViewConPro.saveToCard = ^(NSData *data){
        //            _headImg = [UIImage imageWithData:data];
        //            [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]  withRowAnimation:UITableViewRowAnimationNone];
        //        };
        //        [self.navigationController pushViewController:agViewConPro animated:YES];
        
        KHHAFPhotoViewController *editorController = [[KHHAFPhotoViewController alloc] initWithImage:image];
        [editorController setDelegate:self];
        [self.navigationController pushViewController:editorController animated:YES];
        
        return;
    }
    KHHAFPhotoViewController *editorController = [[KHHAFPhotoViewController alloc] initWithImage:image];
    [editorController setDelegate:self];
    [self.navigationController pushViewController:editorController animated:YES];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController.tabBarController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"complate");
    }];
}
- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    
    if (typePickerGoTo == 1) {
        typePickerGoTo = 0;
        _headImg = image;        
        [self.navigationController popViewControllerAnimated:YES];       
        [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]  withRowAnimation:UITableViewRowAnimationFade];       
        return;
    }
    _bgImg = image;
    //_cardImage.image = image;
    [self.navigationController popViewControllerAnimated:YES];
    KHHAlertSelectDetail *sameImageTablePro = [[KHHAlertSelectDetail alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44)];
   
    sameImageTablePro.imageTemp = image;
    sameImageTablePro.card = _card;
    KHHAlertSelectDetail *weakTablePro = sameImageTablePro;
    sameImageTablePro.getTempDetail = ^(CardTemplateDetail *detail){
        _cardImage.detail = detail;
        _cardImage.image = image;
        [UIView animateWithDuration: 0.3
                         animations:^{
                             weakTablePro.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                              [weakTablePro removeFromSuperview]; 
                         }];       
    };
    [self.view addSubview:sameImageTablePro];
   
    
}



- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    if (typePickerGoTo == 1) {
        typePickerGoTo = 0;
    }   
    [self.navigationController popViewControllerAnimated:YES];    
}

- (void)touchInImg:(UIView *)view
{
    KHHBrowseTemplateSrcollViewController *tempBrowseViewConPro = [[KHHBrowseTemplateSrcollViewController alloc]init];
    tempBrowseViewConPro.card = _card;
    tempBrowseViewConPro.selectOne = ^(CardTemplate *templateSelect){
        _cardView.inputTemplate = templateSelect;
        _cardView.inputImage = templateSelect.image;
        [_cardView setNeedsDisplay];
    };
    [self.navigationController pushViewController:tempBrowseViewConPro animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 230;
    }
    return 0;
}
#pragma mark - hiddenKeyboard

- (void)hiddenKeyboard
{
    if (_currentTag != 0 ) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:_currentTag];
        if ([textField isFirstResponder]) {
            [textField resignFirstResponder];
            return;
            
        }
    }
    //    for (NSMutableArray *arrPro in _card.arrForEditView) {
    //        for( ParamForEditecard *paraPro in arrPro){
    //            UIView *viewPro1 = [self.view viewWithTag:paraPro.tag];
    //            if ([viewPro1 isKindOfClass:[UITextField class]]) {
    //                if ([viewPro1 isFirstResponder]) {
    //                    [viewPro1 resignFirstResponder];
    //                    return;
    //                }
    //
    //            }
    //        }
    //    }
    if (sectionPicker&&!sectionPicker.hidden) {
        [sectionPicker cancelPicker:NO];
    }
    if (areaPicker&&!areaPicker.hidden) {
        [areaPicker cancelPicker:NO];
    }
}

#pragma mark - local picker
- (void)showLocalPicker:(NSIndexPath *)indexPath
{
    CGRect rectForKey = [_table cellForRowAtIndexPath:indexPath].frame;
    rectForKey = CGRectMake(rectForKey.origin.x, rectForKey.origin.y+30, rectForKey.size.width, rectForKey.size.height);
    [_table goToInsetForKeyboard:rectForKey];
    
    [self hiddenKeyboard];
    if (!areaPicker) {
        areaPicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self];
        
        areaPicker.hidden = YES;
        
    }
    if (areaPicker.hidden) {
        [areaPicker showInView:self.view ];
    }else{
        [_table showNormal];
    }
}

- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    // locationStr = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    [_card upAddressTab:picker reloadRow:^{
        [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:2]]  withRowAnimation:UITableViewRowAnimationNone];
        [_cardView setNeedsDisplay];
    }];
    
}


#pragma mark - textField delegate;
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _currentTag = textField.tag;
    if (!sectionPicker.hidden) {
        [sectionPicker cancelPicker:NO];
    }
    if (!areaPicker.hidden) {
        [areaPicker cancelPicker:NO];
    }
    if ([self nextTag:textField.tag]!=-1) {
        textField.returnKeyType = UIReturnKeyNext;
    }else{
        textField.returnKeyType = UIReturnKeyDone;
    }
    CGRect rectForKey = textField.superview.superview.frame;
    rectForKey.origin.y += 30;
    
    [_table goToInsetForKeyboard:rectForKey];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_card upFieldFromTag:textField.tag value:textField.text];
    _cardImage.card = _card;
    _cardImage.strUrl = _card.cardTemplate.imageUrl;
    ParamForEditecard *param =  [self paramFromTag:textField.tag];
    param.value = textField.text;
    
    [self valid:param];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    int nextTag = [self nextTag:textField.tag];
    
    if (nextTag == -1){
        [textField resignFirstResponder];
        [_table showNormal];
        return YES;
    }
    UITextField *view = (UITextField *)[self.view viewWithTag:nextTag];
    [view becomeFirstResponder];
    return YES;
}


#pragma mark - textField Util

- (ParamForEditecard *)paramFromTag:(int)tag
{
    for (NSMutableArray *arrPro in _card.arrForEditView) {
        for (ParamForEditecard *paramPro in arrPro) {
            if(paramPro.tag == tag){
                return paramPro;
            }
        }
    }
    return nil;
}

- (int)nextTag:(int)tag
{
    
    NSMutableArray *sectionPro = [_card.arrForEditView objectAtIndex:3];
    if ([sectionPro count]==1) {
        sectionPro = [_card.arrForEditView objectAtIndex:2];
    }
    if (!((ParamForEditecard *)[sectionPro lastObject]).toPicker) {
        ParamForEditecard *paramPro = (ParamForEditecard *)[sectionPro objectAtIndex:[sectionPro count]-1];
        if (tag>=paramPro.tag) {
            return -1;
        }
    }else{
        ParamForEditecard *paramPro = (ParamForEditecard *)[sectionPro objectAtIndex:[sectionPro count]-2];
        if (tag>=paramPro.tag) {
            return -1;
        }
    }
    
    int nextTag = tag+1;
    UIView *view = [self.view viewWithTag:nextTag];
    if([view isKindOfClass:[UITextField class]]){
        return nextTag;
    }
    nextTag = tag-tag%100+100;
    UIView *view2 = [self.view viewWithTag:nextTag];
    if([view2 isKindOfClass:[UITextField class]]){
        return nextTag;
    }
    return -1;
    
}


- (void)valid:(ParamForEditecard *)param
{
    param.worn = @"";
    if ([param.title isEqualToString:@"手机"]) {
        
        if (param.value.length > 0 && ![param.value isValidMobilePhoneNumber]) {
            param.worn = @"手机格式错误";
        }
        
        
    }else if ([param.title isEqualToString:@"电话"]){
        
        if (param.value.length > 0 && ![param.value isValidTelephoneNUmber]) {
            param.worn = @"电话号码格式错误";
        }
        //  [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:param.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else if ([param.title isEqualToString:@"传真"]){
        if (param.value.length > 0 && ![param.value isValidTelephoneNUmber]) {
            param.worn = @"传真格式错误";
            // [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:param.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //[self warnAlertMessage:@"传真格式错误"];
        }
        
    }else if ([param.title isEqualToString:@"邮箱"]){
        if (param.value.length > 0 && ![param.value isValidEmail]) {
            param.worn = @"邮箱格式错误";
            //  [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:param.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //[self warnAlertMessage:@"邮箱格式错误"];
        }
        
    }else if ([param.title isEqualToString:@"QQ"]){
        if (param.value.length > 0 && ![param.value isValidQQ]) {
            param.worn = @"QQ格式错误";
            // [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:param.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            // [self warnAlertMessage:@"QQ格式错误"];
        }
    }else if ([param.title isEqualToString:@"邮编"]){
        if (param.value.length > 0 && ![param.value isValidPostalCode]) {
            param.worn = @"邮编格式错误";
            //            [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:param.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //[self warnAlertMessage:@"邮编格式错误"];
        }
    }
    if(param.indexPath){
        [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:param.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

- (void)warnAlertMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)addToExternArrayFromPick:(NSString *)str
{
    if (indexPathForEditPicker.section == 1) {
        [_card doInsertParamSection1:str reloadSection:^{
            [_table reloadSections:[NSIndexSet indexSetWithIndex:indexPathForEditPicker.section] withRowAnimation:UITableViewRowAnimationNone];
            [self hiddenKeyboard];
        }];
    }
    
    if (indexPathForEditPicker.section == 2) {
        [_card doInsertParamSection2:str reloadSection:^{
            [_table reloadSections:[NSIndexSet indexSetWithIndex:indexPathForEditPicker.section] withRowAnimation:UITableViewRowAnimationNone];
            [self hiddenKeyboard];
        }];
    }
    
    if (indexPathForEditPicker.section == 3) {
        [_card doInsertParamSection3:str reloadSection:^{
            [_table reloadSections:[NSIndexSet indexSetWithIndex:indexPathForEditPicker.section] withRowAnimation:UITableViewRowAnimationNone];
            [self hiddenKeyboard];
        }];
    }
    
    //    [_card doInsertParam:str section:indexPathForEditPicker.section toAddRow:^(int tag){
    //        [_table insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPathForEditPicker.row inSection:indexPathForEditPicker.section]] withRowAnimation:UITableViewRowAnimationNone];
    //        [self hiddenKeyboard];
    //        [((UITextField *)[self.view viewWithTag:tag]) becomeFirstResponder];
    //    }  toRemovePicker:^{
    //        [_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPathForEditPicker.row+1 inSection:indexPathForEditPicker.section]] withRowAnimation:UITableViewRowAnimationNone];
    //    }];
    
    //    ParamForEditecard* paramPro = [[ParamForEditecard alloc]initWithTitle:str placeholder:[NSString stringWithFormat:@"请输入%@",str]];
    //
    //    if ([str isEqualToString:@"手机"]||[str isEqualToString:@"电话"]||[str isEqualToString:@"传真"]) {
    //        paramPro.boardType = UIKeyboardTypeNumberPad;
    //    }
    //
    //    paramPro.editingStyle = UITableViewCellEditingStyleDelete;
    //    paramPro.tag = 2400 +indexPathForEditPicker.section*100 +indexPathForEditPicker.row;
    //    [[_card.arrForEditView objectAtIndex:indexPathForEditPicker.section] insertObject:paramPro atIndex:indexPathForEditPicker.row];
    //
    //
    //
    //    if(editingParamPorPicker.forPickerToDel){
    //        [editingParamPorPicker.toPicker removeObject:str];
    //        if ([editingParamPorPicker.toPicker count] == 0) {
    //            [[_card.arrForEditView objectAtIndex:indexPathForEditPicker.section] removeObject:editingParamPorPicker];
    //            [_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPathForEditPicker.row+1 inSection:indexPathForEditPicker.section]] withRowAnimation:UITableViewRowAnimationNone];
    //        }
    //
    //    }
}

#pragma mark - picker sortUtil delegate

NSMutableArray *topicker2;
NSMutableArray *topicker3;
- (NSMutableArray *)sortArrToPick:(int)section
{
    ParamForEditecard *pro = (ParamForEditecard *)[[_card.arrForEditView objectAtIndex:section]lastObject];
    
    if (section == 1) {
        return pro.toPicker;
    }
    
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:8];
    NSMutableArray *topicker;
    
    if (section == 2) {
        topicker = topicker2;
    }else{
        topicker = topicker3;
    }
    [topicker enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([self isIn:(NSString *)obj arr:pro.toPicker] ) {
            [arrPro addObject:(NSString *)obj];
        }
    }];
    return arrPro;
}

- (BOOL)isIn:(NSString *)str2 arr:(NSArray *)arr{
    for (NSString * str in arr) {
        if ([str isEqualToString:str2]) {
            return YES;
        }
    }
    return NO;
}


#pragma mark - validate

- (Boolean)validate:(NSDictionary *)dicParam
{
    //姓名检查
    if (!dicParam[@"cardDetail.trueName"]) {
        [self warnAlertMessage:@"名片上的姓名为空!"];
        return NO;
    }
    
    // 对是否为空或格式进行判断，然后把手机，电话，传真，邮箱保存起来
    if (!dicParam[@"cardDetail.mobiles"] && !dicParam[@"cardDetail.phones"]) {
        //[self showMessage:@"名片上的电话未空!请至少填写一个手机号码或者电话号码!" withTitile:nil];
        [self warnAlertMessage:@"名片上的电话未空!请至少填写一个手机号码或者电话号码!"];
        return NO;
    }
    
    if(!dicParam[@"company.name"]  && !dicParam[@"cardDetail.address"] ){
        //[self showMessage:@"名片上的公司信息为空!请至少填写公司或地址中的一项!" withTitile:nil];
        [self warnAlertMessage:@"名片上的公司信息为空!请至少填写公司或地址中的一项!"];
        return NO;
    }
    
    //    //////////////////////validate//////////////////////
    //validate mobile
    for(NSString *str in [dicParam[@"cardDetail.mobiles"] componentsSeparatedByString:@"|"]){
        if(str.length>0 && ![str isValidMobilePhoneNumber]){
            //[self showMessage:@"手机格式错误!" withTitile:nil];
            [self warnAlertMessage:@"手机格式错误!!"];
            return NO;
        }
    }
    
    //    //validate phone
    for(NSString *str in [dicParam[@"cardDetail.phones"] componentsSeparatedByString:@"|"]){
        if(str.length>0 && ![str isValidTelephoneNUmber]){
            //[self showMessage:@"电话格式错误!" withTitile:nil];
            [self warnAlertMessage:@"电话格式错误!"];
            return NO;
        }
    }
    
    //validate fax
    for(NSString *str in [dicParam[@"cardDetail.faxs"] componentsSeparatedByString:@"|"]){
        if(str.length>0 && ![str isValidTelephoneNUmber]){
            //[self showMessage:@"传真格式错误!" withTitile:nil];
            [self warnAlertMessage:@"传真格式错误!"];
            return NO;
        }
    }
    
    //validate email
    for(NSString *str in [dicParam[@"cardDetail.mails"] componentsSeparatedByString:@"|"]){
        if(str.length>0 && ![str isValidEmail]){
            //[self showMessage:@"邮箱格式错误!" withTitile:nil];
            [self warnAlertMessage:@"邮箱格式错误!"];
            return NO;
        }
    }
    return YES;
}

@end
