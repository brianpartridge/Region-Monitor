//
//  BPRegionMonitorViewController.h
//  Region Monitor
//
//  Created by Brian Partridge on 10/3/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPRegionMonitorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
