//
//  POIViewController.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 15/12/15.
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

@interface BasePOIViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    DemoGuideAppDelegate * appDelegate;
    UITableViewCell * poiCell;    
}

@property (nonatomic, retain) IBOutlet UITableViewCell *poiCell;
@property (retain, nonatomic) DemoGuideAppDelegate * appDelegate;
@property (retain, nonatomic) DescViewController * descView;
@property (retain, nonatomic) NSMutableDictionary * categoryPoiDict;


@property (nonatomic, retain) NSDictionary * normalSortList;
@property (nonatomic, retain) NSDictionary * itiSortList;

-(void)setUpCell:(UITableViewCell*)cell ForPoi:(Poi *)p;
@end

@interface POIViewControllerKid : BasePOIViewController {
    //KID instance variables
    UITableViewCell * poiCell_KID;

}

@property (nonatomic, retain) IBOutlet UITableViewCell *poiCell_KID;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)index;
@end

@interface POIViewControllerTime : BasePOIViewController
- (void)setUpCell:(UITableViewCell*)cell ForPoi:(Poi *) p;
@end

@interface POIViewControllerGuidedTour : BasePOIViewController
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface POIViewControllerCategory : BasePOIViewController {
    UITableViewCell * poiCell_CATEGORY;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *poiCell_CATEGORY;

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface POIViewControllerGuidedTourEN : BasePOIViewController
-(NSArray *) poiSortList;
@end

@interface POIViewControllerGuidedTourNL : BasePOIViewController
-(NSArray *) poiSortList;
@end

@interface POIViewControllerGuidedTourFR : BasePOIViewController
-(NSArray *) poiSortList;
@end

@interface POIViewControllerEN : BasePOIViewController
-(NSArray *) poiSortList;
@end

@interface POIViewControllerNL : BasePOIViewController
-(NSArray *) poiSortList;
@end

@interface POIViewControllerFR : BasePOIViewController
-(NSArray *) poiSortList;
@end

@interface POIViewControllerSimple : BasePOIViewController
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)index;
@end

@interface POIViewController : BasePOIViewController {
    NSMutableDictionary * categoryPoiDict;
    
    IBOutlet UISegmentedControl *segmentedControl;
    NSArray * poiSortList;
    IBOutlet UITableView *tableView;
    
    UISegmentedControl *modifyPoiOrder;
    
    NSDictionary * normalSortList;
    NSDictionary * itiSortList;
    
    id strategy;
}

@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (retain, nonatomic) NSArray * poiSortList;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)modifyPoiOrder:(id)sender;
- (void)setUpCell:(UITableViewCell*)cell ForPoi:(Poi *)p;
- (void) resetPoiSortTab;
+ (void) setStrategy: (id) _strategy;
+ (id) getStrategy;

@end