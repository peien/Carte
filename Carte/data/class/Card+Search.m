//
//  Card+Search.m
//  Carte
//
//  Created by CJK on 13-3-31.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "Card+Search.h"
#import "NSString+Contain.h"

@implementation Card (Search)
- (Boolean)searchRes:(NSString *)searchString
{
    if ([self.name containsString:searchString]) {
        return YES;
    };
    if ([self.company containsString:searchString]) {
        return YES;
    }
    if ([self.mobile0 containsString:searchString]) {
        return YES;
    }
    if ([self.mobile1 containsString:searchString]) {
        return YES;
    }
    if ([self.mobile2 containsString:searchString]) {
        return YES;
    }
    if ([self.tele0 containsString:searchString]) {
        return YES;
    }
    if ([self.tele1 containsString:searchString]) {
        return YES;
    }
    if ([self.tele2 containsString:searchString]) {
        return YES;
    }
    return NO;

}
@end
