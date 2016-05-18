//
//  MercurySOAPHelper.m
//  CallMercuryHostedCheckoutWebService
//
//  Created by Kevin Oliver on 5/16/13.
//  Copyright (c) 2013 Kevin Oliver. All rights reserved.
//

#import "HCMercuryHelper.h"
#import "JSMercury.h"

@implementation HCMercuryHelper

static int          _numberOfPasses = 0;
NSMutableString     *_soapResults;
NSString            *_hcTransactionResult;
NSMutableDictionary *_dict;
NSString            *_currentElement;
NSXMLParser         *_xmlParser;
static BOOL         _recordResults = NO;
NSMutableString     *_hctransactionType;
NSString            *_noCaps;

+ (NSString *)MERCURY_WEB_SERVICE_FULL_URL {
    BOOL production = [[[JSMercuryAPIClient sharedClient] production] boolValue];
    return [NSString stringWithFormat:@"%@%@", (production) ? MERCURY_WEB_SERVICE_URL_PRODUCTION : MERCURY_WEB_SERVICE_URL_DEVELOPMENT, MERCURY_WEB_SERVICE_ENDPOINT];
}

+ (NSString *)MERCURY_WEB_SERVICE_TOKEN_FULL_URL {
    BOOL production = [[[JSMercuryAPIClient sharedClient] production] boolValue];
    return [NSString stringWithFormat:@"%@%@", (production) ? MERCURY_WEB_SERVICE_URL_PRODUCTION : MERCURY_WEB_SERVICE_URL_DEVELOPMENT, MERCURY_WEB_SERVICE_TOKENIZATION_ENDPOINT];
}

- (void)actionFromDictionary:(NSDictionary *)dictionary actionType:(NSString *)actionType {
    [self paymentFromDictionary:dictionary actionType:actionType urlString:[HCMercuryHelper MERCURY_WEB_SERVICE_FULL_URL]];
}

- (void)tokenFromDictionary:(NSDictionary *)dictionary actionType:(NSString *)actionType  {
    [self paymentFromDictionary:dictionary actionType:actionType urlString:[HCMercuryHelper MERCURY_WEB_SERVICE_TOKEN_FULL_URL]];
}

- (void)paymentFromDictionary:(NSDictionary *)dictionary actionType:(NSString *)actionType urlString:(NSString *)urlString {
    NSAssert(actionType, @"There must be a specified Type for the payment. Either kHCMercuryHelperInitialize or kHCMercuryHelperVerify");

    NSString *soapMessage;
    if (![actionType containsString:@"Credit"]) {
        soapMessage = [HCMercuryHelper buildPaymentFromDictionary:dictionary type:actionType];
    } else {
        soapMessage = [HCMercuryHelper buildCreditFromDictionary:dictionary type:actionType];
    }

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"http://www.mercurypay.com/%@", actionType] forHTTPHeaderField:@"SOAPAction"];
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    [JSMercuryUtility printRequest:request withBenchmark:[NSDate date]];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(hcTransactionDidFailWithError:)]) {
                    [self.delegate performSelector:@selector(hcTransactionDidFailWithError:) withObject:error];
                }
                return;
            }
        });
        
        _numberOfPasses = 1;
        _xmlParser = [[NSXMLParser alloc] initWithData:data];
        [_xmlParser setDelegate:self];
        [_xmlParser setShouldResolveExternalEntities:YES];
        [_xmlParser parse];
    }];
    [downloadTask resume];
}

