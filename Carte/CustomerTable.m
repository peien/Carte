//
//  CustomerTable.m
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "CustomerTable.h"

@implementation CustomerTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        _arrCustomerList = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark - tableview dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _isCoWorker?[_arrCustomerList count]:[_arrCustomerList count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isCoWorker) {
        static NSString *cellID = @"CustomerCell";
        CustomerCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = _customerCellDelegate;
        }
        cell.isCoWorker = _isCoWorker;
        cell.card = _arrCustomerList[indexPath.row];
        return cell;
    }
    
    
    if (indexPath.row == 0) {
        AddCustomerCell *cell;
        static NSString *cellID = @"AddCustomerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[AddCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = _addCustomerCellDelegate;
        }
        return cell;
    }
    
    static NSString *cellID = @"CustomerCell";
    CustomerCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = _customerCellDelegate;
    }
    cell.isCoWorker = _isCoWorker;
    cell.card = _arrCustomerList[indexPath.row-1];
    return cell;
   
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}


@end
