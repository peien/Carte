#import "_TemplateItemStyle.h"

@interface TemplateItemStyle : _TemplateItemStyle {}

@property(nonatomic,strong)CIColor *color;

+ (void)saveFromJson:(NSDictionary *)dic;

@end
