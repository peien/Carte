// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CardTemplateDetail.m instead.

#import "_CardTemplateDetail.h"

const struct CardTemplateDetailAttributes CardTemplateDetailAttributes = {
	.id = @"id",
};

const struct CardTemplateDetailRelationships CardTemplateDetailRelationships = {
	.cardTempalte = @"cardTempalte",
	.styles = @"styles",
};

const struct CardTemplateDetailFetchedProperties CardTemplateDetailFetchedProperties = {
};

@implementation CardTemplateDetailID
@end

@implementation _CardTemplateDetail

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CardTemplateDetail" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CardTemplateDetail";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CardTemplateDetail" inManagedObjectContext:moc_];
}

- (CardTemplateDetailID*)objectID {
	return (CardTemplateDetailID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
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





@dynamic cardTempalte;

	
- (NSMutableSet*)cardTempalteSet {
	[self willAccessValueForKey:@"cardTempalte"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cardTempalte"];
  
	[self didAccessValueForKey:@"cardTempalte"];
	return result;
}
	

@dynamic styles;

	
- (NSMutableSet*)stylesSet {
	[self willAccessValueForKey:@"styles"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"styles"];
  
	[self didAccessValueForKey:@"styles"];
	return result;
}
	






@end
