//
//  SharedPreferenceTableViewController.m
//  REImage
//
//  Created by Daniel Bell on 2015-04-13.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import "SharedPreferenceTableViewController.h"
#import "AppDelegate.h"
#import "SharedPrefCell.h"
#import "Rating.h"
#import "Partners_Ratings.h"
#import "House.h"

@implementation SharedPreferenceTableViewController
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

    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity2 = [NSEntityDescription
                                   entityForName:@"Rating" inManagedObjectContext:managedObjectContext];
    [fetchRequest2 setEntity:entity2];
    NSError *error2;
    self.partnerRatings = [managedObjectContext executeFetchRequest:fetchRequest2 error:&error2];

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSManagedObject *info in self.partnerRatings) {
        if ([[info valueForKey:@"rating"] integerValue]>2) {
            [tempArray addObject:[info valueForKey:@"houseID"]];
        }
    }
    
    NSMutableArray *tempArray2 = [[NSMutableArray alloc] init];
    for (int i =0; i<self.myRatings.count; i++) {
        Rating *info = self.myRatings[i];
        if ([tempArray indexOfObject:info.houseID] != NSNotFound) {
            [tempArray2 addObject:info.houseID];
        }
    }
    
    self.myRatings = [NSArray arrayWithArray:tempArray2];
    
    
}
    //NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(rating > 3)"]];
    //[fetchRequest setPredicate:requestPredicate];
    
    //NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"houseID" ascending:NO];


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.myRatings count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SharedPrefCell"];
    
    // Set up the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.myRatings[indexPath.row]];
    
    return cell;
}

@end

