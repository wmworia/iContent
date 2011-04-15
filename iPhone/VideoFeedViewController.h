//
//  VideoFeedViewController.h
//  iContent
//
//  Created by Wilfred Mworia on 4/10/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssParser.h"
#import "VideoPlayerViewController.h"
#import "IconDownloader.h"

@interface VideoFeedViewController : UITableViewController <RssParserDelegate,IconDownloaderDelegate,UIScrollViewDelegate> {
	NSDictionary *feeds; //Multiple feeds
	NSMutableArray *feedsContent;
	
	NSMutableDictionary *imageDownloadsInProgress;
}

@property (nonatomic,retain) NSDictionary *feeds;
@property (nonatomic,retain) NSMutableArray *feedsContent;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;

- (void)appImageDidLoad:(NSIndexPath *)indexPath image:(UIImage *)image;
- (void)startIconDownload:(NSMutableDictionary *)feedItem forIndexPath:(NSIndexPath *)indexPath;

@end
