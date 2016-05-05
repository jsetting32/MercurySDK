//
//  JSMercuryInitializeResponse.h
//  Fora
//
//  Created by John Setting on 4/26/16.
//  Copyright © 2016 Logiciel Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSMercuryInitializeResponse : NSObject

- (nullable instancetype)initWithResponse:(nonnull NSDictionary *)response;

// 0 – Success
// 100 – AuthFail (bad password or MerchantId)
// 200 –Mercury Internal Error
// 300 –ValidationFail: General Validation Error (See Message for list of validation errors)
@property (strong, nonatomic, nonnull) NSNumber *responseCode;

// A unique identifier that identifies this particular payment process.
@property (strong, nonatomic, nullable) NSString *paymentId;

// A unique identifier that identifies this particular payment process.
@property (strong, nonatomic, nullable) NSString *cardId;

// Success if initialization was successful, a verbal description of one or more errors if initialization did not succeed.
@property (strong, nonatomic, nonnull) NSString *message;

@end
