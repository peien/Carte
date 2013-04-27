// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TemplateItemStyle.m instead.

#import "_TemplateItemStyle.h"

const struct TemplateItemStyleAttributes TemplateItemStyleAttributes = {
	.colorBlue = @"colorBlue",
	.colorGreen = @"colorGreen",
	.colorRed = @"colorRed",
	.fontName = @"fontName",
	.fontSize = @"fontSize",
	.id = @"id",
	.left = @"left",
	.name = @"name",
	.top = @"top",
};

const struct TemplateItemStyleRelationships TemplateItemStyleRelationships = {
	.cardTemplate = @"cardTemplate",
};

const struct TemplateItemStyleFetchedProperties TemplateItemStyleFetchedProperties = {
};

@implementation TemplateItemStyleID
@end

@implementation _TemplateItemStyle

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TemplateItemStyle" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TemplateItemStyle";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TemplateItemStyle" inManagedObjectContext:moc_];
}

- (TemplateItemStyleID*)objectID {
	return (TemplateItemStyleID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"colorBlueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"colorBlue"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"colorGreenValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"colorGreen"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"colorRedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"colorRed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"fontSizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fontSize"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"leftValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"left"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"topValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"top"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic colorBlue;



- (float)colorBlueValue {
	NSNumber *result = [self colorBlue];
	return [result floatValue];
}

- (void)setColorBlueValue:(float)value_ {
	[self setColorBlue:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveColorBlueValue {
	NSNumber *result = [self primitiveColorBlue];
	return [result floatValue];
}

- (void)setPrimitiveColorBlueValue:(float)value_ {
	[self setPrimitiveColorBlue:[NSNumber numberWithFloat:value_]];
}





@dynamic colorGreen;



- (float)colorGreenValue {
	NSNumber *result = [self colorGreen];
	return [result floatValue];
}

- (void)setColorGreenValue:(float)value_ {
	[self setColorGreen:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveColorGreenValue {
	NSNumber *result = [self primitiveColorGreen];
	return [result floatValue];
}

- (void)setPrimitiveColorGreenValue:(float)value_ {
	[self setPrimitiveColorGreen:[NSNumber numberWithFloat:value_]];
}





@dynamic colorRed;



- (float)colorRedValue {
	NSNumber *result = [self colorRed];
	return [result floatValue];
}

- (void)setColorRedValue:(float)value_ {
	[self setColorRed:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveColorRedValue {
	NSNumber *result = [self primitiveColorRed];
	return [result floatValue];
}

- (void)setPrimitiveColorRedValue:(float)value_ {
	[self setPrimitiveColorRed:[NSNumber numberWithFloat:value_]];
}





@dynamic fontName;






@dynamic fontSize;



- (int16_t)fontSizeValue {
	NSNumber *result = [self fontSize];
	return [result shortValue];
}

- (void)setFontSizeValue:(int16_t)value_ {
	[self setFontSize:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveFontSizeValue {
	NSNumber *result = [self primitiveFontSize];
	return [result shortValue];
}

- (void)setPrimitiveFontSizeValue:(int16_t)value_ {
	[self setPrimitiveFontSize:[NSNumber numberWithShort:value_]];
}





@dynamic id;



- (int32_t)idValue {
	NSNumber *result = [self id];
	return [result intValue];
}

- (void)setIdValue:(int32_t)value_ {
	[self setId:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result intValue];
}

- (void)setPrimitiveIdValue:(int32_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithInt:value_]];
}





@dynamic left;



- (int16_t)leftValue {
	NSNumber *result = [self left];
	return [result shortValue];
}

- (void)setLeftValue:(int16_t)value_ {
	[self setLeft:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveLeftValue {
	NSNumber *result = [self primitiveLeft];
	return [result shortValue];
}

- (void)setPrimitiveLeftValue:(int16_t)value_ {
	[self setPrimitiveLeft:[NSNumber numberWithShort:value_]];
}





@dynamic name;






@dynamic top;



- (int16_t)topValue {
	NSNumber *result = [self top];
	return [result shortValue];
}

- (void)setTopValue:(int16_t)value_ {
	[self setTop:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTopValue {
	NSNumber *result = [self primitiveTop];
	return [result shortValue];
}

- (void)setPrimitiveTopValue:(int16_t)value_ {
	[self setPrimitiveTop:[NSNumber numberWithShort:value_]];
}





@dynamic cardTemplate;

	






@end
