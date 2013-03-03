//
//  RecentFromPlacesTVC.m
//  4_FlickerFetcher
//
//  Created by Zachary Fleischman on 3/1/13.
//  Copyright (c) 2013 Zachary Fleischman. All rights reserved.
//

#import "RecentFromPlacesTVC.h"
#import "FlickrFetcher.h"

@interface RecentFromPlacesTVC ()
@property NSArray *picturesData;
@end

@implementation RecentFromPlacesTVC
@synthesize picturesData = _picturesData;
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

    self.picturesData = [FlickrFetcher photosInPlace:self.place maxResults:50];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.picturesData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Top Place Picture Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    NSDictionary *picInfo = [self.picturesData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = @"Unknown";
    if([picInfo objectForKey:@"title"] != @"") cell.textLabel.text = [picInfo objectForKey:@"title"];
    
    cell.detailTextLabel.text = @"Unknown";
    if([picInfo valueForKeyPath:@"description._content"] != @"") cell.detailTextLabel.text = [picInfo valueForKeyPath:@"description._content"];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *selectedPic = [self.picturesData objectAtIndex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recent = [[defaults objectForKey:@"FlickrFetcherRecentPictures"] mutableCopy];
    
    //make sure it isn't already in there
    if(recent) {
        for(NSDictionary *pic in recent) {
            if([pic objectForKey:@"id"] == [selectedPic objectForKey:@"id"]) return;
        }
    }
    
    //create a new recent list with the selected one on top
    NSMutableArray *newRecent = [[NSMutableArray alloc] initWithObjects:selectedPic, nil];
    if(recent) {
        [newRecent addObjectsFromArray:recent];
    }
    
    //trim to only 20 pictures
    if(newRecent.count > 20) {
        [newRecent removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(20, (newRecent.count-20))]];
    }
    
    [defaults setObject:[newRecent copy] forKey:@"FlickrFetcherRecentPictures"];
}

@end
