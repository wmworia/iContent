//
//  VideoPlayerViewController.h
//  iContent
//
//  Created by Wilfred Mworia on 4/10/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayerViewController : UIViewController {
	NSURL *url;
	IBOutlet UIWebView *playerView;
	
	MPMoviePlayerController* moviePlayer;
}

@property (nonatomic,retain) NSURL *url;

@end
