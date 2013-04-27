#import "Group.h"
#import "Card.h"

@interface Group ()

// Private interface goes here.

@end


@implementation Group

+ (id)createGroupAll
{
    Group * groupAll = [self objectByKey:@"type" value:[NSNumber numberWithInt:type_group_all] createIfNone:NO];
    if (!groupAll) {
        groupAll = [self objectByKey:@"type" value:[NSNumber numberWithInt:type_group_all] createIfNone:YES];
        groupAll.name = @"所有";
        groupAll.id = [NSNumber numberWithInt:-2];        
    }
    return groupAll;
}

+ (id)createGroupUnPacket
{
    Group * groupUnPacket = [self objectByKey:@"type" value:[NSNumber numberWithInt:type_group_unpage] createIfNone:NO];
    if (!groupUnPacket) {
        groupUnPacket = [self objectByKey:@"type" value:[NSNumber numberWithInt:type_group_unpage] createIfNone:YES];
        groupUnPacket.name = @"未分组";
        groupUnPacket.id = [NSNumber numberWithInt:-1];
        
    }
    return groupUnPacket;
}

+ (NSMutableArray *)allGroups
{
   
        NSMutableArray *_allGroups = [[NSMutableArray alloc]init];        
        [_allGroups addObject:[self createGroupAll]];        
        [_allGroups addObject:[self createGroupUnPacket]];
        [[KHHData sharedData] saveContext];
        [_allGroups addObjectsFromArray:[self doInSelfType2Arr]];
           
    
    return _allGroups;
}

+ (NSArray *)doInSelfType2Arr
{
    return [self objectArrayByPredicate:[NSPredicate predicateWithFormat:@"%K = %@", @"type", [NSNumber numberWithInt:type_group_create]] sortDescriptors: [NSArray arrayWithObjects:[self nameSortDescriptor],nil]];
}

+ (void)saveFromJson:(NSArray *)arr
{
    for (NSDictionary *dicPro in arr) {
        Group *GroupPro = [self objectByKey:@"id" value:dicPro[@"id"] createIfNone:YES];
        GroupPro.name = dicPro[@"name"];
        GroupPro.type = [NSNumber numberWithInt:type_group_create];
    }
    [[KHHData sharedData] saveContext];
    
}

+ (NSArray *)saveGroupCard:(NSArray*)arr
{
    NSMutableArray *arrPro = [[NSMutableArray alloc]init];
    for (NSDictionary *dicPro in arr) {
        Group *GroupPro = [self objectByKey:@"id" value:dicPro[@"groupId"] createIfNone:YES];
        Card *card = [Card objectByKey:@"id" value:dicPro[@"cardId"] createIfNone:NO];
        if (card) {
            card.group = GroupPro;
        }        
    }
    [[KHHData sharedData] saveContext];
    return arrPro;
}

+ (void)clearType2
{
    for (Group* group in [self doInSelfType2Arr]) {
        for (Card *cardPro in [group.cardSet allObjects]) {
            cardPro.group = [self createGroupUnPacket];
        }
        [[self currentContext] deleteObject:group];
    }
    [[KHHData sharedData] saveContext];
}

@end
