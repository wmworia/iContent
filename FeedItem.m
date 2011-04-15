//
//  FeedItem.m
//  iContent
//
//  Created by Wilfred Mworia on 4/11/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import "FeedItem.h"


@implementation FeedItem

@synthesize title;
@synthesize description;
@synthesize link;
@synthesize date;
@synthesize enclosure;
@synthesize imageurl;
@synthesize image;

- (id)initWithDictionary:(NSMutableDictionary *)dict{
	if (self = [super init]) {
		self.title = [dict objectForKey:@"title"];
		self.description = [dict objectForKey:@"description"];
		self.link = [dict objectForKey:@"link"];
		self.date = [dict objectForKey:@"date"];
		self.enclosure = [dict objectForKey:@"enclosure"];
		self.image = [dict objectForKey:@"image"];
	}
}

@end
