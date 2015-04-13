//
//  UserFavsTableTableViewController.m
//  REImage
//
//  Created by Daniel Bell on 2015-04-13.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import "UserFavsTableTableViewController.h"
#import "AppDelegate.h"
#import "Rating.h"
#import "House.h"

@implementation UserFavsTableTableViewController

@synthesize managedObjectContext;


-(void)viewDidLoad{
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Rating" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.myRatings = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.myRatings count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UserFavCell"];
    
    Rating *myrating = self.myRatings[indexPath.row];
    // Set up the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@", myrating.houseID];
    
    return cell;
}

@end
