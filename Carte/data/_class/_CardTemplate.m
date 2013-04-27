// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CardTemplate.m instead.

#import "_CardTemplate.h"

const struct CardTemplateAttributes CardTemplateAttributes = {
	.id = @"id",
	.imageUrl = @"imageUrl",
	.type = @"type",
};

const struct CardTemplateRelationships CardTemplateRelationships = {
	.card = @"card",
	.detail = @"detail",
};

const struct CardTemplateFetchedProperties CardTemplateFetchedProperties = {
};

@implementation CardTemplateID
@end

@implementation _CardTemplate

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CardTemplate" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CardTemplate";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CardTemplate" inManagedObjectContext:moc_];
}

- (CardTemplateID*)objectID {
	return (CardTemplateID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
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





@dynamic imageUrl;






@dynamic type;



- (int16_t)typeValue {
	NSNumber *result = [self type];
	return [result shortValue];
}

- (void)setTypeValue:(int16_t)value_ {
	[self setType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTypeValue {
	NSNumber *result = [self primitiveType];
	return [result shortValue];
}

- (void)setPrimitiveTypeValue:(int16_t)value_ {
	[self setPrimitiveType:[NSNumber numberWithShort:value_]];
}





@dynamic card;

	
- (NSMutableSet*)cardSet {
	[self willAccessValueForKey:@"card"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"card"];
  
	[self didAccessValueForKey:@"card"];
	return result;
}
	

@dynamic detail;

	






@end
