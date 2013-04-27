//
//  Card+ShowDetail.h
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "Card.h"
#import "ParamUnitDetail.h"

@interface Card (ShowDetail)
- (NSArray *)arrForCardView;
- (void)setArrForCardView:(NSArray *)arrForCardView;
@end
