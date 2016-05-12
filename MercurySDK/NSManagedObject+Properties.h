//
//  NSManagedObject+Properties.h
//  iMobileRep
//
//  Created by John Setting on 3/21/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject(Properties)
+ (void)deleteRelatedEntitiesWithPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)context;
+ (instancetype)js_softManagedObject:(NSManagedObjectContext *)context;
+ (instancetype)js_hardManagedObject:(NSManagedObjectContext *)context;
- (BOOL)deleteObject:(NSError **)error;
- (BOOL)saveObject:(NSError **)error;
@end
