//
//  realtor.h
//  REImage
//
//  Created by Daniel Bell on 2015-04-06.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class FlickrPhoto;

//typedef void (^FlickrSearchCompletionBlock)(NSString *searchTerm, NSArray *results, NSError *error);
//typedef void (^FlickrPhotoCompletionBlock)(UIImage *photoImage, NSError *error);
typedef void (^MLSretrievalCompletionBlock)(NSString *houseID, NSArray *results, NSError *error);

@interface realtor : NSObject

//- (void)searchFlickrForTerm:(NSString *) term completionBlock:(FlickrSearchCompletionBlock) completionBlock;
//+ (void)loadImageForPhoto:(FlickrPhoto *)flickrPhoto thumbnail:(BOOL)thumbnail completionBlock:(FlickrPhotoCompletionBlock) completionBlock;
//+ (NSString *)flickrPhotoURLForFlickrPhoto:(FlickrPhoto *) flickrPhoto size:(NSString *) size;
- (void)retrieveHome:(NSString *) houseID completionBlock:(MLSretrievalCompletionBlock) completionBlock;

@end
