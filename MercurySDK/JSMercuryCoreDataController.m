//
//  JSMercuryCoreDataController.m
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCoreDataController.h"
#import "NSManagedObject+Properties.h"

@interface JSMercuryCoreDataController()
@property (strong, nonatomic) NSManagedObjectContext *masterManagedObjectContext;
@property (strong, nonatomic) NSManagedObjectContext *backgroundManagedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation JSMercuryCoreDataController
@synthesize masterManagedObjectContext = _masterManagedObjectContext;
@synthesize backgroundManagedObjectContext = _backgroundManagedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (instancetype)sharedInstance {
    static JSMercuryCoreDataController *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Core Data stack

// Used to propegate saves to the persistent store (disk) without blocking the UI
- (NSManagedObjectContext *)masterManagedObjectContext {
    if (_masterManagedObjectContext != nil) {
        return _masterManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _masterManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_masterManagedObjectContext performBlockAndWait:^{
            [_masterManagedObjectContext setPersistentStoreCoordinator:coordinator];
            [_masterManagedObjectContext setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];
        }];
        
    }
    return _masterManagedObjectContext;
}

// Return the NSManagedObjectContext to be used in the background during sync
- (NSManagedObjectContext *)backgroundManagedObjectContext {
    if (_backgroundManagedObjectContext != nil) {
        return _backgroundManagedObjectContext;
    }
    
    NSManagedObjectContext *masterContext = [self masterManagedObjectContext];
    if (masterContext != nil) {
        _backgroundManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_backgroundManagedObjectContext performBlockAndWait:^{
            [_backgroundManagedObjectContext setParentContext:masterContext];
            
        }];
    }
    
    return _backgroundManagedObjectContext;
}

// Return a new NSManagedObjectContext
- (NSManagedObjectContext *)newManagedObjectContext {
    NSManagedObjectContext *newContext = nil;
    NSManagedObjectContext *masterContext = [self masterManagedObjectContext];
    if (masterContext != nil) {
        newContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [newContext performBlockAndWait:^{
            [newContext setParentContext:masterContext];
        }];
    }
    
    return newContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MercurySDK" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MercurySDK.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
//    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        //         Replace this implementation with code to handle the error appropriately.
        //
        //         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //
        //         Typical reasons for an error here include:
        //         * The persistent store is not accessible;
        //         * The schema for the persistent store is incompatible with current managed object model.
        //         Check the error message to determine what the actual problem was.
        //
        //
        //         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
        //
        //         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
        //         * Simply deleting the existing store:
        //         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
        //
        //         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
        //         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        //
        //         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
    return _persistentStoreCoordinator;
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.masterManagedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSLog(@"%@", url);
    return url;
}

#pragma mark - Fetch Requests
+ (nullable VerifyCardInfo *)fetchVerifyCardInfoByToken:(nullable NSString *)token error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VerifyCardInfo"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"token == %@", token]];
    return [[context executeFetchRequest:request error:error] firstObject];
}

+ (NSArray <VerifyPayment *> *)fetchVerifyPaymentAll:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSManagedObjectModel* model = [[context persistentStoreCoordinator] managedObjectModel];
    NSFetchRequest* request = [model fetchRequestTemplateForName:@"VerifyPaymentFetchAll"];
    return [context executeFetchRequest:request error:&error];
}

+ (NSArray <VerifyCardInfo *> *)fetchVerifyCardInfoAll:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSManagedObjectModel* model = [[context persistentStoreCoordinator] managedObjectModel];
    NSFetchRequest* request = [model fetchRequestTemplateForName:@"VerifyCardInfoFetchAll"];
    return [context executeFetchRequest:request error:&error];
}

+ (NSArray <CreditResponse *> *)fetchCreditResponseAll:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSManagedObjectModel* model = [[context persistentStoreCoordinator] managedObjectModel];
    NSFetchRequest* request = [model fetchRequestTemplateForName:@"CreditResponseFetchAll"];
    return [context executeFetchRequest:request error:&error];
}

+ (NSArray <Address *> *)fetchAddressBillingAll:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSManagedObjectModel* model = [[context persistentStoreCoordinator] managedObjectModel];
    NSFetchRequest* request = [model fetchRequestTemplateForName:@"AddressBillingFetchAll"];
    return [context executeFetchRequest:request error:&error];
}

+ (NSArray <Address *> *)fetchAddressShippingAll:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSManagedObjectModel* model = [[context persistentStoreCoordinator] managedObjectModel];
    NSFetchRequest* request = [model fetchRequestTemplateForName:@"AddressShippingFetchAll"];
    return [context executeFetchRequest:request error:&error];
}

+ (NSNumber *)fetchNextInvoiceNumber:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CreditResponse"];
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"invoice" ascending:NO]];
    CreditResponse * response = [[context executeFetchRequest:fetchRequest error:&error] firstObject];
    return response ? @([[response invoice] integerValue] + 1) : @1;
}

+ (nullable VerifyCardInfo *)fetchVerifyCardInfoLastUsed:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VerifyCardInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateUsed" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        
    }
    return [fetchedObjects firstObject];
}

+ (nullable Address *)fetchBillingAddressLastUsed:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"billing == %@", @YES];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateUsed" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        
    }
    return [fetchedObjects firstObject];
}

+ (nullable Address *)fetchShippingAddressLastUsed:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"billing == %@", @NO];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateUsed" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        
    }
    return [fetchedObjects firstObject];
}

+ (BOOL)updateUsedCard:(VerifyCardInfo *)card billing:(Address *)billing shipping:(Address *)shipping error:(NSError **)error {
    if (card) card.dateUsed = [NSDate date];
    if (billing) billing.dateUsed = [NSDate date];
    if (shipping) shipping.dateUsed = [NSDate date];
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    return [context save:error];
}

@end
