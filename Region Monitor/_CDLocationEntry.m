// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDLocationEntry.m instead.

#import "_CDLocationEntry.h"

const struct CDLocationEntryAttributes CDLocationEntryAttributes = {
	.latitude = @"latitude",
	.longitude = @"longitude",
	.manualEntry = @"manualEntry",
	.timestamp = @"timestamp",
};

const struct CDLocationEntryRelationships CDLocationEntryRelationships = {
};

const struct CDLocationEntryFetchedProperties CDLocationEntryFetchedProperties = {
};

@implementation CDLocationEntryID
@end

@implementation _CDLocationEntry

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDLocationEntry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDLocationEntry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDLocationEntry" inManagedObjectContext:moc_];
}

- (CDLocationEntryID*)objectID {
	return (CDLocationEntryID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"manualEntryValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"manualEntry"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic latitude;



- (double)latitudeValue {
	NSNumber *result = [self latitude];
	return [result doubleValue];
}

- (void)setLatitudeValue:(double)value_ {
	[self setLatitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveLatitudeValue:(double)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithDouble:value_]];
}





@dynamic longitude;



- (double)longitudeValue {
	NSNumber *result = [self longitude];
	return [result doubleValue];
}

- (void)setLongitudeValue:(double)value_ {
	[self setLongitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveLongitudeValue:(double)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithDouble:value_]];
}





@dynamic manualEntry;



- (BOOL)manualEntryValue {
	NSNumber *result = [self manualEntry];
	return [result boolValue];
}

- (void)setManualEntryValue:(BOOL)value_ {
	[self setManualEntry:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveManualEntryValue {
	NSNumber *result = [self primitiveManualEntry];
	return [result boolValue];
}

- (void)setPrimitiveManualEntryValue:(BOOL)value_ {
	[self setPrimitiveManualEntry:[NSNumber numberWithBool:value_]];
}





@dynamic timestamp;











@end
