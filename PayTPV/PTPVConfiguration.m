//
//  PTPVConfiguration.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 7/28/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVConfiguration.h"

@implementation PTPVConfiguration

+ (instancetype)sharedConfiguration {
    static PTPVConfiguration *sharedConfiguration;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedConfiguration = [self new];
    });
    return sharedConfiguration;
}

- (instancetype)initWithMerchantCode:(NSString *)merchantCode
                            terminal:(NSString *)terminal
                            password:(NSString *)password
                               jetId:(NSString *)jetId {
    self = [super init];
    if (self) {
        _merchantCode = merchantCode;
        _terminal = terminal;
        _password = password;
        _jetId = jetId;
    }
    return self;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"merchantCode = %@", self.merchantCode],
                       [NSString stringWithFormat:@"terminal = %@", self.terminal],
                       [NSString stringWithFormat:@"password = %@", self.password],
                       [NSString stringWithFormat:@"jetId = %@", self.jetId],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - NSCopying

- (id)copyWithZone:(__unused NSZone *)zone {
    PTPVConfiguration *copy = [self.class new];
    copy.merchantCode = self.merchantCode;
    copy.terminal = self.terminal;
    copy.password = self.password;
    copy.jetId = self.jetId;
    return copy;
}

#pragma mark - PTPVNSDictionaryEncodable

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"DS_MERCHANT_MERCHANTCODE"] = self.merchantCode;
    dict[@"DS_MERCHANT_TERMINAL"] = self.terminal;
    return dict;
}

@end
