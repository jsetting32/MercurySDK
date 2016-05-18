//
//  Address.h
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Address : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (NSString *)tomsFormattedMultiLineAddress;
- (NSString *)formattedMultiLineAddress;
- (NSString *)formattedSingleLineAddress;
- (NSString *)formattedVantivAddress;
+ (Address *)saveAddress:(NSDictionary *)data error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END

#import "Address+CoreDataProperties.h"
