//
//  FeedItemViewController.h
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
