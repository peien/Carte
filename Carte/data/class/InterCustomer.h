//
//  InterCustomer.h
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMObject.h"

@interface InterCustomer : SMObject

@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *roleType;

@property(nonatomic,strong)NSString *mobileList;
@property(nonatomic,strong)NSString *companyName;

@end
