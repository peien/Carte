//
//  KHHHeadCell.h
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KHHHeadCellDelegate <NSObject>
@optional
- (void)pickImage;
@end

@interface KHHHeadCell : UITableViewCell
@property(nonatomic,assign)int tagName;
@property(nonatomic,assign)int tagJob;
@property(nonatomic,assign)NSString *textName;
@property(nonatomic,assign)NSString *textJob;
@property(nonatomic,strong)id<UITextFieldDelegate> delegate;
@property(nonatomic,strong)id<KHHHeadCellDelegate> pickDelegate;
@property(nonatomic,strong)UIImage *headImg;
- (void)becameFirstRes;
@end
