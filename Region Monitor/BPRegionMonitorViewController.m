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
                                               delegate:nil];
    self.formatter = [[NSDateFormatter alloc] init];;
    self.formatter.dateStyle = NSDateFormatterShortStyle;
    self.formatter.timeStyle = NSDateFormatterShortStyle;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kLocationEntryCell];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.results.fetchedObjects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.results.sections objectAtIndex:section];
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocationEntryCell forIndexPath:indexPath];
    CDLocationEntry *entry = [self.results objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%0.2f - %0.2f", entry.latitudeValue, entry.longitudeValue];
    cell.detailTextLabel.text = [self.formatter stringFromDate:entry.timestamp];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
