//
//  PTPVPurchaseRequest.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVPurchaseRequest.h"

@implementation PTPVPurchaseRequest

- (instancetype)initWithAmount:(NSNumber *)amount
                         order:(NSString *)order
                      currency:(PTPVCurrency *)currency
            productDescription:(nullable NSString *)productDescription
                         owner:(nullable NSString *)owner
                       scoring:(nullable NSString *)scoring {
    self = [super init];
    if (self) {
        _amount = amount;
        _order = order;
        _currency = currency;
        _productDescription = productDescription;
        _owner = owner;
        _scoring = scoring;
    }
    return self;
}

- (instancetype)initDCCWithAmount:(NSNumber *)amount
                            order:(NSString *)order
               productDescription:(nullable NSString *)productDescription
                            owner:(nullable NSString *)owner {
    self = [super init];
    if (self) {
        _amount = amount;
        _order = order;
        _productDescription = productDescription;
        _owner = owner;
    }
    return self;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"amount = %@", self.amount],
                       [NSString stringWithFormat:@"order = %@", self.order],
                       [NSString stringWithFormat:@"currency = %@", self.currency],
                       [NSString stringWithFormat:@"productDescription = %@", self.productDescription],
                       [NSString stringWithFormat:@"owner = %@", self.owner],
                       [NSString stringWithFormat:@"scoring = %@", self.scoring],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVNSDictionaryEncodable

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"DS_MERCHANT_AMOUNT"] = self.amount;
    dict[@"DS_MERCHANT_ORDER"] = self.order;
    dict[@"DS_MERCHANT_CURRENCY"] = self.currency;
    dict[@"DS_MERCHANT_PRODUCTDESCRIPTION"] = self.productDescription;
    dict[@"DS_MERCHANT_OWNER"] = self.owner;
    dict[@"DS_MERCHANT_SCORING"] = self.scoring;
    return dict;
}

@end
