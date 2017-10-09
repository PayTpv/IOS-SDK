//
//  PTPVCard.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVCard.h"

@interface PTPVCard()
@property (nonatomic, readwrite, nonnull, copy) NSDictionary *originalResponse;
@end

@implementation PTPVCard

- (instancetype)initWithPan:(NSString *)pan
                 expiryDate:(NSString *)expiryDate
                        cvv:(NSString *)cvv {
    self = [super init];
    if (self) {
        _pan = pan;
        _expiryDate = expiryDate;
        _cvv = cvv;
    }
    return self;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"pan = %@", self.pan],
                       [NSString stringWithFormat:@"expiryDate = %@", self.expiryDate],
                       [NSString stringWithFormat:@"cvv = %@", self.cvv],
                       [NSString stringWithFormat:@"brand = %@", self.brand],
                       [NSString stringWithFormat:@"type = %@", self.type],
                       [NSString stringWithFormat:@"country = %@", self.country],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVNSDictionaryEncodable

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"DS_MERCHANT_PAN"] = self.pan;
    dict[@"DS_MERCHANT_EXPIRYDATE"] = self.expiryDate;
    dict[@"DS_MERCHANT_CVV2"] = self.cvv;
    return dict;
}

#pragma mark - PTPVAPIResponseDecodable

+ (instancetype)decodedObjectFromAPIResponse:(NSDictionary *)response {
    PTPVCard *res = [self new];
    res.pan = [response[@"DS_MERCHANT_PAN"] stringValue];
    res.brand = [response[@"DS_CARD_BRAND"] stringValue];
    res.type = [response[@"DS_CARD_TYPE"] stringValue];
    res.country = [response[@"DS_CARD_I_COUNTRY_ISO3"] stringValue];
    res.expiryDate = [response[@"DS_EXPIRYDATE"] stringValue];

    res.originalResponse = response;

    return res;
}

@end
