//
//  HousePhotoViewController.h
//  REImage
//
//  Created by Daniel Bell on 2015-04-08.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class HousePhotoViewController;

@protocol HousePhotoViewControllerDelegate <NSObject>

-(void)HousePhotoViewControllerDidFinish:(HousePhotoViewController *)controller;

@end


@interface HousePhotoViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, assign) id <HousePhotoViewControllerDelegate> delegate;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UIImageView *aHousePicture;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UITableView *CommenTableView;
@property (nonatomic,retain) UIPopoverPresentationController *popoverController;
@property (weak, nonatomic) NSString *housePictureLocation;
@property (assign, nonatomic) NSUInteger houseID;

- (IBAction)done:(id)sender;
- (void)showImage:(NSString *)image;
@end


