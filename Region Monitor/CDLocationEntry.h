#import "_CDLocationEntry.h"

@interface CDLocationEntry : _CDLocationEntry {}

- (CDLocationEntry *)entryWithLocation:(CLLocation *)location inContext:(NSManagedObjectContext *)context;

@end
