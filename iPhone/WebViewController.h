//
//  WebViewController.h
//  iContent
//
//  Created by Wilfred Mworia on 4/13/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController {
	IBOutlet UIWebView *webView;
	
	NSURL *url;
}
@property (nonatomic, retain) NSURL *url;
@end