+ (NSString *)buildPaymentFromDictionary:(NSDictionary *)dict type:(NSString *)type {
    
    NSMutableString *hcSoap = [NSMutableString string];
    [hcSoap appendFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://www.mercurypay.com/\">\n"];
    [hcSoap appendFormat:@"<soapenv:Header/>\n"];
    [hcSoap appendFormat:@"<soapenv:Body>\n"];
    [hcSoap appendFormat:@"<%@>\n", type];
    [hcSoap appendFormat:@"<request>\n"];
    [hcSoap appendFormat:@"<Password>%@</Password>\n", [[JSMercuryAPIClient sharedClient] passwordKey]];
    [hcSoap appendFormat:@"<MerchantID>%@</MerchantID>\n", [[JSMercuryAPIClient sharedClient] merchantKey]];

    for (NSString *key in [dict allKeys]) {
        [hcSoap appendFormat:@"<%@>%@</%@>\n", key, [dict objectForKey:key], key];
    }
    
    [hcSoap appendFormat:@"</request>\n"];
    [hcSoap appendFormat:@"</%@>\n", type];
    [hcSoap appendFormat:@"</soapenv:Body>\n"];
    [hcSoap appendFormat:@"</soapenv:Envelope>\n"];
    
    return hcSoap;
}

+ (NSString *)buildCreditFromDictionary:(NSDictionary *)dict type:(NSString *)type {
    
    NSMutableString *hcSoap = [NSMutableString string];
    [hcSoap appendFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://www.mercurypay.com/\">\n"];
    [hcSoap appendFormat:@"<soapenv:Header/>\n"];
    [hcSoap appendFormat:@"<soapenv:Body>\n"];
    [hcSoap appendFormat:@"<%@>\n", type];
    [hcSoap appendFormat:@"<request>\n"];
    [hcSoap appendFormat:@"<MerchantID>%@</MerchantID>\n", [[JSMercuryAPIClient sharedClient] merchantKey]];
    
    for (NSString *key in [dict allKeys]) {
        [hcSoap appendFormat:@"<%@>%@</%@>\n", key, [dict objectForKey:key], key];
    }
    
    [hcSoap appendFormat:@"</request>\n"];
    [hcSoap appendFormat:@"<password>%@</password>\n", [[JSMercuryAPIClient sharedClient] passwordKey]];
    [hcSoap appendFormat:@"</%@>\n", type];
    [hcSoap appendFormat:@"</soapenv:Body>\n"];
    [hcSoap appendFormat:@"</soapenv:Envelope>\n"];
    
    return hcSoap;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    _numberOfPasses += 1;
    _dict = [[NSMutableDictionary alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (_numberOfPasses == 1) {
        NSString *hctransactionResult = @"InitializePaymentResult";
        if ([elementName isEqualToString:hctransactionResult]) {
            if (!_soapResults) {
                _soapResults = [[NSMutableString alloc] init];
            }
            _recordResults = YES;
        }
    } else {
        _currentElement = elementName;
        if (!_soapResults) {
            _soapResults = [[NSMutableString alloc] init];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (_numberOfPasses == 1) {
        if (_recordResults) {
            [_soapResults appendString:string];
        }
    } else {
        [_soapResults appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (_numberOfPasses == 1) {
        NSString *hctransactionResult = [NSString stringWithFormat:@"InitializePaymentResult"];
        if ([elementName isEqualToString:hctransactionResult]) {
            _hcTransactionResult = _soapResults;
            _hcTransactionResult = [_hcTransactionResult stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            _hcTransactionResult = [_hcTransactionResult stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            _recordResults = NO;
        }
    } else {
        if ([elementName isEqualToString:_currentElement] && ![_soapResults hasPrefix:@"<"]) {
            NSString *value = [_soapResults stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_dict setObject:value forKey:_currentElement];
        }
    }
    
    _soapResults = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (_numberOfPasses == 1) {
        NSData *data = [_hcTransactionResult dataUsingEncoding:NSUTF8StringEncoding];
        _xmlParser = [[NSXMLParser alloc] initWithData: data];
        [_xmlParser setDelegate: self];
        [_xmlParser setShouldResolveExternalEntities: YES];
        [_xmlParser parse];
        _numberOfPasses += 1;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(hcTransactionDidFinish:)]) {
                [self.delegate performSelector:@selector(hcTransactionDidFinish:) withObject:_dict];
            }
        });
    }
}

- (void)dealloc { NSLog(@"%s : %@", __PRETTY_FUNCTION__, NSStringFromClass([self class])); }

@end