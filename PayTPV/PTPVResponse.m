//
//  PTPVResponse.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/8/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVResponse.h"

@interface PTPVResponse()
@property (nonatomic, readwrite, nonnull, copy) NSDictionary *originalResponse;
@end

@implementation PTPVResponse

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"result = %s", self.result == PTPVResultOK ? "OK" : "KO"],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVAPIResponseDecodable

+ (instancetype)decodedObjectFromAPIResponse:(NSDictionary *)response {
    PTPVResponse *res = [self new];
    res.result = [response[@"DS_RESPONSE"] intValue];

    res.originalResponse = response;

    return res;
}

@end
