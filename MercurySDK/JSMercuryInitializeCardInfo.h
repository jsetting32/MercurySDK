//
//  JSMercuryInitializeCardInfo.h
//  MercurySDK
//
//  Created by John Setting on 4/22/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryInitialize.h"

@interface JSMercuryInitializeCardInfo : JSMercuryInitialize

// Operator ID
@property (strong, nonatomic, nullable) NSString *operatorID;

- (void)js_mercury_transaction:(nullable kJSMercuryInitializeBlock)completion;
@end
