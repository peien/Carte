// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TemplateItemStyle.h instead.

#import <CoreData/CoreData.h>


extern const struct TemplateItemStyleAttributes {
	__unsafe_unretained NSString *colorBlue;
	__unsafe_unretained NSString *colorGreen;
	__unsafe_unretained NSString *colorRed;
	__unsafe_unretained NSString *fontName;
	__unsafe_unretained NSString *fontSize;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *left;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *top;
} TemplateItemStyleAttributes;

extern const struct TemplateItemStyleRelationships {
	__unsafe_unretained NSString *cardTemplate;
} TemplateItemStyleRelationships;

extern const struct TemplateItemStyleFetchedProperties {
} TemplateItemStyleFetchedProperties;

@class CardTemplateDetail;











@interface TemplateItemStyleID : NSManagedObjectID {}
@end

@interface _TemplateItemStyle : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TemplateItemStyleID*)objectID;





@property (nonatomic, strong) NSNumber* colorBlue;



@property float colorBlueValue;
- (float)colorBlueValue;
- (void)setColorBlueValue:(float)value_;

//- (BOOL)validateColorBlue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* colorGreen;



@property float colorGreenValue;
- (float)colorGreenValue;
- (void)setColorGreenValue:(float)value_;

//- (BOOL)validateColorGreen:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* colorRed;



@property float colorRedValue;
- (float)colorRedValue;
- (void)setColorRedValue:(float)value_;

//- (BOOL)validateColorRed:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fontName;



//- (BOOL)validateFontName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* fontSize;



@property int16_t fontSizeValue;
- (int16_t)fontSizeValue;
- (void)setFontSizeValue:(int16_t)value_;

//- (BOOL)validateFontSize:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* left;



@property int16_t leftValue;
- (int16_t)leftValue;
- (void)setLeftValue:(int16_t)value_;

//- (BOOL)validateLeft:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* top;



@property int16_t topValue;
- (int16_t)topValue;
- (void)setTopValue:(int16_t)value_;

//- (BOOL)validateTop:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) CardTemplateDetail *cardTemplate;

//- (BOOL)validateCardTemplate:(id*)value_ error:(NSError**)error_;





@end

@interface _TemplateItemStyle (CoreDataGeneratedAccessors)

@end

@interface _TemplateItemStyle (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveColorBlue;
- (void)setPrimitiveColorBlue:(NSNumber*)value;

- (float)primitiveColorBlueValue;
- (void)setPrimitiveColorBlueValue:(float)value_;




- (NSNumber*)primitiveColorGreen;
- (void)setPrimitiveColorGreen:(NSNumber*)value;

- (float)primitiveColorGreenValue;
- (void)setPrimitiveColorGreenValue:(float)value_;




- (NSNumber*)primitiveColorRed;
- (void)setPrimitiveColorRed:(NSNumber*)value;

- (float)primitiveColorRedValue;
- (void)setPrimitiveColorRedValue:(float)value_;




- (NSString*)primitiveFontName;
- (void)setPrimitiveFontName:(NSString*)value;




- (NSNumber*)primitiveFontSize;
- (void)setPrimitiveFontSize:(NSNumber*)value;

- (int16_t)primitiveFontSizeValue;
- (void)setPrimitiveFontSizeValue:(int16_t)value_;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;




- (NSNumber*)primitiveLeft;
- (void)setPrimitiveLeft:(NSNumber*)value;

- (int16_t)primitiveLeftValue;
- (void)setPrimitiveLeftValue:(int16_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveTop;
- (void)setPrimitiveTop:(NSNumber*)value;

- (int16_t)primitiveTopValue;
- (void)setPrimitiveTopValue:(int16_t)value_;





- (CardTemplateDetail*)primitiveCardTemplate;
- (void)setPrimitiveCardTemplate:(CardTemplateDetail*)value;


@end
