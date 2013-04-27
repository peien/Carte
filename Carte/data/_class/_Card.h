// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Card.h instead.

#import <CoreData/CoreData.h>


extern const struct CardAttributes {
	__unsafe_unretained NSString *another;
	__unsafe_unretained NSString *company;
	__unsafe_unretained NSString *companyEmail;
	__unsafe_unretained NSString *email0;
	__unsafe_unretained NSString *email1;
	__unsafe_unretained NSString *email2;
	__unsafe_unretained NSString *fax0;
	__unsafe_unretained NSString *fax1;
	__unsafe_unretained NSString *fax2;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *id2Cus;
	__unsafe_unretained NSString *job;
	__unsafe_unretained NSString *logoUrl;
	__unsafe_unretained NSString *mobile0;
	__unsafe_unretained NSString *mobile1;
	__unsafe_unretained NSString *mobile2;
	__unsafe_unretained NSString *msn;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *needReply;
	__unsafe_unretained NSString *qq;
	__unsafe_unretained NSString *tele0;
	__unsafe_unretained NSString *tele1;
	__unsafe_unretained NSString *tele2;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *viewed;
	__unsafe_unretained NSString *wangwang;
	__unsafe_unretained NSString *web;
	__unsafe_unretained NSString *zipcode;
} CardAttributes;

extern const struct CardRelationships {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *cardTemplate;
	__unsafe_unretained NSString *group;
} CardRelationships;

extern const struct CardFetchedProperties {
} CardFetchedProperties;

@class Address;
@class CardTemplate;
@class Group;






























@interface CardID : NSManagedObjectID {}
@end

@interface _Card : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CardID*)objectID;





@property (nonatomic, strong) NSString* another;



//- (BOOL)validateAnother:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* company;



//- (BOOL)validateCompany:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* companyEmail;



//- (BOOL)validateCompanyEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email0;



//- (BOOL)validateEmail0:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email1;



//- (BOOL)validateEmail1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email2;



//- (BOOL)validateEmail2:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fax0;



//- (BOOL)validateFax0:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fax1;



//- (BOOL)validateFax1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fax2;



//- (BOOL)validateFax2:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id2Cus;



@property int32_t id2CusValue;
- (int32_t)id2CusValue;
- (void)setId2CusValue:(int32_t)value_;

//- (BOOL)validateId2Cus:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* job;



//- (BOOL)validateJob:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* logoUrl;



//- (BOOL)validateLogoUrl:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mobile0;



//- (BOOL)validateMobile0:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mobile1;



//- (BOOL)validateMobile1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mobile2;



//- (BOOL)validateMobile2:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* msn;



//- (BOOL)validateMsn:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* needReply;



@property BOOL needReplyValue;
- (BOOL)needReplyValue;
- (void)setNeedReplyValue:(BOOL)value_;

//- (BOOL)validateNeedReply:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* qq;



//- (BOOL)validateQq:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tele0;



//- (BOOL)validateTele0:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tele1;



//- (BOOL)validateTele1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tele2;



//- (BOOL)validateTele2:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* type;



@property int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* viewed;



@property BOOL viewedValue;
- (BOOL)viewedValue;
- (void)setViewedValue:(BOOL)value_;

//- (BOOL)validateViewed:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* wangwang;



//- (BOOL)validateWangwang:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* web;



//- (BOOL)validateWeb:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* zipcode;



//- (BOOL)validateZipcode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Address *address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) CardTemplate *cardTemplate;

//- (BOOL)validateCardTemplate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Group *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;





@end

@interface _Card (CoreDataGeneratedAccessors)

@end

@interface _Card (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAnother;
- (void)setPrimitiveAnother:(NSString*)value;




- (NSString*)primitiveCompany;
- (void)setPrimitiveCompany:(NSString*)value;




- (NSString*)primitiveCompanyEmail;
- (void)setPrimitiveCompanyEmail:(NSString*)value;




- (NSString*)primitiveEmail0;
- (void)setPrimitiveEmail0:(NSString*)value;




- (NSString*)primitiveEmail1;
- (void)setPrimitiveEmail1:(NSString*)value;




- (NSString*)primitiveEmail2;
- (void)setPrimitiveEmail2:(NSString*)value;




- (NSString*)primitiveFax0;
- (void)setPrimitiveFax0:(NSString*)value;




- (NSString*)primitiveFax1;
- (void)setPrimitiveFax1:(NSString*)value;




- (NSString*)primitiveFax2;
- (void)setPrimitiveFax2:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;




- (NSNumber*)primitiveId2Cus;
- (void)setPrimitiveId2Cus:(NSNumber*)value;

- (int32_t)primitiveId2CusValue;
- (void)setPrimitiveId2CusValue:(int32_t)value_;




- (NSString*)primitiveJob;
- (void)setPrimitiveJob:(NSString*)value;




- (NSString*)primitiveLogoUrl;
- (void)setPrimitiveLogoUrl:(NSString*)value;




- (NSString*)primitiveMobile0;
- (void)setPrimitiveMobile0:(NSString*)value;




- (NSString*)primitiveMobile1;
- (void)setPrimitiveMobile1:(NSString*)value;




- (NSString*)primitiveMobile2;
- (void)setPrimitiveMobile2:(NSString*)value;




- (NSString*)primitiveMsn;
- (void)setPrimitiveMsn:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveNeedReply;
- (void)setPrimitiveNeedReply:(NSNumber*)value;

- (BOOL)primitiveNeedReplyValue;
- (void)setPrimitiveNeedReplyValue:(BOOL)value_;




- (NSString*)primitiveQq;
- (void)setPrimitiveQq:(NSString*)value;




- (NSString*)primitiveTele0;
- (void)setPrimitiveTele0:(NSString*)value;




- (NSString*)primitiveTele1;
- (void)setPrimitiveTele1:(NSString*)value;




- (NSString*)primitiveTele2;
- (void)setPrimitiveTele2:(NSString*)value;




- (NSNumber*)primitiveType;
- (void)setPrimitiveType:(NSNumber*)value;

- (int16_t)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(int16_t)value_;




- (NSNumber*)primitiveViewed;
- (void)setPrimitiveViewed:(NSNumber*)value;

- (BOOL)primitiveViewedValue;
- (void)setPrimitiveViewedValue:(BOOL)value_;




- (NSString*)primitiveWangwang;
- (void)setPrimitiveWangwang:(NSString*)value;




- (NSString*)primitiveWeb;
- (void)setPrimitiveWeb:(NSString*)value;




- (NSString*)primitiveZipcode;
- (void)setPrimitiveZipcode:(NSString*)value;





- (Address*)primitiveAddress;
- (void)setPrimitiveAddress:(Address*)value;



- (CardTemplate*)primitiveCardTemplate;
- (void)setPrimitiveCardTemplate:(CardTemplate*)value;



- (Group*)primitiveGroup;
- (void)setPrimitiveGroup:(Group*)value;


@end
