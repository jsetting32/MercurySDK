//
//  JSMercuryError.h
//  Mercury Hosted Checkout
//
//  Created by John Setting on 4/18/16.
//  Copyright © 2016 Mercury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSMercuryError : NSObject
+ (nullable NSError *)js_mercury_error:(NSInteger)errorCode response:(nullable NSString *)response;

@end
