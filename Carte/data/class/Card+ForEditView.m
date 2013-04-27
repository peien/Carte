//
//  Card+ForEditView.m
//  Carte
//
//  Created by CJK on 13-3-18.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "Card+ForEditView.h"
#import "ParamForEditecard.h"
#import "NSString+Validation.h"

@implementation Card (ForEditView)


- (void)section0
{
    NSMutableArray  *section0Arr = [[NSMutableArray alloc]initWithCapacity:2];
    ParamForEditecard *paramPro00 = [[ParamForEditecard alloc]init];
    paramPro00.tag = 2400;
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro00.tag]] = @"name";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro00.tag]] = paramPro00;
    paramPro00.value = self.name;
    [section0Arr addObject:paramPro00];
    
    ParamForEditecard *paramPro01 = [[ParamForEditecard alloc]init];
    paramPro01.tag = 2400+1;
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro01.tag]] = @"job";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro01.tag]] = paramPro01;
    paramPro01.value = self.job;
    [section0Arr addObject:paramPro01];
    [_arrAllIn addObject:section0Arr];
}

- (void)section1
{
    NSMutableArray *section1Arr = [[NSMutableArray alloc]initWithCapacity:10];
    
    int i = 0;
    ParamForEditecard *paramPro0 = [[ParamForEditecard alloc]initWithTitle:@"手机" placeholder:@"请输入手机号"];
    paramPro0.boardType = UIKeyboardTypeNumberPad;
    paramPro0.tag = 2400 +100+i;i++;
    paramPro0.value = self.mobile0;
    [self valid:paramPro0];
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro0.tag]] = @"mobile0";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro0.tag]] = paramPro0;
    [section1Arr addObject:paramPro0];
    
    ParamForEditecard *paramPro1 = [[ParamForEditecard alloc]initWithTitle:@"电话" placeholder:@"请输入电话号码"];
    paramPro1.boardType = UIKeyboardTypeNumberPad;
    paramPro1.tag = 2400 +100+i;i++;
    paramPro1.value = self.tele0;
    [self valid:paramPro1];
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro1.tag]] = @"tele0";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro1.tag]] = paramPro1;
    [section1Arr addObject:paramPro1];
    
    ParamForEditecard *paramPro2 = [[ParamForEditecard alloc]initWithTitle:@"传真" placeholder:@"请输入传真"];
    paramPro2.boardType = UIKeyboardTypeNumberPad;
    paramPro2.tag = 2400 +100+i;i++;
    paramPro2.value = self.fax0;
    [self valid:paramPro2];
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro2.tag]] = @"fax0";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro2.tag]] = paramPro2;
    [section1Arr addObject:paramPro2];
    
    ParamForEditecard *paramPro3 = [[ParamForEditecard alloc]initWithTitle:@"邮箱" placeholder:@"请输入邮箱"];
    paramPro3.tag = 2400 +100+i;i++;
    paramPro3.value = self.email0;
    [self valid:paramPro3];
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro3.tag]] = @"email0";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro3.tag]] = paramPro3;
    [section1Arr addObject:paramPro3];
    
    ParamForEditecard *paramPickerPro1 = [[ParamForEditecard alloc]init];
    paramPickerPro1.editingStyle = UITableViewCellEditingStyleInsert;
    paramPickerPro1.title = @"添加";
    
    if (self.mobile1) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"手机" placeholder:@"请输入手机号"];
        paramPro.tag = 2400 +100+i;i++;
        paramPro.value = self.mobile1;
        [self valid:paramPro];
        paramPro.boardType = UIKeyboardTypeNumberPad;
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"mobile1";
        dicItemFromTag[@"endMobile"] = @"NO";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section1Arr addObject:paramPro];
    }
    
    if (self.mobile2) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"手机" placeholder:@"请输入手机号"];
        paramPro.tag = 2400 +100+i;i++;
        paramPro.value = self.mobile2;
        [self valid:paramPro];
        paramPro.boardType = UIKeyboardTypeNumberPad;
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"mobile2";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        dicItemFromTag[@"endMobile"] = @"YES";
        [section1Arr addObject:paramPro];
    }
    
    if (self.tele1) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"电话" placeholder:@"请输入电话号码"];
        paramPro.tag = 2400 +100+i;i++;
        paramPro.value = self.tele1;
        [self valid:paramPro];
        paramPro.boardType = UIKeyboardTypeNumberPad;
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"tele1";
        dicItemFromTag[@"endTele"] = @"NO";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section1Arr addObject:paramPro];
    }
    
    if (self.tele2) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"电话" placeholder:@"请输入电话号码"];
        paramPro.tag = 2400 +100+i;i++;
        paramPro.value = self.tele2;
        [self valid:paramPro];
        paramPro.boardType = UIKeyboardTypeNumberPad;
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"tele2";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        dicItemFromTag[@"endTele"] = @"YES";
        [section1Arr addObject:paramPro];
    }
    
    if (self.fax1) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"传真" placeholder:@"请输入传真"];
        paramPro.tag = 2400 +100+i;i++;
        paramPro.value = self.fax1;
        [self valid:paramPro];
        paramPro.boardType = UIKeyboardTypeNumberPad;
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"fax1";
        dicItemFromTag[@"endFax"] = @"NO";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section1Arr addObject:paramPro];
    }
    
    if (self.fax2) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"传真" placeholder:@"请输入传真"];
        paramPro.tag = 2400 +100+i;i++;
        paramPro.value = self.fax2;
        [self valid:paramPro];
        paramPro.boardType = UIKeyboardTypeNumberPad;
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"fax2";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        dicItemFromTag[@"endFax"] = @"YES";
        [section1Arr addObject:paramPro];
    }
    
    if (self.email1) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"邮箱" placeholder:@"请输入邮箱"];
        paramPro.tag = 2400 +100+i;i++;
        paramPro.value = self.email1;
        [self valid:paramPro];
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"email1";
        dicItemFromTag[@"endEmail"] = @"NO";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section1Arr addObject:paramPro];
    }
    
    if (self.email2) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"邮箱" placeholder:@"请输入邮箱"];
        paramPro.tag = 2400 +100+i;i++;
        paramPro.value = self.email2;
        [self valid:paramPro];
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"email2";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        dicItemFromTag[@"endEmail"] = @"YES";
        [section1Arr addObject:paramPro];
    }
    
    
    paramPickerPro1.toPicker = [[NSMutableArray alloc]initWithCapacity:4];
    if (!dicItemFromTag[@"endMobile"]||[dicItemFromTag[@"endMobile"] isEqualToString:@"NO"]) {
        [paramPickerPro1.toPicker addObject:@"手机"];
    }
    if (!dicItemFromTag[@"endTele"]||[dicItemFromTag[@"endTele"] isEqualToString:@"NO"]) {
        [paramPickerPro1.toPicker addObject:@"电话"];
    }
    if (!dicItemFromTag[@"endFax"]||[dicItemFromTag[@"endFax"] isEqualToString:@"NO"]) {
        [paramPickerPro1.toPicker addObject:@"传真"];
    }
    if (!dicItemFromTag[@"endEmail"]||[dicItemFromTag[@"endEmail"] isEqualToString:@"NO"]) {
        [paramPickerPro1.toPicker addObject:@"邮箱"];
    }
    
    if ([paramPickerPro1.toPicker count]>0) {
        [section1Arr addObject:paramPickerPro1];
    }
    
    //    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithObjects:@"手机",@"电话",@"传真",@"邮箱", nil];
    //    NSMutableArray *arrPro1 = [[NSMutableArray alloc]initWithObjects:@"请输入手机号",@"请输入电话号码",@"请输入传真",@"请输入邮箱", nil];
    //    for (int i=0; i<4; i++) {
    //        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:arrPro[i] placeholder:arrPro1[i]];
    //        paramPro.tag = 2400 +100 +i;
    //        if (i==0||i==1||i==2) {
    //            paramPro.boardType = UIKeyboardTypeNumberPad;
    //        }
    //        [section1Arr addObject:paramPro];
    //    }
    //   // ParamForEditecard *paramPro = [[ParamForEditecard alloc]init];
    //    paramPro.title = @"添加";
    //    paramPro.editingStyle = UITableViewCellEditingStyleInsert;
    //    paramPro.toPicker = [[NSMutableArray alloc]initWithArray:arrPro copyItems:YES];
    //    [section1Arr addObject:paramPro];
    if ([_arrAllIn count]>1) {
        [_arrAllIn insertObject:section1Arr atIndex:1];
        [_arrAllIn removeObjectAtIndex:2];
    }else{
        [_arrAllIn addObject:section1Arr];
    }
}

