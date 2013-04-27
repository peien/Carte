// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CardTemplate.h instead.

#import <CoreData/CoreData.h>


extern const struct CardTemplateAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *imageUrl;
	__unsafe_unretained NSString *type;
} CardTemplateAttributes;

extern const struct CardTemplateRelationships {
	__unsafe_unretained NSString *card;
	__unsafe_unretained NSString *detail;
} CardTemplateRelationships;

extern const struct CardTemplateFetchedProperties {
} CardTemplateFetchedProperties;

@class Card;
@class CardTemplateDetail;





@interface CardTemplateID : NSManagedObjectID {}
@end

@interface _CardTemplate : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CardTemplateID*)objectID;





@property (nonatomic, strong) NSNumber* id;



@property int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* imageUrl;



//- (BOOL)validateImageUrl:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* type;



@property int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *card;

- (NSMutableSet*)cardSet;




@property (nonatomic, strong) CardTemplateDetail *detail;

//- (BOOL)validateDetail:(id*)value_ error:(NSError**)error_;





@end

@interface _CardTemplate (CoreDataGeneratedAccessors)

- (void)addCard:(NSSet*)value_;
- (void)removeCard:(NSSet*)value_;
- (void)addCardObject:(Card*)value_;
- (void)removeCardObject:(Card*)value_;

@end

@interface _CardTemplate (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;




- (NSString*)primitiveImageUrl;
- (void)setPrimitiveImageUrl:(NSString*)value;




- (NSNumber*)primitiveType;
- (void)setPrimitiveType:(NSNumber*)value;

- (int16_t)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(int16_t)value_;





- (NSMutableSet*)primitiveCard;
- (void)setPrimitiveCard:(NSMutableSet*)value;



- (CardTemplateDetail*)primitiveDetail;
- (void)setPrimitiveDetail:(CardTemplateDetail*)value;


@end
