//
//  AHouseDisplayViewController.h
//  REImage
//
//  Created by Daniel Bell on 2015-04-06.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HousePhotoViewController.h"

@interface AHouseDisplayViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HousePhotoViewControllerDelegate>{
    NSUInteger houseID;
}

//@property(nonatomic, strong) NSMutableDictionary *pictureResults;
//@property(nonatomic, strong) NSMutableArray *houses;


@property (weak, nonatomic) IBOutlet UISegmentedControl *ratingButtons;
@property (nonatomic, retain) NSMutableData* responseData;
@property (strong, nonatomic) NSMutableArray *houseImages;
@property(nonatomic, weak) IBOutlet UILabel *houseAddress;
@property (weak, nonatomic) IBOutlet UINavigationItem *houseInforNaviagationItem;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionsView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
- (IBAction)reloadScreen:(UIBarButtonItem *)sender;
- (IBAction)ratingButtons:(UISegmentedControl *)sender;

@end
