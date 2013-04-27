#import "_Group.h"
#import "NSManagedObject+KHH.h"

enum type_group {
    type_group_all = 1,
    type_group_unpage,
    type_group_create,
};

@interface Group : _Group


+ (id)createGroupAll;
+ (id)createGroupUnPacket;
+ (NSMutableArray *)allGroups;
+ (void)saveFromJson:(NSArray *)arr;
+ (NSArray *)saveGroupCard:(NSArray*)arr;
+ (void)clearType2;
@end
