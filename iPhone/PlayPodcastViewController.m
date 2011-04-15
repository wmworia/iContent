//
//  PlayPodcastViewController.m
//  iContent
//
//  Created by Wilfred Mworia on 4/10/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import "PlayPodcastViewController.h"
#import "AudioStreamer.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>

@implementation PlayPodcastViewController

@synthesize description,source;

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	
	[self destroyStreamer];
}

- (IBAction)buttonPressed:(id)sender{
	if ([playStopButton.currentImage isEqual:[UIImage imageNamed:@"playbutton.png"]])
	{
		[self createStreamer];
		[self setButtonImage:[UIImage imageNamed:@"loadingbar.gif"]];
		[streamer start];
	}
	else
	{
		[streamer stop];
	}
}

//
// destroyStreamer
//
// Removes the streamer, the UI update timer and the change notification
//
- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
		 removeObserver:self
		 name:ASStatusChangedNotification
		 object:streamer];
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
		
		[streamer stop];
		[streamer release];
		streamer = nil;
	}
}

//
// createStreamer
//
// Creates or recreates the AudioStreamer object.
//
- (void)createStreamer
{
	if (streamer)
	{
		return;
	}
	
	[self destroyStreamer];
	
	NSString *escapedValue =
	[(NSString *)CFURLCreateStringByAddingPercentEscapes(
														 nil,
														 (CFStringRef)self.source,
														 NULL,
														 NULL,
														 kCFStringEncodingUTF8)
	 autorelease];
	
	NSURL *url = [NSURL URLWithString:escapedValue];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	
	progressUpdateTimer =
	[NSTimer
	 scheduledTimerWithTimeInterval:0.1
	 target:self
	 selector:@selector(updateProgress:)
	 userInfo:nil
	 repeats:YES];
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(playbackStateChanged:)
	 name:ASStatusChangedNotification
	 object:streamer];
}

//
// setButtonImage:
//
// Used to change the image on the playbutton. This method exists for
// the purpose of inter-thread invocation because
// the observeValueForKeyPath:ofObject:change:context: method is invoked
// from secondary threads and UI updates are only permitted on the main thread.
//
// Parameters:
//    image - the image to set on the play button.
//
- (void)setButtonImage:(UIImage *)image
{
	[playStopButton.layer removeAllAnimations];
	if (!image)
	{
		[playStopButton setImage:[UIImage imageNamed:@"playbutton.png"] forState:0];
	}
	else
	{
		[playStopButton setImage:image forState:0];
		
		if ([playStopButton.currentImage isEqual:[UIImage imageNamed:@"loadingbar.gif"]])
		{
			//[self spinButton];
		}
	}
}

//
// sliderMoved:
//
// Invoked when the user moves the slider
//
// Parameters:
//    aSlider - the slider (assumed to be the progress slider)
//
- (IBAction)sliderMoved:(UISlider *)aSlider
{
	if (streamer.duration)
	{
		double newSeekTime = (aSlider.value / 100.0) * streamer.duration;
		[streamer seekToTime:newSeekTime];
	}
}

//
// playbackStateChanged:
//
// Invoked when the AudioStreamer
// reports that its playback status has changed.
//
- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([streamer isWaiting])
	{
		[self setButtonImage:[UIImage imageNamed:@"loadingbar.gif"]];
	}
	else if ([streamer isPlaying])
	{
		[self setButtonImage:[UIImage imageNamed:@"stopbutton.png"]];
	}
	else if ([streamer isIdle])
	{
		[self destroyStreamer];
		[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
	}
}

//
// updateProgress:
//
// Invoked when the AudioStreamer
// reports that its playback progress has changed.
//
- (void)updateProgress:(NSTimer *)updatedTimer
{
	if (streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		double duration = streamer.duration;
		
		if (duration > 0)
		{
			/*
			[positionLabel setText:
			 [NSString stringWithFormat:@"Time Played: %.1f/%.1f seconds",
			  progress,
			  duration]];
			*/
			[progressSlider setEnabled:YES];
			[progressSlider setValue:100 * progress / duration];
		}
		else
		{
			[progressSlider setEnabled:NO];
		}
	}
	else
	{
		//positionLabel.text = @"Time Played:";
	}
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

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	descriptionView.text = self.description;
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
	[self destroyStreamer];
	if (progressUpdateTimer)
	{
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
	}
	[source release];
	[description release];
    [super dealloc];
}


@end
