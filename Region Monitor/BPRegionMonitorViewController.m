//
//  BPRegionMonitorViewController.m
//  Region Monitor
//
//  Created by Brian Partridge on 10/3/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "BPRegionMonitorViewController.h"
#import "CDLocationEntry.h"

static NSString * const kLocationEntryCell = @"LocationEntryCell";

@interface BPRegionMonitorViewController ()

@property (nonatomic, strong) NSFetchedResultsController *results;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UIBarButtonItem *addButton;

@end

@implementation BPRegionMonitorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.results = [CDLocationEntry MR_fetchAllSortedBy:CDLocationEntryAttributes.timestamp
                                              ascending:YES
                                          withPredicate:nil
                                                groupBy:nil
                                               delegate:self];
    self.formatter = [[NSDateFormatter alloc] init];;
    self.formatter.dateStyle = NSDateFormatterShortStyle;
    self.formatter.timeStyle = NSDateFormatterShortStyle;

    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTapped:)];
    self.addButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.addButton;

    [self startMonitoringLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {

    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {

    UITableView *tableView = self.tableView;

    switch(type) {

        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;

        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Location Mgmt

- (void)startMonitoringLocation {
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }

    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = 100;

    [self.locationManager startUpdatingLocation];

    self.mapView.showsUserLocation = YES;
}

#pragma mark - Location Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *loc = [locations lastObject];
    NSLog(@"Location update: %@", loc);

    self.addButton.enabled = (loc != nil);

    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    [CDLocationEntry entryWithLocation:loc inContext:context];
    [context MR_saveNestedContexts];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
}

#pragma mark - Target Actions

- (void)addTapped:(id)sender {
    NSLog(@"add tapped");

    CLLocation *loc = self.locationManager.location;
    if (loc == nil) {
        NSLog(@"location not set");
        return;
    }

    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    CDLocationEntry *entry = [CDLocationEntry entryWithLocation:loc inContext:context];
    entry.manualEntryValue = YES;
    [context MR_saveNestedContexts];
}

#pragma mark - UITableViewDatasource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CDLocationEntry *entry = [self.results objectAtIndexPath:indexPath];
    cell.textLabel.text = entry.title;
    cell.detailTextLabel.text = [self.formatter stringFromDate:entry.timestamp];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.results.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.results.sections objectAtIndex:section];
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocationEntryCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kLocationEntryCell];
    }
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mapView removeAnnotations:self.results.fetchedObjects];
    
    CDLocationEntry *entry = [self.results objectAtIndexPath:indexPath];
    [self.mapView addAnnotation:entry];
}

@end
