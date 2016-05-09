//
//  Verify.m
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "Verify.h"
#import "VerifyCardInfo.h"
#import "VerifyPayment.h"
#import "NSManagedObject+Properties.h"
#import "JSMercuryCoreDataController.h"

@implementation Verify

// Insert code here to add functionality to your managed object subclass
- (NSString *)formattedExpDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/yyyy"];
    return [formatter stringFromDate:self.expDate];
}

- (NSString *)formattedExpDateMonth {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    return [formatter stringFromDate:self.expDate];
}

- (NSString *)formattedExpDateYear {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:self.expDate];
}

- (BOOL)isValid { return [self.status isEqualToString:@"Approved"]; }

- (NSString *)formattedMaskedAccount {
    return [self.maskedAccount substringFromIndex:MAX((int)[self.maskedAccount length] - 5, 0)];
}

@end
