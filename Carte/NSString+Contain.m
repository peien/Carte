//
//  NSString+Contain.m
//  Carte
//
//  Created by CJK on 13-3-31.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NSString+Contain.h"

@implementation NSString (Contain)
- (BOOL)containsString:(NSString *)s
{    
    return [[self lowercaseString] rangeOfString:[s lowercaseString]].location != NSNotFound;
}

- (NSString *)replaceAll:(NSString *)fromStr toStr:(NSString *)toStr
{
    if ([self rangeOfString:fromStr].location == NSNotFound) {
        return self;
    }
    NSMutableString *strPro = [[NSMutableString alloc]initWithString:self];
    [strPro replaceCharactersInRange:[self rangeOfString:fromStr] withString:toStr];
    return [strPro replaceAll:fromStr toStr:toStr];
}

- (NSString *)appendTo6LengthColor
{
    NSMutableString *strPro = [[NSMutableString alloc]initWithString:self];
    if (strPro.length>=6) {
        return self;
    }
    int lengthPro = 6-strPro.length;
    for (int i=0; i<lengthPro; i++) {
        [strPro insertString:@"0" atIndex:0];
    }
    return strPro;
}
@end
