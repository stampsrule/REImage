//
//  AHouseDisplayViewController.m
//  REImage
//
//  Created by Daniel Bell on 2015-04-06.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import "AHouseDisplayViewController.h"
#import "AHousePicture.h"

@implementation AHouseDisplayViewController

@synthesize responseData;
@synthesize navigationItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUInteger houseID = arc4random_uniform(505001) + 15000000;
    [self getDataFrom:[NSString stringWithFormat:@"%lu", houseID]];
    
//    self.houses = [@[] mutableCopy];
//    self.pictureResults = [@{} mutableCopy];
    self.houseImages = [[NSMutableArray alloc] init];
}



- (void) getDataFrom:(NSString *)houseID{
    NSString *url = [NSString stringWithFormat:@"http://www.realtor.ca/propertyDetails.aspx?PropertyId=%@", houseID];
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
    NSLog(@"the html was %@", responseString);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(href='http://cdn.realtor.ca/listing/reb)(.*/highres.*)('>)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matches = [regex matchesInString:responseString options:0 range:NSMakeRange(0, responseString.length)];
    
    NSLog(@"results: %@", matches);
    
    if (matches.count == 0) {
        NSLog(@"returned no images");
        NSUInteger houseID = arc4random_uniform(505001) + 15000000;
        [self getDataFrom:[NSString stringWithFormat:@"%lu", houseID]];


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
        
        [self.collectionView reloadData];
        //http://cdn.realtor.ca/listing/reb9/highres/7/c3623407_2.jpg '><img id
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
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}
- (IBAction)reloadScreen:(UIBarButtonItem *)sender {
    [self.houseImages removeAllObjects];
    NSUInteger houseID = arc4random_uniform(505001) + 15000000;
    [self getDataFrom:[NSString stringWithFormat:@"%lu", houseID]];

}
@end
