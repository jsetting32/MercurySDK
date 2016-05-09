//
//  NSManagedObject+Properties.m
//  iMobileRep
//
//  Created by John Setting on 3/21/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "NSManagedObject+Properties.h"
#import "NSManagedObjectContext+Properties.h"

@implementation NSManagedObject(Properties)

+ (void)deleteRelatedEntitiesWithPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)context;
{
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [context setUndoManager:nil];

    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:context];
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

+ (instancetype)js_softManagedObject:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:context];
    return [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+ (instancetype)js_hardManagedObject:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:context];
}

- (BOOL)deleteObject:(NSError **)error {
    NSManagedObjectContext *context = self.managedObjectContext;
    [context deleteObject:self];
    return [context save:error];
}

@end
