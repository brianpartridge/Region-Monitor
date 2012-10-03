// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDLocationEntry.h instead.

#import <CoreData/CoreData.h>


extern const struct CDLocationEntryAttributes {
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *timestamp;
} CDLocationEntryAttributes;

extern const struct CDLocationEntryRelationships {
} CDLocationEntryRelationships;

extern const struct CDLocationEntryFetchedProperties {
} CDLocationEntryFetchedProperties;






@interface CDLocationEntryID : NSManagedObjectID {}
@end

@interface _CDLocationEntry : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CDLocationEntryID*)objectID;




@property (nonatomic, strong) NSNumber* latitude;


@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* longitude;


@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* timestamp;


//- (BOOL)validateTimestamp:(id*)value_ error:(NSError**)error_;






@end

@interface _CDLocationEntry (CoreDataGeneratedAccessors)

@end

@interface _CDLocationEntry (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;




- (NSDate*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSDate*)value;




@end
