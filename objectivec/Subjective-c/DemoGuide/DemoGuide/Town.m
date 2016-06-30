//
//  Town.m
//  MiniGuide
//
//  Created by Guillaume Kaisin on 23/10/11.
//

#import "Town.h"

@implementation Town
@synthesize townId, name, pois;

- (id)initWithId:(int)anId name:(NSString*)aName pois:(NSMutableArray*)aPoiArray {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.townId = anId;
        self.name = aName;
        self.pois = aPoiArray;
    }
    
    return self;
}

@end