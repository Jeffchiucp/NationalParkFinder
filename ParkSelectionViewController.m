//
//  ParkSelectionViewController.m
//  NationalParkFinder
//
//  Created by Jeff on 6/25/16.
//  Copyright © 2016 Jeff Chiu. All rights reserved.
//

#import "ParkSelectionViewController.h"
#import "DetailsViewController.h"

@interface ParkSelectionViewController () <UITableViewDelegate, UITableViewDataSource, DetailsViewControllerDelegate>
@property NSMutableArray *parks;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIAlertController *deleteConfirmation;

@end

@implementation ParkSelectionViewController



#pragma create intial parks and ensure tableView reloads
- (void)viewDidLoad {
    [super viewDidLoad];

    
    NationalPark *park1 = [[NationalPark alloc]init];
    park1.parkName = @"Yosemite National Park";
    park1.parkLocation = @"Mariposa, California";
    park1.image = @"Yosemite National Park";
    park1.websiteLink = @"https://en.wikipedia.org/wiki/Yosemite_National_Park";

    NationalPark *park2 = [[NationalPark alloc]init];
    park2.parkName = @"Kings Canyon National Park";
    park2.parkLocation = @"Kings Canyon, California";
    park2.image = @"Kings Canyon National Park";
    park2.websiteLink = @"https://en.wikipedia.org/wiki/Yosemite_National_Park";

    NationalPark *park3 = [[NationalPark alloc]init];
    park3.parkName = @"Death Valley National Park";
    park3.parkLocation = @"Death Valley";
    park3.image = @"Death_Valley_National_Park";
    park3.websiteLink = @"https://en.wikipedia.org/wiki/Death_Valley_National_Park";
    

    NationalPark *park4 = [[NationalPark alloc]init];
    park4.parkName = @"National Park of American Samoa";
    park4.parkLocation = @"American Samoa";
    park4.image = @"National Park of American Samoa";
    park4.websiteLink = @"https://en.wikipedia.org/wiki/National_Park_of_American_Samoa";
    
    NationalPark *park5 = [[NationalPark alloc]init];
    park5.parkName = @"Minute Man National Historic Park";
    park5.parkLocation = @"Lincoln, Massachusetts";
    park5.image = @"Minute Man National Historic Park";
    park5.websiteLink = @"https://en.wikipedia.org/wiki/Minute_Man_National_Historical_Park";

    NationalPark *park6 = [[NationalPark alloc]init];
    park6.parkName = @"Sequoia National Park";
    park6.parkLocation = @"Sequoia, California";
    park6.image = @"Sequoia National Park";
    park6.websiteLink = @"https://en.wikipedia.org/wiki/Sequoia_National_Park";
    
    
    NationalPark *park7 = [[NationalPark alloc]init];
    park7.parkName = @"Virgin Islands National Park";
    park7.parkLocation = @"The US Virgin Islands";
    park7.image = @"Virgin Islands National Park";
    park7.websiteLink = @"https://en.wikipedia.org/wiki/Virgin_Islands_National_Park";


    NationalPark *park8 = [[NationalPark alloc]init];
    park8.parkName = @"Yellow Stone National Park";
    park8.parkLocation = @"Yellow Stone, Utah";
    park8.image = @"Yellow_Stone_National_Park";
    park8.websiteLink = @"https://en.wikipedia.org/wiki/Virgin_Islands_National_Park";

    
    self.parks = [@[park1, park2, park3, park4, park6, park5, park7, park8] mutableCopy];
    
}


-(void) setTitleOnParent:(NSString *)title {
    [self setTitle:title];
}


-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

	
#pragma edit and delete list items
- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    
    if (self.editing) {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else{
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.deleteConfirmation = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"You can't undo this" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.parks removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    [self.deleteConfirmation addAction:confirm];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [self.deleteConfirmation addAction:cancel];
    
    [self presentViewController:self.deleteConfirmation animated:true completion:nil];
    
}

#pragma tableView cells
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.parks.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NationalPark *park = [self.parks objectAtIndex:indexPath.row];
    cell.textLabel.text = park.parkName;
    cell.detailTextLabel.text = park.parkLocation;
    cell.imageView.image = [UIImage imageNamed:park.image];
    return cell;
}


#pragma segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *detailsVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NationalPark *park = [self.parks objectAtIndex:indexPath.row];
    
    detailsVC.nationalPark = park;
    detailsVC.delegate = self;
    detailsVC.currentSetLocation = self.title;

    
}

@end
