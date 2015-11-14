//
//  ToolsCategoriesViewController_COLOR.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ToolsCategoriesViewController_COLOR.h"

@implementation ToolsCategoriesViewController (ToolsCategoriesViewController_COLOR)

@contexts ColoredCategories
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CategoryPoi * category = [[[self.appDelegate cacheManager] categoryList] objectAtIndex:indexPath.row];
    NSString * catTitle = [category name];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell... 
    cell.textLabel.text = catTitle;
    cell.textLabel.textColor = category.catColor;
    if([[self.selectedCategories objectAtIndex:indexPath.row] boolValue]) cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}

@end