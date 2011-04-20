//
//  RssParser.h
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