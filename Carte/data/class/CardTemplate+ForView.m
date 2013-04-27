//
//  Template+ForView.m
//  Carte
//
//  Created by CJK on 13-3-28.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "CardTemplate+ForView.h"
#import "NSManagedObject+KHH.h"

@implementation CardTemplate (ForView)
+ (id)defaultTemplate
{
    return [self objectByKey:@"type" value:[NSNumber numberWithInt:type_template_default] createIfNone:YES];
}
@end
