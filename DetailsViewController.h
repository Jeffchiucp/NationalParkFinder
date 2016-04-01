//
//  DetailsViewController.h
//  NationalParkFinder
//
//  Created by Sam on 3/25/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
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
