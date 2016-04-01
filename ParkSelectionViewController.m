//
//  ParkSelectionViewController.m
//  NationalParkFinder
//
//  Created by Sam on 3/25/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
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
    park1.parkName = @"National Park of American Samoa";
    park1.parkLocation = @"American Samoa";
    park1.image = @"National Park of American Samoa";
    park1.websiteLink = @"https://en.wikipedia.org/wiki/National_Park_of_American_Samoa";
    
    NationalPark *park2 = [[NationalPark alloc]init];
    park2.parkName = @"Minute Man National Historic Park";
    park2.parkLocation = @"Lincoln, Massachusetts";
    park2.image = @"Minute Man National Historic Park";
    park2.websiteLink = @"https://en.wikipedia.org/wiki/Minute_Man_National_Historical_Park";
    
    NationalPark *park3 = [[NationalPark alloc]init];
    park3.parkName = @"Virgin Islands National Park";
    park3.parkLocation = @"The US Virgin Islands";
    park3.image = @"Virgin Islands National Park";
    park3.websiteLink = @"https://en.wikipedia.org/wiki/Virgin_Islands_National_Park";
    
    NationalPark *park4 = [[NationalPark alloc]init];
    park4.parkName = @"Yosemite National Park";
    park4.parkLocation = @"Mariposa, California";
    park4.image = @"Yosemite National Park";
    park4.websiteLink = @"https://en.wikipedia.org/wiki/Yosemite_National_Park";

    self.parks = [@[park1, park2, park3, park4] mutableCopy];
    
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
