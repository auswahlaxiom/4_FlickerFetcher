//
//  RecentPlacesTVC.m
//  4_FlickerFetcher
//
//  Created by Zachary Fleischman on 2/28/13.
//  Copyright (c) 2013 Zachary Fleischman. All rights reserved.
//

#import "RecentPlacesTVC.h"
#import "Flickrfetcher.h"

@interface RecentPlacesTVC ()
@property NSArray *picturesData;
@end

@implementation RecentPlacesTVC
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.picturesData = [defaults objectForKey:@"FlickrFetcherRecentPictures"];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.picturesData = [defaults objectForKey:@"FlickrFetcherRecentPictures"];
    [self.tableView reloadData];
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
    static NSString *CellIdentifier = @"Recent Picture Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    NSDictionary *picInfo = [self.picturesData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = @"Unknown";
    if([picInfo objectForKey:@"title"]) cell.textLabel.text = [picInfo objectForKey:@"title"];
    
    cell.detailTextLabel.text = @"Unknown";
    if([picInfo valueForKeyPath:@"description._content"]) cell.detailTextLabel.text = [picInfo valueForKeyPath:@"description._content"];

    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
