//
//  AppDelegate_iPhone.h
//  iContent
//
//  Created by Wilfred Mworia on 4/8/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
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

