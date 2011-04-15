//
//  AppDelegate_iPhone.m
//  iContent
//
//  Created by Wilfred Mworia on 4/8/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import "AppDelegate_iPhone.h"

@implementation AppDelegate_iPhone

@synthesize window,tabBarController;
@synthesize feedViewController,newsNavigationController;
@synthesize podcastNavigationController,podcastViewController;
@synthesize videoNavigationController,videoViewController;
@synthesize aboutNavigationController,aboutViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	self.tabBarController = [[UITabBarController alloc] init];
	
	//news nav controller
	self.newsNavigationController = [[UINavigationController alloc] init];
	self.newsNavigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	self.feedViewController = [[FeedViewController alloc] initWithNibName:@"FeedViewController" bundle:[NSBundle mainBundle]];
	
	self.feedViewController.title = @"Recent News";
	
	UITabBarItem *newsTabItem = [[UITabBarItem alloc] initWithTitle:@"News" image:[UIImage imageNamed:@"subscribe.png"] tag:0];
	self.feedViewController.tabBarItem = newsTabItem;
	[newsTabItem release];
	
	[self.newsNavigationController pushViewController:self.feedViewController animated:NO];

	//podcast nav controller
	self.podcastNavigationController = [[UINavigationController alloc] init];
	self.podcastNavigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	self.podcastViewController = [[PodcastFeedViewController alloc] initWithNibName:@"PodcastFeedViewController" bundle:[NSBundle mainBundle]];
	
	self.podcastViewController.title = @"Podcast";
	
	UITabBarItem *podTabItem = [[UITabBarItem alloc] initWithTitle:@"Podcast" image:[UIImage imageNamed:@"ipod.png"] tag:0];
	self.podcastViewController.tabBarItem = podTabItem;
	[podTabItem release];
	
	[self.podcastNavigationController pushViewController:self.podcastViewController animated:NO];
	
	
	//video
	self.videoNavigationController = [[UINavigationController alloc] init];
	self.videoNavigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	self.videoViewController = [[VideoFeedViewController alloc] initWithNibName:@"VideoFeedViewController" bundle:[NSBundle mainBundle]];
	
	self.videoViewController.title = @"Video";
	
	UITabBarItem *videoTabItem = [[UITabBarItem alloc] initWithTitle:@"Video" image:[UIImage imageNamed:@"tv.png"] tag:0];
	self.videoViewController.tabBarItem = videoTabItem;
	[videoTabItem release];
	
	[self.videoNavigationController pushViewController:self.videoViewController animated:NO];
	
	//about
	self.aboutNavigationController = [[UINavigationController alloc] init];
	self.aboutNavigationController.navigationBar.barStyle = UIBarStyleBlack;	
	
	self.aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
	self.aboutViewController.title = @"About iContent";
	
	[self.aboutNavigationController pushViewController:self.aboutViewController animated:NO];
	
	UITabBarItem *aboutTabItem = [[UITabBarItem alloc] initWithTitle:@"About" image:[UIImage imageNamed:@"info.png"] tag:0];
	self.aboutViewController.tabBarItem = aboutTabItem;
	[aboutTabItem release];
	
	NSArray *viewControllers = [NSArray arrayWithObjects:self.newsNavigationController, 
								self.podcastNavigationController, 
								self.videoNavigationController,
								self.aboutNavigationController,
								nil];
	
	self.tabBarController.viewControllers = viewControllers;
	
    //[self.window addSubview:self.loadingView.view];
	[self.window addSubview:self.tabBarController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[aboutNavigationController release];
	[aboutViewController release];
	[videoNavigationController release];
	[videoViewController release];
	[podcastViewController release];
	[podcastNavigationController release];
	[newsNavigationController release];
	[feedViewController release];
	[tabBarController release];
    [window release];
    [super dealloc];
}


@end
