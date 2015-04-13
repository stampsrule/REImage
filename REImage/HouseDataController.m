//
//  HouseDataController.m
//  REImage
//
//  Created by Daniel Bell on 2015-04-09.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import "HouseDataController.h"
#import "AppDelegate.h"

@implementation HouseDataController

@synthesize fetchedResultsController = _fetchedResultsController;



+(void)save:(NSDictionary *)data toLocation:(NSString *)entityName{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *newContact;
    
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:entityName
                  inManagedObjectContext:context];
    for (NSString *key in data) {
        [newContact setValue: [data objectForKey:key] forKey:key];
    }    
    NSError *error;
    [context save:&error];
    
}





//- (IBAction)findContact:(id)sender {
//    CoreDataAppDelegate *appDelegate =
//    [[UIApplication sharedApplication] delegate];
//    
//    NSManagedObjectContext *context =
//    [appDelegate managedObjectContext];
//    
//    NSEntityDescription *entityDesc =
//    [NSEntityDescription entityForName:@"Contacts"
//                inManagedObjectContext:context];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDesc];
//    
//    NSPredicate *pred =
//    [NSPredicate predicateWithFormat:@"(name = %@)",
//     _name.text];
//    [request setPredicate:pred];
//    NSManagedObject *matches = nil;
//    
//    NSError *error;
//    NSArray *objects = [context executeFetchRequest:request
//                                              error:&error];
//    
//    if ([objects count] == 0) {
//        _status.text = @"No matches";
//    } else {
//        matches = objects[0];
//        _address.text = [matches valueForKey:@"address"];
//        _phone.text = [matches valueForKey:@"phone"];
//        _status.text = [NSString stringWithFormat:
//                        @"%lu matches found", (unsigned long)[objects count]];
//    }
//}
@end
