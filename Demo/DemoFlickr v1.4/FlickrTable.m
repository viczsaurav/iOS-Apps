//
//  FlickrTable.m
//  DemoFlickr
//
//  Created by Ouh Eng Lieh on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlickrTable.h"

@implementation FlickrTable

@synthesize flickrTable;
@synthesize searchString, photoNames, photoURLs, photoSmallURLs;

- (id) init:(NSString *) str {
	self.searchString = str;
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	
	// Construct a Flickr API request.
	// Important! Enter your Flickr API key in FlickrAPIKey.h
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=10&format=json&nojsoncallback=1", @"fe03aaae8c9fc55d02d6b6df7832cf03", searchString];
    NSURL *url = [NSURL URLWithString:urlString];

    // Get the contents of the URL as a string, and parse the JSON into Foundation objects.
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSError *e = nil;
	NSDictionary *results = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&e];
	
	NSLog(@"The json string is %@", jsonString);
    
	self.photoNames = [[NSMutableArray alloc] init];
	self.photoURLs = [[NSMutableArray alloc] init];
	self.photoSmallURLs = [[NSMutableArray alloc] init];
	
    NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    for (NSDictionary *photo in photos) {
        // Get the title for each photo
        NSString *title = [photo objectForKey:@"title"];
        [photoNames addObject:(title.length > 0 ? title : @"Untitled")];

        // Construct the URL for each photo.
        NSString *photoSmallURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        [photoSmallURLs addObject:[NSURL URLWithString:photoSmallURLString]];

        // Construct the URL for each photo.
        NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        [photoURLs addObject:[NSURL URLWithString:photoURLString]];
    }    	
	[flickrTable reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [photoNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    cell.textLabel.text = [photoNames objectAtIndex:indexPath.row];

    NSData *imageData = [NSData dataWithContentsOfURL:[photoSmallURLs objectAtIndex:indexPath.row]];
    cell.imageView.image = [UIImage imageWithData:imageData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
	 // ...
	 // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	NSUInteger row = indexPath.row;

	NSDictionary *info = [NSDictionary dictionaryWithObject:[photoURLs objectAtIndex:row] forKey:@"selected"];	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"loadSelectedImage" object:nil userInfo:info];	
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"loadSelectedImage" object:nil];	
	NSLog(@"posted");
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/





/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
