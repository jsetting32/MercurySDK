//
//  Address.m
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "Address.h"

@implementation Address

// Insert code here to add functionality to your managed object subclass
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
    [s appendString:[self assorted:@[self.address]]];
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

@end
