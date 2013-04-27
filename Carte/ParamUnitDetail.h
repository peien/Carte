//
//  ParamUnitDetail.h
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParamUnitDetail : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *value;

- (id)initWithTitle:(NSString *)title value:(NSString *)value;
@end
