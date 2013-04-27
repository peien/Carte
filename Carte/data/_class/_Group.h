// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Group.h instead.

#import <CoreData/CoreData.h>


extern const struct GroupAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *type;
} GroupAttributes;

extern const struct GroupRelationships {
	__unsafe_unretained NSString *card;
} GroupRelationships;

extern const struct GroupFetchedProperties {
} GroupFetchedProperties;

@class Card;





@interface GroupID : NSManagedObjectID {}
@end

@interface _Group : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GroupID*)objectID;





@property (nonatomic, strong) NSNumber* id;



@property int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* type;



@property int32_t typeValue;
- (int32_t)typeValue;
- (void)setTypeValue:(int32_t)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *card;

- (NSMutableSet*)cardSet;





@end

@interface _Group (CoreDataGeneratedAccessors)

- (void)addCard:(NSSet*)value_;
- (void)removeCard:(NSSet*)value_;
- (void)addCardObject:(Card*)value_;
- (void)removeCardObject:(Card*)value_;

@end

@interface _Group (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveType;
- (void)setPrimitiveType:(NSNumber*)value;

- (int32_t)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(int32_t)value_;





- (NSMutableSet*)primitiveCard;
- (void)setPrimitiveCard:(NSMutableSet*)value;


@end
