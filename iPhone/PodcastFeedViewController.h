//
//  PodcastFeedViewController.h
//  iContent
//
//  Created by Wilfred Mworia on 4/9/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssParser.h"
#import "PlayPodcastViewController.h"
#import "IconDownloader.h"

@interface PodcastFeedViewController : UITableViewController <RssParserDelegate,IconDownloaderDelegate,UIScrollViewDelegate> {
	NSDictionary *podcastFeedURLs;
	NSMutableArray *podcastFeeds;
	
	NSMutableDictionary *imageDownloadsInProgress;
}

@property (nonatomic,retain) NSDictionary *podcastFeedURLs;
@property (nonatomic,retain) NSMutableArray *podcastFeeds;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;


- (void)startIconDownload:(NSMutableDictionary *)feedItem forIndexPath:(NSIndexPath *)indexPath;

@end
