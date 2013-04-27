#import "_Card.h"
#import "CardTemplate.h"
#import "ParamForEditecard.h"
#import "Address.h"
#import "NSManagedObject+KHH.h"

enum type_card {
    type_card_my = 1,
    type_card_private,
    type_card_reseave
};


@interface Card : _Card {
    NSMutableArray *_arrAllIn;
    NSMutableArray *_arrAllInShowDetail;
    NSMutableDictionary *dicItemFromTag;
    
//    NSMutableArray *topicker1;
//    NSMutableArray *topicker2;
//    NSMutableArray *topicker3;
    
}
@property(nonatomic,strong)NSArray *arrForEditView;

+ (id)doInitForTest;
+ (id)mycard;
+ (int)numCard;
+ (int)numNew;

+ (id)saveFromJsonMyCard:(NSDictionary *)dic;
+ (id)saveFromJson:(NSDictionary *)dic;
@end
