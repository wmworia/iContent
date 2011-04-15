//
//  RssParser.m
//  iContent
//
//  Created by Wilfred Mworia on 4/8/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import "RssParser.h"


@implementation RssParser

@synthesize delegate,defaultTitle,useFeedTitle;

- (id)init{
	if(self = [super init]){
		/*CUSTOMIZATION POINT*/
		numberOfItems = 5; //0 means all items in feed
		useFeedTitle = YES;
	}
	
	return self;
}

- (BOOL)parse:(NSURL *)url{
	feedItems = [[NSMutableArray alloc] init];
	
	xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	[xmlParser setDelegate:self];
	[xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
	
	BOOL success = [xmlParser parse];
	
	return success;
}

- (BOOL)parse:(NSURL *)url numberOfItems:(int)number{
	numberOfItems = number;
	
	feedItems = [[NSMutableArray alloc] init];
	
	xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	[xmlParser setDelegate:self];
	[xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
	
	BOOL success = [xmlParser parse];
	
	return success;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	if ([parseError code] == 512) {
		return;
		
	}
	NSString * errorString = [NSString stringWithFormat:@"Web download error (Error code %i )", [parseError code]];
	NSLog(@"Error: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	//[errorAlert release];
	
	//[[self delegate] didFinishParsingFeedSuccessfully:NO dictionary:nil];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
    
	currentElement = [elementName copy];
	
	if ([elementName isEqualToString:@"enclosure"]) {
		itemEnclosure = [attributeDict objectForKey:@"url"];
	}
	
	if ([elementName isEqualToString:@"channel"]) {
		headElement = @"channel";
		feedTitle = [[NSMutableString alloc] init];
		feedDescription = [[NSMutableString alloc] init];
	}

	
	if ([elementName isEqualToString:@"item"]) {
		headElement = @"item";
		
		item = [[NSMutableDictionary alloc] init];
		itemTitle = [[NSMutableString alloc] init];
		itemDate = [[NSMutableString alloc] init];
		itemDescription = [[NSMutableString alloc] init];
		itemLink = [[NSMutableString alloc] init];
		
	}
	
	if ([elementName isEqualToString:@"image"]) {
		headElement = @"image";
		
		imageURL = [[NSMutableString alloc] init];
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	
	if ([elementName isEqualToString:@"item"]) {
		[item setObject:itemTitle forKey:@"title"];
		[item setObject:itemLink forKey:@"link"];
		[item setObject:itemDescription forKey:@"description"];
		[item setObject:itemDate forKey:@"date"];
		
		
		if (itemEnclosure != nil) {
			[item setObject:itemEnclosure forKey:@"enclosure"];
		}else {
			[item setObject:@"" forKey:@"enclosure"];
		}
		
		if(imageURL != nil){
			[item setObject:imageURL forKey:@"imageurl"];
		}else {
			[item setObject:@"" forKey:@"imageurl"];
		}

		//[item setObject:@"" forKey:@"image"];
		
		
		[feedItems addObject:[item copy]];
		
		if(numberOfItems > 0 && [feedItems count] == numberOfItems){
			[self windUp];
			
			//stop
			[xmlParser abortParsing];
		}

	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

	
	//headElement
	if([headElement isEqualToString:@"image"]) {
		if ([currentElement isEqualToString:@"url"]) {
			[imageURL appendString:string];
		}
	}
	
	if([headElement isEqualToString:@"channel"]) {
		if ([currentElement isEqualToString:@"title"]) {
			NSString *trimmedString = [string stringByTrimmingCharactersInSet:
									   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
			[feedTitle appendString:trimmedString];
		} else if ([currentElement isEqualToString:@"description"]) {
			[feedDescription appendString:string];
		}	
	}
	
	if([headElement isEqualToString:@"item"]) {
		
		if ([currentElement isEqualToString:@"title"]) {
			NSString *trimmedString = [string stringByTrimmingCharactersInSet:
									   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
			[itemTitle appendString:trimmedString];
		} else if ([currentElement isEqualToString:@"link"]) {
			[itemLink appendString:string];
		} else if ([currentElement isEqualToString:@"description"]) {
			[itemDescription appendString:string];
		} else if ([currentElement isEqualToString:@"pubDate"]) {
			[itemDate appendString:string];
		} else if ([currentElement isEqualToString:@"pubDate"]) {
			[itemDate appendString:string];
		}
	}
	

	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[self windUp];
}

- (void)windUp{
	feedPackage = [[NSMutableDictionary alloc] init];
	
	if(!useFeedTitle)
		[feedTitle setString:defaultTitle];
	
	[feedPackage setObject:feedTitle forKey:@"title"];
	[feedPackage setObject:feedDescription forKey:@"description"];
	[feedPackage setObject:feedItems forKey:@"items"];
	
	[[self delegate] didFinishParsingFeedSuccessfully:YES dictionary:feedPackage];
}

- (void)dealloc{
	[defaultTitle release];
	[delegate release];
	[super dealloc];
}

@end
