//
//  VideoPlayerViewController.m
//  iContent
//
//  Created by Wilfred Mworia on 4/10/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import "VideoPlayerViewController.h"


@implementation VideoPlayerViewController

@synthesize url;


-(void) playMovieAtURL: (NSURL*) theURL {
	/*
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL: theURL];
	
    moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
	
    // Register for the playback finished notification
    [[NSNotificationCenter defaultCenter]
	 addObserver: self
	 selector: @selector(movieDidFinish:)
	 name: MPMoviePlayerPlaybackDidFinishNotification
	 object: moviePlayer];
	
	[playerView addSubview:moviePlayer.view];
	moviePlayer.view.frame = playerView.frame;//CGRectMake(50, 50, 200, 200);
	
    // Movie playback is asynchronous, so this method returns immediately.
    [moviePlayer play];
	 */
	
	NSURLRequest *req = [[NSURLRequest alloc] initWithURL:theURL];
	[playerView loadRequest:req];
}
/*
// When the movie is done, release the controller.
-(void) movieDidFinish: (NSNotification*) aNotification
{
    moviePlayer = [aNotification object];
	
    [[NSNotificationCenter defaultCenter]
	 removeObserver: self
	 name: MPMoviePlayerPlaybackDidFinishNotification
	 object: moviePlayer];
	
    // Release the movie instance created in playMovieAtURL:
    [moviePlayer release];
}
*/
// When the movie starts
-(void) movieStarted: (NSNotification*) aNotification{
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"";
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self playMovieAtURL:self.url];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	
	if([moviePlayer retainCount] > 0)
		[moviePlayer release];
}

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
	[url release];
    [super dealloc];
}


@end
