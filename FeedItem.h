//
//  FeedItem.h
//  iContent
//
//  Created by Wilfred Mworia on 4/11/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedItem : NSObject {
	NSString *title;
	NSString *description;
	NSString *link;
	NSString *date;
	NSString *enclosure;
	NSString *imageurl;	
	UIImage *image;
}

@property (copy) NSString *title;
@property (copy) NSString *description;
@property (copy) NSString *link;
@property (copy) NSString *date;
@property (copy) NSString *enclosure;
@property (copy) NSString *imageurl;
@property (nonatomic,retain) UIImage *image;

- (id)initWithDictionary:(NSMutableArray *)array;

@end
