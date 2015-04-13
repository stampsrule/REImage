//
//  Picture.h
//  REImage
//
//  Created by Daniel Bell on 2015-04-13.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Picture : NSManagedObject

@property (nonatomic, retain) NSNumber * houseID;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSManagedObject *aPictureOfHouse;
@property (nonatomic, retain) NSOrderedSet *commentsOfPicture;
@end

@interface Picture (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inCommentsOfPictureAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentsOfPictureAtIndex:(NSUInteger)idx;
- (void)insertCommentsOfPicture:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentsOfPictureAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentsOfPictureAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceCommentsOfPictureAtIndexes:(NSIndexSet *)indexes withCommentsOfPicture:(NSArray *)values;
- (void)addCommentsOfPictureObject:(NSManagedObject *)value;
- (void)removeCommentsOfPictureObject:(NSManagedObject *)value;
- (void)addCommentsOfPicture:(NSOrderedSet *)values;
- (void)removeCommentsOfPicture:(NSOrderedSet *)values;
@end
