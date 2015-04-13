//
//  HousePhotoViewController.m
//  REImage
//
//  Created by Daniel Bell on 2015-04-08.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import "HousePhotoViewController.h"
#import "AppDelegate.h"

@implementation HousePhotoViewController

@synthesize popoverController;
@synthesize imageScrollView;
@synthesize CommenTableView;
@synthesize aHousePicture;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.imageScrollView.delegate = self;
    [self showImage:self.housePictureLocation];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [appDelegate managedObjectContext];

}


- (IBAction)done:(id)sender
{
    [self.delegate HousePhotoViewControllerDidFinish:self];
}


- (void)showImage:(NSString *)image{
    UIImage *houseImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
    self.aHousePicture.image=houseImage;

    self.imageScrollView.contentSize = self.aHousePicture.image.size;
    self.imageScrollView.frame = CGRectMake(0, 0, self.aHousePicture.image.size.width, self.aHousePicture.image.size.height);    

}


- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Comment" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(pictureForComments.location like '%@')", self.housePictureLocation]];
    [fetchRequest setPredicate:requestPredicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    fetchedResultsController.delegate = self;
    
    return fetchedResultsController;
    
}


-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // return which subview we want to zoom
    return self.aHousePicture;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id  sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    FailedBankInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = info.name;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
//                                 info.city, info.state];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.CommenTableView dequeueReusableCellWithIdentifier:@"AHousePicture" forIndexPath:indexPath];
    
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.CommenTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.CommenTableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.CommenTableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.CommenTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.CommenTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.CommenTableView endUpdates];
}
@end
