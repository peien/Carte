#import "TemplateItemStyle.h"

#import "NSManagedObject+KHH.h"
#import "NSString+Contain.h"
#import "NSNumber+SM.h"

@interface TemplateItemStyle ()

// Private interface goes here.

@end


@implementation TemplateItemStyle
@synthesize color = _color;
- (void)setColor:(CIColor *)color
{
    _color = color;
    self.colorRedValue = _color.red;
    self.colorGreenValue = _color.green;
    self.colorBlueValue = _color.blue;
}

- (CIColor *)color
{
    if (!_color) {
        _color = [CIColor colorWithRed:self.colorRedValue green:self.colorGreenValue blue:self.colorBlueValue alpha:1.0];
    }
    return _color;
}

+ (void)saveFromJson:(NSDictionary *)dic
{
    TemplateItemStyle *stylePro = [self objectByKey:@"id" value:dic[@"id"] createIfNone:YES];
    stylePro.name = [self isNilStr:dic[@"item"]];
    if ([self isNilStr:dic[@"style"]]) {
        NSArray *arrPro = [dic[@"style"] componentsSeparatedByString:@";"];
        NSMutableDictionary *dicPro = [[NSMutableDictionary alloc]initWithCapacity:[arrPro count]];
        for (NSString *strPro in arrPro) {
            NSArray *arrPro2 = [strPro componentsSeparatedByString:@":"];            
            dicPro[[arrPro2[0] replaceAll:@" " toStr:@""]] = [[arrPro2[1] replaceAll:@"px" toStr:@""]replaceAll:@" " toStr:@""];
        }
        stylePro.topValue = [dicPro[@"top"] integerValue];
        stylePro.leftValue = [dicPro[@"left"] integerValue];
        stylePro.fontSizeValue = [dicPro[@"font-size"] integerValue];
        stylePro.fontName = dicPro[@"fontWeight"];
        stylePro.color = [self getColor:dicPro[@"color"]];
    }
    
}

+ (CIColor *) getColor:(NSString *)hexColor
{
    hexColor = [[hexColor replaceAll:@"#" toStr:@""] appendTo6LengthColor];
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [CIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f) alpha:1.0f];
   
}

@end
