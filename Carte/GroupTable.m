//
//  GroupTable.m
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "GroupTable.h"
#import "Card.h"

@implementation GroupTable
{
    NSIndexPath *_currentIndex;
    UIImageView *_messageImageView;
    UILabel *_numLab;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;        
       
        [self setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"left_bg2"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]]];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
      //  [self setSeparatorColor:[UIColor blackColor]];
        
        _arrGroupList = [[NSMutableArray alloc]init];
    }
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrGroupList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"GroupCell";
    GroupCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = _groupActionDelegate;        
    }
    cell.group = _arrGroupList[indexPath.row];
    if (((Group *)_arrGroupList[indexPath.row]).idValue == _selectGroupId) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return cell;
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupCell *cell = (GroupCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([indexPath isEqual:_currentIndex]) {
        if (cell.delegate&&[cell.delegate respondsToSelector:@selector(towTouchGroup:)]) {
            [cell.delegate towTouchGroup:cell.group];
        }
    }
    else{
         _currentIndex = indexPath;
        if(cell.delegate&&[cell.delegate respondsToSelector:@selector(oneTouchGroup:)]) {
            [cell.delegate oneTouchGroup:cell.group];
        }
    }
   
//    if (!cell.selected) {
//            if (cell.delegate&&[cell.delegate respondsToSelector:@selector(towTouchGroup:)]) {
//                [cell.delegate towTouchGroup:cell.group];
//            }        
//        }
   // _currentIndexPath = indexPath;
}

- (void)showNewContactsNum
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    GroupCell *cell = (GroupCell *)[self cellForRowAtIndexPath:indexPath];
    if (!_messageImageView) {
        _messageImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"message_bg.png"]stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
        _messageImageView.frame = CGRectMake(40, -8, 35, 35);
        //self.messageImageView.backgroundColor = [UIColor grayColor];
        _numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 35, 35)];
        _numLab.backgroundColor = [UIColor clearColor];
        _numLab.font = [UIFont systemFontOfSize:10];
        _numLab.textColor = [UIColor whiteColor];
        _numLab.textAlignment = UITextAlignmentCenter;
        [_messageImageView addSubview:_numLab];
        [cell addSubview:_messageImageView];
    }
    int num = [Card numNew];
    if (num > 0) {
        _messageImageView.hidden = NO;
        _numLab.text = [NSString stringWithFormat:@"%d",num];
    }else if (num == 0){
        _messageImageView.hidden = YES;
    }
}

@end
