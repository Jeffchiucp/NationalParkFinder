//
//  DetailsViewController.h
//  NationalParkFinder
//
//  Created by Jeff on 6/25/16.
//  Copyright © 2016 Jeff Chiu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NationalPark.h"

@protocol DetailsViewControllerDelegate
- (void) setTitleOnParent: (NSString *)title;
@end

@interface DetailsViewController : UIViewController

@property id <DetailsViewControllerDelegate> delegate;

@property NSString *currentSetLocation;
@property NationalPark *nationalPark;
@end
