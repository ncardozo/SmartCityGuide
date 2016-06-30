//
//  Poi_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//

#import "Poi_LANGUAGE.h"

@implementation Poi (Poi_LANGUAGE)


@contexts English
-(NSString*) address{
    NSString *query = [NSString stringWithFormat:@"SELECT address FROM Poi WITH language = %@ AND id_poi = %d", @"en", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

@contexts Dutch
-(NSString*) address{
    NSString *query = [NSString stringWithFormat:@"SELECT address FROM Poi WITH language = %@ AND id_poi = %d", @"nl", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

@contexts French
-(NSString*) address{
    NSString *query = [NSString stringWithFormat:@"SELECT address FROM Poi WITH language = %@ AND id_poi = %d", @"fr", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

@contexts Dutch
-(NSString*) name{
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Poi WITH language = %@ AND id_poi = %d", @"nl", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

@contexts English
-(NSString*) name{
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Poi WITH language = %@ AND id_poi = %d", @"en", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

@contexts French
-(NSString*) name{
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Poi WITH language = %@ AND id_poi = %d", @"fr", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

@end