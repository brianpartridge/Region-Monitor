#import "_CDLocationEntry.h"

@interface CDLocationEntry : _CDLocationEntry <MKAnnotation>

+ (CDLocationEntry *)entryWithLocation:(CLLocation *)location inContext:(NSManagedObjectContext *)context;

@end
