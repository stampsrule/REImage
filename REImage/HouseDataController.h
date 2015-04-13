//
//  HouseDataController.h
//  REImage
//
//  Created by Daniel Bell on 2015-04-09.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HouseDataController : NSObject

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

+(void)save:(NSDictionary *)data toLocation:(NSString *)entityName;
@end