- (void)section2
{
    NSMutableArray *section2Arr = [[NSMutableArray alloc]initWithCapacity:10];
    
    int i = 0;
    ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"公司" placeholder:@"请输入公司"];   
    paramPro.tag = 2400 +200+i;i++;
    paramPro.value = self.company;
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"company";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
    [section2Arr addObject:paramPro];
    
    ParamForEditecard *paramPro1 = [[ParamForEditecard alloc]initWithTitle:@"地址" placeholder:@"请输入地址"];    
    paramPro1.tag = 2400 +200+i;i++;
    paramPro1.value = self.address.detailStreet;
    paramPro1.province = self.address.province;
    paramPro1.city = self.address.city;
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro1.tag]] = @"address.detail";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro1.tag]] = paramPro1;
    [section2Arr addObject:paramPro1];
    
    ParamForEditecard *paramPro2 = [[ParamForEditecard alloc]initWithTitle:@"邮编" placeholder:@"请输入邮编"];
    paramPro2.tag = 2400 +200+i;i++;
    paramPro2.value = self.zipcode;
    [self valid:paramPro];
    paramPro2.boardType = UIKeyboardTypeNumberPad;
    dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro2.tag]] = @"zipcode";
    dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro2.tag]] = paramPro2;
    [section2Arr addObject:paramPro2];
    
    ParamForEditecard *paramPickerPro2 = [[ParamForEditecard alloc]init];
    paramPickerPro2.editingStyle = UITableViewCellEditingStyleInsert;
    paramPickerPro2.title = @"添加";
    
    if (self.companyEmail) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"公司邮箱" placeholder:@"请输入公司邮箱"];
        paramPro.tag = 2400 +200+i;i++;
        paramPro.value = self.companyEmail;
       
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"companyEmail";        
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section2Arr addObject:paramPro];
    }
    
    paramPickerPro2.toPicker = [[NSMutableArray alloc]initWithCapacity:2];
    if (!self.companyEmail) {
        [paramPickerPro2.toPicker addObject:@"公司邮箱"];
    }
    
    if ([paramPickerPro2.toPicker count]>0) {
        [section2Arr addObject:paramPickerPro2];
    }
    
    if ([_arrAllIn count]>2) {
        [_arrAllIn insertObject:section2Arr atIndex:2];
        [_arrAllIn removeObjectAtIndex:3];
    }else{
        [_arrAllIn addObject:section2Arr];
    }

}


