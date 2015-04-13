//
//  House.h
//  REImage
//
//  Created by Daniel Bell on 2015-04-13.
//  Copyright (c) 2015 BellTechMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Picture;

@interface House : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * houseID;
@property (nonatomic, retain) NSOrderedSet *commentsForHouse;
@property (nonatomic, retain) NSManagedObject *localUserRating;
@property (nonatomic, retain) NSSet *picturesOfHouse;
@property (nonatomic, retain) NSManagedObject *remoteUserRating;
@end

@interface House (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inCommentsForHouseAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentsForHouseAtIndex:(NSUInteger)idx;
- (void)insertCommentsForHouse:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentsForHouseAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentsForHouseAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceCommentsForHouseAtIndexes:(NSIndexSet *)indexes withCommentsForHouse:(NSArray *)values;
- (void)addCommentsForHouseObject:(NSManagedObject *)value;
- (void)removeCommentsForHouseObject:(NSManagedObject *)value;
- (void)addCommentsForHouse:(NSOrderedSet *)values;
- (void)removeCommentsForHouse:(NSOrderedSet *)values;
- (void)addPicturesOfHouseObject:(Picture *)value;
- (void)removePicturesOfHouseObject:(Picture *)value;
- (void)addPicturesOfHouse:(NSSet *)values;
- (void)removePicturesOfHouse:(NSSet *)values;

@end
