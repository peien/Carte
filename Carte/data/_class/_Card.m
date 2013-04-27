// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Card.m instead.

#import "_Card.h"

const struct CardAttributes CardAttributes = {
	.another = @"another",
	.company = @"company",
	.companyEmail = @"companyEmail",
	.email0 = @"email0",
	.email1 = @"email1",
	.email2 = @"email2",
	.fax0 = @"fax0",
	.fax1 = @"fax1",
	.fax2 = @"fax2",
	.id = @"id",
	.id2Cus = @"id2Cus",
	.job = @"job",
	.logoUrl = @"logoUrl",
	.mobile0 = @"mobile0",
	.mobile1 = @"mobile1",
	.mobile2 = @"mobile2",
	.msn = @"msn",
	.name = @"name",
	.needReply = @"needReply",
	.qq = @"qq",
	.tele0 = @"tele0",
	.tele1 = @"tele1",
	.tele2 = @"tele2",
	.type = @"type",
	.viewed = @"viewed",
	.wangwang = @"wangwang",
	.web = @"web",
	.zipcode = @"zipcode",
};

const struct CardRelationships CardRelationships = {
	.address = @"address",
	.cardTemplate = @"cardTemplate",
	.group = @"group",
};

const struct CardFetchedProperties CardFetchedProperties = {
};

@implementation CardID
@end

@implementation _Card

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Card";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Card" inManagedObjectContext:moc_];
}

- (CardID*)objectID {
	return (CardID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"id2CusValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id2Cus"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"needReplyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"needReply"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"viewedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"viewed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic another;






@dynamic company;






@dynamic companyEmail;






@dynamic email0;






@dynamic email1;






@dynamic email2;






@dynamic fax0;






@dynamic fax1;






@dynamic fax2;






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





@dynamic id2Cus;



- (int32_t)id2CusValue {
	NSNumber *result = [self id2Cus];
	return [result intValue];
}

- (void)setId2CusValue:(int32_t)value_ {
	[self setId2Cus:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveId2CusValue {
	NSNumber *result = [self primitiveId2Cus];
	return [result intValue];
}

- (void)setPrimitiveId2CusValue:(int32_t)value_ {
	[self setPrimitiveId2Cus:[NSNumber numberWithInt:value_]];
}





@dynamic job;






@dynamic logoUrl;






@dynamic mobile0;






@dynamic mobile1;






@dynamic mobile2;






@dynamic msn;






@dynamic name;






@dynamic needReply;



- (BOOL)needReplyValue {
	NSNumber *result = [self needReply];
	return [result boolValue];
}

- (void)setNeedReplyValue:(BOOL)value_ {
	[self setNeedReply:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveNeedReplyValue {
	NSNumber *result = [self primitiveNeedReply];
	return [result boolValue];
}

- (void)setPrimitiveNeedReplyValue:(BOOL)value_ {
	[self setPrimitiveNeedReply:[NSNumber numberWithBool:value_]];
}





@dynamic qq;






@dynamic tele0;






@dynamic tele1;






@dynamic tele2;






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





@dynamic viewed;



- (BOOL)viewedValue {
	NSNumber *result = [self viewed];
	return [result boolValue];
}

- (void)setViewedValue:(BOOL)value_ {
	[self setViewed:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveViewedValue {
	NSNumber *result = [self primitiveViewed];
	return [result boolValue];
}

- (void)setPrimitiveViewedValue:(BOOL)value_ {
	[self setPrimitiveViewed:[NSNumber numberWithBool:value_]];
}





@dynamic wangwang;






@dynamic web;






@dynamic zipcode;






@dynamic address;

	

@dynamic cardTemplate;

	

@dynamic group;

	






@end
