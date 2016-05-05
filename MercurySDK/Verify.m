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
    [formatter setDateStyle:NSDateFormatterShortStyle];
    return [formatter stringFromDate:self.expDate];
}

@end
