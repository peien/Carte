//
//  KHHEditCardViewController.h
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHHViewController.h"
#import "HZAreaPickerView.h"
#import "Card+ForEditView.h"
#import "KHHCardImageView.h"
#import "KHHAFPhotoViewController.h"
#import "KHHHeadCell.h"

@interface KHHEditCardViewController : KHHViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,HZAreaPickerDelegate,KHHCardImageViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AFPhotoEditorControllerDelegate,KHHHeadCellDelegate>
@property(nonatomic,strong)Card *card;
@property(nonatomic,strong)void(^editSave)();

//for subs
@property(nonatomic,assign)Boolean isForMyCard;

//for block
@property(nonatomic,strong)UIImage *bgImg;
@end
