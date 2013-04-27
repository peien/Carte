#import "SyncMark.h"
#import "NSManagedObject+KHH.h"

@interface SyncMark ()

// Private interface goes here.

@end


@implementation SyncMark

+ (NSString *)valueByKey:(NSString *)key
{
    return [self syncMarkByKey:key].value;
}

+ (SyncMark *)syncMarkByKey:(NSString *)key
{
    return (SyncMark *)[SyncMark objectByKey:@"key" value:key createIfNone:YES];
    
}

+ (void)UpdateKey:(NSString *)key value:(NSString *)value
{
    if (key.length && value.length) {
        SyncMark *sm = [self syncMarkByKey:key];
        sm.value = value;
    }
}


@end
