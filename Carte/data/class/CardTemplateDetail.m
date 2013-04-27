#import "CardTemplateDetail.h"
#import "NSManagedObject+KHH.h"
#import "TemplateItemStyle.h"


@interface CardTemplateDetail ()

// Private interface goes here.

@end


@implementation CardTemplateDetail
@synthesize dicStyles = _dicStyles;

- (NSMutableDictionary *)dicStyles
{
    _dicStyles = nil;
    _dicStyles = [[NSMutableDictionary alloc]initWithCapacity:10];
    for (TemplateItemStyle *style in [self.styles allObjects]) {
        if (style.name) {
            _dicStyles[style.name] = style;
        }
    }    
    return _dicStyles;
    
}

+ (id)saveFromJson:(NSDictionary *)dic
{
    CardTemplateDetail * temDetailPro;
    temDetailPro = [self objectByKey:@"id" value:dic[@"id"] createIfNone:YES];
    
    for (TemplateItemStyle *stylePro in [temDetailPro.styles allObjects]) {
        [[self currentContext] deleteObject:stylePro];
    }
    for (NSDictionary *dicPro in dic[@"templateDetails"]) {
        [temDetailPro.stylesSet addObject:[TemplateItemStyle objectByID:dicPro[@"id"] createIfNone:YES]];
        [TemplateItemStyle saveFromJson:dicPro];
    }
    return temDetailPro;
}

+ (NSArray *)allTempDetail
{
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"viewed <> YES"];
    //    if (myComID.integerValue) {
    //        // 自己属于某公司
    //        predicate = [NSPredicate predicateWithFormat:@"(viewed <> YES)", myComID];
    //    }
    NSArray *fetched;
    fetched = [self objectArrayByPredicate:nil
                           sortDescriptors:nil];
    return fetched;
}

@end
