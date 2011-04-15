//
//  RssParser.h
//  iContent
//
//  Created by Wilfred Mworia on 4/8/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@protocol RssParserDelegate;

@interface RssParser : NSObject <NSXMLParserDelegate> {
	id <RssParserDelegate> delegate;
	
	NSXMLParser *xmlParser;
	
	NSString *currentElement;
	NSString *headElement;
	
	BOOL useFeedTitle;
	NSString *defaultTitle;
	NSMutableString *feedTitle;
	NSMutableString *feedDescription;
	//NSMutableString *feedImageURL;
	
	NSMutableDictionary *item;
	
	NSMutableString *itemTitle;
	NSMutableString *itemDescription;
	NSMutableString *itemLink;
	NSMutableString *itemDate;
	NSString *itemEnclosure;
	NSMutableString *imageURL;
	
	NSMutableArray *feedItems;
	
	NSMutableDictionary *feedPackage;
	
	int numberOfItems;
	
	//BOOL isImageElement;
}

@property (nonatomic,assign) id <RssParserDelegate> delegate;
@property (copy) NSString *defaultTitle;
@property BOOL useFeedTitle;


- (BOOL)parse:(NSURL *)url;
- (BOOL)parse:(NSURL *)url numberOfItems:(int)number;
- (void)windUp;

@end


@protocol RssParserDelegate <NSObject>

- (void)didFinishParsingFeedSuccessfully:(BOOL)success dictionary:(NSMutableDictionary *)feed;

@end 