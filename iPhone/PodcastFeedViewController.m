//
//  PodcastFeedViewController.m
//  iContent
//
//  Created by Wilfred Mworia on 4/9/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import "PodcastFeedViewController.h"

#define kCustomRowHeight    60.0
#define kNumberOfItemsToParse    5

@implementation PodcastFeedViewController

@synthesize podcastFeedURLs,podcastFeeds,imageDownloadsInProgress;

#pragma mark -
#pragma mark RssParserDelegate

- (void)didFinishParsingFeedSuccessfully:(BOOL)success dictionary:(NSMutableDictionary *)feed{
	if (success) {
		[self.podcastFeeds addObject:feed];
	}
}


#pragma mark -
#pragma mark View lifecycle

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	

}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.tableView.rowHeight = kCustomRowHeight;
	
	self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
	
	self.podcastFeeds = [[NSMutableArray alloc] init];
	
	self.podcastFeedURLs = [[NSDictionary alloc] initWithObjectsAndKeys: 
				  @"http://www.rfu.com/rss/RFUPodcasts",@"England RFU Podcast",
							@"http://www.rbs6nations.com/tools/podcasts/sixnations/RBS-6Nations-Radio.xml",@"RBS 6 Nations Podcast",
				  nil]; //Add more feed URLs as needed
	
	id key;
	
	NSEnumerator *e = [self.podcastFeedURLs keyEnumerator];
	
	while (key = [e nextObject]) {
		NSString *url = [self.podcastFeedURLs objectForKey:key];
		NSURL *feedURL = [NSURL URLWithString:url];
		
		RssParser *rssParser = [[RssParser alloc] init];
		rssParser.delegate = self;
		rssParser.useFeedTitle = NO;
		rssParser.defaultTitle = (NSString *)key;
		
		if([rssParser parse:feedURL numberOfItems:kNumberOfItemsToParse]){
			
		}
		
		[rssParser release];
	}

}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.podcastFeeds count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSMutableDictionary *feed = [self.podcastFeeds objectAtIndex:section];
	NSMutableArray *items = [feed objectForKey:@"items"];
	return [items count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	/*CUSTOMIZATION POINT*/
	NSMutableDictionary *feed = [self.podcastFeeds objectAtIndex:section];
	
	NSMutableString *sectionTitle = [NSString stringWithFormat:@"%@",[feed objectForKey:@"title"]];
	
	return sectionTitle;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"PodcastCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	NSMutableDictionary *feed = [self.podcastFeeds objectAtIndex:indexPath.section];
	NSMutableArray *items = [feed objectForKey:@"items"];
	NSMutableDictionary *item = [items objectAtIndex:indexPath.row];
	
	NSString *feedTitle = [NSString stringWithFormat:@"%@",[item objectForKey:@"title"]];
	cell.textLabel.text = feedTitle;
	
	NSString *description = [NSString stringWithFormat:@"%@",[item objectForKey:@"description"]];
	if ([description isEqualToString:@""]) {
		description = [NSString stringWithFormat:@"%@", [feed objectForKey:@"title"]];										
	}
	
	UIImage *image = [item objectForKey:@"image"];
	
	// Only load cached images; defer new downloads until scrolling ends
	if (!image)
	{
		if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
		{
			[self startIconDownload:item forIndexPath:indexPath];
		}
		// if a download is deferred or in progress, return a placeholder image
		//[item setObject:@"image" forKey:@"image"
		cell.imageView.image = [UIImage imageNamed:@"podcast.png"];                
	}
	else
	{
		cell.imageView.image = image;
	}
 
	
    return cell;
	
}

#pragma mark -
#pragma mark Table cell image support

- (void)startIconDownload:(NSMutableDictionary *)feedItem forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.feedItem = feedItem;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];   
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.podcastFeeds count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
			
			NSMutableDictionary *feed = [self.podcastFeeds objectAtIndex:indexPath.section];
			NSMutableArray *items = [feed objectForKey:@"items"];
			NSMutableDictionary *item = [items objectAtIndex:indexPath.row];
			/*
			 UIImage *image = [item objectForKey:@"image"];
			 */
            
			IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
			if (iconDownloader != nil) {
				UIImage *image = iconDownloader.icon;
				
	            if (!image) // avoid the app icon download if the app already has an icon
				{
					[self startIconDownload:item forIndexPath:indexPath];
				}
				else
				{
					
					UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
					cell.imageView.image = image;
				}			
			}
			else {
				[self startIconDownload:item forIndexPath:indexPath];
			}
			
			
        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath image:(UIImage *)image
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        
        // Display the newly loaded image
        cell.imageView.image = iconDownloader.icon;//[iconDownloader.feedItem objectForKey:@"image"];
		
		/*NSMutableDictionary *feed = [self.podcastFeeds objectAtIndex:indexPath.section];
		NSMutableArray *items = [feed objectForKey:@"items"];
		NSMutableDictionary *item = [items objectAtIndex:indexPath.row];
		
		if(![item objectForKey:@"image"]){
			[item setObject:iconDownloader.icon forKey:@"image"];
		}*/
    }
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
    PlayPodcastViewController *player = [[PlayPodcastViewController alloc] initWithNibName:@"PlayPodcastViewController" bundle:nil];
    
	NSMutableDictionary *feed = [self.podcastFeeds objectAtIndex:indexPath.section];
	NSMutableArray *items = [feed objectForKey:@"items"];
	NSMutableDictionary *item = [items objectAtIndex:indexPath.row];
	
	player.title = [NSString stringWithFormat:@"%@", [item objectForKey:@"title"]];
	player.description = [NSString stringWithFormat:@"%@", [item objectForKey:@"description"]];
	player.source = [NSString stringWithFormat:@"%@", [item objectForKey:@"enclosure"]];
	
    [self.navigationController pushViewController:player animated:YES];
    [player release];
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[imageDownloadsInProgress release];
	[podcastFeeds release];
	[podcastFeedURLs release];
    [super dealloc];
}


@end

