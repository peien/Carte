#import "Card.h"
#import "KHHData.h"
#import "NSManagedObject+KHH.h"
#import "Group.h"

@interface Card ()


// Private interface goes here.

@end


@implementation Card
@synthesize arrForEditView = _arrForEditView;

+ (id)doInitForTest
{
    return nil;
    Card * cardPro = [self objectByID:[NSNumber numberWithInt:1] createIfNone:NO];
    if (cardPro) {
        return cardPro;
    }
    cardPro = [self objectByID:[NSNumber numberWithInt:1] createIfNone:YES];
    cardPro.name = @"芷若 周";
    cardPro.job = @"峨眉掌门";
    cardPro.company = @"峨眉派";
    cardPro.mobile0 = @"13355555555";
    cardPro.mobile1 = @"13355666666";
    cardPro.tele0 = @"057188555555";
    cardPro.tele1 = @"057188665566";
    cardPro.email0 = @"ZhiruoZhou@emei.com";
    cardPro.fax0 = @"057188555556";
    
    Address *address = [Address objectByID:[NSNumber numberWithInt:1]  createIfNone:YES];
    address.detailStreet = @"华山以北，衡山以南";
    address.province = @"台湾";
    address.city = @"台北";
    cardPro.address = address;
    
    cardPro.cardTemplate = [CardTemplate doInitForTest];
    [[KHHData sharedData] saveContext];
    return cardPro;
}

+ (id)mycard
{
    return  [self objectByKey:@"type" value:[NSNumber numberWithInt:type_card_my] createIfNone:NO];
}



+ (id)saveFromJsonMyCard:(NSDictionary *)dic
{
    Card * cardPro = [self saveFromJson:dic];
    cardPro.typeValue = type_card_my;    
    cardPro.group = [Group createGroupAll];
    [[KHHData sharedData] saveContext];
    return cardPro;
}

+ (int)numCard
{
   
    NSArray *fetched;
    fetched = [self objectArrayByPredicate:[NSPredicate predicateWithFormat:@"type != 1"]
                           sortDescriptors:@[[self nameSortDescriptor]]];
    // 过滤掉意外情况
    // NSMutableArray *result = [self filterUnexpectedCardsFromArray:fetched];
    return [fetched count];
}

+ (int)numNew
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"viewed <> YES"];
//    if (myComID.integerValue) {
//        // 自己属于某公司
//        predicate = [NSPredicate predicateWithFormat:@"(viewed <> YES)", myComID];
//    }
    NSArray *fetched;
    fetched = [self objectArrayByPredicate:predicate
                                   sortDescriptors:@[[self nameSortDescriptor]]];
    // 过滤掉意外情况
   // NSMutableArray *result = [self filterUnexpectedCardsFromArray:fetched];
    return [fetched count];
}

