//
//  PTPVPreauthorization.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/9/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVPreauthorization.h"

@implementation PTPVPreauthorization

- (instancetype)initWithOrder:(NSString *)order
                       amount:(NSNumber *)amount {
    self = [super init];
    if (self) {
        _order = order;
        _amount = amount;
    }
    return self;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"order = %@", self.order],
                       [NSString stringWithFormat:@"amount = %@", self.amount],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVNSDictionaryEncodable

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"DS_MERCHANT_ORDER"] = self.order;
    dict[@"DS_MERCHANT_AMOUNT"] = self.amount;
    return dict;
}

@end
