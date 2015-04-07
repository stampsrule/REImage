//
//  AHouseDisplayViewController.m
//  REImage
//
//  Created by Daniel Bell on 2015-04-06.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import "AHouseDisplayViewController.h"
#import "AHousePicture.h"
#import "housePhoto.h"
#import "realtor.h"

@implementation AHouseDisplayViewController

@synthesize responseData;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUInteger houseID = arc4random_uniform(505001) + 15000000;
    
    NSString *aHousePage = [NSString stringWithFormat:@"http://www.realtor.ca/propertyDetails.aspx?PropertyId=%lu", (unsigned long)houseID];
    NSLog(@"the url: %@", aHousePage);
    [self getDataFrom:aHousePage];
    
    self.houses = [@[] mutableCopy];
    self.pictureResults = [@{} mutableCopy];
    self.Realtor = [[realtor alloc] init];
    self.houseImages = [[NSMutableArray alloc] init];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AHousePicture"];
}

- (void) getDataFrom:(NSString *)url{
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
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(href='http://cdn.realtor.ca/listing/reb.*/highres)(.*)('>)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matches = [regex matchesInString:responseString options:0 range:NSMakeRange(0, responseString.length)];
    
    NSLog(@"results: %@", matches);
    
    int count =0;
    
    for (NSTextCheckingResult *entry in matches)
    {
        NSRange matchRange = [entry rangeAtIndex:2];
        NSString *matchString = [responseString substringWithRange:matchRange];
        NSLog(@"Result1 %d: - %@", count++, matchString);
        
        [self.houseImages addObject:[NSString stringWithFormat:@"http://cdn.realtor.ca/listing/reb9/highres%@",matchString]];
        NSLog(@"size: %lu", (unsigned long)self.houseImages.count);
        
    }
    [self.collectionView reloadData];
    //http://cdn.realtor.ca/listing/reb9/highres/7/c3623407_2.jpg '><img id
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
    //cell.imageView.image = [UIImage imageNamed:self.truckImages[0]];
    UIImage *houseImage = [[UIImage alloc] init];
    //houseImage = [UIImage imageNamed:[self.houseImages objectAtIndex:indexPath.row]];
    //cell.imageView.image = houseImage;
    cell.backgroundColor = [UIColor whiteColor];
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
#pragma mark – UICollectionViewDelegateFlowLayout

// 1
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
//    self.searchResults[searchTerm][indexPath.row];
//    // 2
//    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
//    retval.height += 35; retval.width += 35; return retval;
//}
//
//// 3
//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(50, 20, 50, 20);
//}
@end
