#import "_CardTemplate.h"
#import "TemplateItemStyle.h"

enum type_template {
    type_template_default = 1,
    type_template_private,
    type_template_public,
};


@interface CardTemplate : _CardTemplate {}

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSMutableDictionary *dicStyles;
+ (NSArray *)allTemplate;
+ (id)doInitForTest;
+ (id)chenQETemplate:(int)templateId;
+ (id)guTLTemplate:(int)templateId;

+ (id)saveFromJson:(NSDictionary *)dic;
@end
