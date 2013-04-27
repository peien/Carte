// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CardTemplateDetail.h instead.

#import <CoreData/CoreData.h>


extern const struct CardTemplateDetailAttributes {
	__unsafe_unretained NSString *id;
} CardTemplateDetailAttributes;

extern const struct CardTemplateDetailRelationships {
	__unsafe_unretained NSString *cardTempalte;
	__unsafe_unretained NSString *styles;
} CardTemplateDetailRelationships;

extern const struct CardTemplateDetailFetchedProperties {
} CardTemplateDetailFetchedProperties;

@class CardTemplate;
@class TemplateItemStyle;



@interface CardTemplateDetailID : NSManagedObjectID {}
@end

@interface _CardTemplateDetail : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CardTemplateDetailID*)objectID;





@property (nonatomic, strong) NSNumber* id;



@property int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *cardTempalte;

- (NSMutableSet*)cardTempalteSet;




@property (nonatomic, strong) NSSet *styles;

- (NSMutableSet*)stylesSet;





@end

@interface _CardTemplateDetail (CoreDataGeneratedAccessors)

- (void)addCardTempalte:(NSSet*)value_;
- (void)removeCardTempalte:(NSSet*)value_;
- (void)addCardTempalteObject:(CardTemplate*)value_;
- (void)removeCardTempalteObject:(CardTemplate*)value_;

- (void)addStyles:(NSSet*)value_;
- (void)removeStyles:(NSSet*)value_;
- (void)addStylesObject:(TemplateItemStyle*)value_;
- (void)removeStylesObject:(TemplateItemStyle*)value_;

@end

@interface _CardTemplateDetail (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;





- (NSMutableSet*)primitiveCardTempalte;
- (void)setPrimitiveCardTempalte:(NSMutableSet*)value;



- (NSMutableSet*)primitiveStyles;
- (void)setPrimitiveStyles:(NSMutableSet*)value;


@end
