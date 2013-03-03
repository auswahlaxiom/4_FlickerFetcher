//
//  TopPlacesTVC.m
//  4_FlickerFetcher
//
//  Created by Zachary Fleischman on 2/28/13.
//  Copyright (c) 2013 Zachary Fleischman. All rights reserved.
//

#import "TopPlacesTVC.h"
#import "FlickrFetcher.h"
#import "RecentFromPlacesTVC.h"

@interface TopPlacesTVC ()
@property NSArray *topData;
@end

@implementation TopPlacesTVC

@synthesize topData = _topData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"_content" ascending:YES];
    self.topData=[[FlickrFetcher topPlaces] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"View Top Place Image"]) {
        RecentFromPlacesTVC *dest = segue.destinationViewController;
        
        //selectedPlace is set when a cell is selected
        NSDictionary *place = [self.topData objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        dest.place = place;
        dest.navigationItem.title = [[[place objectForKey:@"_content"] componentsSeparatedByString:@", "] objectAtIndex:0];
        
    }
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Top Place Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    NSString *place = [[self.topData objectAtIndex:indexPath.row] objectForKey:@"_content"];
    
    NSArray *placeParts = [place componentsSeparatedByString:@", "];
    
    cell.textLabel.text = [placeParts objectAtIndex:0];
    
    cell.detailTextLabel.text = [placeParts objectAtIndex:1];
    
    for(int i = 2; i < placeParts.count; i++) {
        cell.detailTextLabel.text = [cell.detailTextLabel.text stringByAppendingFormat:@", %@", [placeParts objectAtIndex:i]];
    }
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
