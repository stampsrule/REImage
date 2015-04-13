//
//  UserFavsTableTableViewController.h
//  REImage
//
//  Created by Daniel Bell on 2015-04-13.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserFavsTableTableViewController : UITableViewController<UITableViewDelegate>

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *myRatings;


@end