- (void)section3
{
    NSMutableArray  *section3Arr = [[NSMutableArray alloc]initWithCapacity:10];
    int i=0;
    if (self.web) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"网页" placeholder:@"请输入网页"];
        paramPro.tag = 2400 +300+i;i++;
        paramPro.value = self.web;        
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"web";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section3Arr addObject:paramPro];
    }
    
    if (self.qq) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"QQ" placeholder:@"请输入QQ"];
        paramPro.tag = 2400 +300+i;i++;
        paramPro.value = self.qq;
        [self valid:paramPro];
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"qq";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section3Arr addObject:paramPro];
    }
    
    if (self.msn) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"MSN" placeholder:@"请输入MSN"];
        paramPro.tag = 2400 +300+i;i++;
        paramPro.value = self.msn;
        [self valid:paramPro];
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"msn";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section3Arr addObject:paramPro];
    }
    
    if (self.wangwang) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"旺旺" placeholder:@"请输入旺旺"];
        paramPro.tag = 2400 +300+i;i++;
        paramPro.value = self.wangwang;        
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"wangwang";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section3Arr addObject:paramPro];
    }
    
    if (self.another) {
        ParamForEditecard *paramPro = [[ParamForEditecard alloc]initWithTitle:@"其他信息" placeholder:@"请输入其他信息"];
        paramPro.tag = 2400 +300+i;i++;
        paramPro.value = self.another;
        paramPro.editingStyle = UITableViewCellEditingStyleDelete;
        dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] = @"another";
        dicItemFromTag[[NSString stringWithFormat:@"%dParam",paramPro.tag]] = paramPro;
        [section3Arr addObject:paramPro];
    }
    
    ParamForEditecard *paramPro3 = [[ParamForEditecard alloc]init];
    paramPro3.editingStyle = UITableViewCellEditingStyleInsert;
    paramPro3.title = @"添加更多";
    paramPro3.toPicker = [[NSMutableArray alloc]initWithCapacity:6];
    if (!self.web)
    {
        [paramPro3.toPicker addObject:@"网页"];
    }
    if (!self.qq)
    {
        [paramPro3.toPicker addObject:@"QQ"];
    }
    if (!self.msn)
    {
        [paramPro3.toPicker addObject:@"MSN"];
    }
    if (!self.wangwang)
    {
        [paramPro3.toPicker addObject:@"旺旺"];
    }
    if (!self.another)
    {
        [paramPro3.toPicker addObject:@"其他信息"];
    }
    if ([paramPro3.toPicker count]>0) {
        [section3Arr addObject:paramPro3];
    }
    
    if ([_arrAllIn count]>3) {
        [_arrAllIn insertObject:section3Arr atIndex:3];
        [_arrAllIn removeObjectAtIndex:4];
    }else{
        [_arrAllIn addObject:section3Arr];
    }
}
#pragma mark - insert row

