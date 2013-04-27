#import "CardTemplate.h"

#import "NSManagedObject+KHH.h"
#import "CardTemplateDetail.h"

@interface CardTemplate ()

// Private interface goes here.

@end


@implementation CardTemplate
@synthesize image = _image;
@synthesize dicStyles = _dicStyles;

+ (NSArray *)allTemplate
{
    return [self objectArrayByPredicate:nil sortDescriptors:nil];
}

+ (id)chenQETemplate:(int)templateId
{
    CardTemplate * tempPro = [self objectByID:[NSNumber numberWithInt:20+templateId] createIfNone:NO];
    if (tempPro) {
        tempPro.image = [UIImage imageNamed:[NSString stringWithFormat:@"chenQE0%d.jpg",templateId]];
        return tempPro;
    }
    tempPro = [self objectByID:[NSNumber numberWithInt:20+templateId] createIfNone:YES];
    tempPro.image = [UIImage imageNamed:[NSString stringWithFormat:@"chenQE0%d.jpg",templateId]];
    TemplateItemStyle *style = [TemplateItemStyle newObject];
    style.topValue = 26;
    style.leftValue = 21;
    style.fontSizeValue = 22;
    style.fontName = @"sys";
    style.color = [CIColor colorWithRed:100.0/255.0 green:200.0/255.0 blue:5.0/255.0 alpha:1.0];
    style.name = @"name";
    [tempPro.detail.stylesSet addObject:style];
    
    TemplateItemStyle *style2  = [TemplateItemStyle newObject];
    style2.topValue = 30;
    style2.leftValue = 150;
    style2.fontSizeValue = 13;
    style2.fontName = @"sys";
    style2.color = [CIColor colorWithRed:100.0/255.0 green:60.0/255.0 blue:5.0/255.0 alpha:1.0];
    style2.name = @"job";
    [tempPro.detail.stylesSet addObject:style2];
    
    
    TemplateItemStyle *style3  = [TemplateItemStyle newObject];
    style3.topValue = 100;
    style3.leftValue = 21;
    style3.fontSizeValue = 13;
    style3.fontName = @"sys";
    style3.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:105.0/255.0 alpha:1.0];
    style3.name = @"company";
    [tempPro.detail.stylesSet addObject:style3];
    
    TemplateItemStyle *style4  = [TemplateItemStyle newObject];
    style4.topValue = 50;
    style4.leftValue = 100;
    style4.fontSizeValue = 16;
    style4.fontName = @"sys";
    style4.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:10.0/255.0 alpha:1.0];
    style4.name = @"mobile";
    [tempPro.detail.stylesSet addObject:style4];
    
    TemplateItemStyle *style5  = [TemplateItemStyle newObject];
    style5.topValue = 80;
    style5.leftValue = 120;
    style5.fontSizeValue = 17;
    style5.fontName = @"sys";
    style5.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:105.0/255.0 alpha:1.0];
    style5.name = @"address";
    [tempPro.detail.stylesSet addObject:style5];
    
    [[KHHData sharedData] saveContext];
    return tempPro;
}


+ (id)guTLTemplate:(int)templateId
{
    CardTemplate * tempPro = [self objectByID:[NSNumber numberWithInt:10+templateId] createIfNone:NO];
    if (tempPro) {
        tempPro.image = [UIImage imageNamed:[NSString stringWithFormat:@"guTL0%d.jpg",templateId]];
        return tempPro;
    }
    tempPro = [self objectByID:[NSNumber numberWithInt:10+templateId] createIfNone:YES];
    tempPro.image = [UIImage imageNamed:[NSString stringWithFormat:@"guTL0%d.jpg",templateId]];
    TemplateItemStyle *style = [TemplateItemStyle newObject];
    style.topValue = 26;
    style.leftValue = 21;
    style.fontSizeValue = 22;
    style.fontName = @"sys";
    style.color = [CIColor colorWithRed:100.0/255.0 green:200.0/255.0 blue:5.0/255.0 alpha:1.0];
    style.name = @"name";
    [tempPro.detail.stylesSet addObject:style];
    
    TemplateItemStyle *style2  = [TemplateItemStyle newObject];
    style2.topValue = 30;
    style2.leftValue = 150;
    style2.fontSizeValue = 13;
    style2.fontName = @"sys";
    style2.color = [CIColor colorWithRed:100.0/255.0 green:60.0/255.0 blue:5.0/255.0 alpha:1.0];
    style2.name = @"job";
    [tempPro.detail.stylesSet addObject:style2];
    
    
    TemplateItemStyle *style3  = [TemplateItemStyle newObject];
    style3.topValue = 100;
    style3.leftValue = 21;
    style3.fontSizeValue = 13;
    style3.fontName = @"sys";
    style3.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:105.0/255.0 alpha:1.0];
    style3.name = @"company";
    [tempPro.detail.stylesSet addObject:style3];
    
    TemplateItemStyle *style4  = [TemplateItemStyle newObject];
    style4.topValue = 50;
    style4.leftValue = 100;
    style4.fontSizeValue = 16;
    style4.fontName = @"sys";
    style4.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:10.0/255.0 alpha:1.0];
    style4.name = @"mobile";
    [tempPro.detail.stylesSet addObject:style4];
    
    TemplateItemStyle *style5  = [TemplateItemStyle newObject];
    style5.topValue = 80;
    style5.leftValue = 120;
    style5.fontSizeValue = 17;
    style5.fontName = @"sys";
    style5.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:105.0/255.0 alpha:1.0];
    style5.name = @"address";
    [tempPro.detail.stylesSet addObject:style5];
    
    [[KHHData sharedData] saveContext];
    return tempPro;
}

