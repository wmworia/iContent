//
//  AboutViewController.h
//  iContent
//
//  Created by Wilfred Mworia on 4/10/11.
//  Copyright 2011 African Pixel, Afrinnovator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@interface AboutViewController : UIViewController {
	IBOutlet UIButton *linkButton;
}

-(IBAction)openLink:(id)sender;

@end
