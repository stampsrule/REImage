//
//  AHouseDisplayViewController.m
//  REImage
//
//  Created by Daniel Bell on 2015-04-06.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import "AHouseDisplayViewController.h"
#import "AHousePicture.h"
#import "HousePhotoViewController.h"
#import "HouseDataController.h"
#import "AppDelegate.h"


@implementation AHouseDisplayViewController

@synthesize responseData;
@synthesize navigationItem;
@synthesize ratingButtons;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    houseID = arc4random_uniform(505001) + 15000000;
    self.houseImages = [[NSMutableArray alloc] init];
    [self getData];
    
//    self.houses = [@[] mutableCopy];
//    self.pictureResults = [@{} mutableCopy];
}



- (void) getData{
    NSString *url = [NSString stringWithFormat:@"http://www.realtor.ca/propertyDetails.aspx?PropertyId=%lu", (unsigned long)houseID];
    NSLog(@"the url: %@", url);

    responseData = [NSMutableData new];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!conn) {
        NSLog(@"issue creating connections");
    }
    
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [NSMutableData data];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error = nil;
    NSString* responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(href='http://cdn.realtor.ca/listing/reb)(.*/highres.*)('>)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matches = [regex matchesInString:responseString options:0 range:NSMakeRange(0, responseString.length)];
    
    
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"(id=\"m_property_dtl_address\">)(.*)( &nbsp; .*</span>)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (matches.count == 0) {
        NSLog(@"returned no images");
        houseID = arc4random_uniform(505001) + 15000000;
        [self getData];


    } else if (matches.count>0){
        int count =0;
        
        for (NSTextCheckingResult *entry in matches)
        {
            NSRange matchRange = [entry rangeAtIndex:2];
            NSString *matchString = [responseString substringWithRange:matchRange];
            NSLog(@"Result1 %d: - %@", count++, matchString);
            
            [self.houseImages addObject:[NSString stringWithFormat:@"http://cdn.realtor.ca/listing/reb%@",matchString]];
            NSLog(@"size: %lu", (unsigned long)self.houseImages.count);
            
        }

        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];

        for (int i =0; i == self.houseImages.count; i++) {

            NSManagedObject *newPicture;
            newPicture = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Picture"
                                inManagedObjectContext:context];
            [newPicture setValue: [NSNumber numberWithInteger:houseID] forKey:@"houseID"];
            [newPicture setValue: self.houseImages[i] forKey:@"location"];
            NSError *error2;
            if (![context save:&error2]) {
                NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
            } else {
                NSLog(@"Partner Rating saved");
            }
        }
        
        NSFetchRequest *fetchRequest3 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity3 = [NSEntityDescription
                                        entityForName:@"Picture" inManagedObjectContext:context];
        [fetchRequest3 setEntity:entity3];
        NSError *error3;
        NSArray *myPictures = [context executeFetchRequest:fetchRequest3 error:&error3];
        
        for (NSManagedObject *info in myPictures) {
            NSLog(@"House: %@ picture: %@", [info valueForKey:@"houseID"], [info valueForKey:@"location"]);
        }
        
        count =0;

        NSTextCheckingResult *match = [regex2 firstMatchInString:responseString
                                                        options:0
                                                          range:NSMakeRange(0, [responseString length])];
        if (match) {
            NSRange secondHalfRange = [match rangeAtIndex:2];
            NSString *secondMatchString = [responseString substringWithRange:secondHalfRange];
            self.navigationItem.title = secondMatchString;
        }
        
        
        
        
        [self.collectionView reloadData];
        ratingButtons.hidden = NO;

    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"something very bad happened here");
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"items: %lu", (unsigned long)self.houseImages.count);
    return self.houseImages.count;
}

// The cell that is returned must be retrieved from a call to - dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AHousePicture *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AHousePicture" forIndexPath:indexPath];
    UIImage *houseImage = [[UIImage alloc] init];
    houseImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.houseImages objectAtIndex:indexPath.row]]]];
    cell.imageView.image = houseImage;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowPicture" sender:self];
    //deletes the image
//    long row = [indexPath row];
//    [self.houseImages removeObjectAtIndex:row];
//    NSArray *deletions = @[indexPath];
//    [self.collectionView deleteItemsAtIndexPaths:deletions];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPicture"]) {
        
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        UINavigationController *navigationController = segue.destinationViewController;
        HousePhotoViewController *housePhotoViewController = [navigationController viewControllers][0];
        housePhotoViewController.delegate=self;
        housePhotoViewController.housePictureLocation = [self.houseImages objectAtIndex:selectedIndexPath.row];
        housePhotoViewController.houseID=houseID;
        
    }
}

- (IBAction)reloadScreen:(UIBarButtonItem *)sender {
    [self.houseImages removeAllObjects];
    houseID = arc4random_uniform(505001) + 15000000;
    [self getData];
    ratingButtons.selectedSegmentIndex=0;
}






- (IBAction)ratingButtons:(UISegmentedControl *)sender {
    NSLog(@"%ld",(long)((UISegmentedControl *)sender).selectedSegmentIndex);
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newRating;
    newRating = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Rating"
                  inManagedObjectContext:context];
    [newRating setValue: [NSNumber numberWithInteger:houseID] forKey:@"houseID"];
    [newRating setValue: [NSNumber numberWithInteger:((UISegmentedControl *)sender).selectedSegmentIndex] forKey:@"rating"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
        NSLog(@"Rating saved");
    }
    
    
    NSManagedObject *newPartnerRating;
    newPartnerRating = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Partners_Ratings"
                 inManagedObjectContext:context];
    [newPartnerRating setValue: [NSNumber numberWithInteger:houseID] forKey:@"houseID"];
    NSNumber *aRating = [NSNumber numberWithInteger:arc4random_uniform(4)];
    NSLog(@"%@", aRating);
    [newPartnerRating setValue: aRating forKey:@"rating"];
    NSError *error2;
    if (![context save:&error2]) {
        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
    } else {
        NSLog(@"Partner Rating saved");
    }
    ratingButtons.hidden = YES;
}

-(void)HousePhotoViewControllerDidFinish:(HousePhotoViewController *)controller{
    NSLog(@"did dismiss");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
