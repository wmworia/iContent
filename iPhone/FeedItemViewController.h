//
//  FeedItemViewController.h
//  iContent
//
//  Created by Wilfred Mworia on 4/9/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@interface FeedItemViewController : UIViewController {
	IBOutlet UIWebView *webView;
	IBOutlet UIButton *openWebView;
	IBOutlet UIButton *openSafari;
	IBOutlet UITextView *titleTextView;
	IBOutlet UITextView *display;
	
	NSMutableDictionary *item;
}

@property (nonatomic, retain) NSMutableDictionary *item;

- (IBAction)openWebView;
- (IBAction)openSafari;
-(NSURL *)makeURL;

@end
