//
//  PTPVPurchase.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVPurchase.h"

@interface PTPVPurchase()
@property (nonatomic, readwrite, nonnull, copy) NSDictionary *originalResponse;
@end

@implementation PTPVPurchase

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"amount = %@", self.amount],
                       [NSString stringWithFormat:@"order = %@", self.order],
                       [NSString stringWithFormat:@"currency = %@", self.currency],
                       [NSString stringWithFormat:@"authCode = %@", self.authCode],
                       [NSString stringWithFormat:@"cardCountry = %@", self.cardCountry],
                       [NSString stringWithFormat:@"result = %s", self.result == PTPVResultOK ? "OK" : "KO"],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVAPIResponseDecodable

+ (instancetype)decodedObjectFromAPIResponse:(NSDictionary *)response {
    PTPVPurchase *res = [self new];
    res.amount = [NSNumber numberWithInteger:[response[@"DS_MERCHANT_AMOUNT"] integerValue]];
    res.order = [response[@"DS_MERCHANT_ORDER"] stringValue];
    res.currency = [response[@"DS_MERCHANT_CURRENCY"] stringValue];
    res.authCode = [response[@"DS_MERCHANT_AUTHCODE"] stringValue];
    res.cardCountry = [response[@"DS_MERCHANT_CARDCOUNTRY"] stringValue];
    res.result = [response[@"DS_RESPONSE"] intValue];

    res.originalResponse = response;

    return res;
}

@end
