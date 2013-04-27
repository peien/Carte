//
//  KHHUser.h
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface KHHUser : NSObject

@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *sessionId;
@property(nonatomic,assign)Boolean agreeSync;

@property(nonatomic,strong)Card *card;

+ (KHHUser *)shareInstance;

@end
