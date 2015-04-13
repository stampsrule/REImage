//
//  Comment.h
//  REImage
//
//  Created by Daniel Bell on 2015-04-13.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class House, Picture;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * houseID;
@property (nonatomic, retain) House *houseForComments;
@property (nonatomic, retain) Picture *pictureForComments;

@end
