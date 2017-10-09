//
//  PTPVDCCConfirmation.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVDCCConfirmation.h"

@implementation PTPVDCCConfirmation

- (instancetype)initWithOrder:(NSString *)order
                     currency:(NSString *)currency
                      session:(NSString *)session {
    self = [super init];
    if (self) {
        _order = order;
        _currency = currency;
        _session = session;
    }
    return self;
}

- (instancetype)initWithDCCDetails:(PTPVDCCDetails *)details
                          currency:(NSString *)currency {
    self = [super init];
    if (self) {
        _order = details.order;
        _currency = currency;
        _session = details.dccSession;
    }
    return self;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"order = %@", self.order],
                       [NSString stringWithFormat:@"currency = %@", self.currency],
                       [NSString stringWithFormat:@"session = %@", self.session],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVNSDictionaryEncodable

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"DS_MERCHANT_ORDER"] = self.order;
    dict[@"DS_MERCHANT_DCC_CURRENCY"] = self.currency;
    dict[@"DS_MERCHANT_DCC_SESSION"] = self.session;
    return dict;
}

@end
