//
//  FeedItemViewController.m
//  iContent
//
//  Created by Wilfred Mworia on 4/9/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import "FeedItemViewController.h"


@implementation FeedItemViewController

@synthesize item;

- (IBAction)openWebView{
	WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	
	webViewController.url = [self makeURL];
    [self.navigationController pushViewController:webViewController animated:YES];
	
    [webViewController release];
}

- (IBAction)openSafari{

	[[UIApplication sharedApplication] openURL:[self makeURL]];

}

-(NSURL *)makeURL{
	NSString *link = [item objectForKey:@"link"];
	
	link = [link stringByReplacingOccurrencesOfString:@" " withString:@""];
	link = [link stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	link = [link stringByReplacingOccurrencesOfString:@"	" withString:@""];
	
	NSURL *url = [NSURL URLWithString:link];
	
	return url;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.title = [item objectForKey:@"title"];
	display.text = [item objectForKey:@"description"];
	titleTextView.font = [UIFont boldSystemFontOfSize:14];
	titleTextView.text = [item objectForKey:@"title"];
}



// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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


- (void)dealloc {
	[item release];
    [super dealloc];
}


@end