- (void)doInsertParamSection1:(NSString *)str reloadSection:(void(^)())reloadSection
{
    if ([str isEqualToString:@"手机"]) {
        if (self.mobile1) {
            self.mobile2 = @"";
        }else{
            self.mobile1 = @"";
        }
        
    }
    if ([str isEqualToString:@"电话"]) {
        if (self.tele1) {
            self.tele2 = @"";
        }else{
            self.tele1 = @"";
        }
    }
    if ([str isEqualToString:@"传真"]) {
        if (self.fax1) {
            self.fax2 = @"";
        }else{
            self.fax1 = @"";
        }
    }
    if ([str isEqualToString:@"邮箱"]) {
        if (self.email1) {
            self.email2 = @"";
        }else{
            self.email1 = @"";
        }
    }
    [self section1];
    if (reloadSection) {
        reloadSection();
    }
}

- (void)doInsertParamSection2:(NSString *)str reloadSection:(void(^)())reloadSection
{
    if ([str isEqualToString:@"公司邮箱"]) {
        self.companyEmail = @"";
    }
    [self section2];
    if (reloadSection) {
        reloadSection();
    }
}

- (void)doInsertParamSection3:(NSString *)str reloadSection:(void(^)())reloadSection
{
    if ([str isEqualToString:@"网页"]) {
        self.web = @"";
    }
    if ([str isEqualToString:@"QQ"]) {
        self.qq = @"";
    }
    if ([str isEqualToString:@"MSN"]) {
        self.msn = @"";
    }
    if ([str isEqualToString:@"旺旺"]) {
        self.wangwang = @"";
    }
    if ([str isEqualToString:@"其他信息"]) {
        self.another = @"";
    }    
    [self section3];
    if (reloadSection) {
        reloadSection();
    }
}

#pragma mark - delete row
- (void)doDeleteParamSection1:(ParamForEditecard *)paramPro reloadSection:(void(^)())reloadSection
{
    if ([paramPro.title isEqualToString:@"手机"]) {
        if ([dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] isEqualToString:@"mobile1"]) {
            if (self.mobile2) {
                self.mobile1 = [self.mobile2 copy];
                self.mobile2 = nil;
            }else{
                self.mobile1 = nil;
            }
        }
        if ([dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] isEqualToString:@"mobile2"]) {
            self.mobile2 = nil;
        }
    }
    
    if ([paramPro.title isEqualToString:@"电话"]) {
        if ([dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] isEqualToString:@"tele1"]) {
            if (self.tele2) {
                self.tele1 = [self.tele2 copy];
                self.tele2 = nil;
            }else{
                self.tele1 = nil;
            }
        }
        if ([dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] isEqualToString:@"tele2"]) {
            self.tele2 = nil;
        }
    }
    
    if ([paramPro.title isEqualToString:@"传真"]) {
        if ([dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] isEqualToString:@"fax1"]) {
            if (self.fax2) {
                self.fax1 = [self.fax2 copy];
                self.fax2 = nil;
            }else{
                self.fax1 = nil;
            }
        }
        if ([dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] isEqualToString:@"fax2"]) {
            self.fax2 = nil;
        }
    }
    
    if ([paramPro.title isEqualToString:@"邮箱"]) {
        if ([dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] isEqualToString:@"email1"]) {
            if (self.email2) {
                self.email1 = [self.email2 copy];
                self.email2 = nil;
            }else{
                self.email1 = nil;
            }
        }
        if ([dicItemFromTag[[NSString stringWithFormat:@"%d",paramPro.tag]] isEqualToString:@"email2"]) {
            self.email2 = nil;
        }
    }
    
    [self section1];
    if (reloadSection) {
        reloadSection();
    }
    
}

- (void)doDeleteParamSection2:(ParamForEditecard *)paramPro reloadSection:(void(^)())reloadSection
{
    self.companyEmail = nil;
    [self section2];
    if (reloadSection) {
        reloadSection();
    }
}

