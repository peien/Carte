//
//  Group+ForView.m
//  Carte
//
//  Created by CJK on 13-3-28.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "Group+ForView.h"
#import "Card.h"
@implementation Group (ForView)

+ (NSArray *)allGroupCard
{
    
    return [Card objectArrayByPredicate:[NSPredicate predicateWithFormat:@"%K != %@", @"type", [NSNumber numberWithInt:type_card_my]] sortDescriptors: [NSArray arrayWithObjects:[Card newCardSortDescriptor],[Card nameSortDescriptor],nil]];
}

- (NSArray *)allCard
{
     return [Card objectArrayByPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"group", self] sortDescriptors: [NSArray arrayWithObjects:[Card newCardSortDescriptor],[Card nameSortDescriptor],nil]];
}

@end
