//
//  Card+ShowDetail.m
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "Card+ShowDetail.h"

@implementation Card (ShowDetail)


- (NSArray *)arrForCardView
{
    if (!_arrAllInShowDetail) {
        _arrAllInShowDetail = [[NSMutableArray alloc]initWithCapacity:4];
        NSMutableArray  *section0Arr = [[NSMutableArray alloc]initWithCapacity:2];
        ParamUnitDetail *paramPro00 = [[ParamUnitDetail alloc]initWithTitle:@"姓名" value:self.name];
        [section0Arr addObject:paramPro00];
        ParamUnitDetail *paramPro01 = [[ParamUnitDetail alloc]initWithTitle:@"职位" value:self.job];
        [section0Arr addObject:paramPro01];
        [_arrAllInShowDetail addObject:section0Arr];
        
        NSMutableArray  *section1Arr = [[NSMutableArray alloc]init];
        if (self.mobile0) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"手机" value:self.mobile0];
            [section1Arr addObject:paramPro];
        }
        if (self.mobile1) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"手机" value:self.mobile1];
            [section1Arr addObject:paramPro];
        }
        if (self.mobile2) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"手机" value:self.mobile2];
            [section1Arr addObject:paramPro];
        }
        
        if (self.tele0) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"电话" value:self.tele0];
            [section1Arr addObject:paramPro];
        }        
        if (self.tele1) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"电话" value:self.tele1];
            [section1Arr addObject:paramPro];
        }
        if (self.tele2) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"电话" value:self.tele2];
            [section1Arr addObject:paramPro];
        }
        
        if (self.fax0) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"传真" value:self.fax0];
            [section1Arr addObject:paramPro];
        }
        if (self.fax1) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"传真" value:self.fax1];
            [section1Arr addObject:paramPro];
        }
        if (self.fax2) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"传真" value:self.fax2];
            [section1Arr addObject:paramPro];
        }
        
        if (self.email0) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"邮箱" value:self.email0];
            [section1Arr addObject:paramPro];
        }        
        if (self.email1) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"邮箱" value:self.email1];
            [section1Arr addObject:paramPro];
        }
        if (self.email2) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"邮箱" value:self.email2];
            [section1Arr addObject:paramPro];
        }
        [_arrAllInShowDetail addObject:section1Arr];
        
         NSMutableArray  *section2Arr = [[NSMutableArray alloc]init];
        if (self.company) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"公司" value:self.company];
            [section2Arr addObject:paramPro];
        }
        if (self.address.province) {
            NSMutableString *strPro = [[NSMutableString alloc]initWithCapacity:3];
            [strPro appendFormat:@"%@ %@",self.address.province,self.address.city];            
            if (self.address.detailStreet) {
                [strPro appendFormat:@" %@",self.address.detailStreet];
            }
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"地址" value:strPro];
            [section2Arr addObject:paramPro];
        }
        
        if (self.zipcode) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"邮编" value:self.zipcode];
            [section2Arr addObject:paramPro];
        }
        
        if (self.companyEmail) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"公司邮箱" value:self.companyEmail];
            [section2Arr addObject:paramPro];
        }

        [_arrAllInShowDetail addObject:section2Arr];
        
         NSMutableArray  *section3Arr = [[NSMutableArray alloc]init];
        if (self.web) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"网页" value:self.web];
            [section3Arr addObject:paramPro];
        }
        if (self.qq) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"QQ" value:self.qq];
            [section3Arr addObject:paramPro];
        }
        if (self.msn) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"MSN" value:self.msn];
            [section3Arr addObject:paramPro];
        }
        if (self.wangwang) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"旺旺" value:self.wangwang];
            [section3Arr addObject:paramPro];
        }
        if (self.another) {
            ParamUnitDetail *paramPro = [[ParamUnitDetail alloc]initWithTitle:@"其他信息" value:self.another];
            [section3Arr addObject:paramPro];
        }
        [_arrAllInShowDetail addObject:section3Arr];
    }
    return _arrAllInShowDetail;
}

- (void)setArrForCardView:(NSArray *)arrForCardView
{
    _arrAllInShowDetail = nil;
}
@end
