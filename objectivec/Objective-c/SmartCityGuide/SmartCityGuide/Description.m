//
//  Description.m
//  MiniGuide
//
//  Created by Nicolas Cardozo on 17/11/15.
//

#import "Description.h"

@implementation DescriptionEN
- (NSString *) description {
    NSString *query = [NSString stringWithFormat:@"SELECT text FROM Description WITH language = %@ AND id_poi = %d", @"en", [self poidId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end

@implementation DescriptionFR
- (NSString *) description {
    NSString *query = [NSString stringWithFormat:@"SELECT text FROM Description WITH language = %@ AND id_poi = %d", @"fr", [self poidId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end


@implementation DescriptionNL
- (NSString *) description {
    NSString *query = [NSString stringWithFormat:@"SELECT text FROM Description WITH language = %@ AND id_poi = %d", @"nl", [self poidId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end


@implementation Description
@synthesize descText, poidId, descId;

-(id)initWithText:(NSString *) aDico ident:(int)anIdent poiId:(int) anId {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.descText = aDico;
        self.descId = anIdent;
        self.poidId = anId;
        [Description setStrategy: [[NSClassFromString([NSString stringWithFormat:@"Description%@", @"EN"]) alloc] init]];
    }
    
    return self;
}

-(NSString*) description{
    return @"Error, no language selected to retrieve the description";
}

+ (void) setStrategy:(id)_strategy {
    self.strategy = _strategy;
}
@end