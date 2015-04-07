//
//  realtor.m
//  REImage
//
//  Created by Daniel Bell on 2015-04-06.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import "realtor.h"
#import "housePhoto.h"

@implementation realtor

- (void)retrieveHome:(NSString *) houseID completionBlock:(MLSretrievalCompletionBlock) completionBlock{
    NSString *searchURL = [NSString stringWithFormat:@"http://www.realtor.ca/propertyDetails.aspx?PropertyId=%lu", (unsigned long)houseID];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        NSError *error = nil;
        NSString *searchResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                                encoding:NSUTF8StringEncoding
                                                                   error:&error];
        if (error != nil) {
            completionBlock(houseID,nil,error);
        }
        else
        {
                    NSMutableArray *flickrPhotos = [@[] mutableCopy];
//                    for(NSMutableDictionary *objPhoto in objPhotos)
//                    {
//                        FlickrPhoto *photo = [[FlickrPhoto alloc] init];
//                        photo.farm = [objPhoto[@"farm"] intValue];
//                        photo.server = [objPhoto[@"server"] intValue];
//                        photo.secret = objPhoto[@"secret"];
//                        photo.photoID = [objPhoto[@"id"] longLongValue];
//
//                        NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:photo size:@"m"];
//                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
//                                                                  options:0
//                                                                    error:&error];
//                        UIImage *image = [UIImage imageWithData:imageData];
//                        photo.thumbnail = image;
//
//                        [flickrPhotos addObject:photo];
//                    }

                    completionBlock(houseID,flickrPhotos,nil);
                }
    
    });
}




//@implementation Flickr
//
//+ (NSString *)flickrSearchURLForSearchTerm:(NSString *) searchTerm
//{
//    searchTerm = [searchTerm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    return [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&format=json&nojsoncallback=1",kFlickrAPIKey,searchTerm];
//}
//
//+ (NSString *)flickrPhotoURLForFlickrPhoto:(FlickrPhoto *) flickrPhoto size:(NSString *) size
//{
//    if(!size)
//    {
//        size = @"m";
//    }
//    return [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%d/%lld_%@_%@.jpg",flickrPhoto.farm,flickrPhoto.server,flickrPhoto.photoID,flickrPhoto.secret,size];
//}
//
//- (void)searchFlickrForTerm:(NSString *) term completionBlock:(FlickrSearchCompletionBlock) completionBlock
//{
//    NSString *searchURL = [Flickr flickrSearchURLForSearchTerm:term];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//    dispatch_async(queue, ^{
//        NSError *error = nil;
//        NSString *searchResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL]
//                                                                encoding:NSUTF8StringEncoding
//                                                                   error:&error];
//        if (error != nil) {
//            completionBlock(term,nil,error);
//        }
//        else
//        {
//            // Parse the JSON Response
//            NSData *jsonData = [searchResultString dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *searchResultsDict = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                              options:kNilOptions
//                                                                                error:&error];
//            if(error != nil)
//            {
//                completionBlock(term,nil,error);
//            }
//            else
//            {
//                NSString * status = searchResultsDict[@"stat"];
//                if ([status isEqualToString:@"fail"]) {
//                    NSError * error = [[NSError alloc] initWithDomain:@"FlickrSearch" code:0 userInfo:@{NSLocalizedFailureReasonErrorKey: searchResultsDict[@"message"]}];
//                    completionBlock(term, nil, error);
//                } else {
//                    
//                    NSArray *objPhotos = searchResultsDict[@"photos"][@"photo"];
//                    NSMutableArray *flickrPhotos = [@[] mutableCopy];
//                    for(NSMutableDictionary *objPhoto in objPhotos)
//                    {
//                        FlickrPhoto *photo = [[FlickrPhoto alloc] init];
//                        photo.farm = [objPhoto[@"farm"] intValue];
//                        photo.server = [objPhoto[@"server"] intValue];
//                        photo.secret = objPhoto[@"secret"];
//                        photo.photoID = [objPhoto[@"id"] longLongValue];
//                        
//                        NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:photo size:@"m"];
//                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
//                                                                  options:0
//                                                                    error:&error];
//                        UIImage *image = [UIImage imageWithData:imageData];
//                        photo.thumbnail = image;
//                        
//                        [flickrPhotos addObject:photo];
//                    }
//                    
//                    completionBlock(term,flickrPhotos,nil);
//                }
//            }
//        }
//    });
//}
//
//+ (void)loadImageForPhoto:(FlickrPhoto *)flickrPhoto thumbnail:(BOOL)thumbnail completionBlock:(FlickrPhotoCompletionBlock) completionBlock
//{
//    
//    NSString *size = thumbnail ? @"m" : @"b";
//    
//    NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:flickrPhoto size:size];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//    dispatch_async(queue, ^{
//        NSError *error = nil;
//        
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
//                                                  options:0
//                                                    error:&error];
//        if(error)
//        {
//            completionBlock(nil,error);
//        }
//        else
//        {
//            UIImage *image = [UIImage imageWithData:imageData];
//            if([size isEqualToString:@"m"])
//            {
//                flickrPhoto.thumbnail = image;
//            }
//            else
//            {
//                flickrPhoto.largeImage = image;
//            }
//            completionBlock(image,nil);
//        }
//        
//    });
//}
//
//
//
//@end

@end
