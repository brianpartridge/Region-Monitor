#import "CDLocationEntry.h"

@implementation CDLocationEntry

+ (CDLocationEntry *)entryWithLocation:(CLLocation *)location inContext:(NSManagedObjectContext *)context {
    CDLocationEntry *result = [CDLocationEntry MR_createInContext:context];
    result.timestamp = location.timestamp;
    result.latitudeValue = location.coordinate.latitude;
    result.longitudeValue = location.coordinate.longitude;
    return result;
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitudeValue, self.longitudeValue);
}

- (NSString *)title {
    return [NSString stringWithFormat:@"Lat: %0.5f Lon: %0.5f", self.latitudeValue, self.longitudeValue];
}

@end
