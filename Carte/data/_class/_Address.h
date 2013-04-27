// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Address.h instead.

#import <CoreData/CoreData.h>


extern const struct AddressAttributes {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *detailStreet;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *province;
} AddressAttributes;

extern const struct AddressRelationships {
	__unsafe_unretained NSString *card;
} AddressRelationships;

extern const struct AddressFetchedProperties {
} AddressFetchedProperties;

@class Card;






@interface AddressID : NSManagedObjectID {}
@end

@interface _Address : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AddressID*)objectID;





@property (nonatomic, strong) NSString* city;



//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* detailStreet;



//- (BOOL)validateDetailStreet:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* province;



//- (BOOL)validateProvince:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Card *card;

//- (BOOL)validateCard:(id*)value_ error:(NSError**)error_;





@end

@interface _Address (CoreDataGeneratedAccessors)

@end

@interface _Address (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveDetailStreet;
- (void)setPrimitiveDetailStreet:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;




- (NSString*)primitiveProvince;
- (void)setPrimitiveProvince:(NSString*)value;





- (Card*)primitiveCard;
- (void)setPrimitiveCard:(Card*)value;


@end
