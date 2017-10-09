//
//  PTPVDCCDetails.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVDCCDetails.h"

@interface PTPVDCCDetails()
@property (nonatomic, readwrite, nonnull, copy) NSDictionary *originalResponse;
@end

@implementation PTPVDCCDetails

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"amount = %@", self.amount],
                       [NSString stringWithFormat:@"order = %@", self.order],
                       [NSString stringWithFormat:@"currency = %@", self.currency],
                       [NSString stringWithFormat:@"dccSession = %@", self.dccSession],
                       [NSString stringWithFormat:@"dccCurrency = %@", self.dccCurrency],
                       [NSString stringWithFormat:@"dccCurrencyISO3 = %@", self.dccCurrencyISO3],
                       [NSString stringWithFormat:@"dccCurrencyName = %@", self.dccCurrencyName],
                       [NSString stringWithFormat:@"dccExchange = %@", self.dccExchange],
                       [NSString stringWithFormat:@"dccAmount = %@", self.dccAmount],
                       [NSString stringWithFormat:@"dccMarkup = %@", self.dccMarkup],
                       [NSString stringWithFormat:@"dccCardCountry = %@", self.dccCardCountry],
                       [NSString stringWithFormat:@"result = %s", self.result == PTPVResultOK ? "OK" : "KO"],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVAPIResponseDecodable

+ (instancetype)decodedObjectFromAPIResponse:(NSDictionary *)response {
    PTPVDCCDetails *res = [self new];
    res.amount = [NSNumber numberWithInteger:[response[@"DS_MERCHANT_AMOUNT"] integerValue]];
    res.order = [response[@"DS_MERCHANT_ORDER"] stringValue];
    res.currency = [response[@"DS_MERCHANT_CURRENCY"] stringValue];

    res.dccSession = [response[@"DS_MERCHANT_DCC_SESSION"] stringValue];
    res.dccCurrency = [response[@"DS_MERCHANT_DCC_CURRENCY"] stringValue];
    res.dccCurrencyISO3 = [response[@"DS_MERCHANT_DCC_CURRENCYISO3"] stringValue];
    res.dccCurrencyName = [response[@"DS_MERCHANT_DCC_CURRENCYNAME"] stringValue];
    res.dccExchange = [response[@"DS_MERCHANT_DCC_EXCHANGE"] stringValue];
    res.dccAmount = [NSNumber numberWithInteger:[response[@"DS_MERCHANT_DCC_AMOUNT"] integerValue]];
    res.dccMarkup = [response[@"DS_MERCHANT_DCC_MARKUP"] stringValue];
    res.dccCardCountry = [response[@"DS_MERCHANT_DCC_CARDCOUNTRY"] stringValue];
    res.result = [response[@"DS_RESPONSE"] intValue];

    res.originalResponse = response;

    return res;
}

@end
