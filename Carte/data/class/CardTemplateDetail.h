#import "_CardTemplateDetail.h"

@interface CardTemplateDetail : _CardTemplateDetail {}
@property(nonatomic,strong)NSMutableDictionary *dicStyles;
// Custom logic goes here.
+ (NSArray *)allTempDetail;

+ (id)saveFromJson:(NSDictionary *)dic;
@end
