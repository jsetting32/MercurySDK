//
//  NSManagedObjectContext+Properties.h
//  iMobileRep
//
//  Created by John Setting on 3/15/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext(Properties)
- (BOOL)cascadeSave:(NSError **)error;
- (void)deleteRelatedEntitiesWithPredicate:(NSPredicate *)predicate withEntityName:(NSString *)entityName;
@end
