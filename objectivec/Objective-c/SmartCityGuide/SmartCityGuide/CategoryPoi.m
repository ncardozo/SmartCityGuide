//
//  CategoryPoi.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 14/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryPoi.h"

@implementation CategoryPoi
@synthesize nameEn, nameFr, nameNl, idCat, idString, catColor;

- (id)initWithId:(int)anId frName:(NSString*)frName enName:(NSString*)enName nlName:(NSString*)nlName {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.nameFr = frName;
        self.nameEn = enName;
        self.nameNl = nlName;
        self.idCat = anId;
        self.idString = [NSString stringWithFormat:@"%d", anId];
        
        if([self.nameFr compare:GREENCAT]==0){
            self.catColor = [UIColor colorWithRed:0/255.0f green:184/255.0f blue:46/255.0f alpha:1];
        } else if([self.nameFr compare:BLUECAT]==0){
            self.catColor = [UIColor colorWithRed:184/255.0f green:138/255.0f blue:0.0f alpha:1];
        } else if([self.nameFr compare:PINKCAT]==0){
            self.catColor = [UIColor purpleColor];
        } else{
            self.catColor = [UIColor colorWithRed:255/255.0f green:230/255.0f blue:102/255.0f alpha:1];
        }
    }
    
    return self;
}

-(UIColor*)categoryColor{
    return self.catColor;
}


-(NSString*)name{
    return @"Context_definition_error";
}

@end