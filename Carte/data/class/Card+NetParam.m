//
//  Card+NetParam.m
//  Carte
//
//  Created by CJK on 13-3-28.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "Card+NetParam.h"
#import "Group.h"
@implementation Card (NetParam)

- (NSMutableDictionary *)netParam0ForEdit
{
    NSMutableDictionary *dicPro = [self netParam1ForNew];
    [dicPro removeObjectForKey:@"groupId"];
    dicPro[@"id"] = self.id;
    return dicPro;
}

- (NSMutableDictionary *)netParam1ForNew
{
    NSMutableDictionary *dicPro = [[NSMutableDictionary alloc]init];
    
    dicPro[@"template.id"] = self.cardTemplate.id;
    
    if (!(self.group.typeValue == type_group_all||self.group.typeValue == type_group_unpage)) {
         dicPro[@"groupId"] = self.group.id;
    } 
    
    if (self.name) {
        dicPro[@"cardDetail.trueName"] = self.name;
    }
    if (self.job) {
        dicPro[@"cardDetail.jobTitle"] = self.job;
    }
    if (self.another) {
        dicPro[@"moreInfo"] = self.another;
    }
    if (self.address.province) {
        dicPro[@"cardDetail.province"] = self.address.province;
        dicPro[@"cardDetail.city"] = self.address.city;
        if (self.address.detailStreet) {
             dicPro[@"cardDetail.address"] = self.address.detailStreet;
        }       
    }
    if (self.zipcode) {
        dicPro[@"zipcode"] = self.zipcode;
    }
    
    if (self.mobile0) {        
        dicPro[@"cardDetail.mobiles"] = [self addSeprate:[NSArray arrayWithObjects:self.mobile0,self.mobile1,self.mobile2,nil]];
    }
    if (self.tele0) {
        dicPro[@"cardDetail.phones"] = [self addSeprate:[NSArray arrayWithObjects:self.tele0,self.tele1,self.tele2,nil]];
    }
    if (self.fax0) {
        dicPro[@"cardDetail.faxs"] = [self addSeprate:[NSArray arrayWithObjects:self.fax0,self.fax1,self.fax2,nil]];
    }
    if (self.email0) {
        dicPro[@"cardDetail.mails"] = [self addSeprate:[NSArray arrayWithObjects:self.email0,self.email1,self.email1,nil]];
    }
    if (self.company) {
        dicPro[@"company.name"] = self.company;
    }
    if (self.companyEmail) {
        dicPro[@"company.mails"] = self.companyEmail;
    }
    if (self.web) {
        dicPro[@"cardDetail.homePages"] = self.web;
    }
    if (self.qq) {
        dicPro[@"cardDetail.qqs"] = self.qq;
    }
    if (self.msn) {
        dicPro[@"cardDetail.msns"] = self.msn;
    }
    if (self.wangwang) {
        dicPro[@"cardDetail.wangwangs"] = self.wangwang;
    }
    if (self.another) {
        dicPro[@"cardDetail.moreInfo"] = self.another;
    }
    
    return dicPro;
}

- (NSString *)addSeprate:(NSArray *)arr
{
    NSMutableString *strPro = [[NSMutableString alloc]initWithCapacity:3];
   
    for (int i = 0; i<[arr count]; i++) {
        if (i == 0) {
            [strPro appendFormat:@"%@",arr[i]];
            continue;
        }
        [strPro appendFormat:@"|%@",arr[i]];
    }
    return strPro;
}
@end
