//
//  PTPVSubscription.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVSubscription.h"

@implementation PTPVSubscription

- (instancetype)initWithStartDate:(NSString *)startDate
                          endDate:(NSString *)endDate
                            order:(NSString *)order
                           amount:(NSNumber *)amount
                         currency:(PTPVCurrency *)currency
                      periodicity:(NSString *)periodicity
                          scoring:(nullable NSString *)scoring {
    self = [super init];
    if (self) {
        _startDate = startDate;
        _endDate = endDate;
        _order = order;
        _amount = amount;
        _currency = currency;
        _periodicity = periodicity;
        _scoring = scoring;
    }
    return self;
}

- (instancetype)initWithStartDate:(NSString *)startDate
                          endDate:(NSString *)endDate
                            order:(NSString *)order
                           amount:(NSNumber *)amount
                         currency:(PTPVCurrency *)currency
                      periodicity:(NSString *)periodicity {
    self = [self initWithStartDate:startDate
                           endDate:endDate
                             order:order
                            amount:amount
                          currency:currency
                       periodicity:periodicity
                           scoring:nil];
    return self;
}

- (instancetype)initWithStartDate:(NSString *)startDate
                          endDate:(NSString *)endDate
                           amount:(NSNumber *)amount
                      periodicity:(NSString *)periodicity {
    self = [super init];
    if (self) {
        _startDate = startDate;
        _endDate = endDate;
        _amount = amount;
        _periodicity = periodicity;
    }
    return self;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"startDate = %@", self.startDate],
                       [NSString stringWithFormat:@"endDate = %@", self.endDate],
                       [NSString stringWithFormat:@"order = %@", self.order],
                       [NSString stringWithFormat:@"periodicity = %@", self.periodicity],
                       [NSString stringWithFormat:@"amount = %@", self.amount],
                       [NSString stringWithFormat:@"currency = %@", self.currency],
                       [NSString stringWithFormat:@"scoring = %@", self.scoring],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVNSDictionaryEncodable

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"DS_SUBSCRIPTION_STARTDATE"] = self.startDate;
    dict[@"DS_SUBSCRIPTION_ENDDATE"] = self.endDate;
    dict[@"DS_SUBSCRIPTION_ORDER"] = self.order;
    dict[@"DS_SUBSCRIPTION_PERIODICITY"] = self.periodicity;
    dict[@"DS_SUBSCRIPTION_AMOUNT"] = self.amount;
    dict[@"DS_SUBSCRIPTION_CURRENCY"] = self.currency;
    dict[@"DS_MERCHANT_SCORING"] = self.scoring;
    return dict;
}

@end
