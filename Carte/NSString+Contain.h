//
//  NSString+Contain.h
//  Carte
//
//  Created by CJK on 13-3-31.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Contain)
- (BOOL)containsString:(NSString *)s;
- (NSString *)replaceAll:(NSString *)fromStr toStr:(NSString *)toStr;
- (NSString *)appendTo6LengthColor;
@end
