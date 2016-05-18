//
//  JSCheckoutItemCell.m
//  MercurySDK
//
//  Created by John Setting on 5/18/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutItemCell.h"

@implementation JSCheckoutItemCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)heightForCell {
    return 61.0f;
}

@end
