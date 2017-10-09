//
//  PTPVRefund.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVRefund.h"

@interface PTPVRefund()
@property (nonatomic, readwrite, nonnull, copy) NSDictionary *originalResponse;
@end

@implementation PTPVRefund

- (instancetype)initWithAuthCode:(NSString *)authCode
                           order:(NSString *)order
                        currency:(PTPVCurrency *)currency
                          amount:(nullable NSNumber *)amount {
    self = [super init];
    if (self) {
        _authCode = authCode;
        _order = order;
        _currency = currency;
        _amount = amount;
    }
    return self;
}

- (instancetype)initWithAuthCode:(NSString *)authCode
                           order:(NSString *)order
                        currency:(PTPVCurrency *)currency {
    self = [self initWithAuthCode:authCode
                            order:order
                         currency:currency
                           amount:nil];
    return self;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"authCode = %@", self.authCode],
                       [NSString stringWithFormat:@"order = %@", self.order],
                       [NSString stringWithFormat:@"currency = %@", self.currency],
                       [NSString stringWithFormat:@"amount = %@", self.amount],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVNSDictionaryEncodable

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"DS_MERCHANT_AUTHCODE"] = self.authCode;
    dict[@"DS_MERCHANT_ORDER"] = self.order;
    dict[@"DS_MERCHANT_CURRENCY"] = self.currency;
    dict[@"DS_MERCHANT_AMOUNT"] = self.amount;
    return dict;
}

#pragma mark - PTPVAPIResponseDecodable

+ (instancetype)decodedObjectFromAPIResponse:(NSDictionary *)response {
    PTPVRefund *res = [self new];
    res.order = [response[@"DS_MERCHANT_ORDER"] stringValue];
    res.currency = [response[@"DS_MERCHANT_CURRENCY"] stringValue];
    res.authCode = [response[@"DS_MERCHANT_AUTHCODE"] stringValue];

    res.originalResponse = response;

    return res;
}

@end