- (void)doDeleteParamSection3:(ParamForEditecard *)paramPro reloadSection:(void(^)())reloadSection
{
    if ([paramPro.title isEqualToString:@"网页"]) {
        self.web = nil;
    }
    if ([paramPro.title isEqualToString:@"QQ"]) {
        self.qq = nil;
    }
    if ([paramPro.title isEqualToString:@"MSN"]) {
        self.msn = nil;
    }
    if ([paramPro.title isEqualToString:@"旺旺"]) {
        self.wangwang = nil;
    }
    if ([paramPro.title isEqualToString:@"其他信息"]) {
        self.another = nil;
    }
    [self section3];
    if (reloadSection) {
        reloadSection();
    }
}

- (void)upAddressTab:(HZAreaPickerView *)picker reloadRow:(void(^)())reloadRow;
{
    self.address.province = picker.locate.state;
    self.address.city = picker.locate.city;
    ParamForEditecard *paramPro = (ParamForEditecard *)_arrAllIn[2][1];
    paramPro.province = picker.locate.state;
    paramPro.city = picker.locate.city;
    if (reloadRow) {
        reloadRow();
    }
}

- (void)upFieldFromTag:(int)tag value:(NSString *)value
{
    NSString *strItem = dicItemFromTag[[NSString stringWithFormat:@"%d",tag]];
    if ([strItem isEqualToString:@"name"]) {
        self.name = value;
    }
    if ([strItem isEqualToString:@"job"]) {
        self.job = value;
    }
    if ([strItem isEqualToString:@"mobile0"]) {
        self.mobile0 = value;
    }
    if ([strItem isEqualToString:@"mobile1"]) {
        self.mobile1 = value;
    }
    if ([strItem isEqualToString:@"mobile2"]) {
        self.mobile2 = value;
    }
    if ([strItem isEqualToString:@"tele0"]) {
        self.tele0 = value;
    }
    if ([strItem isEqualToString:@"tele1"]) {
        self.tele1 = value;
    }
    if ([strItem isEqualToString:@"tele2"]) {
        self.tele2 = value;
    }
    if ([strItem isEqualToString:@"fax0"]) {
        self.fax0 = value;
    }
    if ([strItem isEqualToString:@"fax1"]) {
        self.fax1 = value;
    }
    if ([strItem isEqualToString:@"fax2"]) {
        self.fax2 = value;
    }
    if ([strItem isEqualToString:@"email0"]) {
        self.email0 = value;
    }
    if ([strItem isEqualToString:@"email1"]) {
        self.email1 = value;
    }
    if ([strItem isEqualToString:@"email2"]) {
        self.email2 = value;
    }    
    if ([strItem isEqualToString:@"company"]) {
        self.company = value;
    }
    if ([strItem isEqualToString:@"address.detail"]) {
        self.address.detailStreet = value;
    }
    if ([strItem isEqualToString:@"zipcode"]) {
        self.zipcode = value;
    }    
    if ([strItem isEqualToString:@"companyEmail"]) {
        self.companyEmail = value;
    }
    
    if ([strItem isEqualToString:@"web"]) {
        self.web = value;
    }
    if ([strItem isEqualToString:@"qq"]) {
        self.qq = value;
    }
    if ([strItem isEqualToString:@"msn"]) {
        self.msn = value;
    }
    if ([strItem isEqualToString:@"wangwang"]) {
        self.wangwang = value;
    }
    if ([strItem isEqualToString:@"another"]) {
        self.another = value;
    }
    
    if (_arrAllIn) {
        ((ParamForEditecard *)dicItemFromTag[[NSString stringWithFormat:@"%dParam",tag]]).value = value;
    }
}

- (void)setArrForEditView:(NSArray *)arrForEditView
{
    _arrAllIn = nil;
}