+ (id)doInitForTest
{
    CardTemplate * tempPro = [self objectByID:[NSNumber numberWithInt:1] createIfNone:NO];
    if (tempPro) {
        tempPro.image = [UIImage imageNamed:@"zhou0.jpg"];
        return tempPro;
    }
    tempPro = [self objectByID:[NSNumber numberWithInt:1] createIfNone:YES];
    tempPro.image = [UIImage imageNamed:@"zhou0.jpg"];
    TemplateItemStyle *style = [TemplateItemStyle newObject];
    style.topValue = 26;
    style.leftValue = 21;
    style.fontSizeValue = 22;
    style.fontName = @"sys";
    style.color = [CIColor colorWithRed:100.0/255.0 green:200.0/255.0 blue:5.0/255.0 alpha:1.0];
    style.name = @"name";
    [tempPro.detail.stylesSet addObject:style];
    
    TemplateItemStyle *style2  = [TemplateItemStyle newObject];
    style2.topValue = 30;
    style2.leftValue = 150;
    style2.fontSizeValue = 13;
    style2.fontName = @"sys";
    style2.color = [CIColor colorWithRed:100.0/255.0 green:60.0/255.0 blue:5.0/255.0 alpha:1.0];
    style2.name = @"job";
    [tempPro.detail.stylesSet addObject:style2];
    
    
    TemplateItemStyle *style3  = [TemplateItemStyle newObject];
    style3.topValue = 100;
    style3.leftValue = 21;
    style3.fontSizeValue = 13;
    style3.fontName = @"sys";
    style3.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:105.0/255.0 alpha:1.0];
    style3.name = @"company";
    [tempPro.detail.stylesSet addObject:style3];
    
    TemplateItemStyle *style4  = [TemplateItemStyle newObject];
    style4.topValue = 50;
    style4.leftValue = 100;
    style4.fontSizeValue = 16;
    style4.fontName = @"sys";
    style4.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:10.0/255.0 alpha:1.0];
    style4.name = @"mobile";
    [tempPro.detail.stylesSet addObject:style4];
    
    TemplateItemStyle *style5  = [TemplateItemStyle newObject];
    style5.topValue = 80;
    style5.leftValue = 120;
    style5.fontSizeValue = 17;
    style5.fontName = @"sys";
    style5.color = [CIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:105.0/255.0 alpha:1.0];
    style5.name = @"address";
    [tempPro.detail.stylesSet addObject:style5];
    
    [[KHHData sharedData] saveContext];
    return tempPro;
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
}

- (UIImage *)image
{
    if (!_image) {
        if (self.imageUrl) {
            
        }
        _image = [UIImage imageNamed:@"zhou0.jpg"];
    }
    return _image;
}

+ (id)saveFromJson:(NSDictionary *)dic
{
    CardTemplate * temPro;
    temPro = [self objectByKey:@"id" value:dic[@"id"] createIfNone:YES];
    
    if ([dic[@"templateType"] isEqual:@"TDEFAULT"]) {
        temPro.type = [NSNumber numberWithInt:type_template_default];
    }
    if ([dic[@"templateType"] isEqual:@"TPRIVATE"]) {
        temPro.type = [NSNumber numberWithInt:type_template_private];
    }
    
    temPro.imageUrl = [self isNilStr:dic[@"imgUrl"]];
    if ([self isNilStr:dic[@"templateDetailGroup"]]) {
        temPro.detail = [CardTemplateDetail objectByID:dic[@"templateDetailGroup"][@"id"] createIfNone:NO];
    }
    
    
//    for (TemplateItemStyle *stylePro in [temPro.detail.styles allObjects]) {
//        [[self currentContext] deleteObject:stylePro];
//    }
//    
//    for (NSDictionary *dicPro in dic[@"templateDetails"]) {
//        [temPro.detail.stylesSet addObject:[TemplateItemStyle objectByID:dicPro[@"id"] createIfNone:YES]];
//        [TemplateItemStyle saveFromJson:dicPro];
//    }
    return temPro;
    
}

@end
