//
//  DetailsViewController.m
//  NationalParkFinder
//
//  Created by Sam on 3/25/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

#import "DetailsViewController.h"
#import "WebViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *parkNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkLocationLabel;
@property (weak, nonatomic) IBOutlet UITextField *parkNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *parkLocationTextField;
@property (weak, nonatomic) IBOutlet UIImageView *parkImageView;
@property (weak, nonatomic) IBOutlet UIButton *setCurrentParkButton;
@property NSString *parkNameLabelOnViewControllerLoad;

@end

@implementation DetailsViewController

#pragma set initial state of this UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //sets the textfields to hidden, so that they only appear when editing
    self.parkNameTextField.hidden = YES;
    self.parkLocationTextField.hidden = YES;
    
    //sets the titles, labels, and image correctly
    self.title = self.nationalPark.parkName;
    self.parkNameLabel.text = self.nationalPark.parkName;
    self.parkLocationLabel.text = self.nationalPark.parkLocation;
    self.parkImageView.image = [UIImage imageNamed:self.nationalPark.image];
    
    //ensures that we know what the starting value of the park name was, so that if we edit the park name, we can do a conditional check later and ensure the previous view controller can change title accordingly
    self.parkNameLabelOnViewControllerLoad = self.nationalPark.parkName;


}
#pragma selecting park as 'current park'

//sets the title on ParkSelectionViewController if we press the park selection button
- (IBAction)onCurrentParkButtonPressed:(UIButton *)sender{
    [self.delegate setTitleOnParent:self.nationalPark.parkName];
}


#pragma editing park details

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    
    if (self.editing) {
        self.editing = false;
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
        
        //hides the textfields again and updates all the necessary fields
        self.parkNameTextField.hidden = YES;
        self.parkLocationTextField.hidden = YES;
        [self.parkNameTextField resignFirstResponder];
        self.parkNameLabel.text = self.parkNameTextField.text;
        self.parkLocationLabel.text = self.parkLocationTextField.text;
        self.nationalPark.parkName = self.parkNameTextField.text;
        self.nationalPark.parkLocation = self.parkLocationTextField.text;
        self.title = self.nationalPark.parkName;
        
        //re-enables the set park button
        self.setCurrentParkButton.enabled = YES;
        [self.setCurrentParkButton setTitleColor:[UIColor colorWithRed:1.0 green:0.553 blue:0.172 alpha:1] forState:UIControlStateNormal];

        //if the park we just edited is the park we 'made our current park', any changes will update the ParkSelectionViewController's title AND the individual cells. Otherwise only the cells will change
        if (self.currentSetLocation == self.parkNameLabelOnViewControllerLoad) {
            [self.delegate setTitleOnParent:self.nationalPark.parkName];
        }
        
    } else {
        self.editing = true;
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        self.parkNameTextField.text = self.nationalPark.parkName;
        self.parkLocationTextField.text = self.nationalPark.parkLocation;
        [self.parkNameTextField setHidden:NO];
        [self.parkNameTextField becomeFirstResponder];
        [self.parkLocationTextField setHidden:NO];
        
        //this ensures that we can't set the current park until we are done editing, and tells users visually they can't click the button to do so
        self.setCurrentParkButton.enabled = NO;
        [self.setCurrentParkButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];


    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *webVC = segue.destinationViewController;
    webVC.url = self.nationalPark.websiteLink;
    
}

@end