- (NSArray *)arrForEditView
{
    if (!_arrAllIn) {
        _arrAllIn = [[NSMutableArray alloc]initWithCapacity:4];
        dicItemFromTag = [[NSMutableDictionary alloc]initWithCapacity:30];
//        topicker1 = [[NSMutableArray alloc]initWithObjects:@"手机",@"电话",@"传真",@"邮箱", nil];
//        topicker2 = [[NSMutableArray alloc]initWithObjects:@"公司邮箱", nil];
//        topicker3 = [[NSMutableArray alloc]initWithObjects:@"网页",@"QQ",@"MSN",@"旺旺",@"其它信息", nil];
        [self section0];
        [self section1];
        [self section2];
        [self section3];
       
        
        
    }
    return _arrAllIn;
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

- (void)save
{
    
    if (self.mobile2&&self.mobile2.length==0) {
        self.mobile2 = nil;
    }    
    if (self.mobile1&&self.mobile1.length==0) {        
        
        if (!self.mobile2) {
            self.mobile1 = nil;
        }
        
        if (self.mobile2) {
            self.mobile1 = [self.mobile2 copy];
            self.mobile2 = nil;
        }
        
    }
    
    if (self.mobile0&&self.mobile0.length==0) {        
        if (self.mobile1) {
            self.mobile0 = [self.mobile1 copy];
            self.mobile1 = nil;
        }        
    }
    
    if (self.mobile0&&self.mobile0.length==0) {
        self.mobile0 = nil;
    }
    
    if (self.tele2&&self.tele2.length==0) {
        self.tele2 = nil;
    }
    if (self.tele1&&self.tele1.length==0) {       
        if (!self.tele2) {
            self.tele1 = nil;
        }
        
        if (self.tele2) {
            self.tele1 = [self.tele2 copy];
            self.tele2 = nil;
        }        
    }
    
    if (self.tele0&&self.tele0.length==0) {
        if (self.tele1) {
            self.tele0 = [self.tele1 copy];
            self.tele1 = nil;
        }        
    }
    if (self.tele0&&self.tele0.length==0) {
        self.tele0 = nil;
    }
    
    if (self.fax2&&self.fax2.length==0) {
        self.fax2 = nil;
    }
    if (self.fax1&&self.fax1.length==0) {
        
        
        if (!self.fax2) {
            self.fax1 = nil;
        }
        
        if (self.fax2) {
            self.fax1 = [self.fax2 copy];
            self.fax2 = nil;
        }
    }
    
    if (self.fax0&&self.fax0.length==0) {
        if (self.fax1) {
            self.fax0 = [self.fax1 copy];
            self.fax1 = nil;
        }
    }

    if (self.fax0&&self.fax0.length==0) {
        self.fax0 = nil;
    }
    
    if (self.email2&&self.email2.length==0) {
        self.email2 = nil;
    }
    if (self.email1&&self.email1.length==0) {
        
        
        if (!self.email2) {
            self.email1 = nil;
        }
        
        if (self.email2) {
            self.email1 = [self.email2 copy];
            self.email2 = nil;
        }        
    }
    
    if (self.email0&&self.email0.length==0) {
        if (self.email1) {
            self.email0 = [self.email1 copy];
            self.email1 = nil;
        }
    }
    
    if (self.email0&&self.email0.length==0) {
        self.email0 = nil;
    }
    
    if (self.companyEmail&&self.companyEmail.length==0) {
        self.companyEmail = nil;
    }
    
    if (self.web&&self.web.length==0) {
        self.web = nil;
    }
    if (self.qq&&self.qq.length==0) {
        self.qq = nil;
    }

    if (self.msn&&self.msn.length==0) {
        self.msn = nil;
    }

    if (self.wangwang&&self.wangwang.length==0) {
        self.wangwang = nil;
    }
    if (self.another&&self.another.length==0) {
        self.another = nil;
    }
   
}

- (void)valid:(ParamForEditecard *)param
{
    if ([param.title isEqualToString:@"手机"]) {
        if (param.value.length > 0 && ![param.value isValidMobilePhoneNumber]) {
            param.worn = @"手机格式错误";
            
        }
        
    }else if ([param.title isEqualToString:@"电话"]){
        if (param.value.length > 0 && ![param.value isValidTelephoneNUmber]) {
            param.worn = @"电话号码格式错误";
            
        }
    }else if ([param.title isEqualToString:@"传真"]){
        if (param.value.length > 0 && ![param.value isValidTelephoneNUmber]) {
            param.worn = @"传真格式错误";
            
        }
        
    }else if ([param.title isEqualToString:@"邮箱"]){
        if (param.value.length > 0 && ![param.value isValidEmail]) {
            param.worn = @"邮箱格式错误";
            
        }
        
    }else if ([param.title isEqualToString:@"QQ"]){
        if (param.value.length > 0 && ![param.value isValidQQ]) {
            param.worn = @"QQ格式错误";
           
        }
    }else if ([param.title isEqualToString:@"邮编"]){
        if (param.value.length > 0 && ![param.value isValidPostalCode]) {
            param.worn = @"邮编格式错误";
            
        }
        
    }
}


@end
