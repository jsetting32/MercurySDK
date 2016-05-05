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
NSMutableData       *_conWebData;
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
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    [theRequest addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    NSString *soapAction = [NSString stringWithFormat:@"http://www.mercurypay.com/%@", actionType];
    [theRequest addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    [JSMercuryUtility printRequest:theRequest withBenchmark:[NSDate date]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection ) {
        _conWebData = [NSMutableData data];
    }
    else {
        NSLog(@"theConnection is NULL");
    }
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

//+ (NSString *)buildCreditFromDictionary:(NSDictionary *)dict type:(NSString *)type {
//    
//    NSMutableString *hcSoap = [NSMutableString string];
//    [hcSoap appendFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://www.mercurypay.com/\">\n"];
//    [hcSoap appendFormat:@"<soapenv:Header/>\n"];
//    [hcSoap appendFormat:@"<soapenv:Body>\n"];
//    [hcSoap appendFormat:@"<mer:%@>\n", type];
//    [hcSoap appendFormat:@"<mer:request>\n"];
//    [hcSoap appendFormat:@"<mer:MerchantID>%@</mer:MerchantID>\n", [[JSMercuryAPIClient sharedClient] merchantKey]];
//    
//    for (NSString *key in [dict allKeys]) {
//        [hcSoap appendFormat:@"<mer:%@>%@</mer:%@>\n", key, [dict objectForKey:key], key];
//    }
//    
//    [hcSoap appendFormat:@"</mer:request>\n"];
//    [hcSoap appendFormat:@"<mer:Password>%@</mer:Password>\n", [[JSMercuryAPIClient sharedClient] passwordKey]];
//    [hcSoap appendFormat:@"</mer:%@>\n", type];
//    [hcSoap appendFormat:@"</soapenv:Body>\n"];
//    [hcSoap appendFormat:@"</soapenv:Envelope>\n"];
//    
//    return hcSoap;
//}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_conWebData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_conWebData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate performSelector:@selector(hcTransactionDidFailWithError:) withObject:error];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _numberOfPasses = 1;
    _xmlParser = [[NSXMLParser alloc] initWithData: _conWebData];
    [_xmlParser setDelegate: self];
    [_xmlParser setShouldResolveExternalEntities: YES];
    [_xmlParser parse];
}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    _numberOfPasses += 1;
    _dict = [[NSMutableDictionary alloc] init];
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName   attributes: (NSDictionary *)attributeDict
{
    if (_numberOfPasses == 1)
    {
       NSString *hctransactionResult = @"InitializePaymentResult";
        
        if( [elementName isEqualToString:hctransactionResult])
        {
            if(!_soapResults)
            {
                _soapResults = [[NSMutableString alloc] init];
            }
            _recordResults = YES;
        }
    }
    else
    {
        _currentElement = elementName;
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_numberOfPasses == 1)
    {
        if(_recordResults)
        {
            [_soapResults appendString: string];
        }
    }
    else
    {
        [_soapResults appendString: string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (_numberOfPasses == 1)
    {
        NSString *hctransactionResult = [NSString stringWithFormat:@"InitializePaymentResult"];
        
        if([elementName isEqualToString:hctransactionResult])
        {
            _hcTransactionResult = _soapResults;
            _hcTransactionResult = [_hcTransactionResult stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            _hcTransactionResult = [_hcTransactionResult stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            _recordResults = NO;
        }
    }
    else
    {
        if ([elementName isEqualToString:_currentElement]
            && ![_soapResults hasPrefix:@"<"])
        {
            NSString *value = [_soapResults stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_dict setObject:value forKey:_currentElement];
        }
    }
    
    _soapResults = nil;
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (_numberOfPasses == 1)
    {
        NSData *data = [_hcTransactionResult dataUsingEncoding:NSUTF8StringEncoding];
        _xmlParser = [[NSXMLParser alloc] initWithData: data];
        [_xmlParser setDelegate: self];
        [_xmlParser setShouldResolveExternalEntities: YES];
        [_xmlParser parse];
        _numberOfPasses += 1;
    }
    else
    {
        [self.delegate performSelector:@selector(hcTransactionDidFinish:) withObject:_dict];
    }
}

- (void)dealloc { NSLog(@"%s : %@", __PRETTY_FUNCTION__, NSStringFromClass([self class])); }

@end