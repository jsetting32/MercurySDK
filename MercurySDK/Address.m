//
//  Address.m
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "Address.h"
#import "NSManagedObject+Properties.h"
#import "JSMercuryCoreDataController.h"

@implementation Address

// Insert code here to add functionality to your managed object subclass
- (NSString *)tomsFormattedMultiLineAddress {
    NSMutableString *s = [NSMutableString string];
    [s appendString:[self assorted:@[self.address]]];
    [s appendString:[self assorted:@[self.city, self.state, self.postalCode, self.country]]];
    return s;
}

- (NSString *)formattedMultiLineAddress {
    NSMutableString *s = [NSMutableString string];
    [s appendString:[self assorted:@[self.name]]];
    [s appendString:[self assorted:@[self.address, self.city]]];
    [s appendString:[self assorted:@[self.state, self.postalCode, self.country]]];
    return s;
}

- (NSString *)formattedSingleLineAddress {
    NSMutableString *s = [NSMutableString string];
    [s appendString:[self assorted:@[self.name, self.address, self.city, self.state, self.postalCode, self.country]]];
    return s;
}

- (NSString *)formattedVantivAddress {
    NSMutableString *s = [NSMutableString string];
    [s appendString:[self.address uppercaseString]];
    return s;
}

- (NSString *)assortedSingleLine:(NSArray *)list {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in list) {
        if (str && [str length] > 0) {
            [array addObject:str];
        }
    }
    
    return [[array componentsJoinedByString:@" "] uppercaseString];
}

- (NSString *)assorted:(NSArray *)list {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in list) {
        if (str && [str length] > 0) {
            [array addObject:str];
        }
    }
    
    return [[[array componentsJoinedByString:@" "] stringByAppendingString:@"\n"] uppercaseString];
}

+ (Address *)saveAddress:(NSDictionary *)data error:(NSError **)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    Address *address = [Address js_hardManagedObject:context];
    address.name = [data objectForKey:@"name"];
    address.address = [data objectForKey:@"address"];
    address.city = [data objectForKey:@"city"];
    address.state = [data objectForKey:@"state"];
    address.postalCode = [data objectForKey:@"postalCode"];
    address.country = [data objectForKey:@"country"];
    address.phone = [data objectForKey:@"phone"];
    address.billing = [data objectForKey:@"billing"];
    address.dateUsed = [NSDate date];
    return ([context save:error]) ? address : nil;
}

@end
