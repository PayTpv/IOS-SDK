//
//  PTPVSubscription.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVSubscriptionDetails.h"

@interface PTPVSubscriptionDetails()
@property (nonatomic, readwrite, nonnull, copy) NSDictionary *originalResponse;
@end

@implementation PTPVSubscriptionDetails

- (PTPVUser *)user {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:self.idUser
                                            tokenUser:self.tokenUser];
    return user;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"idUser = %@", self.idUser],
                       [NSString stringWithFormat:@"tokenUser = %@", self.tokenUser],
                       [NSString stringWithFormat:@"amount = %@", self.amount],
                       [NSString stringWithFormat:@"order = %@", self.order],
                       [NSString stringWithFormat:@"currency = %@", self.currency],
                       [NSString stringWithFormat:@"authCode = %@", self.authCode],
                       [NSString stringWithFormat:@"cardCountry = %@", self.cardCountry],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVAPIResponseDecodable

+ (instancetype)decodedObjectFromAPIResponse:(NSDictionary *)response {
    PTPVSubscriptionDetails *res = [self new];
    res.idUser = [response[@"DS_IDUSER"] stringValue];
    res.tokenUser = [response[@"DS_TOKEN_USER"] stringValue];
    res.amount = [NSNumber numberWithInteger:[response[@"DS_SUBSCRIPTION_AMOUNT"] integerValue]];
    res.order = [response[@"DS_SUBSCRIPTION_ORDER"] stringValue];
    res.currency = [response[@"DS_SUBSCRIPTION_CURRENCY"] stringValue];
    res.authCode = [response[@"DS_MERCHANT_AUTHCODE"] stringValue];
    res.cardCountry = [response[@"DS_MERCHANT_CARDCOUNTRY"] stringValue];

    res.originalResponse = response;

    return res;
}

@end