+ (id)saveFromJson:(NSDictionary *)dic
{
    
    Card * cardPro;
     
    
    if (dic[@"caontactType"]) {
        cardPro = [self objectByKey:@"id" value:dic[@"sendCard"][@"id"] createIfNone:YES];
        cardPro.logoUrl = [self isNilStr:dic[@"logoUrl"]];
        if ([self isNilStr:dic[@"contactGroup"]]) {
            cardPro.group = [Group objectByID:dic[@"contactGroup"][@"id"] createIfNone:YES];
        }else{
            cardPro.group = [Group createGroupUnPacket];
        }
        
        cardPro.id2Cus = dic[@"id"];
        
        if ([dic[@"caontactType"] isEqualToString:@"SELFBUILD"]) {
            cardPro.typeValue = type_card_private;
        }
        
        if ([dic[@"caontactType"] isEqualToString:@"EXCHANGE"]) {
            cardPro.typeValue = type_card_reseave;
        }
        
        if ([self isNilStr:dic[@"needReply"]]) {
            if ([dic[@"needReply"] isEqualToNumber:[NSNumber numberWithInt:1]]) {
                cardPro.needReplyValue = YES;
            }else{
                cardPro.needReplyValue = NO;
            }            
        }
        
        if ([self isNilStr:dic[@"viewed"]]) {
            if ([dic[@"viewed"] isEqualToNumber:[NSNumber numberWithInt:1]]) {
                cardPro.viewedValue = YES;
            }else{
                cardPro.viewedValue = NO;
            }
        }else{
            cardPro.viewedValue = YES;
        }

        
        dic = dic[@"sendCard"];
    }else{
         cardPro = [self objectByKey:@"id" value:dic[@"id"] createIfNone:YES];
       
    }
    
    if ([dic[@"deleted"] isEqualToString:@"y"]) {
        [[self currentContext] deleteObject:cardPro];
        [[KHHData sharedData] saveContext];
        return nil;
    }

    cardPro.name = [self isNilStr: dic[@"cardDetail"][@"trueName"]];
    cardPro.job = [self isNilStr: dic[@"cardDetail"][@"jobTitle"]];
    cardPro.zipcode = [self isNilStr: dic[@"cardDetail"][@"zipCode"]];
    if ([self isNilStr:dic[@"cardDetail"][@"mobiles"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"mobiles"] componentsSeparatedByString:@"|"];
        cardPro.mobile0 = arrPro[0];
        cardPro.mobile1 = [arrPro count]>=2?arrPro[1]:nil;
        cardPro.mobile2 = [arrPro count]>=3?arrPro[2]:nil;
    }else{
        cardPro.mobile0 = nil;
        cardPro.mobile1 = nil;
        cardPro.mobile2 = nil;
    }
    
    if ([self isNilStr:dic[@"cardDetail"][@"phones"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"phones"] componentsSeparatedByString:@"|"];
        cardPro.tele0 = arrPro[0];
        cardPro.tele1 = [arrPro count]>=2?arrPro[1]:nil;
        cardPro.tele2 = [arrPro count]>=3?arrPro[2]:nil;
    }else{
        cardPro.tele0 = nil;
        cardPro.tele1 = nil;
        cardPro.tele2 = nil;
    }
    
    
    if ([self isNilStr:dic[@"cardDetail"][@"mails"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"mails"] componentsSeparatedByString:@"|"];
        cardPro.email0 = arrPro[0];
        cardPro.email1 = [arrPro count]>=2?arrPro[1]:nil;
        cardPro.email2 = [arrPro count]>=3?arrPro[2]:nil;
    }else{
        cardPro.email0 = nil;
        cardPro.email1 = nil;
        cardPro.email2 = nil;
    }
    
    
    if ([self isNilStr:dic[@"cardDetail"][@"faxs"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"faxs"] componentsSeparatedByString:@"|"];
        cardPro.fax0 = arrPro[0];
        cardPro.fax1 = [arrPro count]>=2?arrPro[1]:nil;
        cardPro.fax2 = [arrPro count]>=3?arrPro[2]:nil;
    }else{
        cardPro.fax0 = nil;
        cardPro.fax1 = nil;
        cardPro.fax2 = nil;
    }
    
    if ([self isNilStr:dic[@"company"]]) {
        cardPro.company = [self isNilStr:dic[@"company"][@"name"]];
        cardPro.companyEmail = [self isNilStr:dic[@"company"][@"mails"]];
    }else{
        cardPro.company = nil;
        cardPro.companyEmail = nil;
        
    }
    
    if (!cardPro.address) {
        cardPro.address = [Address newObject];
    }
    cardPro.address.city = [self isNilStr:dic[@"cardDetail"][@"city"]];
    cardPro.address.province =  [self isNilStr: dic[@"cardDetail"][@"province"]];
    cardPro.address.detailStreet = [self isNilStr: dic[@"cardDetail"][@"address"]];
    
    if ([self isNilStr:dic[@"cardDetail"][@"homePages"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"homePages"] componentsSeparatedByString:@"|"];
        cardPro.web = arrPro[0];
    }else{
        cardPro.web = nil;
    }
    
    if ([self isNilStr:dic[@"cardDetail"][@"qqs"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"qqs"] componentsSeparatedByString:@"|"];
        cardPro.qq = arrPro[0];
    }else{
        cardPro.qq = nil;
    }
    
    if ([self isNilStr:dic[@"cardDetail"][@"msns"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"msns"] componentsSeparatedByString:@"|"];
        cardPro.msn = arrPro[0];
    }else{
        cardPro.msn = nil;
    }
    
    if ([self isNilStr:dic[@"cardDetail"][@"wangwangs"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"wangwangs"] componentsSeparatedByString:@"|"];
        cardPro.wangwang = arrPro[0];
    }else{
        cardPro.wangwang = nil;
    }
    
    if ([self isNilStr:dic[@"cardDetail"][@"moreInfo"]]) {
        NSArray* arrPro = [dic[@"cardDetail"][@"moreInfo"] componentsSeparatedByString:@"|"];
        cardPro.another = arrPro[0];
    }else{
        cardPro.another = nil;
    }
    cardPro.logoUrl = [self isNilStr:dic[@"logoUrl"]];
    //    if (!cardPro.template) {
//        cardPro.template = [Template newObject];
//    }
    
    if ([self isNilStr:dic[@"template"]]) {
        cardPro.cardTemplate = [CardTemplate objectByID:dic[@"template"][@"id"] createIfNone:NO];
//        cardPro.template.id = dic[@"template"][@"id"];
//        if ([dic[@"template"][@"templateType"] isEqual:@"TDEFAULT"]) {
//            cardPro.template.type = [NSNumber numberWithInt:0];
//        }
//        [Template saveFromJson:dic[@"template"]];
    }
    
    
    
    return cardPro;
}

@end
