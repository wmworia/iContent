//
//  AppDelegate_iPhone.h
//  iContent
//
//  Created by Wilfred Mworia on 4/8/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "PodcastFeedViewController.h"
#import "VideoFeedViewController.h"
#import "AboutViewController.h"

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	
	//news
	UINavigationController *newsNavigationController;
	FeedViewController *feedViewController;
	
	//podcast
	UINavigationController *podcastNavigationController;
	PodcastFeedViewController *podcastViewController;
	
	//video
	UINavigationController *videoNavigationController;
	VideoFeedViewController *videoViewController;
	
	//about
	UINavigationController *aboutNavigationController;
	AboutViewController *aboutViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

@property (nonatomic, retain) UINavigationController *newsNavigationController;
@property (nonatomic, retain) FeedViewController *feedViewController;

@property (nonatomic, retain) UINavigationController *podcastNavigationController;
@property (nonatomic, retain) PodcastFeedViewController *podcastViewController;

@property (nonatomic, retain) UINavigationController *videoNavigationController;
@property (nonatomic, retain) VideoFeedViewController *videoViewController;

@property (nonatomic, retain) UINavigationController *aboutNavigationController;
@property (nonatomic, retain) AboutViewController *aboutViewController;

@end

