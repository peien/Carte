#import "_SyncMark.h"

@interface SyncMark : _SyncMark {}
+ (NSString *)valueByKey:(NSString *)key;
+ (void)UpdateKey:(NSString *)key value:(NSString *)value;
+ (SyncMark *)syncMarkByKey:(NSString *)key;
@end
