//
//  POIViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//


#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"
#import "DescViewController.h"
#import "CategoryPoi.h"
#import "Poi.h"
#import "Description.h"

#define IMAGE_TAG 3
#define TITLE_TAG 4
#define SUBTITLE_TAG 5
#define CLOSED_TAG 6
#define ITI_TAG 7

@interface POIViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    DemoGuideAppDelegate * appDelegate;
    UITableViewCell * poiCell;
    DescViewController * descView;
    NSMutableDictionary * categoryPoiDict;
    
    IBOutlet UISegmentedControl *segmentedControl;
    NSArray * poiSortList;
    IBOutlet UITableView *tableView;
    
    //KID instance variables
    UITableViewCell * poiCell_KID;
    
    UITableViewCell * poiCell_CATEGORY;
    
    UISegmentedControl *modifyPoiOrder;
    
    NSDictionary * normalSortList;
    NSDictionary * itiSortList;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *poiCell;
@property (retain, nonatomic) DemoGuideAppDelegate * appDelegate;
@property (retain, nonatomic) DescViewController * descView;
@property (retain, nonatomic) NSMutableDictionary * categoryPoiDict;

@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (retain, nonatomic) NSArray * poiSortList;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

//KID properties
@property (nonatomic, retain) IBOutlet UITableViewCell *poiCell_KID;

@property (nonatomic, retain) IBOutlet UITableViewCell *poiCell_CATEGORY;

@property (nonatomic, retain) NSDictionary * normalSortList;
@property (nonatomic, retain) NSDictionary * itiSortList;

- (IBAction)modifyPoiOrder:(id)sender;
-(void)setUpCell:(UITableViewCell*)cell ForPoi:(Poi *)p;
- (void) resetPoiSortTab;

@end