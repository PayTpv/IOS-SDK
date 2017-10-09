//
//  PTPVRemoteIP.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/11/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVRemoteIP.h"

@interface PTPVRemoteIP()
@property (nonatomic, readwrite, nonnull, copy) NSDictionary *originalResponse;
@end

@implementation PTPVRemoteIP

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                        [NSString stringWithFormat:@"remoteAddress = %@", self.remoteAddress],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVAPIResponseDecodable

+ (instancetype)decodedObjectFromAPIResponse:(NSDictionary *)response {
    PTPVRemoteIP *res = [self new];
    res.remoteAddress = [response[@"DS_REMOTE_ADDRESS"] stringValue];

    res.originalResponse = response;

    return res;
}

@end
