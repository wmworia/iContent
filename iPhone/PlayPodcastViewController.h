//
//  PlayPodcastViewController.h
//  iContent
//
//  Created by Wilfred Mworia on 4/10/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AudioStreamer;

@interface PlayPodcastViewController : UIViewController {
	IBOutlet UITextView *descriptionView;
	IBOutlet UISlider *progressSlider;
	IBOutlet UIButton *playStopButton;
	
	NSString *description;
	
	AudioStreamer *streamer;
	NSString *source;
	
	NSTimer *progressUpdateTimer;
	
}

@property (copy) NSString *description;
@property (copy) NSString *source;

- (IBAction)buttonPressed:(id)sender;
- (void)createStreamer;
- (IBAction)sliderMoved:(UISlider *)aSlider;
- (void)updateProgress:(NSTimer *)aNotification;
- (void)setButtonImage:(UIImage *)image;
- (void)destroyStreamer;

@end
