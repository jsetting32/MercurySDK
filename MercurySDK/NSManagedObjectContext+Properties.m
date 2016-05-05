//
//  NSManagedObjectContext+Properties.m
//  iMobileRep
//
//  Created by John Setting on 3/15/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "NSManagedObjectContext+Properties.h"

@implementation NSManagedObjectContext(Properties)

- (BOOL)cascadeSave:(NSError **)error {
    __block BOOL saveResult = YES;
    if ([self hasChanges]) {
        saveResult = [self save:error];
    }
    if (saveResult && self.parentContext) {
        [self.parentContext performBlockAndWait:^{
            saveResult = [self.parentContext cascadeSave:error];
        }];
    }
    return saveResult;
}

- (void)deleteRelatedEntitiesWithPredicate:(NSPredicate *)predicate withEntityName:(NSString *)entityName
{
    NSManagedObjectContext *context = self;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [context setUndoManager:nil];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    if (!entity) {
        return;
    }
    
    if (predicate) [fetch setPredicate:predicate];
    [fetch setEntity:entity];
    //    [fetch setIncludesPropertyValues:NO];
    [fetch setFetchLimit:500];
    
    NSError *error = nil;
    NSArray *entities = [context executeFetchRequest:fetch error:&error];
    while ([entities count] > 0) {
        @autoreleasepool {
            for (NSManagedObject *item in entities) {
                [context deleteObject:item];
            }
            if (![context cascadeSave:&error]) {
                // Handle error appropriately
            }
        }
        entities = [context executeFetchRequest:fetch error:&error];
    }
}

@end
